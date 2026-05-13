import 'dart:io';
import 'dart:convert';

void main() async {
  try {
    // Read the errors.json file
    final file = File('.dev\\log\\error_ui.json');
    final jsonString = await file.readAsString();
    var jsonData = jsonDecode(jsonString);

    List errorss = jsonData['errors'] ?? [];
    List newErrors = [];
    for (var i = 0; i < errorss.length; i++) {
      var error = errorss[i];
      var path = error['view'];
      var errorDetails = error['errorDetails'].toString();
      if (errorDetails.contains("errorDetails")) {
        newErrors.add(error);
        continue;
      }

      if (File(path).existsSync()) {
        File(path).deleteSync();
        errorss.removeAt(i);
      }
      else {
        print('File not found: $path');
      }
    }

    //save again 
    jsonData = {
      "errorCount": newErrors.length,
      "generatedAt": DateTime.now().toIso8601String(),
      "errors": newErrors,
    };
    await file.writeAsString(jsonEncode(jsonData));
  } catch (e) {
    print('Error: $e');
  }
}
