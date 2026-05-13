import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport1View extends StatefulWidget {
  @override
  State<GrlImport1View> createState() => _GrlImport1ViewState();
}

class _GrlImport1ViewState extends State<GrlImport1View> {
  bool isLoading = false;
  String selectedFormat = "csv";
  String importProgress = "";
  double progressValue = 0.0;
  int importedRecords = 0;
  int totalRecords = 0;
  String selectedFile = "";
  
  List<Map<String, dynamic>> supportedFormats = [
    {
      "format": "csv",
      "name": "CSV (Comma Separated)",
      "icon": Icons.table_chart,
      "description": "Standard CSV format with comma separators",
      "maxSize": "50 MB",
      "extensions": [".csv"]
    },
    {
      "format": "excel",
      "name": "Microsoft Excel",
      "icon": Icons.grid_on,
      "description": "Excel workbook files (.xlsx, .xls)",
      "maxSize": "100 MB",
      "extensions": [".xlsx", ".xls"]
    },
    {
      "format": "json",
      "name": "JSON Format",
      "icon": Icons.code,
      "description": "JavaScript Object Notation format",
      "maxSize": "25 MB",
      "extensions": [".json"]
    },
    {
      "format": "xml",
      "name": "XML Format",
      "icon": Icons.description,
      "description": "Extensible Markup Language format",
      "maxSize": "25 MB",
      "extensions": [".xml"]
    },
    {
      "format": "tsv",
      "name": "TSV (Tab Separated)",
      "icon": Icons.table_rows,
      "description": "Tab-separated values format",
      "maxSize": "50 MB",
      "extensions": [".tsv", ".txt"]
    }
  ];

  List<Map<String, dynamic>> importHistory = [
    {
      "id": 1,
      "fileName": "customers_2024.csv",
      "format": "CSV",
      "records": 15420,
      "status": "completed",
      "date": "2024-06-22 14:30:00",
      "duration": "2m 15s"
    },
    {
      "id": 2,
      "fileName": "products_inventory.xlsx",
      "format": "Excel",
      "records": 8950,
      "status": "completed",
      "date": "2024-06-21 16:45:00",
      "duration": "1m 45s"
    },
    {
      "id": 3,
      "fileName": "orders_data.json",
      "format": "JSON",
      "records": 3420,
      "status": "failed",
      "date": "2024-06-21 10:30:00",
      "duration": "0m 30s"
    },
    {
      "id": 4,
      "fileName": "user_settings.xml",
      "format": "XML",
      "records": 156,
      "status": "completed",
      "date": "2024-06-20 14:15:00",
      "duration": "0m 45s"
    },
    {
      "id": 5,
      "fileName": "report_data.tsv",
      "format": "TSV",
      "records": 2890,
      "status": "partial",
      "date": "2024-06-20 09:20:00",
      "duration": "1m 20s"
    }
  ];

  Map<String, dynamic>? get selectedFormatInfo {
    return supportedFormats.firstWhere(
      (format) => format["format"] == selectedFormat,
      orElse: () => supportedFormats.first,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return successColor;
      case 'partial':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'Completed';
      case 'partial':
        return 'Partial';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  void _selectFile() {
    // Simulate file selection
    selectedFile = "sample_data.${selectedFormat}";
    totalRecords = 5420;
    setState(() {});
    ss("File selected: $selectedFile");
  }

  Future<void> _startImport() async {
    if (selectedFile.isEmpty) {
      se("Please select a file to import");
      return;
    }

    isLoading = true;
    progressValue = 0.0;
    importedRecords = 0;
    importProgress = "Initializing import...";
    setState(() {});

    List<String> steps = [
      "Reading file headers...",
      "Validating data format...",
      "Processing records...",
      "Importing data...",
      "Finalizing import...",
      "Import completed!"
    ];

    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(Duration(seconds: 2));
      importProgress = steps[i];
      progressValue = (i + 1) / steps.length;
      importedRecords = ((totalRecords * progressValue).round());
      setState(() {});
    }

    isLoading = false;
    setState(() {});
    
    ss("Import completed successfully - $importedRecords records imported");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Data"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Import Progress (if active)
            if (isLoading)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: infoColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: infoColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Importing Data",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                importProgress,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${(progressValue * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                    ),
                    Text(
                      "$importedRecords of $totalRecords records imported",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // File Format Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select File Format",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: supportedFormats.map((format) {
                      bool isSelected = selectedFormat == format["format"];
                      
                      return GestureDetector(
                        onTap: isLoading ? null : () {
                          selectedFormat = "${format["format"]}";
                          selectedFile = "";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withAlpha(10)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(isSelected ? 30 : 10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      format["icon"] as IconData,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    isSelected 
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                ],
                              ),
                              Text(
                                "${format["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${format["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.file_present,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    (format["extensions"] as List).join(", "),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.storage,
                                    size: 12,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Max: ${format["maxSize"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // File Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Select File",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  if (selectedFormatInfo != null) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                selectedFormatInfo!["icon"] as IconData,
                                color: infoColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Selected Format: ${selectedFormatInfo!["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Supported extensions: ${(selectedFormatInfo!["extensions"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Maximum file size: ${selectedFormatInfo!["maxSize"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  if (selectedFile.isEmpty)
                    GestureDetector(
                      onTap: isLoading ? null : _selectFile,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spLg),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: primaryColor,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 48,
                              color: primaryColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "Click to select file",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "or drag and drop your file here",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.insert_drive_file,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedFile,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Ready to import • $totalRecords records estimated",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: isLoading ? null : () {
                              selectedFile = "";
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Import Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Import Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Skip duplicate records",
                        "value": true,
                        "checked": true,
                      }
                    ],
                    value: [{"label": "Skip duplicate records", "value": true, "checked": true}],
                    onChanged: (values, ids) {},
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Validate data before import",
                        "value": true,
                        "checked": true,
                      }
                    ],
                    value: [{"label": "Validate data before import", "value": true, "checked": true}],
                    onChanged: (values, ids) {},
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Create backup before import",
                        "value": true,
                        "checked": false,
                      }
                    ],
                    value: [],
                    onChanged: (values, ids) {},
                  ),
                ],
              ),
            ),

            // Import History
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Import History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...importHistory.take(3).map((import) {
                    DateTime importDate = DateTime.parse("${import["date"]}");
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${import["status"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getStatusColor("${import["status"]}"),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${import["fileName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${import["format"]} • ${import["records"]} records",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXxs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${import["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText("${import["status"]}"),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${importDate.dMMMy} • ${import["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Import Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Importing..." : "Start Import",
                icon: Icons.file_upload,
                size: bs.md,
                onPressed: isLoading ? null : _startImport,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
