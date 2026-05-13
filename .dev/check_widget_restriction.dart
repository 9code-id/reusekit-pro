import 'dart:io';
import 'dart:convert';
import 'icon_fixer.dart';

void main() async {
  deleteAllFilesThatNotExists();
  // Read widget restrictions
  final restrictionsFile =
      File('.github/improvements/widget-restrictions.json');
  if (!restrictionsFile.existsSync()) {
    print('Widget restrictions file not found');
    return;
  }

  final restrictionsContent = await restrictionsFile.readAsString();
  final restrictions = jsonDecode(restrictionsContent);
  final forbiddenWidgets = List<String>.from(
      restrictions['widget_restrictions']['forbidden_widgets']);

  print('Checking for forbidden widgets: ${forbiddenWidgets.join(', ')}');

  // Scan lib/presentation directory
  final presentationDir = Directory('lib/presentation');
  if (!presentationDir.existsSync()) {
    print('lib/presentation directory not found');
    return;
  }

  final violations = <Map<String, dynamic>>[];

  await scanDirectory(presentationDir, forbiddenWidgets,
      violations); // Generate summary count by widget type
  final summaryCount = <String, int>{};
  final fileSummary = <String, Set<String>>{};
  final violationsByWidget = <String, List<String>>{};

  for (final violation in violations) {
    final widgets = List<String>.from(violation['widgets']);
    final filePath = violation['file'] as String;

    for (final widget in widgets) {
      summaryCount[widget] = (summaryCount[widget] ?? 0) + 1;
      fileSummary.putIfAbsent(widget, () => <String>{}).add(filePath);
      violationsByWidget.putIfAbsent(widget, () => <String>[]).add(filePath);
    }
  }

  // Convert to formatted summary
  final violationSummary = <String, String>{};
  for (final entry in summaryCount.entries) {
    final fileCount = fileSummary[entry.key]?.length ?? 0;
    violationSummary[entry.key] = '$fileCount files';
  }

  // Write results to errors.json
  final outputFile = File('.dev\\log\\errors.json');
  final output = {
    'scan_date': DateTime.now().toIso8601String(),
    'total_violations': violations.length,
    'forbidden_widgets': forbiddenWidgets,
    'violation_summary': violationSummary,
    'violations': violationsByWidget,
  };

  // Format JSON with proper indentation
  const encoder = JsonEncoder.withIndent('  ');
  await outputFile.writeAsString(encoder.convert(output));

  // Print summary
  if (violations.isEmpty) {
    print('✅ No widget restriction violations found!');
  } else {
    print('❌ Found ${violations.length} violations:');
    for (final violation in violations) {
      print('  ${violation['file']}: ${violation['widgets'].join(', ')}');
    }
  }
  print('Results saved to .dev\\log\\errors.json');
}

Future<void> scanDirectory(Directory dir, List<String> forbiddenWidgets,
    List<Map<String, dynamic>> violations) async {
  await for (final entity in dir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      await scanFile(entity, forbiddenWidgets, violations);
    }
  }
}

Future<void> scanFile(File file, List<String> forbiddenWidgets,
    List<Map<String, dynamic>> violations) async {
  try {
    var content = await file.readAsString();
    content = codeCleaner(content, file.path);
    file.writeAsStringSync(content);


    //if content has more than one Widget build, delete file and print
    final widgetBuildCount = content.split("Widget build").length;
    if (widgetBuildCount > 2) {
      print('❌ Multiple Widget builds found in ${file.path}. Deleting file.');
      file.deleteSync();
    }

    final classCount = content.split("class ").length;
    if (classCount == 1) {
      print('❌ Class is not completed, found in ${file.path}. Deleting file.');
      file.deleteSync();
    }

    final lines = content.split('\n');
    final foundWidgets = <String>[];
    final violationDetails = <Map<String, dynamic>>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      for (final widget in forbiddenWidgets) {
        // Check for widget usage patterns
        final patterns = [
          RegExp(r'\b' + widget + r'\('), // Widget(
          RegExp(r'\b' + widget + r'\.'), // Widget.
          RegExp(r':\s*' + widget + r'\('), // : Widget(
          RegExp(r'<' + widget + r'>'), // <Widget>
          RegExp(r'extends\s+' + widget + r'\b'), // extends Widget
          RegExp(r'with\s+' + widget + r'\b'), // with Widget
        ];

        for (final pattern in patterns) {
          if (pattern.hasMatch(line)) {
            if (!foundWidgets.contains(widget)) {
              foundWidgets.add(widget);
            }

            violationDetails.add({
              'widget': widget,
              'line_number': i + 1,
              'line_content': line.trim(),
            });
            break;
          }
        }
      }
    }

    if (foundWidgets.isNotEmpty) {
      violations.add({
        'file': file.path.replaceAll('\\', '/'),
        'widgets': foundWidgets,
        'details': violationDetails,
      });
    }
  } catch (e) {
    print('Error scanning ${file.path}: $e');
  }
}

