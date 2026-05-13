import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaContactExportView extends StatefulWidget {
  const CmaContactExportView({super.key});

  @override
  State<CmaContactExportView> createState() => _CmaContactExportViewState();
}

class _CmaContactExportViewState extends State<CmaContactExportView> {
  String exportFormat = "CSV";
  String exportRange = "All";
  List<String> selectedFields = [];
  List<String> selectedFilters = [];
  String customDateRange = "";
  DateTime? startDate;
  DateTime? endDate;
  bool includeCustomFields = true;
  bool includeNotes = false;
  bool includeTags = true;
  String fileName = "";

  List<Map<String, dynamic>> formatOptions = [
    {
      "title": "CSV File",
      "value": "CSV",
      "icon": Icons.file_copy,
      "description": "Comma-separated values, compatible with Excel",
      "extension": ".csv"
    },
    {
      "title": "Excel File",
      "value": "Excel",
      "icon": Icons.table_chart,
      "description": "Microsoft Excel spreadsheet format",
      "extension": ".xlsx"
    },
    {
      "title": "Google Contacts",
      "value": "Google",
      "icon": Icons.contacts,
      "description": "Import ready format for Google Contacts",
      "extension": ".csv"
    },
    {
      "title": "Outlook Contacts",
      "value": "Outlook",
      "icon": Icons.email,
      "description": "Microsoft Outlook contacts format",
      "extension": ".vcf"
    },
    {
      "title": "vCard",
      "value": "vCard",
      "icon": Icons.contact_page,
      "description": "Universal contact format for mobile devices",
      "extension": ".vcf"
    }
  ];

  List<Map<String, dynamic>> rangeOptions = [
    {"label": "All Contacts", "value": "All"},
    {"label": "Active Contacts Only", "value": "Active"},
    {"label": "Selected Contacts", "value": "Selected"},
    {"label": "Filtered Results", "value": "Filtered"},
    {"label": "Date Range", "value": "DateRange"},
  ];

