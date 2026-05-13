import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerExportView extends StatefulWidget {
  const CrmCustomerExportView({super.key});

  @override
  State<CrmCustomerExportView> createState() => _CrmCustomerExportViewState();
}

class _CrmCustomerExportViewState extends State<CrmCustomerExportView> {
  bool loading = false;
  
  String selectedFormat = "csv";
  String selectedData = "all";
  String selectedSegment = "all";
  String selectedDateRange = "all_time";
  bool includeHeaders = true;
  bool includePersonalInfo = true;
  bool includeContactInfo = true;
  bool includeOrderHistory = false;
  bool includePayments = false;
  bool includeNotes = false;
  bool compressFile = false;

  List<Map<String, dynamic>> formatOptions = [
    {"label": "CSV File (.csv)", "value": "csv", "icon": Icons.table_chart},
    {"label": "Excel File (.xlsx)", "value": "excel", "icon": Icons.grid_on},
    {"label": "JSON File (.json)", "value": "json", "icon": Icons.code},
    {"label": "PDF Report (.pdf)", "value": "pdf", "icon": Icons.picture_as_pdf},
  ];

  List<Map<String, dynamic>> dataOptions = [
    {"label": "All Customers", "value": "all"},
    {"label": "Active Customers Only", "value": "active"},
    {"label": "Inactive Customers Only", "value": "inactive"},
    {"label": "Custom Selection", "value": "custom"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Segments", "value": "all"},
    {"label": "VIP Customers", "value": "vip"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Regular Customers", "value": "regular"},
    {"label": "New Customers", "value": "new"},
    {"label": "At Risk", "value": "at_risk"},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "All Time", "value": "all_time"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "This Year", "value": "this_year"},
    {"label": "Last Year", "value": "last_year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  Map<String, dynamic> exportStats = {
    "totalCustomers": 1969,
    "activeCustomers": 1654,
    "inactiveCustomers": 315,
    "estimatedFileSize": "2.5 MB",
    "estimatedRecords": 1969
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Customers"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () => _showExportHelp(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Export Summary
                  _buildExportSummary(),
                  
                  // Format Selection
                  _buildFormatSelection(),
                  
                  // Data Selection
                  _buildDataSelection(),
                  
                  // Filters
                  _buildFilters(),
                  
                  // Field Selection
                  _buildFieldSelection(),
                  
                  // Export Options
                  _buildExportOptions(),
                  
                  // Export Preview
                  _buildExportPreview(),
                  
                  // Export Actions
                  _buildExportActions(),
                ],
              ),
            ),
    );
  }

  Widget _buildExportSummary() {
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
            children: [
              Icon(
                Icons.download,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Export Summary",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildSummaryCard("Total Records", "${exportStats["estimatedRecords"]}", primaryColor, Icons.people),
              SizedBox(width: spSm),
              _buildSummaryCard("File Size", "${exportStats["estimatedFileSize"]}", infoColor, Icons.storage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              title,
              textAlign: TextAlign.center,
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
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...formatOptions.map((format) => _buildFormatOption(format)),
        ],
      ),
    );
  }

  Widget _buildFormatOption(Map<String, dynamic> format) {
    bool isSelected = selectedFormat == format["value"];
    
    return GestureDetector(
      onTap: () {
        selectedFormat = format["value"];
        _updateExportStats();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withAlpha(20) : disabledColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                format["icon"] as IconData,
                color: isSelected ? primaryColor : disabledBoldColor,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                "${format["label"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? primaryColor : disabledBoldColor,
                ),
              ),
            ),
            if (isSelected) ...[
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataSelection() {
    return Container(
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
            "Data Selection",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Customer Data",
            items: dataOptions,
            value: selectedData,
            onChanged: (value, label) {
              selectedData = value;
              _updateExportStats();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
            "Filters",
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
                  label: "Customer Segment",
                  items: segmentOptions,
                  value: selectedSegment,
                  onChanged: (value, label) {
                    selectedSegment = value;
                    _updateExportStats();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: dateRangeOptions,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    _updateExportStats();
                  },
                ),
              ),
            ],
          ),
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Include Fields",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QSwitch(
            items: [
              {
                "label": "Personal Information (Name, Email, Phone)",
                "value": true,
                "checked": includePersonalInfo,
              }
            ],
            value: [
              if (includePersonalInfo)
                {
                  "label": "Personal Information (Name, Email, Phone)",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includePersonalInfo = values.isNotEmpty;
              _updateExportStats();
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Contact Information (Address, Company)",
                "value": true,
                "checked": includeContactInfo,
              }
            ],
            value: [
              if (includeContactInfo)
                {
                  "label": "Contact Information (Address, Company)",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeContactInfo = values.isNotEmpty;
              _updateExportStats();
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Order History",
                "value": true,
                "checked": includeOrderHistory,
              }
            ],
            value: [
              if (includeOrderHistory)
                {
                  "label": "Order History",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeOrderHistory = values.isNotEmpty;
              _updateExportStats();
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Payment Information",
                "value": true,
                "checked": includePayments,
              }
            ],
            value: [
              if (includePayments)
                {
                  "label": "Payment Information",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includePayments = values.isNotEmpty;
              _updateExportStats();
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Customer Notes",
                "value": true,
                "checked": includeNotes,
              }
            ],
            value: [
              if (includeNotes)
                {
                  "label": "Customer Notes",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              includeNotes = values.isNotEmpty;
              _updateExportStats();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
    return Container(
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
            "Export Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          if (selectedFormat != "pdf") ...[
            QSwitch(
              items: [
                {
                  "label": "Include column headers",
                  "value": true,
                  "checked": includeHeaders,
                }
              ],
              value: [
                if (includeHeaders)
                  {
                    "label": "Include column headers",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                includeHeaders = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
          QSwitch(
            items: [
              {
                "label": "Compress file (ZIP)",
                "value": true,
                "checked": compressFile,
              }
            ],
            value: [
              if (compressFile)
                {
                  "label": "Compress file (ZIP)",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              compressFile = values.isNotEmpty;
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
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPreviewRow("Format", _getFormatDisplayName()),
                _buildPreviewRow("Records", "${exportStats["estimatedRecords"]} customers"),
                _buildPreviewRow("Segment", _getSegmentDisplayName()),
                _buildPreviewRow("Date Range", _getDateRangeDisplayName()),
                _buildPreviewRow("File Size", "${exportStats["estimatedFileSize"]}"),
                _buildPreviewRow("Fields", _getFieldsPreview()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExportActions() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Export Now",
            size: bs.md,
            onPressed: () => _startExport(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Schedule Export",
            size: bs.md,
            onPressed: () => _scheduleExport(),
          ),
        ),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Save as Template",
            size: bs.md,
            onPressed: () => _saveTemplate(),
          ),
        ),
      ],
    );
  }

  String _getFormatDisplayName() {
    Map<String, dynamic> format = formatOptions.firstWhere(
      (f) => f["value"] == selectedFormat,
      orElse: () => formatOptions[0]
    );
    return format["label"];
  }

  String _getSegmentDisplayName() {
    Map<String, dynamic> segment = segmentOptions.firstWhere(
      (s) => s["value"] == selectedSegment,
      orElse: () => segmentOptions[0]
    );
    return segment["label"];
  }

  String _getDateRangeDisplayName() {
    Map<String, dynamic> range = dateRangeOptions.firstWhere(
      (r) => r["value"] == selectedDateRange,
      orElse: () => dateRangeOptions[0]
    );
    return range["label"];
  }

  String _getFieldsPreview() {
    List<String> fields = [];
    if (includePersonalInfo) fields.add("Personal");
    if (includeContactInfo) fields.add("Contact");
    if (includeOrderHistory) fields.add("Orders");
    if (includePayments) fields.add("Payments");
    if (includeNotes) fields.add("Notes");
    
    return fields.isEmpty ? "None selected" : fields.join(", ");
  }

  void _updateExportStats() {
    // Simulate updating export statistics based on selections
    int baseRecords = 1969;
    double multiplier = 1.0;
    
    switch (selectedData) {
      case "active":
        baseRecords = 1654;
        break;
      case "inactive":
        baseRecords = 315;
        break;
    }
    
    switch (selectedSegment) {
      case "vip":
        multiplier = 0.08; // 8% are VIP
        break;
      case "enterprise":
        multiplier = 0.05; // 5% are Enterprise
        break;
      case "regular":
        multiplier = 0.65; // 65% are Regular
        break;
      case "new":
        multiplier = 0.04; // 4% are New
        break;
      case "at_risk":
        multiplier = 0.12; // 12% are At Risk
        break;
    }
    
    int estimatedRecords = (baseRecords * multiplier).round();
    double estimatedSize = estimatedRecords * 0.001; // Rough estimate
    
    if (includeOrderHistory) estimatedSize *= 2;
    if (includePayments) estimatedSize *= 1.5;
    if (includeNotes) estimatedSize *= 1.3;
    
    exportStats = {
      "totalCustomers": baseRecords,
      "estimatedRecords": estimatedRecords,
      "estimatedFileSize": "${estimatedSize.toStringAsFixed(1)} MB"
    };
    
    setState(() {});
  }

  void _showExportHelp() {
    si("Show export help documentation");
  }

  void _startExport() {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Export completed successfully! File downloaded to your device.");
    });
  }

  void _scheduleExport() {
    si("Schedule automatic export");
  }

  void _saveTemplate() {
    si("Save export configuration as template");
  }
}
