import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomReportsView extends StatefulWidget {
  const CrmCustomReportsView({super.key});

  @override
  State<CrmCustomReportsView> createState() => _CrmCustomReportsViewState();
}

class _CrmCustomReportsViewState extends State<CrmCustomReportsView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "Sales Reports", "value": "sales"},
    {"label": "Customer Analytics", "value": "customer"},
    {"label": "Performance Reports", "value": "performance"},
    {"label": "Financial Reports", "value": "financial"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Draft", "value": "draft"},
  ];

  List<Map<String, dynamic>> reportMetrics = [
    {
      "title": "Total Reports",
      "value": 48,
      "change": 25.0,
      "icon": Icons.description,
      "color": Colors.blue,
    },
    {
      "title": "Active Reports",
      "value": 32,
      "change": 18.5,
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "title": "Scheduled Reports",
      "value": 12,
      "change": 42.9,
      "icon": Icons.schedule,
      "color": Colors.orange,
    },
    {
      "title": "Generated This Month",
      "value": 156,
      "change": 12.7,
      "icon": Icons.auto_awesome,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> savedReports = [
    {
      "title": "Monthly Sales Performance",
      "description": "Comprehensive analysis of sales metrics and team performance",
      "category": "Sales Reports",
      "frequency": "Monthly",
      "lastGenerated": "Dec 1, 2024",
      "nextScheduled": "Jan 1, 2025",
      "status": "active",
      "recipients": 8,
      "downloads": 45,
    },
    {
      "title": "Customer Satisfaction Dashboard",
      "description": "Customer feedback analysis and satisfaction trends",
      "category": "Customer Analytics",
      "frequency": "Weekly",
      "lastGenerated": "Dec 18, 2024",
      "nextScheduled": "Dec 25, 2024",
      "status": "active",
      "recipients": 5,
      "downloads": 32,
    },
    {
      "title": "Q4 Financial Summary",
      "description": "Quarterly financial performance and revenue analysis",
      "category": "Financial Reports",
      "frequency": "Quarterly",
      "lastGenerated": "Oct 1, 2024",
      "nextScheduled": "Jan 1, 2025",
      "status": "scheduled",
      "recipients": 12,
      "downloads": 78,
    },
    {
      "title": "Support Team Metrics",
      "description": "Support ticket analysis and team performance metrics",
      "category": "Performance Reports",
      "frequency": "Bi-weekly",
      "lastGenerated": "Dec 15, 2024",
      "nextScheduled": "Dec 29, 2024",
      "status": "active",
      "recipients": 6,
      "downloads": 28,
    },
  ];

  List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Sales Performance Template",
      "description": "Track revenue, deals closed, and team performance",
      "category": "Sales Reports",
      "metrics": ["Revenue", "Deals Closed", "Conversion Rate", "Team Performance"],
      "popularity": 95,
      "uses": 234,
    },
    {
      "name": "Customer Analytics Template",
      "description": "Monitor customer behavior and satisfaction",
      "category": "Customer Analytics",
      "metrics": ["Customer Acquisition", "Retention Rate", "Satisfaction Score", "Churn Rate"],
      "popularity": 88,
      "uses": 187,
    },
    {
      "name": "Support Metrics Template",
      "description": "Analyze support team performance and ticket trends",
      "category": "Performance Reports",
      "metrics": ["Response Time", "Resolution Rate", "Customer Satisfaction", "Ticket Volume"],
      "popularity": 76,
      "uses": 156,
    },
    {
      "name": "Financial Overview Template",
      "description": "Comprehensive financial analysis and trends",
      "category": "Financial Reports",
      "metrics": ["Revenue Growth", "Profit Margins", "Cost Analysis", "ROI"],
      "popularity": 82,
      "uses": 143,
    },
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "title": "Weekly Sales Summary",
      "generatedBy": "Sarah Johnson",
      "avatar": "SJ",
      "generatedDate": "Dec 18, 2024 10:30 AM",
      "fileSize": "2.4 MB",
      "format": "PDF",
      "downloads": 12,
      "status": "completed",
    },
    {
      "title": "Customer Feedback Analysis",
      "generatedBy": "Michael Chen",
      "avatar": "MC",
      "generatedDate": "Dec 17, 2024 3:45 PM",
      "fileSize": "1.8 MB",
      "format": "Excel",
      "downloads": 8,
      "status": "completed",
    },
    {
      "title": "Support Performance Report",
      "generatedBy": "Emma Williams",
      "avatar": "EW",
      "generatedDate": "Dec 16, 2024 2:15 PM",
      "fileSize": "3.1 MB",
      "format": "PDF",
      "downloads": 15,
      "status": "completed",
    },
    {
      "title": "Monthly Revenue Analysis",
      "generatedBy": "David Rodriguez",
      "avatar": "DR",
      "generatedDate": "Dec 15, 2024 11:20 AM",
      "fileSize": "2.7 MB",
      "format": "PowerPoint",
      "downloads": 22,
      "status": "completed",
    },
  ];

  List<Map<String, dynamic>> scheduledReports = [
    {
      "title": "Daily Sales Update",
      "nextRun": "Tomorrow 9:00 AM",
      "frequency": "Daily",
      "recipients": ["sales@company.com", "management@company.com"],
      "format": "Email + PDF",
    },
    {
      "title": "Weekly Customer Metrics",
      "nextRun": "Monday 8:00 AM",
      "frequency": "Weekly",
      "recipients": ["customer-success@company.com"],
      "format": "Dashboard Link",
    },
    {
      "title": "Monthly Financial Report",
      "nextRun": "Jan 1, 2025 10:00 AM",
      "frequency": "Monthly",
      "recipients": ["finance@company.com", "executives@company.com"],
      "format": "PDF + Excel",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return Colors.green;
      case "scheduled":
        return Colors.blue;
      case "draft":
        return Colors.orange;
      case "completed":
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getFormatColor(String format) {
    switch (format.toLowerCase()) {
      case "pdf":
        return Colors.red;
      case "excel":
        return Colors.green;
      case "powerpoint":
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new report feature coming soon");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Report Metrics
            Text(
              "Reports Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: reportMetrics.map((metric) {
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
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) > 0
                                  ? Colors.green.withAlpha(51)
                                  : Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(metric["value"] as num).toString()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Report",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Create new report feature coming soon");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Use Template",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () {
                            ss("Template selection feature coming soon");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Saved Reports
            Text(
              "Saved Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: savedReports.map((report) {
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${report["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${report["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
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
                              color: _getStatusColor("${report["status"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${report["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${report["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${report["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${report["frequency"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(report["downloads"] as int)} downloads",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Last: ${report["lastGenerated"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Next: ${report["nextScheduled"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Report Templates
            Text(
              "Popular Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: reportTemplates.map((template) {
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
                          Expanded(
                            child: Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${(template["popularity"] as int)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${template["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${template["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Included Metrics:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (template["metrics"] as List<String>).take(3).map((metric) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              metric,
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Used ${(template["uses"] as int)} times",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              ss("Template selected: ${template["name"]}");
                            },
                            child: Text(
                              "Use Template",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Recent Reports
            Text(
              "Recently Generated",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: recentReports.map((report) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getFormatColor("${report["format"]}").withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          report["format"] == "PDF"
                              ? Icons.picture_as_pdf
                              : report["format"] == "Excel"
                                  ? Icons.table_chart
                                  : Icons.slideshow,
                          color: _getFormatColor("${report["format"]}"),
                          size: 24,
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "By ${report["generatedBy"]} • ${report["generatedDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${report["fileSize"]} • ${report["format"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(report["downloads"] as int)} downloads",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          ss("Downloading ${report["title"]}");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Scheduled Reports
            Text(
              "Scheduled Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: scheduledReports.map((scheduled) {
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
                            Icons.schedule,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${scheduled["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${scheduled["frequency"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "Next run: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${scheduled["nextRun"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${scheduled["format"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Recipients: ${(scheduled["recipients"] as List<String>).join(", ")}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
