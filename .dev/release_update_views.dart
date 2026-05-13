import 'dart:convert';
import 'dart:io';

void main() async {
  // Read the views.json file
  final file =
      File(r'C:\Users\Administrator\Desktop\reusekit_codespace\views.json');
  final jsonString = await file.readAsString();
  final Map<String, dynamic> data = json.decode(jsonString);

  final sections = data['sections'] as List<dynamic>;
  final count = (sections.length / 10).ceil();
  for (var n = 0; n < count; n++) {
    var number = n + 1;
    var startIndex = n * 10;

    var endIndex = (startIndex + 10).clamp(0, sections.length);
    final selectedSections = sections.sublist(startIndex, endIndex);

    // Create new data structure with selected sections
    final updatedData = {'sections': selectedSections};

    // Convert back to JSON with proper formatting
    final jsonEncoder = JsonEncoder.withIndent('  ');
    final formattedJson = jsonEncoder.convert(updatedData);

    // Write to current file
    var outputFile = File(
        "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number\\views.json");
    outputFile.createSync(recursive: true);
    await outputFile.writeAsString(formattedJson);
    print('Created: ${outputFile.path}');
    // Update Android build.gradle
    updateAndroidBuildGradle(
        "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number",
        number);
    // Update AndroidManifest.xml
    updateAndroidManifestName(
        "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number",
        number);
  }
}

//update android\app\build.gradle
//replace com.cz.reusekit to com.cz.reusekit1
void updateAndroidBuildGradle(String path, int number) {
  final file = File('$path\\android\\app\\build.gradle');
  if (!file.existsSync()) {
    print('❌ File not found: ${file.path}');
    return;
  }
  final content = file.readAsStringSync();
  final updatedContent =
      content.replaceAll('com.cz.reusekit', 'com.cz.reusekit$number');
  file.writeAsStringSync(updatedContent);
  print('✅ Updated build.gradle: ${file.path}');
}


void updateAndroidManifestName(String path, int number) {
  final file = File('$path\\android\\app\\src\\main\\AndroidManifest.xml');
  if (!file.existsSync()) {
    print('❌ File not found: ${file.path}');
    return;
  }
  final content = file.readAsStringSync();
  var updatedContent =
      content.replaceAll('com.cz.reusekit', 'com.cz.reusekit$number');
      updatedContent =
          updatedContent.replaceAll('="Reusekit"', '="Reusekit$number"');
  file.writeAsStringSync(updatedContent);
  print('✅ Updated AndroidManifest.xml: ${file.path}');
}