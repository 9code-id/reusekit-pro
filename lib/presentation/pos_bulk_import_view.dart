import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosBulkImportView extends StatefulWidget {
  const PosBulkImportView({super.key});

  @override
  State<PosBulkImportView> createState() => _PosBulkImportViewState();
}

class _PosBulkImportViewState extends State<PosBulkImportView> {
  final formKey = GlobalKey<FormState>();
  
  // Import Configuration
  String importType = "products";
  String fileFormat = "csv";
  List<String> attachedFiles = [];
  bool validateData = true;
  bool skipErrors = false;
  bool updateExisting = false;
  String duplicateHandling = "skip";
  
  // Import Progress
  bool isImporting = false;
  double importProgress = 0.0;
  int totalRecords = 0;
  int processedRecords = 0;
  int successfulRecords = 0;
  int errorRecords = 0;
  List<Map<String, dynamic>> importErrors = [];
  
  // Sample Data
  List<Map<String, dynamic>> importHistory = [
    {
      "id": 1,
      "date": "2024-12-19 14:30",
      "type": "Products",
      "filename": "products_batch_1.csv",
      "total_records": 250,
      "successful": 248,
      "errors": 2,
      "status": "completed",
      "duration": "2m 15s"
    },
    {
      "id": 2,
      "date": "2024-12-18 09:15",
      "type": "Categories",
      "filename": "categories_update.xlsx",
      "total_records": 45,
      "successful": 45,
      "errors": 0,
      "status": "completed",
      "duration": "45s"
    },
    {
      "id": 3,
      "date": "2024-12-17 16:45",
      "type": "Inventory",
      "filename": "stock_levels.csv",
      "total_records": 180,
      "successful": 165,
      "errors": 15,
      "status": "completed_with_errors",
      "duration": "1m 30s"
    },
    {
      "id": 4,
      "date": "2024-12-16 11:20",
      "type": "Products",
      "filename": "new_products.json",
      "total_records": 89,
      "successful": 0,
      "errors": 89,
      "status": "failed",
      "duration": "0m 20s"
    }
  ];
  
  List<Map<String, dynamic>> importTypeOptions = [
    {"label": "Products", "value": "products"},
    {"label": "Categories", "value": "categories"},
    {"label": "Inventory", "value": "inventory"},
    {"label": "Customers", "value": "customers"},
    {"label": "Suppliers", "value": "suppliers"}
  ];
  
  List<Map<String, dynamic>> fileFormatOptions = [
    {"label": "CSV", "value": "csv"},
    {"label": "Excel (XLSX)", "value": "xlsx"},
    {"label": "JSON", "value": "json"},
    {"label": "XML", "value": "xml"}
  ];
  
