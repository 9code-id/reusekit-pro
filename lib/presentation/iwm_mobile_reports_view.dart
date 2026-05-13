import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmMobileReportsView extends StatefulWidget {
  const IwmMobileReportsView({super.key});

  @override
  State<IwmMobileReportsView> createState() => _IwmMobileReportsViewState();
}

class _IwmMobileReportsViewState extends State<IwmMobileReportsView> {
  int selectedTab = 0;
  String selectedPeriod = "week";
  String selectedCategory = "all";
  String selectedFormat = "pdf";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Inventory Levels", "value": "inventory"},
    {"label": "Stock Movements", "value": "movements"},
    {"label": "Receiving Reports", "value": "receiving"},
    {"label": "Picking Reports", "value": "picking"},
    {"label": "Cycle Counts", "value": "counts"},
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF Report", "value": "pdf"},
    {"label": "Excel Sheet", "value": "excel"},
    {"label": "CSV Export", "value": "csv"},
  ];

  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Items",
      "value": "2,847",
      "change": "+12%",
      "trend": "up",
      "icon": Icons.inventory,
      "color": primaryColor
    },
    {
      "title": "Stock Value",
      "value": "\$485,200",
      "change": "+8%",
      "trend": "up",
      "icon": Icons.attach_money,
      "color": successColor
    },
    {
      "title": "Movements",
      "value": "1,249",
      "change": "-3%",
      "trend": "down",
      "icon": Icons.swap_horiz,
      "color": warningColor
    },
    {
      "title": "Accuracy",
      "value": "98.5%",
      "change": "+1.2%",
      "trend": "up",
      "icon": Icons.check_circle,
      "color": successColor
    },
  ];

  List<Map<String, dynamic>> quickReports = [
    {
      "title": "Stock Level Report",
      "description": "Current inventory levels by category",
      "icon": Icons.bar_chart,
      "color": primaryColor,
      "lastGenerated": "2 hours ago",
      "frequency": "Daily"
    },
    {
      "title": "Movement Summary",
      "description": "Stock in/out movements analysis",
      "icon": Icons.trending_up,
      "color": successColor,
      "lastGenerated": "1 day ago",
      "frequency": "Weekly"
    },
    {
      "title": "Low Stock Alert",
      "description": "Items below minimum threshold",
      "icon": Icons.warning,
      "color": warningColor,
      "lastGenerated": "3 hours ago",
      "frequency": "Real-time"
    },
    {
      "title": "Cycle Count Report",
      "description": "Physical count vs system records",
      "icon": Icons.checklist,
      "color": infoColor,
      "lastGenerated": "5 days ago",
      "frequency": "Monthly"
    },
  ];

  List<Map<String, dynamic>> scheduledReports = [
    {
      "name": "Daily Inventory Summary",
      "schedule": "Daily at 8:00 AM",
      "recipients": "manager@warehouse.com",
      "format": "PDF",
      "status": "Active",
      "nextRun": "Tomorrow 8:00 AM"
    },
    {
      "name": "Weekly Movement Report",
      "schedule": "Every Monday 9:00 AM",
      "recipients": "team@warehouse.com",
      "format": "Excel",
      "status": "Active",
      "nextRun": "Monday 9:00 AM"
    },
    {
      "name": "Monthly Stock Valuation",
      "schedule": "1st of every month",
      "recipients": "finance@company.com",
      "format": "PDF",
      "status": "Paused",
      "nextRun": "Paused"
    },
  ];

  List<Map<String, dynamic>> reportHistory = [
    {
      "name": "Stock Level Report",
      "generatedAt": "2024-01-15 14:30",
      "format": "PDF",
      "size": "2.4 MB",
      "status": "Completed",
      "downloadUrl": "reports/stock_level_20240115.pdf"
    },
    {
      "name": "Movement Summary",
      "generatedAt": "2024-01-15 09:15",
      "format": "Excel",
      "size": "1.8 MB",
      "status": "Completed",
      "downloadUrl": "reports/movement_20240115.xlsx"
    },
    {
      "name": "Cycle Count Report",
      "generatedAt": "2024-01-14 16:45",
      "format": "PDF",
      "size": "3.2 MB",
      "status": "Completed",
      "downloadUrl": "reports/cycle_count_20240114.pdf"
    },
    {
      "name": "Low Stock Alert",
      "generatedAt": "2024-01-14 11:20",
      "format": "CSV",
      "size": "456 KB",
      "status": "Failed",
      "downloadUrl": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Mobile Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Quick Reports", icon: Icon(Icons.assignment)),
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildQuickReportsTab(),
        _buildScheduledTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportFilters(),
          _buildSummaryStats(),
          _buildReportChart(),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildQuickReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGenerateSection(),
          _buildQuickReportsList(),
        ],
      ),
    );
  }

  Widget _buildScheduledTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScheduleHeader(),
          _buildScheduledReportsList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistoryFilters(),
          _buildReportHistoryList(),
        ],
      ),
    );
  }

  Widget _buildReportFilters() {
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
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
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QButton(
            label: "Generate Report",
            icon: Icons.download,
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Key Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: summaryStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    Color trendColor = stat["trend"] == "up" ? successColor : dangerColor;
    IconData trendIcon = stat["trend"] == "up" ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(
                    trendIcon,
                    color: trendColor,
                    size: 16,
                  ),
                  Text(
                    "${stat["change"]}",
                    style: TextStyle(
                      color: trendColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportChart() {
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
            "Inventory Trend Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    List<Map<String, dynamic>> trends = [
      {"category": "Electronics", "change": "+15%", "value": "\$125,400", "trend": "up"},
      {"category": "Clothing", "change": "-3%", "value": "\$89,200", "trend": "down"},
      {"category": "Home & Garden", "change": "+8%", "value": "\$156,800", "trend": "up"},
      {"category": "Sports", "change": "+22%", "value": "\$78,600", "trend": "up"},
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...trends.map((trend) => _buildTrendItem(trend)),
        ],
      ),
    );
  }

  Widget _buildTrendItem(Map<String, dynamic> trend) {
    Color trendColor = trend["trend"] == "up" ? successColor : dangerColor;
    IconData trendIcon = trend["trend"] == "up" ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trend["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${trend["value"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                trendIcon,
                color: trendColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${trend["change"]}",
                style: TextStyle(
                  color: trendColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateSection() {
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
            "Generate Custom Report",
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
                  items: categoryOptions,
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
          QButton(
            label: "Generate Now",
            icon: Icons.play_arrow,
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReportsList() {
    return Column(
      spacing: spSm,
      children: quickReports.map((report) => _buildQuickReportCard(report)).toList(),
    );
  }

  Widget _buildQuickReportCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              color: (report["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              report["icon"],
              color: report["color"],
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
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${report["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Last: ${report["lastGenerated"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                    Text(
                      " • ${report["frequency"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Automated Reports",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          QButton(
            label: "Add Schedule",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledReportsList() {
    return Column(
      spacing: spSm,
      children: scheduledReports.map((report) => _buildScheduledReportCard(report)).toList(),
    );
  }

  Widget _buildScheduledReportCard(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "Active" ? successColor : warningColor;

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
          Row(
            children: [
              Expanded(
                child: Text(
                  "${report["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${report["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Schedule: ${report["schedule"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Recipients: ${report["recipients"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Next run: ${report["nextRun"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: report["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Filter by Type",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReportHistoryList() {
    return Column(
      spacing: spSm,
      children: reportHistory.map((report) => _buildHistoryCard(report)).toList(),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> report) {
    Color statusColor = report["status"] == "Completed" ? successColor : dangerColor;
    IconData statusIcon = report["status"] == "Completed" ? Icons.check_circle : Icons.error;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${report["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${report["generatedAt"]} • ${report["format"]} • ${report["size"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (report["status"] == "Completed")
            QButton(
              icon: Icons.download,
              size: bs.sm,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
