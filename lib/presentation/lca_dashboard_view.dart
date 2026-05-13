import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDashboardView extends StatefulWidget {
  const LcaDashboardView({Key? key}) : super(key: key);

  @override
  State<LcaDashboardView> createState() => _LcaDashboardViewState();
}

class _LcaDashboardViewState extends State<LcaDashboardView> {
  String selectedPeriod = "month";
  String selectedMetric = "cases";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Cases", "value": "cases"},
    {"label": "Revenue", "value": "revenue"},
    {"label": "Hours", "value": "hours"},
    {"label": "Clients", "value": "clients"},
  ];

  List<Map<String, dynamic>> dashboardStats = [
    {
      "title": "Active Cases",
      "current": 28,
      "previous": 25,
      "icon": Icons.folder_open,
      "color": primaryColor,
      "suffix": "",
    },
    {
      "title": "Total Revenue",
      "current": 45200,
      "previous": 38900,
      "icon": Icons.attach_money,
      "color": successColor,
      "suffix": "\$",
    },
    {
      "title": "Billable Hours",
      "current": 127.5,
      "previous": 115.2,
      "icon": Icons.timer,
      "color": infoColor,
      "suffix": "h",
    },
    {
      "title": "New Clients",
      "current": 8,
      "previous": 6,
      "icon": Icons.person_add,
      "color": warningColor,
      "suffix": "",
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "case_created",
      "title": "New case created",
      "description": "Johnson vs. Smith Corporation",
      "timestamp": "2024-06-16T10:30:00Z",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "type": "document_generated",
      "title": "Document generated",
      "description": "Motion to Dismiss - TechCorp case",
      "timestamp": "2024-06-16T09:15:00Z",
      "icon": Icons.description,
      "color": infoColor,
    },
    {
      "type": "meeting_scheduled",
      "title": "Meeting scheduled",
      "description": "Client consultation - Williams Estate",
      "timestamp": "2024-06-15T16:45:00Z",
      "icon": Icons.calendar_today,
      "color": warningColor,
    },
    {
      "type": "deadline_reminder",
      "title": "Deadline approaching",
      "description": "Motion filing due in 2 days",
      "timestamp": "2024-06-15T08:20:00Z",
      "icon": Icons.warning,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> casesByStatus = [
    {"status": "Active", "count": 28, "color": successColor},
    {"status": "Pending", "count": 12, "color": warningColor},
    {"status": "Review", "count": 8, "color": infoColor},
    {"status": "Closed", "count": 145, "color": disabledBoldColor},
  ];

  List<Map<String, dynamic>> practiceAreas = [
    {"area": "Civil Litigation", "cases": 45, "revenue": 18500, "color": primaryColor},
    {"area": "Corporate Law", "cases": 32, "revenue": 15200, "color": successColor},
    {"area": "Estate Planning", "cases": 28, "revenue": 8900, "color": infoColor},
    {"area": "Family Law", "cases": 22, "revenue": 6800, "color": warningColor},
    {"area": "Real Estate", "cases": 18, "revenue": 4200, "color": dangerColor},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () => _exportReport(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshData(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildKPICards(),
            SizedBox(height: spLg),
            _buildChartSection(),
            SizedBox(height: spLg),
            _buildCaseStatusBreakdown(),
            SizedBox(height: spLg),
            _buildPracticeAreaPerformance(),
            SizedBox(height: spLg),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
            "Dashboard Filters",
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
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                    _updateDashboardData();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Primary Metric",
                  items: metricOptions,
                  value: selectedMetric,
                  onChanged: (value, label) {
                    selectedMetric = value;
                    setState(() {});
                    _updateDashboardData();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: dashboardStats.map((stat) {
        double changePercent = ((stat["current"] as num) - (stat["previous"] as num)) / (stat["previous"] as num) * 100;
        bool isPositive = changePercent > 0;
        
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
                      color: (stat["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 24,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPositive ? Icons.trending_up : Icons.trending_down,
                          size: 12,
                          color: isPositive ? successColor : dangerColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${changePercent.abs().toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isPositive ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${stat["suffix"]}${stat["current"]}${stat["suffix"] == "\$" ? "" : stat["suffix"]}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${stat["title"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "vs last period: ${stat["suffix"]}${stat["previous"]}${stat["suffix"] == "\$" ? "" : stat["suffix"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildChartSection() {
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
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewDetailedAnalytics(),
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: _buildMockChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildMockChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, color: primaryColor, size: 48),
          SizedBox(height: spSm),
          Text(
            "Performance Chart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Interactive chart showing ${selectedMetric} trends for ${selectedPeriod}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStatusBreakdown() {
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
            "Cases by Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...casesByStatus.map((statusData) {
            int totalCases = casesByStatus.fold(0, (sum, item) => sum + (item["count"] as int));
            double percentage = ((statusData["count"] as int) / totalCases) * 100;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: statusData["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${statusData["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${statusData["count"]} (${percentage.toStringAsFixed(1)}%)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusData["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: disabledColor.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(statusData["color"] as Color),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPracticeAreaPerformance() {
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
            "Practice Area Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...practiceAreas.map((area) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: (area["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: (area["color"] as Color).withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (area["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.gavel,
                          color: area["color"] as Color,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${area["area"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((area["revenue"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: area["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${area["cases"]} cases",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Avg: \$${(((area["revenue"] as int) / (area["cases"] as int)).toDouble()).currency} per case",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
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
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _viewAllActivity(),
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
          SizedBox(height: spMd),
          ...recentActivity.map((activity) {
            DateTime timestamp = DateTime.parse("${activity["timestamp"]}");
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (activity["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      activity["icon"] as IconData,
                      color: activity["color"] as Color,
                      size: 16,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${activity["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    timestamp.dMMMy,
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _updateDashboardData() {
    si("Updating dashboard data for $selectedPeriod period and $selectedMetric metric");
    // Simulate data refresh
    setState(() {});
  }

  void _exportReport() {
    showLoading();
    // Simulate report generation
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Dashboard report exported successfully");
    });
  }

  void _refreshData() {
    showLoading();
    // Simulate data refresh
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      setState(() {});
      ss("Dashboard data refreshed");
    });
  }

  void _viewDetailedAnalytics() {
    si("Opening detailed analytics");
    // Navigate to detailed analytics
    //navigateTo('');
  }

  void _viewAllActivity() {
    si("Opening activity log");
    // Navigate to activity log
    //navigateTo('');
  }
}
