import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExport4View extends StatefulWidget {
  @override
  State<GrlExport4View> createState() => _GrlExport4ViewState();
}

class _GrlExport4ViewState extends State<GrlExport4View> {
  int currentTab = 0;
  String selectedFormat = "PDF";
  String selectedDateRange = "Last 30 Days";
  List<String> selectedFields = [];
  bool includeHeaders = true;
  bool includeFooters = false;
  String fileName = "export_data";
  
  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF", "value": "PDF"},
    {"label": "Excel", "value": "Excel"},
    {"label": "CSV", "value": "CSV"},
    {"label": "JSON", "value": "JSON"},
  ];
  
  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];
  
  List<Map<String, dynamic>> availableFields = [
    {"label": "ID", "value": "id", "checked": true},
    {"label": "Name", "value": "name", "checked": true},
    {"label": "Email", "value": "email", "checked": true},
    {"label": "Phone", "value": "phone", "checked": false},
    {"label": "Address", "value": "address", "checked": false},
    {"label": "Created Date", "value": "created_date", "checked": true},
    {"label": "Status", "value": "status", "checked": true},
    {"label": "Category", "value": "category", "checked": false},
  ];
  
  List<Map<String, dynamic>> exportHistory = [
    {
      "fileName": "customer_data_2024_01_15.pdf",
      "format": "PDF",
      "size": "2.3 MB",
      "date": "2024-01-15",
      "status": "Completed",
      "downloadUrl": "https://example.com/download/1"
    },
    {
      "fileName": "sales_report_2024_01_10.xlsx",
      "format": "Excel",
      "size": "5.7 MB",
      "date": "2024-01-10",
      "status": "Completed",
      "downloadUrl": "https://example.com/download/2"
    },
    {
      "fileName": "inventory_data_2024_01_08.csv",
      "format": "CSV",
      "size": "1.2 MB",
      "date": "2024-01-08",
      "status": "Failed",
      "downloadUrl": null
    },
    {
      "fileName": "user_analytics_2024_01_05.json",
      "format": "JSON",
      "size": "3.8 MB",
      "date": "2024-01-05",
      "status": "Completed",
      "downloadUrl": "https://example.com/download/4"
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedFields = availableFields
        .where((field) => field["checked"] == true)
        .map((field) => field["value"] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Advanced Export",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Configure", icon: Icon(Icons.settings)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Templates", icon: Icon(Icons.bookmark)),
      ],
      tabChildren: [
        _buildConfigureTab(),
        _buildHistoryTab(),
        _buildTemplatesTab(),
      ],
    );
  }

  Widget _buildConfigureTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildExportFormatSection(),
          _buildDateRangeSection(),
          _buildFieldSelectionSection(),
          _buildOptionsSection(),
          _buildFileNameSection(),
          _buildExportButton(),
        ],
      ),
    );
  }

  Widget _buildExportFormatSection() {
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
              Icon(Icons.file_download, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Export Format",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Format",
            items: formatOptions,
            value: selectedFormat,
            onChanged: (value, label) {
              selectedFormat = value;
              setState(() {});
            },
          ),
          _buildFormatPreview(),
        ],
      ),
    );
  }

  Widget _buildFormatPreview() {
    IconData icon;
    Color color;
    String description;
    
    switch (selectedFormat) {
      case "PDF":
        icon = Icons.picture_as_pdf;
        color = Colors.red;
        description = "Portable Document Format - Best for sharing and printing";
        break;
      case "Excel":
        icon = Icons.table_chart;
        color = Colors.green;
        description = "Excel Spreadsheet - Best for data analysis and calculations";
        break;
      case "CSV":
        icon = Icons.grid_on;
        color = Colors.blue;
        description = "Comma Separated Values - Best for data import/export";
        break;
      case "JSON":
        icon = Icons.code;
        color = Colors.orange;
        description = "JavaScript Object Notation - Best for API integration";
        break;
      default:
        icon = Icons.file_copy;
        color = disabledBoldColor;
        description = "Select a format to see preview";
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeSection() {
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
              Icon(Icons.date_range, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Date Range",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Date Range",
            items: dateRangeOptions,
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),
          if (selectedDateRange == "Custom Range") _buildCustomDateRange(),
        ],
      ),
    );
  }

  Widget _buildCustomDateRange() {
    return Row(
      children: [
        Expanded(
          child: QDatePicker(
            label: "Start Date",
            value: DateTime.now().subtract(Duration(days: 30)),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDatePicker(
            label: "End Date",
            value: DateTime.now(),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.view_column, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Field Selection",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  bool allSelected = availableFields.every((field) => field["checked"] == true);
                  for (var field in availableFields) {
                    field["checked"] = !allSelected;
                  }
                  selectedFields = availableFields
                      .where((field) => field["checked"] == true)
                      .map((field) => field["value"] as String)
                      .toList();
                  setState(() {});
                },
                child: Text(
                  "Select All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          QSwitch(
            items: availableFields,
            value: availableFields.where((field) => field["checked"] == true).toList(),
            onChanged: (values, ids) {
              for (var field in availableFields) {
                field["checked"] = values.any((v) => v["value"] == field["value"]);
              }
              selectedFields = values.map((v) => v["value"] as String).toList();
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "${selectedFields.length} fields selected",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection() {
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
              Icon(Icons.tune, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Export Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Include Headers",
                "value": "headers",
                "checked": includeHeaders,
              }
            ],
            value: [
              if (includeHeaders)
                {
                  "label": "Include Headers",
                  "value": "headers",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeHeaders = values.isNotEmpty;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Include Footers",
                "value": "footers",
                "checked": includeFooters,
              }
            ],
            value: [
              if (includeFooters)
                {
                  "label": "Include Footers",
                  "value": "footers",
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeFooters = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFileNameSection() {
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
              Icon(Icons.drive_file_rename_outline, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "File Name",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Enter file name",
            value: fileName,
            hint: "e.g., customer_data_2024",
            onChanged: (value) {
              fileName = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "File extension will be added automatically based on selected format",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
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

  Widget _buildExportButton() {
    return Container(
      width: double.infinity,
      child: QButton(
        label: "Export Data",
        icon: Icons.download,
        size: bs.md,
        onPressed: () {
          _performExport();
        },
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildHistoryHeader(),
          ...exportHistory.map((export) => _buildHistoryItem(export)),
        ],
      ),
    );
  }

  Widget _buildHistoryHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: primaryColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Export History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "View and download your previous exports",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> export) {
    Color statusColor;
    IconData statusIcon;
    
    switch (export["status"]) {
      case "Completed":
        statusColor = successColor;
        statusIcon = Icons.check_circle;
        break;
      case "Failed":
        statusColor = dangerColor;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = warningColor;
        statusIcon = Icons.schedule;
    }
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.file_copy,
                  color: Colors.white,
                  size: 16,
                ),
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
                    Text(
                      "${export["format"]} • ${export["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: Colors.white, size: 12),
                    SizedBox(width: 2),
                    Text(
                      "${export["status"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Created: ${export["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (export["downloadUrl"] != null) ...[
                QButton(
                  label: "Download",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    _downloadFile(export);
                  },
                ),
                SizedBox(width: spXs),
              ],
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _deleteExport(export);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplateHeader(),
          _buildTemplateItem("Customer Report", "PDF", ["name", "email", "phone", "created_date"]),
          _buildTemplateItem("Sales Analytics", "Excel", ["id", "name", "revenue", "date", "category"]),
          _buildTemplateItem("Basic Export", "CSV", ["id", "name", "status"]),
          _buildTemplateItem("API Data", "JSON", ["id", "name", "email", "metadata"]),
        ],
      ),
    );
  }

  Widget _buildTemplateHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark, color: primaryColor),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Export Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Quick export with predefined settings",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "New Template",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              _createTemplate();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String name, String format, List<String> fields) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$format • ${fields.length} fields",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () {
                  _useTemplate(name, format, fields);
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: fields.map((field) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  field,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _performExport() {
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
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Export completed successfully!");
      
      // Add to history
      Map<String, dynamic> newExport = {
        "fileName": "$fileName.${selectedFormat.toLowerCase()}",
        "format": selectedFormat,
        "size": "4.2 MB",
        "date": DateTime.now().toString().split(' ')[0],
        "status": "Completed",
        "downloadUrl": "https://example.com/download/new"
      };
      
      exportHistory.insert(0, newExport);
      setState(() {});
    });
  }

  void _downloadFile(Map<String, dynamic> export) {
    ss("Downloading ${export["fileName"]}...");
  }

  void _deleteExport(Map<String, dynamic> export) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this export?");
    if (isConfirmed) {
      exportHistory.remove(export);
      setState(() {});
      ss("Export deleted successfully");
    }
  }

  void _createTemplate() {
    si("Template creation feature coming soon!");
  }

  void _useTemplate(String name, String format, List<String> fields) {
    selectedFormat = format;
    fileName = name.toLowerCase().replaceAll(' ', '_');
    
    // Update field selections
    for (var field in availableFields) {
      field["checked"] = fields.contains(field["value"]);
    }
    
    selectedFields = fields;
    currentTab = 0;
    setState(() {});
    
    ss("Template '$name' applied successfully!");
  }
}
