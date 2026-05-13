import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaReportsView extends StatefulWidget {
  const EmaReportsView({super.key});

  @override
  State<EmaReportsView> createState() => _EmaReportsViewState();
}

class _EmaReportsViewState extends State<EmaReportsView> {
  String selectedPeriod = "This Week";
  String selectedReportType = "All";
  
  List<String> periods = ["This Week", "Last Week", "This Month", "Last Month", "Custom"];
  List<String> reportTypes = ["All", "Assessment", "Mood", "Progress", "Summary"];

  List<Map<String, dynamic>> reports = [
    {
      "id": 1,
      "title": "Weekly Assessment Summary",
      "type": "Assessment",
      "period": "June 10-17, 2025",
      "status": "Ready",
      "generatedDate": "2025-06-18",
      "size": "2.3 MB",
      "pages": 8,
      "insights": 15,
      "url": "https://example.com/report1.pdf",
      "description": "Comprehensive analysis of your weekly assessment responses",
    },
    {
      "id": 2,
      "title": "Mood Tracking Report",
      "type": "Mood",
      "period": "June 1-17, 2025",
      "status": "Processing",
      "generatedDate": "2025-06-18",
      "size": "1.8 MB",
      "pages": 6,
      "insights": 12,
      "url": "",
      "description": "Detailed mood patterns and trend analysis",
    },
    {
      "id": 3,
      "title": "Progress Evaluation",
      "type": "Progress",
      "period": "May 2025",
      "status": "Ready",
      "generatedDate": "2025-06-01",
      "size": "3.1 MB",
      "pages": 12,
      "insights": 23,
      "url": "https://example.com/report3.pdf",
      "description": "Monthly progress tracking and goal achievement analysis",
    },
    {
      "id": 4,
      "title": "Comprehensive Summary",
      "type": "Summary",
      "period": "Q2 2025",
      "status": "Ready",
      "generatedDate": "2025-06-15",
      "size": "4.5 MB",
      "pages": 18,
      "insights": 34,
      "url": "https://example.com/report4.pdf",
      "description": "Quarterly comprehensive analysis and recommendations",
    },
    {
      "id": 5,
      "title": "Daily Assessment Overview",
      "type": "Assessment",
      "period": "June 17, 2025",
      "status": "Draft",
      "generatedDate": "2025-06-17",
      "size": "0.8 MB",
      "pages": 3,
      "insights": 7,
      "url": "",
      "description": "Single day assessment analysis and insights",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredReports = reports.where((report) {
      if (selectedReportType == "All") return true;
      return report["type"] == selectedReportType;
    }).toList();

    int readyReports = reports.where((r) => r["status"] == "Ready").length;
    int totalInsights = reports.fold(0, (sum, r) => sum + (r["insights"] as int));

    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // navigateTo('DownloadManagerView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('ReportSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Reports Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "EMA Reports Dashboard",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Track your progress with detailed analytics",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${reports.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Reports",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${readyReports}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Ready",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${totalInsights}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Insights",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    label: "Report Type",
                    items: reportTypes.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    value: selectedReportType,
                    onChanged: (value, label) {
                      selectedReportType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Generate New Report
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add_chart,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Generate New Report",
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
                    "Create custom reports based on your assessment data and preferences",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Generate Report",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo('GenerateReportView')
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Reports List
            Text(
              "Available Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredReports.map((report) {
                Color statusColor = _getStatusColor(report["status"]);
                Color typeColor = _getTypeColor(report["type"]);
                IconData statusIcon = _getStatusIcon(report["status"]);

                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getTypeIcon(report["type"]),
                              size: 20,
                              color: typeColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${report["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${report["description"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  statusIcon,
                                  size: 12,
                                  color: statusColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${report["status"]}",
                                  style: TextStyle(
                                    color: statusColor,
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
                          Icon(
                            Icons.date_range,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${report["period"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.today,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Generated: ${report["generatedDate"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 12,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${report["pages"]} pages",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  size: 12,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${report["insights"]} insights",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${report["size"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      if (report["status"] == "Ready")
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Report",
                                size: bs.sm,
                                onPressed: () {
                                  // navigateTo('ReportViewerView')
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                _downloadReport(report);
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                _shareReport(report);
                              },
                            ),
                          ],
                        )
                      else if (report["status"] == "Processing")
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(15),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Report is being generated...",
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Generate Final Report",
                            size: bs.sm,
                            onPressed: () {
                              _generateFinalReport(report);
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (filteredReports.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.description,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No reports found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Generate your first report to see insights",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('GenerateReportView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Download All",
                          size: bs.sm,
                          onPressed: () {
                            _downloadAllReports();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready":
        return successColor;
      case "Processing":
        return warningColor;
      case "Draft":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Assessment":
        return primaryColor;
      case "Mood":
        return warningColor;
      case "Progress":
        return successColor;
      case "Summary":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Ready":
        return Icons.check_circle;
      case "Processing":
        return Icons.autorenew;
      case "Draft":
        return Icons.edit;
      default:
        return Icons.help;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Assessment":
        return Icons.assignment;
      case "Mood":
        return Icons.mood;
      case "Progress":
        return Icons.trending_up;
      case "Summary":
        return Icons.summarize;
      default:
        return Icons.description;
    }
  }

  void _downloadReport(Map<String, dynamic> report) {
    if (report["url"].isEmpty) {
      se("Report not available for download");
      return;
    }

    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Report downloaded successfully!");
    });
  }

  void _shareReport(Map<String, dynamic> report) {
    if (report["url"].isEmpty) {
      se("Report not available for sharing");
      return;
    }

    ss("Report shared successfully!");
  }

  void _generateFinalReport(Map<String, dynamic> report) {
    showLoading();
    
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        report["status"] = "Ready";
        report["url"] = "https://example.com/report${report["id"]}.pdf";
      });
      
      hideLoading();
      ss("Report generated successfully!");
    });
  }

  void _downloadAllReports() {
    List<Map<String, dynamic>> readyReports = reports
        .where((report) => report["status"] == "Ready")
        .toList();

    if (readyReports.isEmpty) {
      se("No reports available for download");
      return;
    }

    showLoading();
    Future.delayed(Duration(seconds: 3), () {
      hideLoading();
      ss("${readyReports.length} reports downloaded successfully!");
    });
  }
}
