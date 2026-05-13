import 'dart:io';

void main(List args) {
  //first argument can be dir path or file path
  if (args.isEmpty) {
    print('Please provide a directory or file path as an argument.');
    return;
  }

  var path = args[0];
  if (isDirectory(path)) {
    print('The path "$path" is a directory.');
    //deleteSync dir
    final dir = Directory(path);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
      print('Directory "$path" has been deleted successfully.');
    } else {
      print('Directory "$path" does not exist.');
    }
  } else if (isFile(path)) {
    print('The path "$path" is a file.');
    //deleteSync file
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync(recursive: true);
      print('File "$path" has been deleted successfully.');
    } else {
      print('File "$path" does not exist.');
    }
  } else {
    print(
        'The path "$path" does not exist or is neither a file nor a directory.');
  }
}

bool isDirectory(String path) {
  final dir = Directory(path);
  return dir.existsSync() &&
      dir.statSync().type == FileSystemEntityType.directory;
}

bool isFile(String path) {
  final file = File(path);
  return file.existsSync() && file.statSync().type == FileSystemEntityType.file;
}