  List<Map<String, dynamic>> duplicateOptions = [
    {"label": "Skip Duplicates", "value": "skip"},
    {"label": "Update Existing", "value": "update"},
    {"label": "Create New", "value": "create"},
    {"label": "Fail on Duplicate", "value": "fail"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bulk Import"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _showImportHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Import Status Card
              if (isImporting) _buildImportProgressCard(),
              
              // Quick Stats
              _buildQuickStats(),
              
              // Import Configuration Section
              _buildImportConfigSection(),
              
              // File Upload Section
              _buildFileUploadSection(),
              
              // Data Mapping Section
              if (attachedFiles.isNotEmpty) _buildDataMappingSection(),
              
              // Import Options Section
              _buildImportOptionsSection(),
              
              // Import Validation Section
              _buildValidationSection(),
              
              // Import Actions
              _buildImportActions(),
              
              // Recent Import History
              _buildRecentImports(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImportProgressCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, color: infoColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Import in Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Spacer(),
              Text(
                "${(importProgress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ],
          ),
          
          LinearProgressIndicator(
            value: importProgress,
            backgroundColor: infoColor.withAlpha(30),
            valueColor: AlwaysStoppedAnimation<Color>(infoColor),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Processing: $processedRecords/$totalRecords",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "Success: $successfulRecords | Errors: $errorRecords",
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
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Total Imports",
            "1,245",
            Icons.file_upload,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Success Rate",
            "94.2%",
            Icons.check_circle,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Last Import",
            "2h ago",
            Icons.schedule,
            infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportConfigSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Import Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Import Type",
                  items: importTypeOptions,
                  value: importType,
                  onChanged: (value, label) {
                    importType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "File Format",
                  items: fileFormatOptions,
                  value: fileFormat,
                  onChanged: (value, label) {
                    fileFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "File Upload",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _downloadTemplate,
                child: Row(
                  children: [
                    Icon(Icons.download, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "Download Template",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          QAttachmentPicker(
            label: "Import Files",
            value: attachedFiles,
            hint: "Select files to import (${fileFormat.toUpperCase()} format)",
            helper: "Maximum file size: 50MB. Multiple files allowed.",
            maxAttachments: 10,
            allowedTypes: ['document'],
            onChanged: (value) {
              attachedFiles = value;
              setState(() {});
            },
          ),
          
          if (attachedFiles.isNotEmpty) ...[
            SizedBox(height: spSm),
            Text(
              "Selected Files:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            ...attachedFiles.map((file) {
              return Container(
                margin: EdgeInsets.only(top: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.file_present, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${file.split('/').last}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        attachedFiles.remove(file);
                        setState(() {});
                      },
                      child: Icon(Icons.close, color: dangerColor, size: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildDataMappingSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Data Mapping",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _autoMapFields,
                child: Row(
                  children: [
                    Icon(Icons.auto_fix_high, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Text(
                      "Auto Map",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Map your file columns to system fields. Required fields are marked with *",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Sample mapping fields for products
          if (importType == "products") ...[
            _buildMappingRow("Product Name *", "Column A", true),
            _buildMappingRow("SKU *", "Column B", true),
            _buildMappingRow("Price *", "Column C", true),
            _buildMappingRow("Category", "Column D", false),
            _buildMappingRow("Description", "Column E", false),
            _buildMappingRow("Stock Quantity", "Column F", false),
          ],
        ],
      ),
    );
  }

  Widget _buildMappingRow(String fieldName, String mappedColumn, bool isRequired) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              fieldName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isRequired ? FontWeight.w600 : FontWeight.normal,
                color: isRequired ? primaryColor : disabledBoldColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                mappedColumn,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            isRequired ? Icons.check_circle : Icons.remove_circle_outline,
            color: isRequired ? successColor : disabledColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildImportOptionsSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
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
            ),
          ),
          
          QDropdownField(
            label: "Duplicate Handling",
            items: duplicateOptions,
            value: duplicateHandling,
            onChanged: (value, label) {
              duplicateHandling = value;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Validate data before import",
                "value": "validate",
                "checked": validateData,
              }
            ],
            value: validateData ? [{"label": "Validate data before import", "value": "validate", "checked": true}] : [],
            onChanged: (values, ids) {
              validateData = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Skip records with errors",
                "value": "skip_errors",
                "checked": skipErrors,
              }
            ],
            value: skipErrors ? [{"label": "Skip records with errors", "value": "skip_errors", "checked": true}] : [],
            onChanged: (values, ids) {
              skipErrors = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Update existing records",
                "value": "update_existing",
                "checked": updateExisting,
              }
            ],
            value: updateExisting ? [{"label": "Update existing records", "value": "update_existing", "checked": true}] : [],
            onChanged: (values, ids) {
              updateExisting = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildValidationSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Data Validation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Validate Data",
                  icon: Icons.verified,
                  size: bs.sm,
                  onPressed: _validateImportData,
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Preview Import",
                  icon: Icons.preview,
                  size: bs.sm,
                  onPressed: _previewImport,
                ),
              ),
            ],
          ),
          
          // Validation Results
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Data validation passed. Ready to import 245 records.",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Import Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: isImporting ? "Importing..." : "Start Import",
                  icon: isImporting ? Icons.hourglass_empty : Icons.upload,
                  size: bs.md,
                  onPressed: isImporting ? null : _startImport,
                ),
              ),
              if (isImporting)
                QButton(
                  label: "Cancel",
                  icon: Icons.cancel,
                  size: bs.md,
                  onPressed: _cancelImport,
                ),
            ],
          ),
          
          if (!isImporting && attachedFiles.isEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Please select files to import before starting the process.",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentImports() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Recent Imports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _showImportHistory,
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          ...importHistory.take(3).map((import) {
            Color statusColor;
            IconData statusIcon;
            
            switch (import["status"]) {
              case "completed":
                statusColor = successColor;
                statusIcon = Icons.check_circle;
                break;
              case "completed_with_errors":
                statusColor = warningColor;
                statusIcon = Icons.warning;
                break;
              case "failed":
                statusColor = dangerColor;
                statusIcon = Icons.error;
                break;
              default:
                statusColor = infoColor;
                statusIcon = Icons.info;
            }
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${import["type"]} Import",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "${import["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "${import["filename"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Text(
                        "Total: ${import["total_records"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Success: ${import["successful"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                        ),
                      ),
                      if ((import["errors"] as int) > 0) ...[
                        SizedBox(width: spSm),
                        Text(
                          "Errors: ${import["errors"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: dangerColor,
                          ),
                        ),
                      ],
                      Spacer(),
                      Text(
                        "${import["duration"]}",
                        style: TextStyle(
                          fontSize: 11,
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
    );
  }

  void _downloadTemplate() {
    ss("Downloading ${fileFormat.toUpperCase()} template for ${importType}");
  }

  void _autoMapFields() {
    ss("Auto-mapping fields based on column headers");
  }

  void _validateImportData() {
    if (attachedFiles.isEmpty) {
      se("Please select files to validate");
      return;
    }
    
    ss("Validating import data...");
    // Simulate validation process
  }

  void _previewImport() {
    if (attachedFiles.isEmpty) {
      se("Please select files to preview");
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Import Preview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => back(),
                  ),
                ],
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "First 5 records to be imported:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      
                      // Sample preview data
                      ...List.generate(5, (index) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            border: Border.all(color: disabledOutlineBorderColor),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Record ${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text("Name: Sample Product ${index + 1}", style: TextStyle(fontSize: 11)),
                              Text("SKU: SP00${index + 1}", style: TextStyle(fontSize: 11)),
                              Text("Price: \$${(25.99 + index * 5).toStringAsFixed(2)}", style: TextStyle(fontSize: 11)),
                              Text("Category: Electronics", style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () => back(),
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Proceed with Import",
                      size: bs.sm,
                      onPressed: () {
                        back();
                        _startImport();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startImport() async {
    if (attachedFiles.isEmpty) {
      se("Please select files to import");
      return;
    }
    
    bool confirmed = await confirm("Start import process? This may take several minutes.");
    if (!confirmed) return;
    
    isImporting = true;
    importProgress = 0.0;
    totalRecords = 245;
    processedRecords = 0;
    successfulRecords = 0;
    errorRecords = 0;
    setState(() {});
    
    // Simulate import progress
    for (int i = 0; i <= totalRecords; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      
      processedRecords = i;
      importProgress = i / totalRecords;
      
      // Simulate some errors
      if (i % 50 == 0 && i > 0) {
        errorRecords++;
      } else {
        successfulRecords++;
      }
      
      setState(() {});
    }
    
    isImporting = false;
    setState(() {});
    
    ss("Import completed! ${successfulRecords} records imported successfully, ${errorRecords} errors.");
  }

  void _cancelImport() async {
    bool confirmed = await confirm("Cancel import process? Progress will be lost.");
    if (!confirmed) return;
    
    isImporting = false;
    importProgress = 0.0;
    setState(() {});
    
    sw("Import process cancelled");
  }

  void _showImportHistory() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Import History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => back(),
                  ),
                ],
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: importHistory.length,
                  itemBuilder: (context, index) {
                    final import = importHistory[index];
                    
                    Color statusColor;
                    IconData statusIcon;
                    
                    switch (import["status"]) {
                      case "completed":
                        statusColor = successColor;
                        statusIcon = Icons.check_circle;
                        break;
                      case "completed_with_errors":
                        statusColor = warningColor;
                        statusIcon = Icons.warning;
                        break;
                      case "failed":
                        statusColor = dangerColor;
                        statusIcon = Icons.error;
                        break;
                      default:
                        statusColor = infoColor;
                        statusIcon = Icons.info;
                    }
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(statusIcon, color: statusColor, size: 16),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${import["type"]} Import #${import["id"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${import["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "${import["filename"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          
                          Row(
                            children: [
                              Text(
                                "Total: ${import["total_records"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Success: ${import["successful"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                ),
                              ),
                              if ((import["errors"] as int) > 0) ...[
                                SizedBox(width: spSm),
                                Text(
                                  "Errors: ${import["errors"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                              Spacer(),
                              Text(
                                "${import["duration"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          if ((import["errors"] as int) > 0)
                            GestureDetector(
                              onTap: () {
                                // Show error details
                                se("Error details not implemented in demo");
                              },
                              child: Text(
                                "View Error Details →",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Text(
                    "Import Help",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => back(),
                  ),
                ],
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      _buildHelpSection(
                        "Supported File Formats",
                        [
                          "CSV: Comma-separated values with headers",
                          "Excel: .xlsx files with data in first sheet",
                          "JSON: Array of objects with consistent structure",
                          "XML: Structured data with defined schema"
                        ],
                      ),
                      
                      _buildHelpSection(
                        "File Requirements",
                        [
                          "Maximum file size: 50MB per file",
                          "Maximum 10 files per import",
                          "Files must include column headers",
                          "Required fields must not be empty"
                        ],
                      ),
                      
                      _buildHelpSection(
                        "Import Process",
                        [
                          "1. Select import type and file format",
                          "2. Upload your data files",
                          "3. Map columns to system fields",
                          "4. Configure import options",
                          "5. Validate data and preview",
                          "6. Start the import process"
                        ],
                      ),
                      
                      _buildHelpSection(
                        "Duplicate Handling",
                        [
                          "Skip: Ignore duplicate records",
                          "Update: Overwrite existing records",
                          "Create: Create new records anyway",
                          "Fail: Stop import on duplicates"
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        ...items.map((item) {
          return Padding(
            padding: EdgeInsets.only(left: spSm),
            child: Text(
              "• $item",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
