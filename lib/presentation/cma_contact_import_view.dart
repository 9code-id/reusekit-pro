import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactImportView extends StatefulWidget {
  const CmaContactImportView({super.key});

  @override
  State<CmaContactImportView> createState() => _CmaContactImportViewState();
}

class _CmaContactImportViewState extends State<CmaContactImportView> {
  int currentStep = 0;
  String selectedSource = "CSV";
  String uploadedFile = "";
  List<String> selectedColumns = [];
  Map<String, String> columnMapping = {};
  List<Map<String, dynamic>> previewData = [];
  bool importDuplicates = false;
  bool updateExisting = true;
  String duplicateAction = "Skip";
  
  List<Map<String, dynamic>> importSources = [
    {
      "title": "CSV File",
      "value": "CSV",
      "icon": Icons.file_copy,
      "description": "Import from CSV file with comma-separated values",
      "formats": [".csv"]
    },
    {
      "title": "Excel File",
      "value": "Excel",
      "icon": Icons.table_chart,
      "description": "Import from Excel spreadsheet (.xlsx, .xls)",
      "formats": [".xlsx", ".xls"]
    },
    {
      "title": "Google Contacts",
      "value": "Google",
      "icon": Icons.contacts,
      "description": "Import directly from Google Contacts",
      "formats": ["Google Account"]
    },
    {
      "title": "Outlook Contacts",
      "value": "Outlook",
      "icon": Icons.email,
      "description": "Import from Microsoft Outlook contacts",
      "formats": [".pst", ".vcf"]
    },
    {
      "title": "LinkedIn",
      "value": "LinkedIn",
      "icon": Icons.business,
      "description": "Import professional contacts from LinkedIn",
      "formats": ["LinkedIn Account"]
    }
  ];

  List<String> requiredFields = [
    "First Name",
    "Last Name", 
    "Email",
    "Phone",
    "Company",
    "Position"
  ];

  List<String> optionalFields = [
    "Address",
    "Website",
    "LinkedIn",
    "Twitter",
    "Notes",
    "Tags",
    "Lead Score",
    "Source"
  ];

  List<Map<String, dynamic>> sampleData = [
    {
      "First Name": "John",
      "Last Name": "Doe",
      "Email": "john.doe@email.com",
      "Phone": "+1 (555) 123-4567",
      "Company": "Acme Corp",
      "Position": "Software Engineer",
      "Address": "123 Main St, NY",
      "LinkedIn": "linkedin.com/in/johndoe"
    },
    {
      "First Name": "Jane",
      "Last Name": "Smith",
      "Email": "jane.smith@tech.com",
      "Phone": "+1 (555) 234-5678",
      "Company": "Tech Solutions",
      "Position": "Product Manager",
      "Address": "456 Oak Ave, CA",
      "LinkedIn": "linkedin.com/in/janesmith"
    },
    {
      "First Name": "Mike",
      "Last Name": "Johnson",
      "Email": "mike.j@startup.io",
      "Phone": "+1 (555) 345-6789",
      "Company": "StartupIO",
      "Position": "CTO",
      "Address": "789 Pine St, TX",
      "LinkedIn": "linkedin.com/in/mikejohnson"
    }
  ];

