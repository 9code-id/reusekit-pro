import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerImportView extends StatefulWidget {
  const CrmCustomerImportView({super.key});

  @override
  State<CrmCustomerImportView> createState() => _CrmCustomerImportViewState();
}

class _CrmCustomerImportViewState extends State<CrmCustomerImportView> {
  int currentStep = 0;
  bool loading = false;
  
  String selectedImportType = "csv";
  String selectedSource = "file";
  List<String> uploadedFiles = [];
  bool hasHeaders = true;
  bool skipDuplicates = true;
  bool sendWelcomeEmail = false;
  String selectedSegment = "regular";
  String selectedDefaultSource = "import";

  List<Map<String, dynamic>> importTypeOptions = [
    {"label": "CSV File", "value": "csv"},
    {"label": "Excel File (.xlsx)", "value": "excel"},
    {"label": "JSON File", "value": "json"},
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Upload File", "value": "file"},
    {"label": "Google Sheets", "value": "google_sheets"},
    {"label": "External Database", "value": "database"},
    {"label": "API Integration", "value": "api"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "Regular Customer", "value": "regular"},
    {"label": "VIP Customer", "value": "vip"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "New Customer", "value": "new"},
  ];

  List<Map<String, dynamic>> sourceTagOptions = [
    {"label": "Import", "value": "import"},
    {"label": "Migration", "value": "migration"},
    {"label": "API Sync", "value": "api_sync"},
    {"label": "Manual Entry", "value": "manual"},
  ];

  List<Map<String, dynamic>> fieldMappings = [
    {"csvField": "first_name", "crmField": "firstName", "required": true, "mapped": true},
    {"csvField": "last_name", "crmField": "lastName", "required": true, "mapped": true},
    {"csvField": "email", "crmField": "email", "required": true, "mapped": true},
    {"csvField": "phone", "crmField": "phone", "required": false, "mapped": true},
    {"csvField": "company", "crmField": "company", "required": false, "mapped": true},
    {"csvField": "address", "crmField": "address", "required": false, "mapped": false},
  ];

