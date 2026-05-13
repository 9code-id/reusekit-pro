import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaReportingView extends StatefulWidget {
  const RmaReportingView({Key? key}) : super(key: key);

  @override
  State<RmaReportingView> createState() => _RmaReportingViewState();
}

class _RmaReportingViewState extends State<RmaReportingView> {
  String selectedReportType = "monthly";
  String selectedDateRange = "last_30_days";
  bool loading = false;

  List<Map<String, dynamic>> reportTypes = [
    {"label": "Monthly Report", "value": "monthly"},
    {"label": "Weekly Report", "value": "weekly"},
    {"label": "Quarterly Report", "value": "quarterly"},
    {"label": "Annual Report", "value": "annual"},
  ];

  List<Map<String, dynamic>> dateRanges = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 90 Days", "value": "last_90_days"},
    {"label": "This Year", "value": "this_year"},
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "title": "RMA Weekly Summary",
      "date": "2024-03-15",
      "type": "Weekly",
      "status": "completed",
      "cases": 45,
      "resolved": 38,
    },
    {
      "title": "Q1 RMA Analysis",
      "date": "2024-03-01",
      "type": "Quarterly",
      "status": "processing",
      "cases": 256,
      "resolved": 210,
    },
    {
      "title": "February RMA Report",
      "date": "2024-02-28",
      "type": "Monthly",
      "status": "completed",
      "cases": 89,
      "resolved": 82,
    },
    {
      "title": "RMA Trend Analysis",
      "date": "2024-02-15",
      "type": "Custom",
      "status": "completed",
      "cases": 127,
      "resolved": 115,
    },
  ];

  List<Map<String, dynamic>> reportCategories = [
    {
      "title": "Return Processing",
      "description": "Track return request processing times and efficiency",
      "icon": Icons.assignment_return,
      "color": primaryColor,
      "count": 245,
    },
    {
      "title": "Quality Issues",
      "description": "Analyze product quality related returns",
      "icon": Icons.verified,
      "color": warningColor,
      "count": 89,
    },
    {
      "title": "Customer Satisfaction",
      "description": "Monitor customer satisfaction with RMA process",
      "icon": Icons.sentiment_satisfied,
      "color": successColor,
      "count": 92,
    },
    {
      "title": "Financial Impact",
      "description": "Calculate costs and losses from returns",
      "icon": Icons.account_balance,
      "color": infoColor,
      "count": 156,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RMA Reporting"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportReports(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showReportSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportFilters(),
            SizedBox(height: spLg),
            _buildQuickStats(),
            SizedBox(height: spLg),
            _buildReportCategories(),
            SizedBox(height: spLg),
            _buildRecentReports(),
            SizedBox(height: spLg),
            _buildGenerateReport(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
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
                  label: "Date Range",
                  items: dateRanges,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Total RMA Cases",
            "1,245",
            Icons.assignment,
            primaryColor,
            "+12% from last month",
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            "Resolved Cases",
            "1,089",
            Icons.check_circle,
            successColor,
            "87% resolution rate",
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Report Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: reportCategories.map((category) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
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
                          color: (category["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 24,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${category["count"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: category["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${category["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${category["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Report",
                      size: bs.sm,
                      onPressed: () => _viewCategoryReport(category),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _viewAllReports(),
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...recentReports.map((report) => _buildReportItem(report)).toList(),
      ],
    );
  }

  Widget _buildReportItem(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "completed" ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.description,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
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
                Row(
                  children: [
                    Text(
                      "${report["type"]} • ${report["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${report["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Cases: ${report["cases"]} | Resolved: ${report["resolved"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _viewReport(report),
            child: Icon(
              Icons.arrow_forward,
              color: disabledBoldColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateReport() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate New Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Create custom reports based on your specific requirements and date ranges.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Quick Report",
                  size: bs.md,
                  onPressed: () => _generateQuickReport(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Custom Report",
                  size: bs.md,
                  onPressed: () => _generateCustomReport(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _exportReports() {
    ss("Reports exported successfully");
  }

  void _showReportSettings() {
    si("Report settings opened");
  }

  void _viewCategoryReport(Map<String, dynamic> category) {
    si("Viewing ${category["title"]} report");
  }

  void _viewAllReports() {
    si("Viewing all reports");
  }

  void _viewReport(Map<String, dynamic> report) {
    si("Viewing ${report["title"]}");
  }

  void _generateQuickReport() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Quick report generated successfully");
    });
  }

  void _generateCustomReport() {
    si("Opening custom report builder");
  }
}