  @override
  void initState() {
    super.initState();
    previewData = sampleData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Import Contacts"),
        actions: [
          if (currentStep > 0)
            TextButton(
              onPressed: () {
                currentStep--;
                setState(() {});
              },
              child: Text("Back"),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: _buildStepContent(),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: List.generate(4, (index) {
          bool isActive = index <= currentStep;
          bool isCompleted = index < currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: isCompleted ? successColor : isActive ? primaryColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : Icons.circle,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        _getStepTitle(index),
                        style: TextStyle(
                          fontSize: 10,
                          color: isActive ? primaryColor : disabledColor,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                if (index < 3)
                  Container(
                    height: 2,
                    width: 20,
                    color: index < currentStep ? successColor : disabledColor,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0: return "Source";
      case 1: return "Upload";
      case 2: return "Mapping";
      case 3: return "Settings";
      default: return "";
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildSourceSelection();
      case 1:
        return _buildFileUpload();
      case 2:
        return _buildColumnMapping();
      case 3:
        return _buildImportSettings();
      default:
        return Container();
    }
  }

  Widget _buildSourceSelection() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Import Source",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Choose where you want to import your contacts from:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          ...importSources.map((source) {
            bool isSelected = selectedSource == source["value"];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
              ),
              child: RadioListTile<String>(
                value: source["value"],
                groupValue: selectedSource,
                onChanged: (value) {
                  selectedSource = value!;
                  setState(() {});
                },
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        source["icon"],
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${source["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${source["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Formats: ${(source["formats"] as List).join(", ")}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFileUpload() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload File",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Upload your $selectedSource file containing contact information:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          GestureDetector(
            onTap: () {
              _selectFile();
            },
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                  style: BorderStyle.values[1],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    uploadedFile.isEmpty ? Icons.cloud_upload : Icons.check_circle,
                    size: 48,
                    color: uploadedFile.isEmpty ? primaryColor : successColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    uploadedFile.isEmpty ? "Tap to select file" : "File uploaded successfully",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: uploadedFile.isEmpty ? primaryColor : successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    uploadedFile.isEmpty ? "Or drag and drop your file here" : uploadedFile,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (uploadedFile.isNotEmpty) ...[
            SizedBox(height: spMd),
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
                    "File Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(Icons.insert_drive_file, color: primaryColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              uploadedFile,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Size: 1.2 MB • 150 contacts detected",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: dangerColor),
                        onPressed: () {
                          uploadedFile = "";
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spMd),
          _buildFormatRequirements(),
        ],
      ),
    );
  }

  Widget _buildFormatRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor),
              SizedBox(width: spSm),
              Text(
                "File Format Requirements",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• First row should contain column headers\n"
            "• Required fields: First Name, Last Name, Email\n"
            "• Use UTF-8 encoding for special characters\n"
            "• Maximum file size: 10MB\n"
            "• Maximum contacts: 10,000 per import",
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnMapping() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Map Columns",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Map your file columns to contact fields:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildMappingSection("Required Fields", requiredFields, true),
          SizedBox(height: spMd),
          _buildMappingSection("Optional Fields", optionalFields, false),
          SizedBox(height: spMd),
          _buildPreviewSection(),
        ],
      ),
    );
  }

  Widget _buildMappingSection(String title, List<String> fields, bool isRequired) {
    return Container(
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
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: isRequired ? dangerColor : primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...fields.map((field) {
            List<Map<String, dynamic>> columnOptions = [
              {"label": "-- Not Mapped --", "value": ""},
              {"label": "First Name", "value": "First Name"},
              {"label": "Last Name", "value": "Last Name"},
              {"label": "Email", "value": "Email"},
              {"label": "Phone", "value": "Phone"},
              {"label": "Company", "value": "Company"},
              {"label": "Position", "value": "Position"},
              {"label": "Address", "value": "Address"},
              {"label": "LinkedIn", "value": "LinkedIn"},
            ];
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      field,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 3,
                    child: QDropdownField(
                      label: "Select Column",
                      items: columnOptions,
                      value: columnMapping[field] ?? "",
                      onChanged: (value, label) {
                        columnMapping[field] = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
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
            "Preview Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Preview of contacts to be imported:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text("First Name")),
                DataColumn(label: Text("Last Name")),
                DataColumn(label: Text("Email")),
                DataColumn(label: Text("Company")),
              ],
              rows: previewData.take(3).map((contact) {
                return DataRow(
                  cells: [
                    DataCell(Text("${contact["First Name"]}")),
                    DataCell(Text("${contact["Last Name"]}")),
                    DataCell(Text("${contact["Email"]}")),
                    DataCell(Text("${contact["Company"]}")),
                  ],
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Showing 3 of ${previewData.length} contacts",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Import Settings",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Configure how contacts should be imported:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildDuplicateHandling(),
          SizedBox(height: spMd),
          _buildImportSummary(),
        ],
      ),
    );
  }

  Widget _buildDuplicateHandling() {
    List<Map<String, dynamic>> duplicateOptions = [
      {"label": "Skip duplicates", "value": "Skip"},
      {"label": "Update existing", "value": "Update"},
      {"label": "Create duplicates", "value": "Create"},
    ];

    return Container(
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
            "Duplicate Handling",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "How should duplicate contacts be handled?",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Duplicate Action",
            items: duplicateOptions,
            value: duplicateAction,
            onChanged: (value, label) {
              duplicateAction = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Duplicates are detected by matching email addresses",
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

  Widget _buildImportSummary() {
    return Container(
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
            "Import Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          _buildSummaryRow("Total contacts", "150"),
          _buildSummaryRow("New contacts", "145"),
          _buildSummaryRow("Duplicates found", "5"),
          _buildSummaryRow("Will be imported", "145"),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Import",
              size: bs.md,
              onPressed: () {
                _startImport();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: QButton(
                label: "Previous",
                size: bs.sm,
                onPressed: () {
                  currentStep--;
                  setState(() {});
                },
              ),
            ),
          if (currentStep > 0)
            SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: currentStep == 3 ? "Import" : "Next",
              size: bs.sm,
              onPressed: () {
                _nextStep();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectFile() {
    uploadedFile = "contacts_export.csv";
    setState(() {});
    si("File selected successfully");
  }

  void _nextStep() {
    if (currentStep == 0 && selectedSource.isEmpty) {
      se("Please select an import source");
      return;
    }
    
    if (currentStep == 1 && uploadedFile.isEmpty) {
      se("Please upload a file");
      return;
    }
    
    if (currentStep == 2) {
      bool hasRequiredMappings = requiredFields.every((field) => 
        columnMapping[field] != null && columnMapping[field]!.isNotEmpty);
      if (!hasRequiredMappings) {
        se("Please map all required fields");
        return;
      }
    }
    
    if (currentStep < 3) {
      currentStep++;
      setState(() {});
    } else {
      _startImport();
    }
  }

  void _startImport() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Successfully imported 145 contacts");
    
    back();
  }
}