  List<Map<String, dynamic>> previewData = [
    {
      "firstName": "John",
      "lastName": "Smith",
      "email": "john.smith@email.com",
      "phone": "+1 (555) 123-4567",
      "company": "Tech Solutions Inc",
      "address": "123 Business Ave, SF",
      "status": "Valid"
    },
    {
      "firstName": "Sarah",
      "lastName": "Johnson",
      "email": "sarah.j@company.com",
      "phone": "+1 (555) 987-6543",
      "company": "Enterprise Corp",
      "address": "456 Corporate Blvd, NY",
      "status": "Valid"
    },
    {
      "firstName": "Mike",
      "lastName": "Wilson",
      "email": "invalid-email",
      "phone": "+1 (555) 456-7890",
      "company": "Small Business LLC",
      "address": "789 Main St, LA",
      "status": "Error"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Customers"),
        actions: [
          if (currentStep > 0) ...[
            QButton(
              label: "Back",
              size: bs.sm,
              onPressed: () => _previousStep(),
            ),
            SizedBox(width: spSm),
          ],
          if (currentStep < 3) ...[
            QButton(
              label: "Next",
              size: bs.sm,
              onPressed: () => _nextStep(),
            ),
            SizedBox(width: spSm),
          ],
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Progress Indicator
                _buildProgressIndicator(),
                
                // Step Content
                Expanded(
                  child: _buildStepContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          _buildStepIndicator(0, "Source", Icons.upload_file),
          _buildStepConnector(0),
          _buildStepIndicator(1, "Mapping", Icons.compare_arrows),
          _buildStepConnector(1),
          _buildStepIndicator(2, "Preview", Icons.preview),
          _buildStepConnector(2),
          _buildStepIndicator(3, "Import", Icons.cloud_upload),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String title, IconData icon) {
    bool isActive = currentStep >= step;
    bool isCurrent = currentStep == step;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: isCurrent ? primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(int step) {
    bool isActive = currentStep > step;
    
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: 20),
        color: isActive ? primaryColor : disabledOutlineBorderColor,
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSourceStep();
      case 1:
        return _buildMappingStep();
      case 2:
        return _buildPreviewStep();
      case 3:
        return _buildImportStep();
      default:
        return _buildSourceStep();
    }
  }

  Widget _buildSourceStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Import Source",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Import Source
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data Source",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Import Source",
                  items: sourceOptions,
                  value: selectedSource,
                  onChanged: (value, label) {
                    selectedSource = value;
                    setState(() {});
                  },
                ),
                if (selectedSource == "file") ...[
                  QDropdownField(
                    label: "File Type",
                    items: importTypeOptions,
                    value: selectedImportType,
                    onChanged: (value, label) {
                      selectedImportType = value;
                      setState(() {});
                    },
                  ),
                ],
              ],
            ),
          ),
          
          // File Upload Section
          if (selectedSource == "file") ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload File",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QMultiImagePicker(
                    label: "Customer Data File",
                    value: uploadedFiles,
                    hint: "Upload your customer data file",
                    maxImages: 1,
                    onChanged: (value) {
                      uploadedFiles = value;
                      setState(() {});
                    },
                  ),
                  if (uploadedFiles.isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "File uploaded successfully",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          
          // Import Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "label": "File has headers",
                      "value": true,
                      "checked": hasHeaders,
                    }
                  ],
                  value: [
                    if (hasHeaders)
                      {
                        "label": "File has headers",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    hasHeaders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Skip duplicate emails",
                      "value": true,
                      "checked": skipDuplicates,
                    }
                  ],
                  value: [
                    if (skipDuplicates)
                      {
                        "label": "Skip duplicate emails",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    skipDuplicates = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Send welcome email to new customers",
                      "value": true,
                      "checked": sendWelcomeEmail,
                    }
                  ],
                  value: [
                    if (sendWelcomeEmail)
                      {
                        "label": "Send welcome email to new customers",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    sendWelcomeEmail = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Default Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Default Customer Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Default Segment",
                  items: segmentOptions,
                  value: selectedSegment,
                  onChanged: (value, label) {
                    selectedSegment = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Lead Source Tag",
                  items: sourceTagOptions,
                  value: selectedDefaultSource,
                  onChanged: (value, label) {
                    selectedDefaultSource = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMappingStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Map Data Fields",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Map the columns from your file to CRM fields",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "File Column",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "CRM Field",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Required",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Map",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Mapping Rows
                ...fieldMappings.map((mapping) => _buildMappingRow(mapping)),
              ],
            ),
          ),
          
          // Mapping Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mapping Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildSummaryItem("Total Fields", "${fieldMappings.length}", primaryColor),
                    _buildSummaryItem("Mapped", "${fieldMappings.where((m) => m["mapped"] == true).length}", successColor),
                    _buildSummaryItem("Required", "${fieldMappings.where((m) => m["required"] == true).length}", warningColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMappingRow(Map<String, dynamic> mapping) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "${mapping["csvField"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "${mapping["crmField"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Icon(
              mapping["required"] ? Icons.star : Icons.star_border,
              color: mapping["required"] ? warningColor : disabledColor,
              size: 16,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _toggleMapping(mapping),
              child: Icon(
                mapping["mapped"] ? Icons.check_circle : Icons.radio_button_unchecked,
                color: mapping["mapped"] ? successColor : disabledColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preview Import Data",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          // Preview Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                _buildPreviewStat("Total Records", "3", primaryColor),
                _buildPreviewStat("Valid", "2", successColor),
                _buildPreviewStat("Errors", "1", dangerColor),
              ],
            ),
          ),
          
          // Preview Data
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sample Data Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...previewData.map((data) => _buildPreviewRow(data)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewRow(Map<String, dynamic> data) {
    Color statusColor = data["status"] == "Valid" ? successColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${data["firstName"]} ${data["lastName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${data["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${data["email"]} • ${data["phone"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if (data["company"] != null && data["company"].isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "${data["company"]}",
              style: TextStyle(
                fontSize: 11,
                color: infoColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildImportStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Icon(
            Icons.cloud_upload,
            size: 80,
            color: primaryColor,
          ),
          Text(
            "Ready to Import",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Your customer data is ready to be imported into the CRM",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Import",
              size: bs.md,
              onPressed: () => _startImport(),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleMapping(Map<String, dynamic> mapping) {
    mapping["mapped"] = !mapping["mapped"];
    setState(() {});
  }

  void _nextStep() {
    if (currentStep < 3) {
      currentStep++;
      setState(() {});
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _startImport() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Customers imported successfully!");
      back();
    });
  }
}
