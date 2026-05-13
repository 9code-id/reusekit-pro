import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExport1View extends StatefulWidget {
  @override
  State<GrlExport1View> createState() => _GrlExport1ViewState();
}

class _GrlExport1ViewState extends State<GrlExport1View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String exportFormat = "CSV";
  String dataSource = "Users Table";
  String fileName = "";
  bool includeHeaders = true;
  String encoding = "UTF-8";
  String compression = "None";
  String delimiter = ",";
  bool enableFilters = false;
  String dateFormat = "YYYY-MM-DD";
  
  List<String> selectedFields = [];
  List<Map<String, dynamic>> availableFields = [
    {"label": "ID", "value": "id", "checked": true},
    {"label": "Full Name", "value": "name", "checked": true},
    {"label": "Email Address", "value": "email", "checked": true},
    {"label": "Phone Number", "value": "phone", "checked": false},
    {"label": "Address", "value": "address", "checked": false},
    {"label": "Date Created", "value": "created_at", "checked": true},
    {"label": "Last Login", "value": "last_login", "checked": false},
    {"label": "Status", "value": "status", "checked": true},
  ];

  List<Map<String, dynamic>> exportHistory = [
    {
      "id": "EXP001",
      "name": "User Data Export",
      "format": "CSV",
      "size": "2.4 MB",
      "records": 15420,
      "created": DateTime.now().subtract(Duration(hours: 2)),
      "status": "Completed",
      "downloadCount": 3,
    },
    {
      "id": "EXP002",
      "name": "Product Inventory",
      "format": "Excel",
      "size": "1.8 MB",
      "records": 5670,
      "created": DateTime.now().subtract(Duration(hours: 6)),
      "status": "Completed",
      "downloadCount": 1,
    },
    {
      "id": "EXP003",
      "name": "Sales Report Q4",
      "format": "PDF",
      "size": "890 KB",
      "records": 2340,
      "created": DateTime.now().subtract(Duration(days: 1)),
      "status": "Completed",
      "downloadCount": 8,
    }
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "CSV", "value": "CSV"},
    {"label": "Excel (XLSX)", "value": "Excel"},
    {"label": "JSON", "value": "JSON"},
    {"label": "XML", "value": "XML"},
    {"label": "PDF Report", "value": "PDF"},
    {"label": "TSV", "value": "TSV"},
  ];

  List<Map<String, dynamic>> dataSourceOptions = [
    {"label": "Users Table", "value": "Users Table"},
    {"label": "Products Table", "value": "Products Table"},
    {"label": "Orders Table", "value": "Orders Table"},
    {"label": "Customers Table", "value": "Customers Table"},
    {"label": "Custom Query", "value": "Custom Query"},
  ];

  List<Map<String, dynamic>> encodingOptions = [
    {"label": "UTF-8", "value": "UTF-8"},
    {"label": "UTF-16", "value": "UTF-16"},
    {"label": "ASCII", "value": "ASCII"},
    {"label": "ISO-8859-1", "value": "ISO-8859-1"},
  ];

  List<Map<String, dynamic>> compressionOptions = [
    {"label": "None", "value": "None"},
    {"label": "ZIP", "value": "ZIP"},
    {"label": "GZIP", "value": "GZIP"},
    {"label": "RAR", "value": "RAR"},
  ];

  List<Map<String, dynamic>> delimiterOptions = [
    {"label": "Comma (,)", "value": ","},
    {"label": "Semicolon (;)", "value": ";"},
    {"label": "Tab", "value": "\t"},
    {"label": "Pipe (|)", "value": "|"},
  ];

  @override
  void initState() {
    super.initState();
    selectedFields = availableFields
        .where((field) => field["checked"] == true)
        .map((field) => field["value"].toString())
        .toList();
    fileName = "export_${DateTime.now().millisecondsSinceEpoch}";
  }

  void _startExport() async {
    if (!formKey.currentState!.validate()) return;
    
    if (selectedFields.isEmpty) {
      se("Please select at least one field to export");
      return;
    }
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 4));
    
    final newExport = {
      "id": "EXP${DateTime.now().millisecondsSinceEpoch}",
      "name": fileName,
      "format": exportFormat,
      "size": "1.2 MB",
      "records": 8750,
      "created": DateTime.now(),
      "status": "Completed",
      "downloadCount": 0,
    };
    
    exportHistory.insert(0, newExport);
    
    loading = false;
    setState(() {});
    
    ss("Export completed successfully! File ready for download.");
  }

  void _downloadExport(String exportId) {
    final export = exportHistory.firstWhere((exp) => exp["id"] == exportId);
    export["downloadCount"] = (export["downloadCount"] as int) + 1;
    setState(() {});
    ss("Download started for ${export["name"]}");
  }

  void _deleteExport(String exportId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this export?");
    if (!isConfirmed) return;
    
    exportHistory.removeWhere((export) => export["id"] == exportId);
    setState(() {});
    sw("Export deleted");
  }

  void _previewExport() {
    si("Preview: ${selectedFields.length} fields, estimated 8,750 records");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Export"),
        actions: [
          Icon(
            Icons.file_download,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: spMd),
                Text(
                  "Preparing export file...",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExportConfigSection(),
                  _buildFieldSelectionSection(),
                  _buildFormatSettingsSection(),
                  _buildExportHistorySection(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildExportConfigSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.settings,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Export Configuration",
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
                child: QDropdownField(
                  label: "Data Source",
                  items: dataSourceOptions,
                  value: dataSource,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    dataSource = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Export Format",
                  items: formatOptions,
                  value: exportFormat,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    exportFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "File Name",
            value: fileName,
            hint: "Enter export file name",
            validator: Validator.required,
            onChanged: (value) {
              fileName = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Choose your data source and export format. The file name will be automatically suffixed with the format extension.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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

  Widget _buildFieldSelectionSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.view_column,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Field Selection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Text(
                "${selectedFields.length} selected",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          QSwitch(
            items: availableFields,
            value: availableFields
                .where((field) => selectedFields.contains(field["value"]))
                .toList(),
            onChanged: (values, ids) {
              selectedFields = values.map((v) => v["value"].toString()).toList();
              setState(() {});
            },
          ),
          if (selectedFields.isEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Please select at least one field to export",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Select All",
                    size: bs.sm,
                    onPressed: () {
                      selectedFields = availableFields.map((f) => f["value"].toString()).toList();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Clear All",
                    size: bs.sm,
                    onPressed: () {
                      selectedFields.clear();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Preview",
                    size: bs.sm,
                    onPressed: _previewExport,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFormatSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tune,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Format Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          if (exportFormat == "CSV" || exportFormat == "TSV") ...[
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Delimiter",
                    items: delimiterOptions,
                    value: delimiter,
                    onChanged: (value, label) {
                      delimiter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Encoding",
                    items: encodingOptions,
                    value: encoding,
                    onChanged: (value, label) {
                      encoding = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            QSwitch(
              items: [
                {
                  "label": "Include Header Row",
                  "value": true,
                  "checked": includeHeaders,
                }
              ],
              value: [
                if (includeHeaders)
                  {"label": "Include Header Row", "value": true, "checked": true}
              ],
              onChanged: (values, ids) {
                includeHeaders = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Compression",
                  items: compressionOptions,
                  value: compression,
                  onChanged: (value, label) {
                    compression = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Date Format",
                  value: dateFormat,
                  hint: "e.g., YYYY-MM-DD",
                  onChanged: (value) {
                    dateFormat = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          _buildExportSummary(),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Export",
              size: bs.md,
              onPressed: selectedFields.isEmpty ? null : _startExport,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(100)),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Export Summary",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          _buildSummaryRow("Source", dataSource),
          _buildSummaryRow("Format", exportFormat),
          _buildSummaryRow("Fields", "${selectedFields.length} selected"),
          _buildSummaryRow("File Name", "$fileName.${exportFormat.toLowerCase()}"),
          if (compression != "None")
            _buildSummaryRow("Compression", compression),
          if (exportFormat == "CSV" && delimiter != ",")
            _buildSummaryRow("Delimiter", delimiter == "," ? "Comma" : delimiter == ";" ? "Semicolon" : delimiter == "\t" ? "Tab" : "Pipe"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          ": ",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExportHistorySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: infoColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Export History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Clear History",
                size: bs.sm,
                onPressed: () async {
                  bool isConfirmed = await confirm("Clear all export history?");
                  if (isConfirmed) {
                    exportHistory.clear();
                    setState(() {});
                    sw("Export history cleared");
                  }
                },
              ),
            ],
          ),
          if (exportHistory.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(
                    Icons.file_download,
                    color: disabledColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No export history",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Your exported files will appear here",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ...exportHistory.map((export) => _buildExportHistoryCard(export)),
        ],
      ),
    );
  }

  Widget _buildExportHistoryCard(Map<String, dynamic> export) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: infoColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: infoColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getFormatIcon(export["format"]),
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${export["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${export["format"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${export["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(export["records"] as int).toString()} records",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${(export["created"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Downloaded ${export["downloadCount"]} times",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () => _downloadExport(export["id"]),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () => _deleteExport(export["id"]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getFormatIcon(String format) {
    switch (format) {
      case "CSV": return Icons.table_chart;
      case "Excel": return Icons.grid_on;
      case "JSON": return Icons.code;
      case "XML": return Icons.description;
      case "PDF": return Icons.picture_as_pdf;
      case "TSV": return Icons.table_rows;
      default: return Icons.file_present;
    }
  }
}
