import 'dart:io';

void main() {
  var list =
      Directory("${Directory.current.path}\\lib").listSync(recursive: true);
  List dartFiles = [];
  for (var f in list) {
    if (f is Directory) continue;
    if (f is File) {
      String path = f.path;
      if (!path.endsWith(".dart")) continue;
      if (path.indexOf("lib/model") > -1) continue;
      if (path.indexOf("lib/models") > -1) continue;
      if (path.indexOf("lib/core.dart") > -1) continue;
      if (path.indexOf("lib/main.dart") > -1) continue;
      if (path.indexOf("lib/generated_plugin_registrant.dart") > -1) continue;
      //-----------------------------------------------
      String fileName = f.path.split('\\').last;
      if (path.endsWith(".freezed.dart")) continue;
      if (path.endsWith(".g.dart")) continue;
      if (path.endsWith(".gr.dart")) continue;
      if (path.endsWith("main.dart")) continue;
      if (path.endsWith("core.dart")) continue;

      String content = f.readAsStringSync();
      if (content.split('\n').any((line) => line.trimLeft().startsWith('part of '))) continue;
      if (content.contains("class Datum")) continue;
      if (content.contains("//@excluded_from_core.dart")) continue;

      dartFiles.add(path);
    }
  }

  List exportScripts = [];
  for (var f in dartFiles) {
    String relativePath = f
        .replaceAll("${Directory.current.path}\\lib\\", "")
        .replaceAll("\\", "/");
    String exportScript = "export 'package:reusekit/$relativePath';";
    exportScripts.add(exportScript);
  }

  //save to lib/core.dart
  String corexFilePath = "${Directory.current.path}\\lib\\core.dart";
  File corexFile = File(corexFilePath);
  if (!corexFile.existsSync()) {
    corexFile.createSync(recursive: true);
  }
  corexFile.writeAsStringSync("""
/*
We believe, the class name must be unique. 
If there is a conflicting class name in this file,
it means you have to rename it to something more unique.
fileCount: ${dartFiles.length}
*/
${exportScripts.join("\n")}
""");
}
