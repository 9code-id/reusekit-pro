import 'dart:io';

void main() {
  //run flutter analyze and get results
  print('🔍 Running Flutter Analyzer...\n');
  final result = Process.runSync('fvm', ['flutter', 'analyze', '.']);
  if (result.exitCode != 0) {
    var content = result.stdout.toString();
    var lines = content.split("\n");
    //remove lines that not contains error -
    lines = lines.where((line) => line.contains('error - ')).toList();
    for (var line in lines) {
      var arr = line.split(" - ");
      if (arr.length > 3) {
        var errorDetail = arr[1];
        var filePath = arr[2].toString().split(":")[0].trim();
        if (filePath.indexOf('presentation') == -1) {
          continue; // skip files that are not in the presentation folder
        }

        var file = File(filePath);
        if (file.existsSync()) {
          file.deleteSync();
          print("❌ Force Delete file: $filePath, ${errorDetail}");
        }
      }
    }
    content = lines.join("\n");

    // save result to analyzed.txt
    final analyzedFile = File('.dev\\log\\analyzed.txt');
    analyzedFile.writeAsStringSync(content);
    print('📄 Analysis results saved to analyzed.txt');

    //run code analyzed.txt
    Process.runSync(
      'code',
      ['analyzed.txt'],
      workingDirectory: Directory.current.path,
      runInShell: true,
    );
  } else {
    print('✅ No issues found by Flutter Analyzer.');
  }
}
