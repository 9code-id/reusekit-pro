import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPerformanceMetricsView extends StatefulWidget {
  const RmaPerformanceMetricsView({super.key});

  @override
  State<RmaPerformanceMetricsView> createState() => _RmaPerformanceMetricsViewState();
}

class _RmaPerformanceMetricsViewState extends State<RmaPerformanceMetricsView> {
  int selectedTab = 0;
  bool loading = false;
  String selectedPeriod = "month";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Revenue Growth",
      "value": "24.8%",
      "previous": "19.2%",
      "trend": "up",
      "icon": Icons.trending_up,
      "color": successColor,
    },
    {
      "title": "Customer Satisfaction",
      "value": "94.7%",
      "previous": "91.3%",
      "trend": "up",
      "icon": Icons.sentiment_very_satisfied,
      "color": primaryColor,
    },
    {
      "title": "Return Rate",
      "value": "2.1%",
      "previous": "3.4%",
      "trend": "down",
      "icon": Icons.assignment_return,
      "color": warningColor,
    },
    {
      "title": "Processing Time",
      "value": "1.8 days",
      "previous": "2.5 days",
      "trend": "down",
      "icon": Icons.schedule,
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "category": "Sales Performance",
      "metrics": [
        {"name": "Total Sales", "value": "\$284,590", "change": "+12.4%", "positive": true},
        {"name": "Conversion Rate", "value": "18.7%", "change": "+2.1%", "positive": true},
        {"name": "Average Order Value", "value": "\$127.50", "change": "+5.8%", "positive": true},
        {"name": "Sales Velocity", "value": "3.2 deals/day", "change": "+8.9%", "positive": true},
      ],
    },
    {
      "category": "Operational Efficiency",
      "metrics": [
        {"name": "Processing Speed", "value": "1.2 hrs", "change": "-15.3%", "positive": true},
        {"name": "Error Rate", "value": "0.8%", "change": "-22.1%", "positive": true},
        {"name": "Resource Utilization", "value": "87.4%", "change": "+4.7%", "positive": true},
        {"name": "Quality Score", "value": "9.2/10", "change": "+0.3", "positive": true},
      ],
    },
    {
      "category": "Customer Experience",
      "metrics": [
        {"name": "Response Time", "value": "< 2 mins", "change": "-45.2%", "positive": true},
        {"name": "Resolution Rate", "value": "96.8%", "change": "+3.2%", "positive": true},
        {"name": "Customer Retention", "value": "89.3%", "change": "+1.8%", "positive": true},
        {"name": "Net Promoter Score", "value": "8.7", "change": "+0.9", "positive": true},
      ],
    },
  ];

  List<Map<String, dynamic>> teamPerformance = [
    {
      "name": "Sarah Johnson",
      "role": "Senior Manager",
      "score": 92.5,
      "improvement": 5.2,
      "completedTasks": 24,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
    },
    {
      "name": "Michael Chen",
      "role": "Operations Lead",
      "score": 89.8,
      "improvement": 3.4,
      "completedTasks": 19,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
    },
    {
      "name": "Emma Wilson",
      "role": "Quality Analyst",
      "score": 91.2,
      "improvement": 7.1,
      "completedTasks": 22,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
    },
    {
      "name": "David Rodriguez",
      "role": "Customer Success",
      "score": 88.6,
      "improvement": 2.8,
      "completedTasks": 17,
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "KPIs", icon: Icon(Icons.analytics)),
        Tab(text: "Team", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildKPITab(),
        _buildTeamTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeriodSelector(),
                _buildPerformanceCards(),
                _buildMetricsChart(),
                _buildQuickActions(),
              ],
            ),
          );
  }

  Widget _buildKPITab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: kpiData.map((category) => _buildKPICategory(category)).toList(),
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTeamOverview(),
          _buildTeamPerformanceList(),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.date_range, color: primaryColor, size: 20),
          SizedBox(width: spXs),
          Text(
            "Time Period:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Select Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              setState(() {
                loading = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                setState(() {
                  loading = false;
                });
                ss("Metrics refreshed successfully");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: performanceMetrics.map((metric) {
        bool isPositive = metric["trend"] == "up" && 
                         (metric["title"] == "Revenue Growth" || metric["title"] == "Customer Satisfaction") ||
                         metric["trend"] == "down" && 
                         (metric["title"] == "Return Rate" || metric["title"] == "Processing Time");

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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (metric["color"] as Color).withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 20,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: isPositive ? successColor : dangerColor,
                    size: 16,
                  ),
                ],
              ),
              Text(
                "${metric["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${metric["value"]}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Previous: ",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${metric["previous"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMetricsChart() {
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
              Icon(Icons.bar_chart, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Performance Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {
                  si("Opening detailed chart view");
                },
              ),
            ],
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.show_chart, color: primaryColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Interactive Performance Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Tap to view detailed analytics",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
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

  Widget _buildQuickActions() {
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
                  label: "Export Report",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Report exported successfully");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule Alert",
                  icon: Icons.notifications,
                  size: bs.sm,
                  onPressed: () {
                    si("Alert scheduled");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKPICategory(Map<String, dynamic> category) {
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
            "${category["category"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...(category["metrics"] as List).map((metric) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(13),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "${metric["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${metric["value"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: (metric["positive"] as bool) ? successColor.withAlpha(51) : dangerColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${metric["change"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (metric["positive"] as bool) ? successColor : dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTeamOverview() {
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
            "Team Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "90.5%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Team Average",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: primaryColor.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "82",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Tasks Completed",
                        style: TextStyle(
                          fontSize: 12,
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

  Widget _buildTeamPerformanceList() {
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
            "Individual Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...teamPerformance.map((member) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(13),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${member["avatar"]}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, color: primaryColor);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${member["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${member["role"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(member["completedTasks"] as int)} tasks completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${(member["score"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "+${(member["improvement"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
