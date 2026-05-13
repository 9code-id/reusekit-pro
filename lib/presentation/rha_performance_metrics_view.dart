import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaPerformanceMetricsView extends StatefulWidget {
  const RhaPerformanceMetricsView({super.key});

  @override
  State<RhaPerformanceMetricsView> createState() => _RhaPerformanceMetricsViewState();
}

class _RhaPerformanceMetricsViewState extends State<RhaPerformanceMetricsView> {
  String selectedPeriod = "quarterly";
  String selectedDepartment = "All";
  String selectedEmployee = "All";
  int selectedMetricTab = 0;

  List<Map<String, dynamic>> performanceMetrics = [
    {
      "employee_id": "emp_001",
      "name": "John Smith",
      "position": "Senior Software Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "overall_score": 4.2,
      "metrics": {
        "productivity": 4.5,
        "quality": 4.0,
        "collaboration": 4.3,
        "innovation": 3.8,
        "leadership": 4.1
      },
      "goals_completed": 8,
      "goals_total": 10,
      "trend": "up",
      "last_review": "2024-03-15"
    },
    {
      "employee_id": "emp_002",
      "name": "Sarah Johnson",
      "position": "Engineering Manager",
      "department": "Engineering",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "overall_score": 4.7,
      "metrics": {
        "productivity": 4.6,
        "quality": 4.8,
        "collaboration": 4.9,
        "innovation": 4.5,
        "leadership": 4.8
      },
      "goals_completed": 12,
      "goals_total": 12,
      "trend": "up",
      "last_review": "2024-03-10"
    },
    {
      "employee_id": "emp_003",
      "name": "Michael Chen",
      "position": "UX Designer",
      "department": "Design",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "overall_score": 3.9,
      "metrics": {
        "productivity": 4.1,
        "quality": 4.2,
        "collaboration": 3.8,
        "innovation": 4.0,
        "leadership": 3.5
      },
      "goals_completed": 6,
      "goals_total": 8,
      "trend": "stable",
      "last_review": "2024-03-12"
    },
    {
      "employee_id": "emp_004",
      "name": "Emma Rodriguez",
      "position": "Product Manager",
      "department": "Product",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "overall_score": 4.4,
      "metrics": {
        "productivity": 4.3,
        "quality": 4.5,
        "collaboration": 4.6,
        "innovation": 4.2,
        "leadership": 4.4
      },
      "goals_completed": 9,
      "goals_total": 10,
      "trend": "up",
      "last_review": "2024-03-08"
    }
  ];

  List<Map<String, dynamic>> departmentMetrics = [
    {
      "department": "Engineering",
      "average_score": 4.3,
      "employee_count": 25,
      "top_performers": 8,
      "improvement_needed": 3,
      "retention_rate": 94.2,
      "satisfaction_score": 4.1
    },
    {
      "department": "Design",
      "average_score": 4.0,
      "employee_count": 12,
      "top_performers": 4,
      "improvement_needed": 2,
      "retention_rate": 91.7,
      "satisfaction_score": 4.3
    },
    {
      "department": "Product",
      "average_score": 4.2,
      "employee_count": 8,
      "top_performers": 3,
      "improvement_needed": 1,
      "retention_rate": 100.0,
      "satisfaction_score": 4.4
    },
    {
      "department": "Marketing",
      "average_score": 3.8,
      "employee_count": 15,
      "top_performers": 4,
      "improvement_needed": 4,
      "retention_rate": 86.7,
      "satisfaction_score": 3.9
    }
  ];