String codeCleaner(String content, String path) {
  content = IconFixer.fix(content);
  if (content.contains("await to(")) {
    //Replace await to(.* to comment
    content = content.replaceAllMapped(
      RegExp(r'await\s+to\((.*?)\)'),
      (match) => "ss('Next page')",
    );
    print("Code cleaned for await to(...) @ ${path}");
  }

  if (content.contains("to(")) {
    //Replace to(.* to comment
    content = content.replaceAllMapped(
      RegExp(r'to\((.*?)\)'),
      (match) => "ss('Next page')",
    );
  }

  if (content.contains("textDirection:")) {
    //Remove textDirection:.* to empty
    content = content.replaceAllMapped(
      RegExp(r'textDirection:\s*[^,]+,?'),
      (match) => '',
    );
  }

  content.replaceAll("s('Next page'));","s('Next page');");

  //replace all $1, $2, $3, $4 to \$1, \$2, \$3, \$4
  content = content.replaceAllMapped(
    RegExp(r'\$(\d+)'),
    (match) => r'\$' + match.group(1)!,
  );

  //replace all \\$ to \$
  content = content.replaceAll("\\\\\$", "\\\$");

  //remove third class definision from view
  // Remove third class definition from view
  var lines = content.split('\n');
  var classLines = <int>[];

  // Find all lines that start with 'class'
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().startsWith('class ')) {
      classLines.add(i);
    }
  }

  // If there are more than 2 class definitions, remove from the third one onwards
  if (classLines.length > 2) {
    var thirdClassIndex = classLines[2];
    lines = lines.sublist(0, thirdClassIndex);
    content = lines.join('\n');
    print("Code cleaned for multiple class definitions @ ${path}");
  }

  //replace radiusFull to radiusLg
  content = content.replaceAll("radiusFull", "radiusLg");

  if (content.contains("Math.") &&
      (content.contains("import 'dart:math' as Math;") == false)) {
    content = "import 'dart:math' as Math;\n" + content;
  }

  return content;
}
void deleteAllFilesThatNotExists() {
  // Read views.json
  final viewJsonFile = File('views.json');
  if (!viewJsonFile.existsSync()) {
    print('views.json file not found');
    return;
  }

  final viewsContent = viewJsonFile.readAsStringSync();
  final viewsJson = jsonDecode(viewsContent) as Map<String, dynamic>;
  
  final sections = viewsJson['sections'] as List<dynamic>;
  final registeredFiles = <String>{};
    // Collect all registered files from views.json
  for (final section in sections) {
    final sectionMap = section as Map<String, dynamic>;
    final directory = sectionMap['directory'] as String;
    final views = sectionMap['views'] as List<dynamic>;
    
    for (final view in views) {
      // Construct full path: directory + filename
      final fullPath = '$directory$view';
      registeredFiles.add(fullPath);
    }
  }
  
  // Scan lib/presentation directory and delete unregistered files
  final presentationDir = Directory('lib/presentation');
  if (!presentationDir.existsSync()) {
    print('lib/presentation directory not found');
    return;
  }
  
  int deletedCount = 0;
  presentationDir.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final relativePath = entity.path.replaceAll('\\', '/');
      final fileName = relativePath.split('/').last;
      
      // Check if this filename is registered in any section
      bool isRegistered = registeredFiles.any((path) => path.endsWith(fileName));
      
      if (!isRegistered) {
        print('Deleting unregistered file: $relativePath');
        entity.deleteSync();
        deletedCount++;
      }
    }
  });
  
  print('✅ Deleted $deletedCount unregistered files from lib/presentation');
}
