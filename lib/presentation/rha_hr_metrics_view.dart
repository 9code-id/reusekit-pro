import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaHrMetricsView extends StatefulWidget {
  const RhaHrMetricsView({super.key});

  @override
  State<RhaHrMetricsView> createState() => _RhaHrMetricsViewState();
}

class _RhaHrMetricsViewState extends State<RhaHrMetricsView> {
  int currentTab = 0;
  String selectedPeriod = "month";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> employeeMetrics = [
    {
      "title": "Employee Satisfaction",
      "value": 87,
      "unit": "%",
      "change": "+5",
      "isPositive": true,
      "icon": Icons.sentiment_very_satisfied,
      "description": "Based on latest survey",
    },
    {
      "title": "Retention Rate",
      "value": 94,
      "unit": "%",
      "change": "+2",
      "isPositive": true,
      "icon": Icons.people_alt,
      "description": "12-month average",
    },
    {
      "title": "Average Tenure",
      "value": 2.8,
      "unit": " years",
      "change": "+0.3",
      "isPositive": true,
      "icon": Icons.timeline,
      "description": "Company average",
    },
    {
      "title": "Absenteeism Rate",
      "value": 3.2,
      "unit": "%",
      "change": "-0.5",
      "isPositive": true,
      "icon": Icons.event_busy,
      "description": "Monthly average",
    },
  ];

  List<Map<String, dynamic>> recruitmentMetrics = [
    {
      "title": "Time to Hire",
      "value": 28,
      "unit": " days",
      "change": "-5",
      "isPositive": true,
      "icon": Icons.schedule,
      "description": "Average hiring time",
    },
    {
      "title": "Cost per Hire",
      "value": 4200,
      "unit": "",
      "change": "-300",
      "isPositive": true,
      "icon": Icons.attach_money,
      "description": "Including all expenses",
    },
    {
      "title": "Offer Acceptance",
      "value": 85,
      "unit": "%",
      "change": "+8",
      "isPositive": true,
      "icon": Icons.handshake,
      "description": "Offers accepted",
    },
    {
      "title": "Quality of Hire",
      "value": 4.2,
      "unit": "/5",
      "change": "+0.3",
      "isPositive": true,
      "icon": Icons.star,
      "description": "Performance rating",
    },
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "title": "Average Performance",
      "value": 4.1,
      "unit": "/5",
      "change": "+0.2",
      "isPositive": true,
      "icon": Icons.trending_up,
      "description": "Latest reviews",
    },
    {
      "title": "Goal Achievement",
      "value": 78,
      "unit": "%",
      "change": "+12",
      "isPositive": true,
      "icon": Icons.track_changes,
      "description": "Goals completed",
    },
    {
      "title": "Training Hours",
      "value": 24,
      "unit": " hrs",
      "change": "+6",
      "isPositive": true,
      "icon": Icons.school,
      "description": "Per employee/month",
    },
    {
      "title": "Promotion Rate",
      "value": 15,
      "unit": "%",
      "change": "+3",
      "isPositive": true,
      "icon": Icons.trending_up,
      "description": "Internal promotions",
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {"name": "Engineering", "performance": 4.3, "satisfaction": 89, "retention": 96},
    {"name": "Sales", "performance": 4.0, "satisfaction": 85, "retention": 92},
    {"name": "Marketing", "performance": 4.2, "satisfaction": 87, "retention": 94},
    {"name": "HR", "performance": 4.1, "satisfaction": 91, "retention": 98},
    {"name": "Finance", "performance": 3.9, "satisfaction": 82, "retention": 95},
    {"name": "Operations", "performance": 4.0, "satisfaction": 86, "retention": 93},
  ];

  List<Map<String, dynamic>> trendData = [
    {"month": "Jan", "employees": 220, "hires": 8, "satisfaction": 84},
    {"month": "Feb", "employees": 228, "hires": 12, "satisfaction": 85},
    {"month": "Mar", "employees": 240, "hires": 15, "satisfaction": 87},
    {"month": "Apr", "employees": 248, "hires": 10, "satisfaction": 87},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "HR Metrics & Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Employee", icon: Icon(Icons.people)),
        Tab(text: "Recruitment", icon: Icon(Icons.person_search)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Trends", icon: Icon(Icons.show_chart)),
      ],
      tabChildren: [
        _buildEmployeeMetricsTab(),
        _buildRecruitmentMetricsTab(),
        _buildPerformanceMetricsTab(),
        _buildTrendsTab(),
      ],
    );
  }

  Widget _buildEmployeeMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Filter
          Row(
            children: [
              Text(
                "Employee Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                width: 150,
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
            ],
          ),

          // Employee Metrics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: employeeMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"],
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (metric["isPositive"] as bool)
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["isPositive"] as bool)
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${metric["value"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Department Performance
          Text(
            "Department Performance",
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
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Department",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Performance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Satisfaction",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Retention",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...departmentPerformance.map((dept) {
                  int index = departmentPerformance.indexOf(dept);
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < departmentPerformance.length - 1
                              ? disabledOutlineBorderColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${dept["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${dept["performance"]}/5",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${dept["satisfaction"]}%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${dept["retention"]}%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecruitmentMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recruitment Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: recruitmentMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"],
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (metric["isPositive"] as bool)
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["isPositive"] as bool)
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      metric["title"] == "Cost per Hire"
                          ? "\$${metric["value"]}${metric["unit"]}"
                          : "${metric["value"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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

  Widget _buildPerformanceMetricsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: performanceMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"],
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (metric["isPositive"] as bool)
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: (metric["isPositive"] as bool)
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${metric["value"]}${metric["unit"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trend Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Text(
                  "Monthly Trends",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  child: Column(
                    children: trendData.map((data) {
                      return Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              child: Text(
                                "${data["month"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: spSm),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: (data["employees"] as int) ~/ 10,
                                      child: Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(80),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${data["employees"]}",
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
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