  List<Map<String, dynamic>> kpiData = [
    {
      "title": "Overall Performance Score",
      "value": 4.2,
      "target": 4.5,
      "trend": "up",
      "change": "+0.3",
      "color": warningColor
    },
    {
      "title": "Employee Satisfaction",
      "value": 4.1,
      "target": 4.0,
      "trend": "up",
      "change": "+0.2",
      "color": successColor
    },
    {
      "title": "Goal Completion Rate",
      "value": 87.5,
      "target": 90.0,
      "trend": "up",
      "change": "+5.2%",
      "color": warningColor
    },
    {
      "title": "Retention Rate",
      "value": 92.8,
      "target": 95.0,
      "trend": "stable",
      "change": "0%",
      "color": infoColor
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: [
                      {"label": "Monthly", "value": "monthly"},
                      {"label": "Quarterly", "value": "quarterly"},
                      {"label": "Yearly", "value": "yearly"},
                      {"label": "Custom", "value": "custom"},
                    ],
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
                    label: "Department",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Engineering", "value": "Engineering"},
                      {"label": "Design", "value": "Design"},
                      {"label": "Product", "value": "Product"},
                      {"label": "Marketing", "value": "Marketing"},
                    ],
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Key Performance Indicators
            Text(
              "Key Performance Indicators",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: kpiData.map((kpi) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (kpi["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              kpi["trend"] == "up" ? Icons.trending_up :
                              kpi["trend"] == "down" ? Icons.trending_down :
                              Icons.trending_flat,
                              color: kpi["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: kpi["trend"] == "up" ? successColor.withAlpha(20) :
                                     kpi["trend"] == "down" ? dangerColor.withAlpha(20) :
                                     disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${kpi["change"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: kpi["trend"] == "up" ? successColor :
                                       kpi["trend"] == "down" ? dangerColor :
                                       disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${kpi["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            kpi["title"].toString().contains("Rate") ? 
                              "${(kpi["value"] as num).toStringAsFixed(1)}%" :
                              "${(kpi["value"] as num).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "/ ${kpi["title"].toString().contains("Rate") ? "${(kpi["target"] as num).toStringAsFixed(1)}%" : "${(kpi["target"] as num).toStringAsFixed(1)}"}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: kpi["title"].toString().contains("Rate") ? 
                          (kpi["value"] as num) / 100 :
                          (kpi["value"] as num) / 5,
                        backgroundColor: disabledColor.withAlpha(30),
                        valueColor: AlwaysStoppedAnimation<Color>(kpi["color"] as Color),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Department Performance Overview
            Text(
              "Department Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),

            ...departmentMetrics.map((dept) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
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
                            "${dept["department"]} Department",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (dept["average_score"] as num) >= 4.0 ? 
                                  successColor.withAlpha(20) : 
                                  warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(dept["average_score"] as num).toStringAsFixed(1)}/5.0",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: (dept["average_score"] as num) >= 4.0 ? 
                                    successColor : 
                                    warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildMetricCard("Total Employees", "${dept["employee_count"]}", Icons.people, primaryColor),
                        _buildMetricCard("Top Performers", "${dept["top_performers"]}", Icons.star, successColor),
                        _buildMetricCard("Need Improvement", "${dept["improvement_needed"]}", Icons.trending_down, warningColor),
                        _buildMetricCard("Retention Rate", "${(dept["retention_rate"] as num).toStringAsFixed(1)}%", Icons.trending_up, infoColor),
                        _buildMetricCard("Satisfaction", "${(dept["satisfaction_score"] as num).toStringAsFixed(1)}/5.0", Icons.sentiment_very_satisfied, secondaryColor),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Individual Performance Rankings
            Text(
              "Individual Performance Rankings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spSm),

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
                        Text(
                          "Employee Performance Overview",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.sort,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  ...performanceMetrics.asMap().entries.map((entry) {
                    final index = entry.key;
                    final employee = entry.value;
                    final metrics = employee["metrics"] as Map<String, dynamic>;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: index < 3 ? 
                                    (index == 0 ? Color(0xFFFFD700) : 
                                     index == 1 ? Color(0xFFC0C0C0) : 
                                     Color(0xFFCD7F32)) : 
                                    primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: index < 3 ? Colors.white : primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${employee["avatar"]}"),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${employee["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${employee["position"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: (employee["overall_score"] as num) >= 4.0 ? 
                                        successColor.withAlpha(20) : 
                                        warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${(employee["overall_score"] as num).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: (employee["overall_score"] as num) >= 4.0 ? 
                                          successColor : 
                                          warningColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                employee["trend"] == "up" ? Icons.trending_up :
                                employee["trend"] == "down" ? Icons.trending_down :
                                Icons.trending_flat,
                                color: employee["trend"] == "up" ? successColor :
                                       employee["trend"] == "down" ? dangerColor :
                                       disabledBoldColor,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Goals Progress",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: (employee["goals_completed"] as int) / (employee["goals_total"] as int),
                                      backgroundColor: disabledColor.withAlpha(30),
                                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${employee["goals_completed"]}/${employee["goals_total"]} completed",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              QButton(
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.file_download,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Schedule Review",
                    icon: Icons.schedule,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
