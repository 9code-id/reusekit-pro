import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:reusekit/core.dart';

var flutterHandlerErrors = <Map<String, dynamic>>[];
void flutterErrorHandler(FlutterErrorDetails details) async {
  if (kIsWeb || !Platform.isWindows) return;

  if (details.exception.toString().contains("HTTP request failed")) return;
  if (details.exception
      .toString()
      .contains("package:flutter/src/rendering/mouse_tracker.dart")) return;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? currentView = prefs.getString("current_view");
  print('Flutter Error in $currentView: ${details.exceptionAsString()}');

  // Check if error for this view already exists
  bool errorExists = flutterHandlerErrors.any((error) => error["view"] == currentView);
  if (errorExists) {
    return; // Skip if the error for this view is already logged
  }

  // Truncate error details to first 150 characters
  String errorsDetails = details.exceptionAsString();
  if (errorsDetails.length > 150) {
    errorsDetails = errorsDetails.substring(0, 150) + "...";
  }

  // Add error as structured data
  flutterHandlerErrors.add({
    "errorId": "Error${flutterHandlerErrors.length + 1}",
    "view": currentView ?? "Unknown",
    "errorDetails": errorsDetails,
    "timestamp": DateTime.now().toIso8601String(),
  });
  //show viewname
}

void flutterErrorHandlerSaveLogs() {
  print("flutterErrorHandlerSaveLogs()");
  // Create JSON structure
  Map<String, dynamic> errorReport = {
    "errorCount": flutterHandlerErrors.length,
    "generatedAt": DateTime.now().toIso8601String(),
    "errors": flutterHandlerErrors,
  };

  // Write to JSON file
  File(".dev\\log\\error_ui.json").writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(errorReport)
  );
}
