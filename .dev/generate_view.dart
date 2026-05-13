import 'dart:io';
import 'dart:convert';

void main() async {
  generateAppView();
}

void generateAppView() {
  print('🚀 Generating App View with navigation...');

  // Read views.json to get section definitions
  final viewsJsonFile = File('views.json');
  if (!viewsJsonFile.existsSync()) {
    print('❌ views.json file does not exist!');
    return;
  }

  final jsonContent = jsonDecode(viewsJsonFile.readAsStringSync());
  final sections = jsonContent['sections'] as List;

  // Check if lib/presentation directory exists
  final viewsDir = Directory('lib/presentation');
  if (!viewsDir.existsSync()) {
    print('❌ Directory lib/presentation does not exist!');
    viewsDir.createSync(recursive: true);
  }

  // Group views based on sections in views.json
  Map<String, List<Map<String, String>>> groupedViews = {};

  for (var section in sections) {
    final sectionName = section['name'] as String;
    final prefix = section['prefix'] as String;
    final views = List.from([...section['views']]);

    List<Map<String, String>> sectionViews = [];

    for (var viewFileName in views) {
      // Check if the file exists in the presentation directory
      final filePath = 'lib/presentation/$viewFileName';
      final file = File(filePath);

      if (file.existsSync()) {
        // Check if file is not empty
        final content = file.readAsStringSync();
        if (content.trim().isEmpty) {
          print('❌ File $viewFileName is empty, skipping...');
          file.deleteSync();
          continue;
        }

        // Generate class name and display name
        final baseName = viewFileName.replaceAll('.dart', '');
        final className = baseName
            .split('_')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join('');

        final displayName = baseName
            .split('_')
            .skip(1) // Skip prefix
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');

        sectionViews.add({
          'fileName': viewFileName,
          'className': className,
          'displayName': displayName,
          'route': '/${baseName.replaceAll('_', '-')}',
          'relativePath':
              filePath.replaceAll("\\", "/").replaceAll("/", "\\\\"),
        });

        print('   - $filePath → $className');
      }
    }

    if (sectionViews.isNotEmpty) {
      groupedViews[sectionName] = sectionViews;
    }
  }

  print(
      '📁 Found ${groupedViews.values.fold(0, (sum, views) => sum + views.length)} view files');

  // Generate the app_view.dart content with grouped views
  final appViewContent = generateViewListContent(groupedViews);

  // Write to lib/views.dart
  final appViewFile = File('lib/views.dart');
  appViewFile.writeAsStringSync(appViewContent);

  print('✅ Generated lib/views.dart with ${groupedViews.length} groups');
  print('📱 Available groups:');
  for (var entry in groupedViews.entries) {
    print('   - ${entry.key} (${entry.value.length} views)');
  }
}

List<Map<String, String>> _getAllViewFiles(Directory dir) {
  List<Map<String, String>> viewFiles = [];

  for (var entity in dir.listSync(recursive: true)) {
    if (entity is File &&
        entity.path.endsWith('.dart') &&
        !entity.path.endsWith('app_view.dart')) {
      final relativePath =
          entity.path.replaceAll('${dir.path}${Platform.pathSeparator}', '');
      final fileName = entity.path.split(Platform.pathSeparator).last;
      final baseName = fileName.replaceAll('.dart', '');

      // Determine group based on subdirectory
      String group;
      if (relativePath.contains(Platform.pathSeparator)) {
        group = relativePath.split(Platform.pathSeparator).first;
      } else {
        group = 'Root Views';
      }

      // Generate class name
      final className = baseName
          .split('_')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join('');

      // Generate display name
      final displayName = baseName
          .split('_')
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join(' ');

      viewFiles.add({
        'fileName': fileName,
        'className': className,
        'displayName': displayName,
        'route': '/${baseName.replaceAll('_', '-')}',
        'group': group,
        'relativePath':
            entity.path.replaceAll("\\", "/").replaceAll("/", "\\\\"),
      });
    }
  }

  return viewFiles;
}

String generateViewListContent(
    Map<String, List<Map<String, String>>> groupedViews) {
  // Generate imports for all views


  return '''
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';
final Map<String, List<Map<String, dynamic>>> views = {
${groupedViews.entries.map((entry) => '''  '${entry.key}': [
${entry.value.map((view) => '''    {
      'title': '${view['displayName']}',
      'className': '${view['className']}',
      'view': ${view['className']}(),
      'relativePath': '${view['relativePath']}',
      'onTap': () => to(${view['className']}()),
    },''').join('\n')}
  ],''').join('\n')}
};
''';
}