  List<String> availableFields = [
    "First Name",
    "Last Name",
    "Email",
    "Phone",
    "Company",
    "Position",
    "Address",
    "Website",
    "LinkedIn",
    "Twitter",
    "Lead Score",
    "Status",
    "Source",
    "Created Date",
    "Last Contact Date",
    "Notes",
    "Tags"
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "VIP Contacts", "value": "VIP"},
    {"label": "Hot Leads", "value": "Hot Leads"},
    {"label": "Cold Leads", "value": "Cold Leads"},
    {"label": "High Lead Score (80+)", "value": "High Score"},
    {"label": "Recent Contacts (30 days)", "value": "Recent"},
    {"label": "No Recent Activity", "value": "Inactive"},
  ];

  @override
  void initState() {
    super.initState();
    selectedFields = [
      "First Name",
      "Last Name", 
      "Email",
      "Phone",
      "Company",
      "Position"
    ];
    fileName = "contacts_export_${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Contacts"),
        actions: [
          TextButton(
            onPressed: () {
              _exportContacts();
            },
            child: Text(
              "Export",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildExportStats(),
            _buildFormatSelection(),
            _buildRangeSelection(),
            _buildFieldSelection(),
            _buildFilterOptions(),
            _buildAdvancedOptions(),
            _buildExportPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildExportStats() {
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
            "Export Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard("Total Contacts", "1,245", primaryColor),
              _buildStatCard("Active", "1,156", successColor),
              _buildStatCard("To Export", _getExportCount(), warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
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
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatSelection() {
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
            "Export Format",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Choose the format for your exported file:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ...formatOptions.map((format) {
            bool isSelected = exportFormat == format["value"];
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
              ),
              child: RadioListTile<String>(
                value: format["value"],
                groupValue: exportFormat,
                onChanged: (value) {
                  exportFormat = value!;
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
                        format["icon"],
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
                            "${format["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${format["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
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

  Widget _buildRangeSelection() {
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
            "Export Range",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "Select Range",
            items: rangeOptions,
            value: exportRange,
            onChanged: (value, label) {
              exportRange = value;
              setState(() {});
            },
          ),
          if (exportRange == "DateRange") ...[
            SizedBox(height: spSm),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Start Date",
                    value: startDate ?? DateTime.now().subtract(Duration(days: 30)),
                    onChanged: (value) {
                      startDate = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDatePicker(
                    label: "End Date", 
                    value: endDate ?? DateTime.now(),
                    onChanged: (value) {
                      endDate = value;
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

  Widget _buildFieldSelection() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fields to Export",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      selectedFields = List.from(availableFields);
                      setState(() {});
                    },
                    child: Text("Select All"),
                  ),
                  TextButton(
                    onPressed: () {
                      selectedFields.clear();
                      setState(() {});
                    },
                    child: Text("Clear All"),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Choose which contact fields to include in export:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: availableFields.map((field) {
              bool isSelected = selectedFields.contains(field);
              bool isRequired = ["First Name", "Last Name", "Email"].contains(field);
              
              return GestureDetector(
                onTap: () {
                  if (isRequired) return;
                  
                  if (isSelected) {
                    selectedFields.remove(field);
                  } else {
                    selectedFields.add(field);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : 
                           isRequired ? successColor.withAlpha(20) : Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isRequired)
                        Icon(
                          Icons.star,
                          size: 12,
                          color: successColor,
                        ),
                      if (isRequired)
                        SizedBox(width: 4),
                      Text(
                        field,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : 
                                 isRequired ? successColor : disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          Text(
            "★ Required fields cannot be deselected",
            style: TextStyle(
              fontSize: 10,
              color: successColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
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
            "Additional Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Apply additional filters to your export:",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: filterOptions.map((filter) {
              bool isSelected = selectedFilters.contains(filter["value"]);
              return GestureDetector(
                onTap: () {
                  if (isSelected) {
                    selectedFilters.remove(filter["value"]);
                  } else {
                    selectedFilters.add(filter["value"]);
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${filter["label"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOptions() {
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
            "Advanced Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "File Name",
            value: fileName,
            onChanged: (value) {
              fileName = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          QSwitch(
            items: [
              {
                "label": "Include Custom Fields",
                "value": "custom",
                "checked": includeCustomFields,
              }
            ],
            value: includeCustomFields ? [{"label": "Include Custom Fields", "value": "custom", "checked": true}] : [],
            onChanged: (values, ids) {
              includeCustomFields = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Notes",
                "value": "notes",
                "checked": includeNotes,
              }
            ],
            value: includeNotes ? [{"label": "Include Notes", "value": "notes", "checked": true}] : [],
            onChanged: (values, ids) {
              includeNotes = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Tags",
                "value": "tags",
                "checked": includeTags,
              }
            ],
            value: includeTags ? [{"label": "Include Tags", "value": "tags", "checked": true}] : [],
            onChanged: (values, ids) {
              includeTags = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExportPreview() {
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
            "Export Preview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPreviewRow("Format", "$exportFormat ${_getFileExtension()}"),
                _buildPreviewRow("Range", _getRangeDescription()),
                _buildPreviewRow("Fields", "${selectedFields.length} fields selected"),
                _buildPreviewRow("Contacts", _getExportCount()),
                _buildPreviewRow("File Size", "~${_getEstimatedSize()}"),
                _buildPreviewRow("File Name", "$fileName${_getFileExtension()}"),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export Contacts",
              size: bs.md,
              onPressed: () {
                _exportContacts();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getExportCount() {
    switch (exportRange) {
      case "All":
        return "1,245";
      case "Active":
        return "1,156";
      case "Selected":
        return "45";
      case "Filtered":
        return "234";
      case "DateRange":
        return "567";
      default:
        return "1,245";
    }
  }

  String _getRangeDescription() {
    switch (exportRange) {
      case "All":
        return "All contacts";
      case "Active":
        return "Active contacts only";
      case "Selected":
        return "Selected contacts";
      case "Filtered":
        return "Filtered results";
      case "DateRange":
        return "Date range: ${startDate?.dMMMy ?? 'Not set'}";
      default:
        return "All contacts";
    }
  }

  String _getFileExtension() {
    Map<String, String> extensions = {
      "CSV": ".csv",
      "Excel": ".xlsx",
      "Google": ".csv",
      "Outlook": ".vcf",
      "vCard": ".vcf"
    };
    return extensions[exportFormat] ?? ".csv";
  }

  String _getEstimatedSize() {
    int contactCount = int.parse(_getExportCount().replaceAll(",", ""));
    int fieldCount = selectedFields.length;
    double sizeKB = (contactCount * fieldCount * 50) / 1024; // Rough estimate
    
    if (sizeKB < 1024) {
      return "${sizeKB.toStringAsFixed(0)} KB";
    } else {
      return "${(sizeKB / 1024).toStringAsFixed(1)} MB";
    }
  }

  void _exportContacts() async {
    if (selectedFields.isEmpty) {
      se("Please select at least one field to export");
      return;
    }
    
    if (fileName.isEmpty) {
      se("Please enter a file name");
      return;
    }

    showLoading();
    
    // Simulate export process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    ss("Successfully exported ${_getExportCount()} contacts to $fileName${_getFileExtension()}");
    
    // Show download dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Export Complete"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your contacts have been exported successfully."),
              SizedBox(height: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.file_download, color: successColor),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$fileName${_getFileExtension()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Size: ${_getEstimatedSize()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                back();
                back();
              },
              child: Text("Done"),
            ),
            TextButton(
              onPressed: () {
                back();
                si("Download started");
              },
              child: Text("Download"),
            ),
          ],
        );
      },
    );
  }
}
