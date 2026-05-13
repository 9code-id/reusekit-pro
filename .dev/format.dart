import 'dart:io';

void main() async {
  //baca semua file .dart di lib/presentation
  //jika ada lebih dari satu class di dalam file, print
  final viewsDir = Directory('lib/presentation');
  if (!viewsDir.existsSync()) {
    print('❌ Directory lib/presentation does not exist!');
    return;
  }
  var list = viewsDir.listSync(recursive: true);
  var dartFiles = list
      .where((file) =>
          file.path.endsWith('.dart') && !file.path.contains('app_view.dart'))
      .toList();
  if (dartFiles.isEmpty) {
    print('❌ No Dart files found in lib/presentation directory!');
    return;
  }

  print('📁 Found ${dartFiles.length} Dart files:');
  for (var file in dartFiles) {
    var content = File(file.path).readAsStringSync();
    var classMatches = RegExp(
            r'class\s+(\w+)(?:\s+extends\s+\w+)?(?:\s+with\s+\w+)?(?:\s+implements\s+\w+)?\s*{')
        .allMatches(content);
    if (classMatches.length > 1) {
      print('❗️ File ${file.path} contains multiple classes:');

      var arr = content.split("class ");
      if (arr.length > 3) {
        if (arr[3].trim().split("\n")[0].contains("Painter")) continue;
        print(arr[3]);
        print(
            '❗️ File ${file.path} contains more than 2 classes, please check it!');
      }
    }
  }
}
