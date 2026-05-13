import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaImportDataView extends StatefulWidget {
  const CmaImportDataView({super.key});

  @override
  State<CmaImportDataView> createState() => _CmaImportDataViewState();
}

class _CmaImportDataViewState extends State<CmaImportDataView> {
  String selectedSource = "File Upload";
  String selectedFormat = "Excel (.xlsx)";
  String importMode = "Append";
  String targetTable = "Sales Data";
  bool validateData = true;
  bool createBackup = true;
  bool skipDuplicates = true;
  bool sendNotification = false;
  String notificationEmail = "";
  bool loading = false;
  double uploadProgress = 0.0;

  List<String> uploadedFiles = [];
  List<Map<String, dynamic>> importHistory = [];

  List<Map<String, dynamic>> importSources = [
    {
      "name": "File Upload",
      "description": "Upload files from your device",
      "icon": Icons.upload_file,
      "formats": ["Excel (.xlsx)", "CSV (.csv)", "JSON (.json)", "XML (.xml)"]
    },
    {
      "name": "Database Connection",
      "description": "Import from external database",
      "icon": Icons.storage,
      "formats": ["MySQL", "PostgreSQL", "SQL Server", "Oracle"]
    },
    {
      "name": "API Integration",
      "description": "Import via REST API endpoint",
      "icon": Icons.api,
      "formats": ["REST API", "GraphQL", "SOAP"]
    },
    {
      "name": "Cloud Storage",
      "description": "Import from cloud storage services",
      "icon": Icons.cloud,
      "formats": ["Google Drive", "Dropbox", "OneDrive", "AWS S3"]
    },
    {
      "name": "FTP/SFTP",
      "description": "Import from FTP server",
      "icon": Icons.folder_shared,
      "formats": ["FTP", "SFTP", "FTPS"]
    }
  ];

  List<Map<String, dynamic>> recentImports = [
    {
      "filename": "customer_data_Q4.xlsx",
      "source": "File Upload",
      "records": 2450,
      "status": "Completed",
      "date": "2024-01-15 10:30",
      "size": "1.2 MB",
      "table": "Customers"
    },
    {
      "filename": "sales_transactions.csv",
      "source": "File Upload",
      "records": 8920,
      "status": "Completed",
      "date": "2024-01-14 14:15",
      "size": "3.4 MB",
      "table": "Sales"
    },
    {
      "filename": "inventory_update.json",
      "source": "API Integration",
      "records": 1560,
      "status": "Failed",
      "date": "2024-01-13 09:45",
      "size": "890 KB",
      "table": "Inventory"
    },
    {
      "filename": "employee_data.xlsx",
      "source": "Cloud Storage",
      "records": 340,
      "status": "Processing",
      "date": "2024-01-12 16:20",
      "size": "456 KB",
      "table": "Employees"
    }
  ];

