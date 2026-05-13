import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaExportView extends StatefulWidget {
  const RmaExportView({Key? key}) : super(key: key);

  @override
  State<RmaExportView> createState() => _RmaExportViewState();
}

class _RmaExportViewState extends State<RmaExportView> {
  String selectedFormat = "PDF";
  String selectedDateRange = "last_30_days";
  bool includeProperties = true;
  bool includeAlerts = true;
  bool includeAnalytics = true;
  bool includeTransactions = false;
  bool includeReports = true;
  bool includeImages = false;
  String emailAddress = "user@example.com";
  bool sendToEmail = false;
  bool downloadDirectly = true;

  List<Map<String, dynamic>> exportFormats = [
    {"label": "PDF Document", "value": "PDF", "icon": Icons.picture_as_pdf},
    {"label": "Excel Spreadsheet", "value": "XLSX", "icon": Icons.table_chart},
    {"label": "CSV File", "value": "CSV", "icon": Icons.description},
    {"label": "JSON Data", "value": "JSON", "icon": Icons.code},
    {"label": "XML Data", "value": "XML", "icon": Icons.data_object},
  ];

  List<Map<String, dynamic>> dateRangeOptions = [
    {"label": "Last 7 days", "value": "last_7_days"},
    {"label": "Last 30 days", "value": "last_30_days"},
    {"label": "Last 3 months", "value": "last_3_months"},
    {"label": "Last 6 months", "value": "last_6_months"},
    {"label": "Last year", "value": "last_year"},
    {"label": "All time", "value": "all_time"},
    {"label": "Custom range", "value": "custom"},
  ];

