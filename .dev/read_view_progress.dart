import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  // Read and parse the JSON file
  final file = File('views_progress.json');
  final jsonString = await file.readAsString();
  final jsonData = jsonDecode(jsonString);

  // Check if batch number argument is provided
  if (args.isEmpty) {
    // Print summary when no arguments provided
    _printSummary(jsonData);
    return;
  }

  // Parse batch number argument
  final batchNumber = int.tryParse(args[0]);
  if (batchNumber == null || batchNumber <= 0) {
    print('Error: Please provide a valid batch number (positive number)');
    print('Usage: dart read_view_progress.dart [batch_number]');
    print('Example: dart read_view_progress.dart 2');
    return;
  }

  // Print specific batch of missing views
  _printSpecificBatch(jsonData, batchNumber);
}

void _printSummary(Map<String, dynamic> jsonData) {
  // Print summary information
  final summary = jsonData['summary'];
  print('=== VIEWS PROGRESS SUMMARY ===');
  print('Total Expected Views: ${summary['totalExpectedViews']}');
  print('Total Created Views: ${summary['totalCreatedViews']}');
  print('Total Missing Views: ${summary['totalMissingViews']}');
  print('Overall Progress: ${summary['overallProgress']}%');
  print('Status: ${summary['status']}');
  print('Generated On: ${summary['generatedOn']}');
  print('');

  // Print section details
  print('=== SECTION BREAKDOWN ===');
  final sections = jsonData['sections'] as List;
  for (final section in sections) {
    if (section is Map && section.containsKey('name')) {
      final name = section['name'];
      final progress = section['progress'];
      final created = section['createdViews'];
      final total = section['totalViews'];
      final missing = section['missingViews'];
      
      print('$name:');
      print('  Progress: ${progress}% ($created/$total created, $missing missing)');
      print('');
    }
  }

  // Print first 10 missing views as examples
  print('=== SAMPLE MISSING VIEWS ===');
  final missingViews = jsonData['allMissingViews'] as List;
  final sampleSize = missingViews.length > 10 ? 10 : missingViews.length;
  for (int i = 0; i < sampleSize; i++) {
    print('${i + 1}. ${missingViews[i]}');
  }
  if (missingViews.length > 10) {
    print('... and ${missingViews.length - 10} more');
  }
}

void _printSpecificBatch(Map<String, dynamic> jsonData, int batchNumber) {
  final missingViews = jsonData['allMissingViews'] as List;
  const batchSize = 10; // Fixed batch size of 10 views
  
  if (missingViews.isEmpty) {
    print('No missing views found!');
    return;
  }

  final totalBatches = (missingViews.length / batchSize).ceil();
  
  // Check if requested batch number is valid
  if (batchNumber > totalBatches) {
    print('Error: Batch $batchNumber does not exist!');
    print('Total available batches: $totalBatches');
    print('Total missing views: ${missingViews.length}');
    return;
  }

  // Calculate start and end index for the requested batch
  final startIndex = (batchNumber - 1) * batchSize;
  final endIndex = (startIndex + batchSize > missingViews.length) 
      ? missingViews.length 
      : startIndex + batchSize;
  
  // Print batch information
  print('=== BATCH $batchNumber of $totalBatches ===');
  print('Views ${startIndex + 1}-$endIndex of ${missingViews.length} total missing views');
  print('');
  
  // Print the views in this batch
  for (int i = startIndex; i < endIndex; i++) {
    print('${i + 1}. ${missingViews[i]}');
  }
  
  print('');
  print('=== BATCH SUMMARY ===');
  print('Displayed ${endIndex - startIndex} views from batch $batchNumber');
}