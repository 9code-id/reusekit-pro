import 'dart:io';
import 'dart:convert';

void main() async {
  try {
    // Read the errors.json file
    final file = File('.dev\\log\\errors.json');
    final jsonString = await file.readAsString();
    final jsonData = jsonDecode(jsonString);

    // Get all unique file paths from violations
    Set<String> errorFiles = <String>{};
    
    if (jsonData['violations'] != null) {
      final violations = jsonData['violations'] as Map<String, dynamic>;
      
      for (String widgetType in violations.keys) {
        final files = violations[widgetType] as List<dynamic>;
        for (String filePath in files) {
          errorFiles.add(filePath);
        }
      }
    }

    print('Total violation files to delete: ${errorFiles.length}');
    print('Violations found: ${jsonData['total_violations'] ?? 0}');

    // Delete each file
    int deletedCount = 0;
    int notFoundCount = 0;
    
    for (String filePath in errorFiles) {
      final fileToDelete = File(filePath);

      if (await fileToDelete.exists()) {
        await fileToDelete.delete();
        deletedCount++;
        print('Deleted: $filePath');
      } else {
        notFoundCount++;
        print('File not found: $filePath');
      }
    }

    print('\nFile deletion completed.');
    print('Files deleted: $deletedCount');
    print('Files not found: $notFoundCount');

    // Clear the errors.json file
    final clearedData = {
      "scan_date": DateTime.now().toIso8601String(),
      "total_violations": 0,
      "forbidden_widgets": jsonData['forbidden_widgets'] ?? [],
      "violation_summary": {},
      "violations": {}
    };
    
    await file.writeAsString(jsonEncode(clearedData));

    print('.dev\\log\\errors.json cleared.');
  } catch (e) {
    print('Error: $e');
  }
}
