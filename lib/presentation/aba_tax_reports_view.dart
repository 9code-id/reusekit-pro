import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaTaxReportsView extends StatefulWidget {
  const AbaTaxReportsView({super.key});

  @override
  State<AbaTaxReportsView> createState() => _AbaTaxReportsViewState();
}

class _AbaTaxReportsViewState extends State<AbaTaxReportsView> {
  String selectedReportType = "summary";
  String selectedPeriod = "current_quarter";
  String selectedFormat = "pdf";
  String searchQuery = "";
  
  List<Map<String, dynamic>> reportTypes = [
    {"label": "Tax Summary", "value": "summary"},
    {"label": "Withholding Report", "value": "withholding"},
    {"label": "Compliance Report", "value": "compliance"},
    {"label": "Payment History", "value": "payment_history"},
    {"label": "Audit Trail", "value": "audit_trail"},
    {"label": "Year-end Report", "value": "year_end"},
  ];

  List<Map<String, dynamic>> reportPeriods = [
    {"label": "Current Quarter", "value": "current_quarter"},
    {"label": "Previous Quarter", "value": "previous_quarter"},
    {"label": "Current Year", "value": "current_year"},
    {"label": "Previous Year", "value": "previous_year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> exportFormats = [
    {"label": "PDF", "value": "pdf"},
    {"label": "Excel", "value": "excel"},
    {"label": "CSV", "value": "csv"},
    {"label": "Word", "value": "word"},
  ];

  List<Map<String, dynamic>> reportStats = [
    {
      "title": "Generated Reports",
      "count": 158,
      "icon": Icons.description,
      "color": primaryColor,
    },
    {
      "title": "This Month",
      "count": 24,
      "icon": Icons.calendar_month,
      "color": successColor,
    },
    {
      "title": "Scheduled Reports",
      "count": 12,
      "icon": Icons.schedule,
      "color": warningColor,
    },
    {
      "title": "Failed Reports",
      "count": 3,
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> availableReports = [
    {
      "id": "TR001",
      "title": "Quarterly Tax Summary",
      "description": "Comprehensive overview of Q1 2024 tax activities",
      "type": "Tax Summary",
      "period": "Q1 2024",
      "generatedDate": "2024-04-01",
      "generatedBy": "Sarah Johnson",
      "fileSize": "2.4 MB",
      "format": "PDF",
      "downloads": 15,
      "status": "ready",
      "icon": Icons.summarize,
    },
    {
      "id": "TR002",
      "title": "Federal Withholding Report",
      "description": "Federal tax withholding details for March 2024",
      "type": "Withholding Report",
      "period": "March 2024",
      "generatedDate": "2024-04-02",
      "generatedBy": "Mike Davis",
      "fileSize": "1.8 MB",
      "format": "Excel",
      "downloads": 8,
      "status": "ready",
      "icon": Icons.account_balance,
    },
    {
      "id": "TR003",
      "title": "State Tax Compliance",
      "description": "State tax compliance status and requirements",
      "type": "Compliance Report",
      "period": "Q1 2024",
      "generatedDate": "2024-03-28",
      "generatedBy": "Emily Wilson",
      "fileSize": "3.2 MB",
      "format": "PDF",
      "downloads": 22,
      "status": "ready",
      "icon": Icons.verified_user,
    },
    {
      "id": "TR004",
      "title": "Payment History Analysis",
      "description": "Tax payment history and trends analysis",
      "type": "Payment History",
      "period": "YTD 2024",
      "generatedDate": "2024-04-03",
      "generatedBy": "David Brown",
      "fileSize": "4.1 MB",
      "format": "PDF",
      "downloads": 12,
      "status": "generating",
      "icon": Icons.payment,
    },
    {
      "id": "TR005",
      "title": "Audit Trail Report",
      "description": "Complete audit trail for tax-related activities",
      "type": "Audit Trail",
      "period": "March 2024",
      "generatedDate": "2024-04-04",
      "generatedBy": "Lisa Anderson",
      "fileSize": "5.6 MB",
      "format": "Excel",
      "downloads": 5,
      "status": "failed",
      "icon": Icons.track_changes,
    },
    {
      "id": "TR006",
      "title": "Year-End Tax Summary 2023",
      "description": "Complete year-end tax summary for 2023",
      "type": "Year-end Report",
      "period": "Annual 2023",
      "generatedDate": "2024-01-15",
      "generatedBy": "John Smith",
      "fileSize": "8.9 MB",
      "format": "PDF",
      "downloads": 45,
      "status": "ready",
      "icon": Icons.calendar_today,
    },
  ];

  List<Map<String, dynamic>> scheduledReports = [
    {
      "title": "Monthly Tax Summary",
      "frequency": "Monthly",
      "nextRun": "2024-05-01",
      "recipients": ["tax@company.com", "finance@company.com"],
      "format": "PDF",
      "status": "active",
    },
    {
      "title": "Quarterly Compliance Check",
      "frequency": "Quarterly",
      "nextRun": "2024-07-01",
      "recipients": ["compliance@company.com"],
      "format": "Excel",
      "status": "active",
    },
    {
      "title": "Weekly Payment Status",
      "frequency": "Weekly",
      "nextRun": "2024-04-08",
      "recipients": ["payroll@company.com"],
      "format": "CSV",
      "status": "paused",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "ready":
        return successColor;
      case "generating":
        return warningColor;
      case "failed":
        return dangerColor;
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "ready":
        return "Ready";
      case "generating":
        return "Generating";
      case "failed":
        return "Failed";
      case "active":
        return "Active";
      case "paused":
        return "Paused";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Report Generator Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Generate New Report",
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
                          label: "Report Type",
                          items: reportTypes,
                          value: selectedReportType,
                          onChanged: (value, label) {
                            selectedReportType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: reportPeriods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Format",
                          items: exportFormats,
                          value: selectedFormat,
                          onChanged: (value, label) {
                            selectedFormat = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Generate Report",
                            icon: Icons.play_arrow,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Report Statistics
            Text(
              "Report Statistics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: reportStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${stat["count"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: stat["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Search and Filter
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: QTextField(
                label: "Search Reports",
                value: searchQuery,
                hint: "Search by title, type, or ID",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),

            // Available Reports
            Text(
              "Available Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: availableReports.map((report) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              report["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(report["status"]).withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusLabel(report["status"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(report["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${report["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${report["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${report["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${report["period"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${report["generatedBy"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.file_copy,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${report["fileSize"]} • ${report["format"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.download,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${report["downloads"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Generated: ${report["generatedDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      if (report["status"] == "ready") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Download",
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ] else if (report["status"] == "generating") ...[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ] else if (report["status"] == "failed") ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Regenerate",
                            icon: Icons.refresh,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Scheduled Reports
            Text(
              "Scheduled Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: scheduledReports.map((schedule) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${schedule["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(schedule["status"]).withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                _getStatusLabel(schedule["status"]),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(schedule["status"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Frequency: ${schedule["frequency"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Next run: ${schedule["nextRun"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(schedule["recipients"] as List).length} recipients",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Format: ${schedule["format"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Edit Schedule",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: schedule["status"] == "active" ? "Pause" : "Resume",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
