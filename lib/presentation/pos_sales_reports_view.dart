import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosSalesReportsView extends StatefulWidget {
  const PosSalesReportsView({super.key});

  @override
  State<PosSalesReportsView> createState() => _PosSalesReportsViewState();
}

class _PosSalesReportsViewState extends State<PosSalesReportsView> {
  String selectedReportType = "Sales Summary";
  String selectedPeriod = "This Month";
  String selectedFormat = "PDF";
  
  List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "Sales Summary", "value": "Sales Summary"},
    {"label": "Product Performance", "value": "Product Performance"},
    {"label": "Customer Analysis", "value": "Customer Analysis"},
    {"label": "Inventory Report", "value": "Inventory Report"},
    {"label": "Payment Methods", "value": "Payment Methods"},
    {"label": "Tax Report", "value": "Tax Report"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF", "value": "PDF"},
    {"label": "Excel", "value": "Excel"},
    {"label": "CSV", "value": "CSV"},
  ];

  List<Map<String, dynamic>> quickReports = [
    {
      "title": "Daily Sales Summary",
      "description": "Complete sales overview for today",
      "icon": Icons.today,
      "color": primaryColor,
      "lastGenerated": "2 hours ago",
    },
    {
      "title": "Weekly Performance",
      "description": "7-day sales and performance metrics",
      "icon": Icons.calendar_view_week,
      "color": successColor,
      "lastGenerated": "1 day ago",
    },
    {
      "title": "Monthly Report",
      "description": "Comprehensive monthly analysis",
      "icon": Icons.calendar_month,
      "color": infoColor,
      "lastGenerated": "3 days ago",
    },
    {
      "title": "Product Analysis",
      "description": "Top selling and underperforming products",
      "icon": Icons.inventory,
      "color": warningColor,
      "lastGenerated": "5 hours ago",
    },
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "title": "Sales Summary - January 2024",
      "type": "Monthly Report",
      "generatedDate": "2024-01-15",
      "generatedTime": "14:30",
      "format": "PDF",
      "size": "2.4 MB",
      "status": "completed",
    },
    {
      "title": "Product Performance - Week 2",
      "type": "Weekly Report",
      "generatedDate": "2024-01-14",
      "generatedTime": "09:15",
      "format": "Excel",
      "size": "1.8 MB",
      "status": "completed",
    },
    {
      "title": "Customer Analysis - Q1 2024",
      "type": "Quarterly Report",
      "generatedDate": "2024-01-12",
      "generatedTime": "16:45",
      "format": "PDF",
      "size": "3.2 MB",
      "status": "processing",
    },
    {
      "title": "Inventory Report - January",
      "type": "Monthly Report",
      "generatedDate": "2024-01-10",
      "generatedTime": "11:20",
      "format": "CSV",
      "size": "0.9 MB",
      "status": "completed",
    },
  ];

  Widget _buildReportGenerator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate Custom Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Column(
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Report Type",
                items: reportTypeOptions,
                value: selectedReportType,
                onChanged: (value, label) {
                  selectedReportType = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Period",
                      items: periodOptions,
                      value: selectedPeriod,
                      onChanged: (value, label) {
                        selectedPeriod = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Format",
                      items: formatOptions,
                      value: selectedFormat,
                      onChanged: (value, label) {
                        selectedFormat = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Preview Report",
                      icon: Icons.preview,
                      size: bs.md,
                      onPressed: () {
                        si("Generating report preview...");
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Generate & Download",
                      icon: Icons.download,
                      size: bs.md,
                      onPressed: () {
                        ss("Report generation started. You'll be notified when ready.");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReports() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 200,
            children: quickReports.map((report) {
              return GestureDetector(
                onTap: () {
                  ss("Generating ${report["title"]}...");
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (report["color"] as Color).withAlpha(20),
                        (report["color"] as Color).withAlpha(5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (report["color"] as Color).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: report["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              report["icon"] as IconData,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward,
                            color: report["color"] as Color,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${report["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${report["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Last generated: ${report["lastGenerated"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                "Recent Reports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to all reports
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: recentReports.map((report) {
              IconData statusIcon = Icons.check_circle;
              Color statusColor = successColor;
              
              if (report["status"] == "processing") {
                statusIcon = Icons.hourglass_empty;
                statusColor = warningColor;
              } else if (report["status"] == "failed") {
                statusIcon = Icons.error;
                statusColor = dangerColor;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: _getFormatColor(report["format"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getFormatIcon(report["format"]),
                        color: _getFormatColor(report["format"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${report["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${report["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${DateTime.parse(report["generatedDate"]).dMMMy} at ${report["generatedTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${report["size"]}",
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
                    Column(
                      children: [
                        Icon(
                          statusIcon,
                          color: statusColor,
                          size: 20,
                        ),
                        SizedBox(height: spSm),
                        if (report["status"] == "completed")
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ss("Opening ${report["title"]}");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.open_in_new,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  ss("Downloading ${report["title"]}");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.download,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportInsights() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "47",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Reports Generated",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "This Month",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "12.5 MB",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Storage",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Used",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "PDF",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Most Popular",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Format",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getFormatColor(String format) {
    switch (format) {
      case "PDF":
        return dangerColor;
      case "Excel":
        return successColor;
      case "CSV":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  IconData _getFormatIcon(String format) {
    switch (format) {
      case "PDF":
        return Icons.picture_as_pdf;
      case "Excel":
        return Icons.table_chart;
      case "CSV":
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              // Navigate to scheduled reports
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to report settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildReportGenerator(),
            _buildQuickReports(),
            _buildRecentReports(),
            _buildReportInsights(),
          ],
        ),
      ),
    );
  }
}
