import 'dart:io';
import 'dart:convert';

void main() async {
  print('🔍 Checking unfinished views...\n');
  // Read views.json
  final viewsFile = File('./views.json');
  if (!viewsFile.existsSync()) {
    print('❌ views.json file not found!');
    return;
  }

  final viewsContent = await viewsFile.readAsString();
  final viewsData = jsonDecode(viewsContent.replaceAll(RegExp(r'//.*'), ''));
  final sections = viewsData['sections'] as List<dynamic>;
  var totalViews = 0;
  var totalCreated = 0;
  var totalMissing = 0;
  final allMissingViews = <String>[];
  final allFinishedViews = <String>[];
  final sectionsData = <Map<String, dynamic>>[];

  // First pass: calculate totals and collect missing views
  for (var section in sections) {
    final sectionName = section['name'] as String;
    final prefix = section['prefix'] as String;
    final directory = section['directory'] as String;
    final views = section['views'] as List<dynamic>;

    final presentationDir = Directory(directory);
    var sectionCreated = 0;
    var sectionMissing = 0;
    final extraFiles = <String>[];
    if (!presentationDir.existsSync()) {
      // Add all views as missing if directory doesn't exist
      for (var view in views) {
        if (view is String) {
          allMissingViews.add(view);
        } else if (view is Map<String, dynamic> && view.containsKey('name')) {
          allMissingViews.add(view['name'] as String);
        }
      }
      sectionMissing = views.length;
    } else {
      // Get all dart files in the presentation directory
      final existingFiles = presentationDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .map((file) => file.uri.pathSegments.last)
          .where((filename) => filename.startsWith(prefix))
          .toSet();
      for (var view in views) {
        String viewName;
        if (view is String) {
          viewName = view;
        } else if (view is Map<String, dynamic> && view.containsKey('name')) {
          viewName = view['name'] as String;
        } else {
          continue; // Skip invalid entries
        }        if (existingFiles.contains(viewName)) {
          sectionCreated++;
          allFinishedViews.add(viewName);
        } else {
          allMissingViews.add(viewName);
          sectionMissing++;
        }
      }

      // Check for extra files not in views.json
      final expectedViews = views
          .map((view) {
            if (view is String) {
              return view;
            } else if (view is Map<String, dynamic> &&
                view.containsKey('name')) {
              return view['name'] as String;
            }
            return null;
          })
          .where((name) => name != null)
          .cast<String>()
          .toSet();
      extraFiles
          .addAll(existingFiles.where((file) => !expectedViews.contains(file)));
    }

    final progress =
        views.length > 0 ? (sectionCreated / views.length * 100) : 0.0;

    sectionsData.add({
      'name': sectionName,
      'prefix': prefix,
      'directory': directory,
      'totalViews': views.length,
      'createdViews': sectionCreated,
      'missingViews': sectionMissing,
      'extraFiles': extraFiles.length,
      'progress': double.parse(progress.toStringAsFixed(1)),
      'directoryExists': presentationDir.existsSync(),
    });

    totalViews += views.length;
    totalCreated += sectionCreated;
    totalMissing += sectionMissing;
  }

  final overallProgress =
      totalViews > 0 ? (totalCreated / totalViews * 100) : 0.0;

  // Create JSON output
  final jsonOutput = {
    'summary': {
      'totalExpectedViews': totalViews,
      'totalCreatedViews': totalCreated,
      'totalMissingViews': totalMissing,
      'overallProgress': double.parse(overallProgress.toStringAsFixed(1)),
      'generatedOn': DateTime.now().toIso8601String(),
      'status': totalMissing == 0 ? 'complete' : 'incomplete',
    },
    'allMissingViews': allMissingViews,
    'sections': sectionsData,  };
  createBatchPrompt(allMissingViews);
    // Create JSON output for finished views
  final finishedJsonOutput = {
    'views': allFinishedViews.map((viewName) {
      // Convert view name to image path
      // Remove .dart extension and convert to PascalCase for image name
      String imageName = viewName.replaceAll('.dart', '');
      
      // Convert snake_case to PascalCase
      List<String> parts = imageName.split('_');
      String pascalCase = parts.map((part) => 
        part.isNotEmpty ? part[0].toUpperCase() + part.substring(1).toLowerCase() : ''
      ).join('');
      
      return {
        'name': viewName,
        'image': '/previews/${pascalCase}.png'
      };
    }).toList(),
  };
  
  // Write JSON files
  final outputFile = File('./views_progress.json');
  await outputFile
      .writeAsString(JsonEncoder.withIndent('  ').convert(jsonOutput));
  print('✅ JSON report generated: /landing/views.json');
  print('📂 Created views: $totalCreated');
  print('📝 Missing views: $totalMissing');
  print('📊 Progress: ${overallProgress.toStringAsFixed(1)}%');
}

void createBatchPrompt(List allMissingViews) {
  //get batch count, per batch is 10
  int batchCount = ((allMissingViews.length) / 10).ceil();

  //delete all files in .dev/batches
  final batchesDir = Directory('./.dev/batches');
  if (!batchesDir.existsSync()) {
    batchesDir.createSync(recursive: true);
  } else {
    for (var file in batchesDir.listSync()) {
      if (file is File) {
        file.deleteSync();
      }
    }
  }

  for (var i = 0; i < batchCount; i++) {
    List<String> batchViews = [];
    //get batchView
    int batchStartIndex = i * 10;
    int batchEndIndex = (i + 1) * 10;
    if (batchEndIndex > allMissingViews.length) {
      batchEndIndex = allMissingViews.length;
    }

    for (var j = batchStartIndex; j < batchEndIndex; j++) {
      if (j < allMissingViews.length) {

        var view = allMissingViews[j];
        if(view.toString().endsWith(".dart")==false) {
          print("❌ [Invalid typeof 'views' list] View $view does not end with .dart, skipping...");
          exit(0);
        }
        batchViews.add("${Directory.current.path}\\lib\\presentation\\${view}");
      }
    }

    //create file .dev/batches/batch_$i.prompt.md
    final batchFile = File('./.dev/batches/b${i+1}.prompt.md');
    batchFile.writeAsStringSync("""
Create the views at lib/presentation:
1. Create exactly ${batchViews.length} view files (no more, no less)
2. Generate complete, functional UI implementations for each view
3. Follow all architecture guidelines and coding standards
4. Use proper imports, state management, and reusable components
5. Ensure each view is mobile-optimized with elegant design
6. Overwrite existing files without confirmation
7. Stop after creating all ${batchViews.length} views in this batch
8. No explanations or review - generate files directly

# Batch ${i + 1}
${batchViews.join("\n")}
""");
  }
}
