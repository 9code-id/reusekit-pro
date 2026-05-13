import 'dart:convert';
import 'dart:io';

void main() async {
  // Read the views.json file
  final file = File(
    r'C:\Users\Administrator\Desktop\reusekit_codespace\views.json',
  );
  final jsonString = await file.readAsString();
  final Map<String, dynamic> data = json.decode(jsonString);

  final sections = data['sections'] as List<dynamic>;
  final count = (sections.length / 10).ceil();
  List commands = [];
  List dev3Commands = [];
  List zipCommands = [];
  List dirNames = [];
  for (var n = 0; n < count; n++) {
    var number = n + 1;
    var startIndex = n * 10;

    //execute .dev/release.bat reusekit$number
    commands.add(
      "${Directory.current.path}\\.dev\\release.bat reusekit$number",
    );
    // Add dev3 command for current project
    dev3Commands.add(
      "cd C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number && "
      "dev.bat 3 && "
      "dart pub get",
    );

    // Add zip preparation commands for current project
    var targetDir =
        "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number";
    zipCommands.add(
      [
        "dart .dev\\delete_util.dart $targetDir\\build",
        "dart .dev\\delete_util.dart $targetDir\\.dart_tool",
        "dart .dev\\delete_util.dart $targetDir\\.dev",
        "dart .dev\\delete_util.dart $targetDir\\dev.bat",
        "dart .dev\\delete_util.dart $targetDir\\views.json",
        "cd $targetDir && flutter clean && ^",
      ].join(" && ^\n"),
    );

    dirNames.add("reusekit$number");

    var endIndex = (startIndex + 10).clamp(0, sections.length);
    final selectedSections = sections.sublist(startIndex, endIndex);

    // Create new data structure with selected sections
    final updatedData = {'sections': selectedSections};

    // Convert back to JSON with proper formatting
    final jsonEncoder = JsonEncoder.withIndent('  ');
    final formattedJson = jsonEncoder.convert(updatedData);

    // Write to current file
    var outputFile = File(
      "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number\\views.json",
    );
    outputFile.createSync(recursive: true);
    await outputFile.writeAsString(formattedJson);
    print('Created: ${outputFile.path}');

    // Update Android build.gradle
    updateAndroidBuildGradle(
      "C:\\Users\\Administrator\\Desktop\\reusekit_codes\\reusekit$number",
      number,
    );
  }

  //save commands to commands.bat
  var commandsFile = File("${Directory.current.path}\\commands.bat");
  commandsFile.createSync(recursive: true);
  await commandsFile.writeAsString(commands.join(' && '));

  //save commands to commands.bat
  var commandsFile2 = File("${Directory.current.path}\\commands2.bat");
  commandsFile2.createSync(recursive: true);
  await commandsFile2.writeAsString(
    dev3Commands.join(' && ') +
        " && " +
        " cd C:\\Users\\Administrator\\Desktop\\reusekit_codespace",
  );

  //save to commands3.bat
  var commandsFile3 = File("${Directory.current.path}\\commands3.bat");
  commandsFile3.createSync(recursive: true);
  await commandsFile3.writeAsString(
    [
      zipCommands.join('\n'),
      "cd C:\\Users\\Administrator\\Desktop\\reusekit_codes",
      "7z a -tzip -preusekit0901 public\\reusekit_projects_protected.zip ${dirNames.join(" ")} documentation.html",
      "7z a -tzip reusekit_projects.zip ${dirNames.join(" ")} documentation.html",
      "cd C:\\Users\\Administrator\\Desktop\\reusekit_codespace",
    ].join(" && ^\n").replaceAll('&& ^ && ^', '&& ^'),
  );
}

void updateAndroidBuildGradle(String path, int number) {
  final file = File('$path\\android\\app\\build.gradle');
  if (!file.existsSync()) {
    print('❌ File not found: ${file.path}');
    return;
  }
  final content = file.readAsStringSync();
  final updatedContent = content.replaceAll(
    'com.cz.reusekit',
    'com.cz.reusekit$number',
  );
  file.writeAsStringSync(updatedContent);
  print('✅ Updated build.gradle: ${file.path}');
}
