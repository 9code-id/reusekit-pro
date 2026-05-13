import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmReceivingReportsView extends StatefulWidget {
  const IwmReceivingReportsView({super.key});

  @override
  State<IwmReceivingReportsView> createState() => _IwmReceivingReportsViewState();
}

class _IwmReceivingReportsViewState extends State<IwmReceivingReportsView> {
  int selectedTab = 0;
  String selectedPeriod = "this_month";
  String selectedType = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "This Quarter", "value": "this_quarter"},
    {"label": "This Year", "value": "this_year"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Reports", "value": "all"},
    {"label": "Daily Summary", "value": "daily"},
    {"label": "Supplier Report", "value": "supplier"},
    {"label": "Quality Report", "value": "quality"},
    {"label": "Discrepancy Report", "value": "discrepancy"},
    {"label": "Performance Report", "value": "performance"},
  ];
  
  List<Map<String, dynamic>> reports = [
    {
      "id": "RPT-2024-0001",
      "title": "Daily Receiving Summary",
      "type": "Daily Summary",
      "date": "2024-01-15",
      "period": "January 15, 2024",
      "status": "Completed",
      "generatedBy": "System Auto",
      "description": "Daily summary of all receiving activities",
      "totalItems": 1250,
      "totalValue": 125000.0,
      "suppliers": 8,
      "receipts": 15,
      "format": "PDF",
      "size": "2.3 MB"
    },
    {
      "id": "RPT-2024-0002",
      "title": "Supplier Performance Report",
      "type": "Supplier Report",
      "date": "2024-01-14",
      "period": "January 1-14, 2024",
      "status": "In Progress",
      "generatedBy": "John Smith",
      "description": "Performance analysis of top suppliers",
      "totalItems": 0,
      "totalValue": 0.0,
      "suppliers": 25,
      "receipts": 0,
      "format": "Excel",
      "size": "0 MB"
    },
    {
      "id": "RPT-2024-0003",
      "title": "Quality Inspection Report",
      "type": "Quality Report",
      "date": "2024-01-13",
      "period": "January 1-13, 2024",
      "status": "Completed",
      "generatedBy": "Sarah Johnson",
      "description": "Quality inspection results and defect analysis",
      "totalItems": 2850,
      "totalValue": 285000.0,
      "suppliers": 12,
      "receipts": 42,
      "format": "PDF",
      "size": "5.7 MB"
    },
    {
      "id": "RPT-2024-0004",
      "title": "Discrepancy Analysis",
      "type": "Discrepancy Report",
      "date": "2024-01-12",
      "period": "December 2023",
      "status": "Completed",
      "generatedBy": "Mike Davis",
      "description": "Analysis of receiving discrepancies and variances",
      "totalItems": 186,
      "totalValue": 18600.0,
      "suppliers": 6,
      "receipts": 8,
      "format": "PDF",
      "size": "1.8 MB"
    },
  ];
  
  List<Map<String, dynamic>> summaryStats = [
    {
      "title": "Total Reports",
      "value": 156,
      "subtitle": "This Month",
      "icon": Icons.description,
      "color": primaryColor
    },
    {
      "title": "Auto Generated",
      "value": 124,
      "subtitle": "Automated Reports",
      "icon": Icons.auto_awesome,
      "color": successColor
    },
    {
      "title": "Custom Reports",
      "value": 32,
      "subtitle": "User Generated",
      "icon": Icons.person,
      "color": infoColor
    },
    {
      "title": "Total Size",
      "value": 2850,
      "subtitle": "MB Storage Used",
      "icon": Icons.storage,
      "color": warningColor,
      "isMegabytes": true
    },
  ];
  
  List<Map<String, dynamic>> quickReports = [
    {
      "title": "Today's Receiving",
      "description": "Summary of today's receiving activities",
      "icon": Icons.today,
      "color": primaryColor
    },
    {
      "title": "Weekly Performance",
      "description": "This week's performance metrics",
      "icon": Icons.bar_chart,
      "color": successColor
    },
    {
      "title": "Top Suppliers",
      "description": "Best performing suppliers this month",
      "icon": Icons.business,
      "color": infoColor
    },
    {
      "title": "Quality Metrics",
      "description": "Quality inspection summary",
      "icon": Icons.verified,
      "color": warningColor
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Receiving Reports",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildReportsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryStats(),
          _buildQuickReports(),
          _buildRecentReports(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildReportsList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnalyticsCharts(),
          _buildKPIMetrics(),
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
          "Report Summary",
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
            ],
          ),
          Text(
            stat["isMegabytes"] == true 
                ? "${(stat["value"] as int).toStringAsFixed(0)} MB"
                : "${stat["value"]}",
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
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
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
        spacing: spSm,
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickReports.map((report) => _buildQuickReportCard(report)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReportCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (report["color"] as Color).withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            report["icon"],
            size: 32,
            color: report["color"],
          ),
          Text(
            "${report["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${report["description"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate",
              size: bs.sm,
              onPressed: () {},
            ),
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
        spacing: spSm,
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
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  selectedTab = 1;
                  setState(() {});
                },
              ),
            ],
          ),
          ...reports.take(3).map((report) => _buildReportCard(report)),
        ],
      ),
    );
  }

  Widget _buildFilters() {
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
                child: QTextField(
                  label: "Search Reports",
                  value: searchQuery,
                  hint: "Report title, ID, type...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
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
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
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
                  label: "Custom Report",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export All",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return Column(
      spacing: spSm,
      children: reports.map((report) => _buildReportCard(report)).toList(),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    Color statusColor = _getStatusColor(report["status"]);
    Color typeColor = _getTypeColor(report["type"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
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
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${report["id"]} • Generated: ${report["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: typeColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${report["type"]}",
                      style: TextStyle(
                        color: typeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${report["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Period: ${report["period"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((report["totalItems"] as int) > 0) ...[
                  Row(
                    children: [
                      Text(
                        "Items: ${report["totalItems"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Value: \$${((report["totalValue"] as double)).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Suppliers: ${report["suppliers"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Generated by: ${report["generatedBy"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Format: ${report["format"]} • Size: ${report["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.download,
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

  Widget _buildAnalyticsCharts() {
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
            "Receiving Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildChartCard("Daily Receiving Trend", Icons.trending_up, "Last 30 days trend"),
              _buildChartCard("Supplier Performance", Icons.business, "Top suppliers analysis"),
              _buildChartCard("Quality Metrics", Icons.verified, "Quality inspection data"),
              _buildChartCard("Value Distribution", Icons.pie_chart, "Receiving value breakdown"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, IconData icon, String description) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, size: 32, color: primaryColor),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Center(
              child: Text(
                "Chart",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPIMetrics() {
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
            "Key Performance Indicators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildKPICard("Receiving Accuracy", "98.5%", successColor, "0.2% improvement"),
              _buildKPICard("Processing Time", "2.3 hrs", infoColor, "15% faster"),
              _buildKPICard("Quality Pass Rate", "94.2%", primaryColor, "1.5% improvement"),
              _buildKPICard("Supplier On-Time", "92.8%", warningColor, "2.1% decline"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(String title, String value, Color color, String trend) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              trend,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return successColor;
      case 'in progress':
        return infoColor;
      case 'pending':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'daily summary':
        return primaryColor;
      case 'supplier report':
        return infoColor;
      case 'quality report':
        return successColor;
      case 'discrepancy report':
        return dangerColor;
      case 'performance report':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