  DateTime? customStartDate;
  DateTime? customEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Data"),
        actions: [
          QButton(
            icon: Icons.help,
            size: bs.sm,
            onPressed: () => _showExportHelp(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Export Overview
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(60)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.download, color: primaryColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Export Your Data",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Create a comprehensive export of your property data, alerts, and analytics. Choose your preferred format and customize what to include.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // Export Format Selection
            _buildSectionHeader("Export Format", Icons.file_copy),
            _buildFormatSelection(),

            // Date Range Selection
            _buildSectionHeader("Date Range", Icons.date_range),
            _buildDateRangeSelection(),

            // Data Categories
            _buildSectionHeader("Data to Include", Icons.checklist),
            _buildDataCategorySelection(),

            // Export Options
            _buildSectionHeader("Export Options", Icons.settings),
            _buildExportOptions(),

            // Delivery Method
            _buildSectionHeader("Delivery Method", Icons.send),
            _buildDeliveryMethod(),

            // Export Summary
            _buildSectionHeader("Export Summary", Icons.summarize),
            _buildExportSummary(),

            // Export Button
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Export",
                    icon: Icons.file_download,
                    onPressed: () => _startExport(),
                  ),
                ),
              ],
            ),

            // Recent Exports
            _buildSectionHeader("Recent Exports", Icons.history),
            _buildRecentExports(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(width: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFormatSelection() {
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
          Text(
            "Choose your preferred export format:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          ...exportFormats.map((format) => GestureDetector(
            onTap: () {
              selectedFormat = format["value"];
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: selectedFormat == format["value"] ? primaryColor.withAlpha(20) : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: selectedFormat == format["value"] ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    format["icon"] as IconData,
                    color: selectedFormat == format["value"] ? primaryColor : disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${format["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: selectedFormat == format["value"] ? FontWeight.w600 : FontWeight.normal,
                        color: selectedFormat == format["value"] ? primaryColor : Colors.black,
                      ),
                    ),
                  ),
                  if (selectedFormat == format["value"])
                    Icon(Icons.check_circle, color: primaryColor, size: 20),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDateRangeSelection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          QDropdownField(
            label: "Select Date Range",
            items: dateRangeOptions,
            value: selectedDateRange,
            onChanged: (value, label) {
              selectedDateRange = value;
              setState(() {});
            },
          ),

          if (selectedDateRange == "custom") ...[
            Row(
              children: [
                Expanded(
                  child: QDatePicker(
                    label: "Start Date",
                    value: customStartDate ?? DateTime.now().subtract(Duration(days: 30)),
                    onChanged: (value) {
                      customStartDate = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDatePicker(
                    label: "End Date",
                    value: customEndDate ?? DateTime.now(),
                    onChanged: (value) {
                      customEndDate = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],

          // Date Range Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    _getDateRangeDescription(),
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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

  Widget _buildDataCategorySelection() {
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
          Text(
            "Select data categories to include in your export:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          _buildCategoryRow("Properties", "Property listings, details, and favorites", Icons.home, includeProperties, (value) {
            includeProperties = value;
            setState(() {});
          }),
          
          _buildCategoryRow("Alerts", "Price alerts, notifications, and triggers", Icons.notifications, includeAlerts, (value) {
            includeAlerts = value;
            setState(() {});
          }),
          
          _buildCategoryRow("Analytics", "Search history, trends, and insights", Icons.analytics, includeAnalytics, (value) {
            includeAnalytics = value;
            setState(() {});
          }),
          
          _buildCategoryRow("Transactions", "Purchase history and financial data", Icons.payment, includeTransactions, (value) {
            includeTransactions = value;
            setState(() {});
          }),
          
          _buildCategoryRow("Reports", "Generated reports and summaries", Icons.assessment, includeReports, (value) {
            includeReports = value;
            setState(() {});
          }),
          
          _buildCategoryRow("Images", "Property photos and media files", Icons.image, includeImages, (value) {
            includeImages = value;
            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget _buildExportOptions() {
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
          // Compression Options
          if (selectedFormat == "PDF" || includeImages) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(60)),
              ),
              child: Row(
                children: [
                  Icon(Icons.compress, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Large File Notice",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Including images may result in large file sizes. Consider using compression or splitting into multiple files.",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // File Size Estimate
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.storage, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Text(
                  "Estimated file size: ${_getEstimatedFileSize()}",
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
    );
  }

  Widget _buildDeliveryMethod() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          _buildDeliveryOption("Download Directly", "Download file to your device immediately", Icons.download, downloadDirectly, (value) {
            downloadDirectly = value;
            setState(() {});
          }),
          
          _buildDeliveryOption("Send to Email", "Receive download link via email", Icons.email, sendToEmail, (value) {
            sendToEmail = value;
            setState(() {});
          }),

          if (sendToEmail) ...[
            QTextField(
              label: "Email Address",
              value: emailAddress,
              hint: "Enter email address",
              onChanged: (value) {
                emailAddress = value;
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExportSummary() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Export Summary:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          _buildSummaryRow("Format", selectedFormat),
          _buildSummaryRow("Date Range", _getDateRangeDescription()),
          _buildSummaryRow("Categories", _getSelectedCategories()),
          _buildSummaryRow("Estimated Size", _getEstimatedFileSize()),
          _buildSummaryRow("Delivery", _getDeliveryMethod()),
        ],
      ),
    );
  }

  Widget _buildRecentExports() {
    List<Map<String, dynamic>> recentExports = [
      {
        "name": "Property_Data_March_2024.pdf",
        "date": "2024-03-15",
        "size": "2.4 MB",
        "status": "Completed",
        "format": "PDF",
      },
      {
        "name": "Analytics_Report_February.xlsx",
        "date": "2024-02-28",
        "size": "1.8 MB", 
        "status": "Completed",
        "format": "XLSX",
      },
      {
        "name": "Full_Export_January.json",
        "date": "2024-01-31",
        "size": "5.2 MB",
        "status": "Completed",
        "format": "JSON",
      },
    ];

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
          if (recentExports.isEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: disabledBoldColor),
                  SizedBox(height: spSm),
                  Text(
                    "No recent exports",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...recentExports.map((export) => Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    _getFormatIcon(export["format"]),
                    color: primaryColor,
                    size: 20,
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(export["date"]).dMMMy} • ${export["size"]}",
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(60)),
                    ),
                    child: Text(
                      "${export["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      ss("Downloading ${export["name"]}");
                    },
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, String description, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor.withAlpha(60) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: value ? primaryColor : disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String title, String description, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: value ? primaryColor.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: value ? primaryColor.withAlpha(60) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: value ? primaryColor : disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: value ? primaryColor : Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String _getDateRangeDescription() {
    switch (selectedDateRange) {
      case "last_7_days":
        return "Data from the last 7 days";
      case "last_30_days":
        return "Data from the last 30 days";
      case "last_3_months":
        return "Data from the last 3 months";
      case "last_6_months":
        return "Data from the last 6 months";
      case "last_year":
        return "Data from the last year";
      case "all_time":
        return "All available data";
      case "custom":
        if (customStartDate != null && customEndDate != null) {
          return "${customStartDate!.dMMMy} to ${customEndDate!.dMMMy}";
        }
        return "Custom date range";
      default:
        return "Last 30 days";
    }
  }

  String _getSelectedCategories() {
    List<String> categories = [];
    if (includeProperties) categories.add("Properties");
    if (includeAlerts) categories.add("Alerts");
    if (includeAnalytics) categories.add("Analytics");
    if (includeTransactions) categories.add("Transactions");
    if (includeReports) categories.add("Reports");
    if (includeImages) categories.add("Images");
    
    return categories.isEmpty ? "None selected" : categories.join(", ");
  }

  String _getEstimatedFileSize() {
    int baseSize = 100; // KB
    
    if (includeProperties) baseSize += 500;
    if (includeAlerts) baseSize += 200;
    if (includeAnalytics) baseSize += 300;
    if (includeTransactions) baseSize += 150;
    if (includeReports) baseSize += 400;
    if (includeImages) baseSize += 5000; // Images add significant size
    
    if (selectedFormat == "PDF") baseSize = (baseSize * 1.5).round();
    if (selectedFormat == "XLSX") baseSize = (baseSize * 1.2).round();
    
    if (baseSize < 1024) {
      return "${baseSize} KB";
    } else {
      return "${(baseSize / 1024).toStringAsFixed(1)} MB";
    }
  }

  String _getDeliveryMethod() {
    List<String> methods = [];
    if (downloadDirectly) methods.add("Direct Download");
    if (sendToEmail) methods.add("Email Link");
    
    return methods.isEmpty ? "None selected" : methods.join(", ");
  }

  IconData _getFormatIcon(String format) {
    switch (format) {
      case "PDF":
        return Icons.picture_as_pdf;
      case "XLSX":
        return Icons.table_chart;
      case "CSV":
        return Icons.description;
      case "JSON":
        return Icons.code;
      case "XML":
        return Icons.data_object;
      default:
        return Icons.file_copy;
    }
  }

  void _startExport() {
    // Validation
    if (!includeProperties && !includeAlerts && !includeAnalytics && !includeTransactions && !includeReports && !includeImages) {
      se("Please select at least one data category to export");
      return;
    }

    if (!downloadDirectly && !sendToEmail) {
      se("Please select at least one delivery method");
      return;
    }

    if (sendToEmail && emailAddress.isEmpty) {
      se("Please enter an email address");
      return;
    }

    showLoading();
    
    // Simulate export process
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("Export started successfully! You will be notified when it's ready.");
      
      // In a real app, this would navigate back or show progress
      back();
    });
  }

  void _showExportHelp() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: spSm),
              decoration: BoxDecoration(
                color: disabledOutlineBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Text(
                    "Export Help",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),

            Divider(height: spMd),

            // Help Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHelpSection("Export Formats", [
                      "PDF: Best for reports and presentations",
                      "Excel: Great for data analysis and calculations",
                      "CSV: Simple format for spreadsheet applications",
                      "JSON/XML: Technical formats for developers",
                    ]),
                    
                    _buildHelpSection("Data Categories", [
                      "Properties: Your saved and viewed properties",
                      "Alerts: All your price and market alerts",
                      "Analytics: Search trends and insights",
                      "Transactions: Purchase and financial records",
                      "Reports: Generated analysis reports",
                      "Images: Property photos (increases file size)",
                    ]),
                    
                    _buildHelpSection("File Size Tips", [
                      "Exclude images to reduce file size",
                      "Use shorter date ranges for smaller files",
                      "CSV format produces the smallest files",
                      "PDF with images can be very large",
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(left: spSm, bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("• ", style: TextStyle(color: primaryColor)),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
