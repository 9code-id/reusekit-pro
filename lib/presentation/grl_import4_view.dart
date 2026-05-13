import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlImport4View extends StatefulWidget {
  @override
  State<GrlImport4View> createState() => _GrlImport4ViewState();
}

class _GrlImport4ViewState extends State<GrlImport4View> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String selectedFormat = "CSV";
  String selectedSource = "Local File";
  String fileName = "";
  bool hasHeader = true;
  String delimiter = ",";
  String encoding = "UTF-8";
  int skipRows = 0;
  List<String> selectedColumns = [];
  String dateFormat = "YYYY-MM-DD";
  bool validateData = true;
  String description = "";

  List<Map<String, dynamic>> formatOptions = [
    {"label": "CSV", "value": "CSV"},
    {"label": "Excel (XLSX)", "value": "XLSX"},
    {"label": "JSON", "value": "JSON"},
    {"label": "XML", "value": "XML"},
    {"label": "TSV", "value": "TSV"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Local File", "value": "Local File"},
    {"label": "Google Drive", "value": "Google Drive"},
    {"label": "Dropbox", "value": "Dropbox"},
    {"label": "OneDrive", "value": "OneDrive"},
    {"label": "FTP Server", "value": "FTP Server"},
  ];

  List<Map<String, dynamic>> encodingOptions = [
    {"label": "UTF-8", "value": "UTF-8"},
    {"label": "UTF-16", "value": "UTF-16"},
    {"label": "ASCII", "value": "ASCII"},
    {"label": "ISO-8859-1", "value": "ISO-8859-1"},
  ];

  List<Map<String, dynamic>> delimiterOptions = [
    {"label": "Comma (,)", "value": ","},
    {"label": "Semicolon (;)", "value": ";"},
    {"label": "Tab", "value": "\t"},
    {"label": "Pipe (|)", "value": "|"},
  ];

  List<Map<String, dynamic>> availableColumns = [
    {"label": "ID", "value": "id", "checked": true},
    {"label": "Name", "value": "name", "checked": true},
    {"label": "Email", "value": "email", "checked": true},
    {"label": "Phone", "value": "phone", "checked": false},
    {"label": "Address", "value": "address", "checked": false},
    {"label": "Date Created", "value": "created_at", "checked": true},
  ];

  @override
  void initState() {
    super.initState();
    selectedColumns = availableColumns
        .where((col) => col["checked"] == true)
        .map((col) => col["value"].toString())
        .toList();
  }

  void _performImport() async {
    if (!formKey.currentState!.validate()) return;
    
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Data imported successfully! ${selectedColumns.length} columns processed.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Import Settings"),
        actions: [
          Icon(
            Icons.upload,
            color: primaryColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImportSourceSection(),
                  _buildFileFormatSection(),
                  _buildParsingOptionsSection(),
                  _buildColumnMappingSection(),
                  _buildValidationSection(),
                  _buildImportButton(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildImportSourceSection() {
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
                Icons.cloud_upload,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
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
          QDropdownField(
            label: "Data Source",
            items: sourceOptions,
            value: selectedSource,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedSource = value;
              setState(() {});
            },
          ),
          if (selectedSource == "Local File") ...[
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "File Name",
                    value: fileName,
                    hint: "Select file to import",
                    validator: Validator.required,
                    onChanged: (value) {
                      fileName = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.folder_open,
                  size: bs.sm,
                  onPressed: () {
                    fileName = "sample_data.csv";
                    setState(() {});
                    si("File selected successfully");
                  },
                ),
              ],
            ),
          ],
          QMemoField(
            label: "Import Description",
            value: description,
            hint: "Brief description of this import operation",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFileFormatSection() {
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
                Icons.description,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "File Format Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "File Format",
            items: formatOptions,
            value: selectedFormat,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          if (selectedFormat == "CSV" || selectedFormat == "TSV") ...[
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
            Row(
              children: [
                Expanded(
                  child: QNumberField(
                    label: "Skip Rows",
                    value: skipRows.toString(),
                    hint: "Number of rows to skip",
                    onChanged: (value) {
                      skipRows = int.tryParse(value) ?? 0;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Has Header Row",
                        "value": true,
                        "checked": hasHeader,
                      }
                    ],
                    value: [
                      if (hasHeader)
                        {"label": "Has Header Row", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      hasHeader = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildParsingOptionsSection() {
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
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Parsing Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Date Format",
            value: dateFormat,
            hint: "e.g., YYYY-MM-DD, DD/MM/YYYY",
            onChanged: (value) {
              dateFormat = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Validate Data During Import",
                "value": true,
                "checked": validateData,
              }
            ],
            value: [
              if (validateData)
                {"label": "Validate Data During Import", "value": true, "checked": true}
            ],
            onChanged: (values, ids) {
              validateData = values.isNotEmpty;
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
                    "Data validation will check for format errors and missing required fields",
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

  Widget _buildColumnMappingSection() {
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
                color: secondaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Column Mapping",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${selectedColumns.length} selected",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          QSwitch(
            items: availableColumns,
            value: availableColumns
                .where((col) => selectedColumns.contains(col["value"]))
                .toList(),
            onChanged: (values, ids) {
              selectedColumns = values.map((v) => v["value"].toString()).toList();
              setState(() {});
            },
          ),
          if (selectedColumns.isEmpty)
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
                      "Please select at least one column to import",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildValidationSection() {
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
                Icons.verified,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Import Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          _buildSummaryRow("Format", selectedFormat),
          _buildSummaryRow("Source", selectedSource),
          _buildSummaryRow("Columns", "${selectedColumns.length} selected"),
          if (fileName.isNotEmpty)
            _buildSummaryRow("File", fileName),
          if (selectedFormat == "CSV")
            _buildSummaryRow("Delimiter", delimiter == "," ? "Comma" : delimiter == ";" ? "Semicolon" : delimiter == "\t" ? "Tab" : "Pipe"),
          _buildSummaryRow("Validation", validateData ? "Enabled" : "Disabled"),
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
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          ":",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Start Import Process",
        size: bs.md,
        onPressed: selectedColumns.isEmpty ? null : _performImport,
      ),
    );
  }
}
