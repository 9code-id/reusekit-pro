import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExport2View extends StatefulWidget {
  @override
  State<GrlExport2View> createState() => _GrlExport2ViewState();
}

class _GrlExport2ViewState extends State<GrlExport2View> {
  final formKey = GlobalKey<FormState>();
  
  // Export Settings
  String selectedFormat = "PDF";
  String selectedTemplate = "Standard";
  String selectedOrientation = "Portrait";
  String selectedPaperSize = "A4";
  String fileName = "Export_Report";
  String outputPath = "/Documents/Exports";
  
  // Content Settings
  bool includeHeaders = true;
  bool includeFooters = true;
  bool includePageNumbers = true;
  bool includeWatermark = false;
  bool compressOutput = false;
  bool passwordProtect = false;
  String password = "";
  
  // Advanced Settings
  String qualityLevel = "High";
  String colorMode = "Full Color";
  String marginSize = "Normal";
  bool includeMetadata = true;
  bool optimizeForPrint = false;
  bool optimizeForWeb = true;
  
  // UI State
  bool loading = false;
  int currentStep = 0;
  
  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF", "value": "PDF"},
    {"label": "Excel (XLSX)", "value": "XLSX"},
    {"label": "Word (DOCX)", "value": "DOCX"},
    {"label": "PowerPoint (PPTX)", "value": "PPTX"},
    {"label": "CSV", "value": "CSV"},
    {"label": "HTML", "value": "HTML"},
    {"label": "Image (PNG)", "value": "PNG"},
    {"label": "Image (JPEG)", "value": "JPEG"},
  ];
  
  List<Map<String, dynamic>> templateOptions = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Professional", "value": "Professional"},
    {"label": "Corporate", "value": "Corporate"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Minimal", "value": "Minimal"},
    {"label": "Classic", "value": "Classic"},
  ];
  
  List<Map<String, dynamic>> orientationOptions = [
    {"label": "Portrait", "value": "Portrait"},
    {"label": "Landscape", "value": "Landscape"},
  ];
  
  List<Map<String, dynamic>> paperSizeOptions = [
    {"label": "A4", "value": "A4"},
    {"label": "A3", "value": "A3"},
    {"label": "Letter", "value": "Letter"},
    {"label": "Legal", "value": "Legal"},
    {"label": "Tabloid", "value": "Tabloid"},
  ];
  
  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Ultra", "value": "Ultra"},
  ];
  
  List<Map<String, dynamic>> colorModeOptions = [
    {"label": "Full Color", "value": "Full Color"},
    {"label": "Grayscale", "value": "Grayscale"},
    {"label": "Black & White", "value": "Black & White"},
  ];
  
  List<Map<String, dynamic>> marginOptions = [
    {"label": "Narrow", "value": "Narrow"},
    {"label": "Normal", "value": "Normal"},
    {"label": "Wide", "value": "Wide"},
    {"label": "Custom", "value": "Custom"},
  ];
  
  List<Map<String, dynamic>> recentExports = [
    {
      "fileName": "Sales_Report_2024.pdf",
      "format": "PDF",
      "size": "2.1 MB",
      "date": "2024-01-15",
      "status": "Completed",
    },
    {
      "fileName": "Customer_Data.xlsx",
      "format": "Excel",
      "size": "850 KB",
      "date": "2024-01-14",
      "status": "Completed",
    },
    {
      "fileName": "Project_Summary.docx",
      "format": "Word",
      "size": "1.3 MB",
      "date": "2024-01-13",
      "status": "Failed",
    },
    {
      "fileName": "Analytics_Dashboard.png",
      "format": "Image",
      "size": "3.2 MB",
      "date": "2024-01-12",
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Export"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    _buildStepIndicator(),
                    _buildCurrentStepContent(),
                    _buildNavigationButtons(),
                    if (currentStep == 0) _buildRecentExports(),
                  ],
                ),
              ),
            ),
    );
  }
  
  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          _buildStepItem(0, "Format", currentStep >= 0),
          _buildStepConnector(currentStep > 0),
          _buildStepItem(1, "Layout", currentStep >= 1),
          _buildStepConnector(currentStep > 1),
          _buildStepItem(2, "Settings", currentStep >= 2),
          _buildStepConnector(currentStep > 2),
          _buildStepItem(3, "Export", currentStep >= 3),
        ],
      ),
    );
  }
  
  Widget _buildStepItem(int step, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? primaryColor : disabledColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isActive
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      "${step + 1}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? primaryColor : disabledColor,
      margin: EdgeInsets.symmetric(horizontal: spXs),
    );
  }
  
  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildFormatStep();
      case 1:
        return _buildLayoutStep();
      case 2:
        return _buildSettingsStep();
      case 3:
        return _buildExportStep();
      default:
        return Container();
    }
  }
  
  Widget _buildFormatStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Export Format & Template",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Export Format",
            items: formatOptions,
            value: selectedFormat,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Template",
            items: templateOptions,
            value: selectedTemplate,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedTemplate = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "File Name",
            value: fileName,
            validator: Validator.required,
            onChanged: (value) {
              fileName = value;
              setState(() {});
            },
          ),
          QTextField(
            label: "Output Path",
            value: outputPath,
            validator: Validator.required,
            onChanged: (value) {
              outputPath = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildLayoutStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Page Layout & Orientation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Orientation",
                  items: orientationOptions,
                  value: selectedOrientation,
                  onChanged: (value, label) {
                    selectedOrientation = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Paper Size",
                  items: paperSizeOptions,
                  value: selectedPaperSize,
                  onChanged: (value, label) {
                    selectedPaperSize = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Margin Size",
            items: marginOptions,
            value: marginSize,
            onChanged: (value, label) {
              marginSize = value;
              setState(() {});
            },
          ),
          Text(
            "Content Options",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Include Headers",
                "value": "headers",
                "checked": includeHeaders,
              },
              {
                "label": "Include Footers",
                "value": "footers",
                "checked": includeFooters,
              },
              {
                "label": "Include Page Numbers",
                "value": "pageNumbers",
                "checked": includePageNumbers,
              },
              {
                "label": "Include Watermark",
                "value": "watermark",
                "checked": includeWatermark,
              },
            ],
            value: [
              if (includeHeaders) {"label": "Include Headers", "value": "headers", "checked": true},
              if (includeFooters) {"label": "Include Footers", "value": "footers", "checked": true},
              if (includePageNumbers) {"label": "Include Page Numbers", "value": "pageNumbers", "checked": true},
              if (includeWatermark) {"label": "Include Watermark", "value": "watermark", "checked": true},
            ],
            onChanged: (values, ids) {
              setState(() {
                includeHeaders = values.any((v) => v["value"] == "headers");
                includeFooters = values.any((v) => v["value"] == "footers");
                includePageNumbers = values.any((v) => v["value"] == "pageNumbers");
                includeWatermark = values.any((v) => v["value"] == "watermark");
              });
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Advanced Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Quality Level",
                  items: qualityOptions,
                  value: qualityLevel,
                  onChanged: (value, label) {
                    qualityLevel = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Color Mode",
                  items: colorModeOptions,
                  value: colorMode,
                  onChanged: (value, label) {
                    colorMode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Text(
            "Optimization Options",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Compress Output",
                "value": "compress",
                "checked": compressOutput,
              },
              {
                "label": "Include Metadata",
                "value": "metadata",
                "checked": includeMetadata,
              },
              {
                "label": "Optimize for Print",
                "value": "print",
                "checked": optimizeForPrint,
              },
              {
                "label": "Optimize for Web",
                "value": "web",
                "checked": optimizeForWeb,
              },
            ],
            value: [
              if (compressOutput) {"label": "Compress Output", "value": "compress", "checked": true},
              if (includeMetadata) {"label": "Include Metadata", "value": "metadata", "checked": true},
              if (optimizeForPrint) {"label": "Optimize for Print", "value": "print", "checked": true},
              if (optimizeForWeb) {"label": "Optimize for Web", "value": "web", "checked": true},
            ],
            onChanged: (values, ids) {
              setState(() {
                compressOutput = values.any((v) => v["value"] == "compress");
                includeMetadata = values.any((v) => v["value"] == "metadata");
                optimizeForPrint = values.any((v) => v["value"] == "print");
                optimizeForWeb = values.any((v) => v["value"] == "web");
              });
            },
          ),
          Text(
            "Security Options",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Password Protection",
                "value": "password",
                "checked": passwordProtect,
              },
            ],
            value: [
              if (passwordProtect) {"label": "Password Protection", "value": "password", "checked": true},
            ],
            onChanged: (values, ids) {
              setState(() {
                passwordProtect = values.isNotEmpty;
              });
            },
          ),
          if (passwordProtect)
            QTextField(
              label: "Password",
              value: password,
              obscureText: true,
              validator: Validator.required,
              onChanged: (value) {
                password = value;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildExportStep() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Export Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildSummaryRow("Format", selectedFormat),
          _buildSummaryRow("Template", selectedTemplate),
          _buildSummaryRow("File Name", fileName),
          _buildSummaryRow("Orientation", selectedOrientation),
          _buildSummaryRow("Paper Size", selectedPaperSize),
          _buildSummaryRow("Quality", qualityLevel),
          _buildSummaryRow("Color Mode", colorMode),
          if (passwordProtect) _buildSummaryRow("Security", "Password Protected"),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.file_download,
                  size: 48,
                  color: primaryColor,
                ),
                SizedBox(height: spSm),
                Text(
                  "Ready to Export",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Click the export button to generate your file",
                  style: TextStyle(
                    fontSize: 14,
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
  
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (currentStep > 0)
          Expanded(
            child: QButton(
              label: "Previous",
              size: bs.md,
              onPressed: () {
                if (currentStep > 0) {
                  currentStep--;
                  setState(() {});
                }
              },
            ),
          ),
        if (currentStep > 0) SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: currentStep == 3 ? "Export Now" : "Next",
            size: bs.md,
            onPressed: () {
              if (currentStep == 3) {
                _performExport();
              } else {
                if (_validateCurrentStep()) {
                  currentStep++;
                  setState(() {});
                }
              }
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildRecentExports() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Exports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _clearRecentExports(),
                child: Text(
                  "Clear All",
                  style: TextStyle(
                    fontSize: 14,
                    color: dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentExports.map((export) => _buildExportItem(export)),
        ],
      ),
    );
  }
  
  Widget _buildExportItem(Map<String, dynamic> export) {
    Color statusColor = export["status"] == "Completed" 
        ? successColor 
        : export["status"] == "Failed"
            ? dangerColor
            : warningColor;
            
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: statusColor, width: 4)),
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            _getFormatIcon(export["format"]),
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${export["fileName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${export["format"]} • ${export["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${export["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${export["status"]}",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _downloadExport(export),
            child: Icon(
              Icons.download,
              color: primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getFormatIcon(String format) {
    switch (format.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'excel':
        return Icons.table_chart;
      case 'word':
        return Icons.description;
      case 'image':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }
  
  bool _validateCurrentStep() {
    switch (currentStep) {
      case 0:
        if (selectedFormat.isEmpty || fileName.isEmpty) {
          se("Please fill in all required fields");
          return false;
        }
        return true;
      case 1:
        return true;
      case 2:
        if (passwordProtect && password.isEmpty) {
          se("Please enter a password for protection");
          return false;
        }
        return true;
      default:
        return true;
    }
  }
  
  void _performExport() async {
    if (!formKey.currentState!.validate()) return;
    
    bool isConfirmed = await confirm("Start the export process with current settings?");
    if (!isConfirmed) return;
    
    loading = true;
    setState(() {});
    
    // Simulate export process
    await Future.delayed(Duration(seconds: 3));
    
    loading = false;
    setState(() {});
    
    ss("Export completed successfully!");
    
    // Reset to first step
    currentStep = 0;
    setState(() {});
  }
  
  void _clearRecentExports() async {
    bool isConfirmed = await confirm("Clear all recent export history?");
    if (!isConfirmed) return;
    
    recentExports.clear();
    setState(() {});
    si("Recent exports cleared");
  }
  
  void _downloadExport(Map<String, dynamic> export) {
    if (export["status"] == "Completed") {
      si("Downloading ${export["fileName"]}...");
    } else {
      se("Cannot download failed export");
    }
  }
  
  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Export Help"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Step 1: Choose export format and template"),
            SizedBox(height: spXs),
            Text("Step 2: Configure page layout and content options"),
            SizedBox(height: spXs),
            Text("Step 3: Set advanced settings and security"),
            SizedBox(height: spXs),
            Text("Step 4: Review and export your file"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }
}