  List<Map<String, dynamic>> validationResults = [
    {
      "type": "Error",
      "count": 12,
      "description": "Missing required fields",
      "color": dangerColor
    },
    {
      "type": "Warning",
      "count": 8,
      "description": "Data format inconsistencies",
      "color": warningColor
    },
    {
      "type": "Info",
      "count": 3,
      "description": "Duplicate records found",
      "color": infoColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showImportHistory,
          ),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showImportGuide,
          ),
        ],
      ),
      body: loading
          ? _buildImportProgress()
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildImportSummary(),
                  _buildSourceSelection(),
                  _buildFileUploadSection(),
                  _buildImportConfiguration(),
                  _buildDataValidation(),
                  _buildImportButton(),
                  _buildRecentImports(),
                ],
              ),
            ),
    );
  }

  Widget _buildImportProgress() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(spLg),
        margin: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Icon(
              Icons.cloud_upload,
              size: 64,
              color: primaryColor,
            ),
            Text(
              "Importing Data...",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: uploadProgress,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
              ),
            ),
            Text(
              "${(uploadProgress * 100).toStringAsFixed(0)}% Complete",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            QButton(
              label: "Cancel Import",
              size: bs.sm,
              onPressed: _cancelImport,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: successColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.cloud_upload, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Import Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Source", selectedSource, Icons.source),
              ),
              Expanded(
                child: _buildSummaryItem("Format", selectedFormat, Icons.file_present),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem("Mode", importMode, Icons.merge),
              ),
              Expanded(
                child: _buildSummaryItem("Target", targetTable, Icons.table_chart),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: disabledBoldColor, size: 16),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSourceSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.input, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Import Source",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...importSources.map((source) => _buildSourceOption(source)),
        ],
      ),
    );
  }

  Widget _buildSourceOption(Map<String, dynamic> source) {
    bool isSelected = source["name"] == selectedSource;

    return GestureDetector(
      onTap: () {
        selectedSource = source["name"] as String;
        // Update available formats
        List<String> formats = source["formats"] as List<String>;
        if (!formats.contains(selectedFormat)) {
          selectedFormat = formats.first;
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                source["icon"] as IconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${source["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${source["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadSection() {
    if (selectedSource != "File Upload") return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "File Upload",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "File Format",
            items: [
              {"label": "Excel (.xlsx)", "value": "Excel (.xlsx)"},
              {"label": "CSV (.csv)", "value": "CSV (.csv)"},
              {"label": "JSON (.json)", "value": "JSON (.json)"},
              {"label": "XML (.xml)", "value": "XML (.xml)"}
            ],
            value: selectedFormat,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          GestureDetector(
            onTap: _selectFiles,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Icon(
                    Icons.cloud_upload,
                    size: 48,
                    color: primaryColor,
                  ),
                  Text(
                    "Drop files here or click to browse",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Supported formats: ${selectedFormat}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (uploadedFiles.isNotEmpty) ...[
            SizedBox(height: spSm),
            ...uploadedFiles.map((file) => _buildUploadedFileItem(file)),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadedFileItem(String filename) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.insert_drive_file, color: successColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Ready for import",
                  style: TextStyle(
                    fontSize: 11,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.delete,
            size: bs.sm,
            onPressed: () => _removeFile(filename),
          ),
        ],
      ),
    );
  }

  Widget _buildImportConfiguration() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Import Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Import Mode",
                  items: [
                    {"label": "Append", "value": "Append"},
                    {"label": "Replace", "value": "Replace"},
                    {"label": "Update", "value": "Update"},
                    {"label": "Merge", "value": "Merge"}
                  ],
                  value: importMode,
                  onChanged: (value, label) {
                    importMode = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Target Table",
                  items: [
                    {"label": "Sales Data", "value": "Sales Data"},
                    {"label": "Customer Data", "value": "Customer Data"},
                    {"label": "Product Data", "value": "Product Data"},
                    {"label": "Financial Data", "value": "Financial Data"},
                    {"label": "Employee Data", "value": "Employee Data"}
                  ],
                  value: targetTable,
                  onChanged: (value, label) {
                    targetTable = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Validate Data Before Import",
                "value": "validate",
                "checked": validateData,
              }
            ],
            value: validateData ? [{"label": "Validate Data Before Import", "value": "validate", "checked": true}] : [],
            onChanged: (values, ids) {
              validateData = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Create Backup Before Import",
                "value": "backup",
                "checked": createBackup,
              }
            ],
            value: createBackup ? [{"label": "Create Backup Before Import", "value": "backup", "checked": true}] : [],
            onChanged: (values, ids) {
              createBackup = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Skip Duplicate Records",
                "value": "skip",
                "checked": skipDuplicates,
              }
            ],
            value: skipDuplicates ? [{"label": "Skip Duplicate Records", "value": "skip", "checked": true}] : [],
            onChanged: (values, ids) {
              skipDuplicates = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataValidation() {
    if (!validateData) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.verified, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Data Validation Results",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Run Validation",
                size: bs.sm,
                onPressed: _runValidation,
              ),
            ],
          ),
          if (validationResults.isNotEmpty) ...[
            ...validationResults.map((result) => _buildValidationResult(result)),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Review validation results before proceeding with import",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildValidationResult(Map<String, dynamic> result) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: (result["color"] as Color).withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (result["color"] as Color).withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: result["color"] as Color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${result["type"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: result["color"] as Color,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (result["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${result["count"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: result["color"] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${result["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportButton() {
    bool canImport = uploadedFiles.isNotEmpty || selectedSource != "File Upload";

    return Container(
      width: double.infinity,
      child: QButton(
        label: "Start Import",
        icon: Icons.play_arrow,
        size: bs.md,
        onPressed: canImport ? _startImport : null,
      ),
    );
  }

  Widget _buildRecentImports() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Recent Imports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: _showImportHistory,
              ),
            ],
          ),
          ...recentImports.take(3).map((import) => _buildImportItem(import)),
        ],
      ),
    );
  }

  Widget _buildImportItem(Map<String, dynamic> import) {
    Color statusColor = import["status"] == "Completed" ? successColor :
                       import["status"] == "Processing" ? warningColor :
                       import["status"] == "Failed" ? dangerColor : infoColor;
    IconData statusIcon = import["status"] == "Completed" ? Icons.check_circle :
                         import["status"] == "Processing" ? Icons.schedule :
                         import["status"] == "Failed" ? Icons.error : Icons.info;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${import["filename"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${import["records"]} records • ${import["size"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${import["date"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (import["status"] == "Failed") ...[
            SizedBox(width: spSm),
            QButton(
              icon: Icons.refresh,
              size: bs.sm,
              onPressed: () => _retryImport(import["filename"] as String),
            ),
          ],
        ],
      ),
    );
  }

  void _selectFiles() {
    // Simulate file selection
    uploadedFiles.add("sample_data.xlsx");
    setState(() {});
    si("File selected successfully");
  }

  void _removeFile(String filename) {
    uploadedFiles.remove(filename);
    setState(() {});
  }

  void _runValidation() {
    si("Running data validation...");
    // Validation results are already populated for demo
  }

  void _startImport() async {
    loading = true;
    uploadProgress = 0.0;
    setState(() {});

    // Simulate import process
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 200));
      uploadProgress = i / 100;
      setState(() {});
    }

    loading = false;
    setState(() {});
    ss("Import completed successfully! ${uploadedFiles.length} files imported");
    uploadedFiles.clear();
  }

  void _cancelImport() {
    loading = false;
    uploadProgress = 0.0;
    setState(() {});
    sw("Import cancelled");
  }

  void _retryImport(String filename) {
    si("Retrying import for $filename...");
  }

  void _showImportHistory() {
    si("Opening import history...");
  }

  void _showImportGuide() {
    si("Opening import guide...");
  }
}
