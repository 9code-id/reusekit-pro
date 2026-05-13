import 'dart:io';
import 'dart:convert';

void main() async {
  print('🔍 Starting unused file removal process...\n');
  
  try {
    // Read views.json file
    final viewsFile = File('views.json');
    if (!viewsFile.existsSync()) {
      print('❌ views.json file not found!');
      return;
    }

    // Parse JSON content
    final jsonContent = await viewsFile.readAsString();
    final jsonData = json.decode(jsonContent) as Map<String, dynamic>;
    
    // Extract all view filenames from sections
    final Set<String> allowedFiles = <String>{};
    final sections = jsonData['sections'] as List<dynamic>;
    
    for (final section in sections) {
      final sectionData = section as Map<String, dynamic>;
      final views = sectionData['views'] as List<dynamic>;
      
      for (final view in views) {
        allowedFiles.add(view as String);
      }
    }
    
    print('📄 Found ${allowedFiles.length} files listed in views.json');
    
    // Get all files in lib/presentation directory
    final presentationDir = Directory('lib/presentation');
    if (!presentationDir.existsSync()) {
      print('❌ lib/presentation directory not found!');
      return;
    }
    
    final List<FileSystemEntity> files = presentationDir.listSync();
    final List<String> dartFiles = files
        .where((file) => file is File && file.path.endsWith('.dart'))
        .map((file) => file.path.split('\\').last)
        .toList();
    
    print('📁 Found ${dartFiles.length} .dart files in lib/presentation directory\n');
    
    // Find unused files
    final List<String> unusedFiles = dartFiles
        .where((file) => !allowedFiles.contains(file))
        .toList();
    
    if (unusedFiles.isEmpty) {
      print('✅ No unused files found! All files are listed in views.json');
      return;
    }
    
    print('🗑️  Found ${unusedFiles.length} unused files:');
    for (final file in unusedFiles) {
      print('   - $file');
    }
    
    // Delete unused files
    int deletedCount = 0;
    int failedCount = 0;
    
    print('\n🗑️  Deleting unused files...');
    
    for (final fileName in unusedFiles) {
      try {
        final file = File('lib/presentation/$fileName');
        if (file.existsSync()) {
          await file.delete();
          print('   ✅ Deleted: $fileName');
          deletedCount++;
        } else {
          print('   ⚠️  File not found: $fileName');
        }
      } catch (e) {
        print('   ❌ Failed to delete $fileName: $e');
        failedCount++;
      }
    }
    
    // Summary
    print('\n📊 SUMMARY:');
    print('   • Total unused files found: ${unusedFiles.length}');
    print('   • Successfully deleted: $deletedCount');
    if (failedCount > 0) {
      print('   • Failed to delete: $failedCount');
    }
    print('   • Files remaining in views.json: ${allowedFiles.length}');
    
    final remainingFiles = Directory('lib/presentation')
        .listSync()
        .where((file) => file is File && file.path.endsWith('.dart'))
        .length;
    
    print('   • Files remaining in lib/presentation: $remainingFiles');
    
    if (deletedCount > 0) {
      print('\n✅ Cleanup completed successfully!');
    }
    
  } catch (e) {
    print('❌ Error occurred: $e');
    print('   Please check if views.json is valid JSON format');
  }
}