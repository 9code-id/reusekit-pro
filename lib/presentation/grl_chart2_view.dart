import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChart2View extends StatefulWidget {
  const GrlChart2View({Key? key}) : super(key: key);

  @override
  State<GrlChart2View> createState() => _GrlChart2ViewState();
}

class _GrlChart2ViewState extends State<GrlChart2View> {
  String selectedTimeframe = "This Month";
  String selectedDepartment = "All Departments";

  List<Map<String, dynamic>> performanceData = [
    {"month": "Jan", "target": 85.0, "actual": 82.0, "projects": 12},
    {"month": "Feb", "target": 85.0, "actual": 88.0, "projects": 14},
    {"month": "Mar", "target": 85.0, "actual": 91.0, "projects": 16},
    {"month": "Apr", "target": 85.0, "actual": 87.0, "projects": 15},
    {"month": "May", "target": 85.0, "actual": 93.0, "projects": 18},
    {"month": "Jun", "target": 85.0, "actual": 89.0, "projects": 17},
  ];

  List<Map<String, dynamic>> teamMetrics = [
    {
      "team": "Engineering",
      "efficiency": 92.5,
      "satisfaction": 4.2,
      "delivery": 95.0,
      "quality": 88.0,
      "color": Colors.blue,
    },
    {
      "team": "Design",
      "efficiency": 88.2,
      "satisfaction": 4.5,
      "delivery": 91.0,
      "quality": 94.0,
      "color": Colors.purple,
    },
    {
      "team": "Marketing",
      "efficiency": 85.7,
      "satisfaction": 4.1,
      "delivery": 89.0,
      "quality": 86.0,
      "color": Colors.orange,
    },
    {
      "team": "Sales",
      "efficiency": 90.1,
      "satisfaction": 4.3,
      "delivery": 93.0,
      "quality": 91.0,
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> productivityMetrics = [
    {
      "metric": "Task Completion Rate",
      "value": 94.2,
      "target": 90.0,
      "trend": "up",
      "icon": Icons.task_alt,
    },
    {
      "metric": "Meeting Efficiency",
      "value": 78.5,
      "target": 80.0,
      "trend": "down",
      "icon": Icons.schedule,
    },
    {
      "metric": "Code Quality Score",
      "value": 92.8,
      "target": 85.0,
      "trend": "up",
      "icon": Icons.code,
    },
    {
      "metric": "Customer Satisfaction",
      "value": 4.6,
      "target": 4.0,
      "trend": "up",
      "icon": Icons.star,
    },
  ];

  List<Map<String, dynamic>> weeklyProgress = [
    {"week": "Week 1", "productivity": 78.0, "issues": 3},
    {"week": "Week 2", "productivity": 85.0, "issues": 1},
    {"week": "Week 3", "productivity": 92.0, "issues": 2},
    {"week": "Week 4", "productivity": 88.0, "issues": 4},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
  ];

  Color _getTrendColor(String trend) {
    return trend == "up" ? successColor : dangerColor;
  }

  IconData _getTrendIcon(String trend) {
    return trend == "up" ? Icons.trending_up : Icons.trending_down;
  }

  double _getMaxPerformance() {
    return performanceData.map((e) => (e["actual"] as double)).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    double maxPerformance = _getMaxPerformance();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Performance Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Productivity Metrics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: productivityMetrics.map((metric) {
                bool isTargetMet = (metric["value"] as double) >= (metric["target"] as double);
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTrendColor(metric["trend"] as String).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              _getTrendIcon(metric["trend"] as String),
                              color: _getTrendColor(metric["trend"] as String),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["metric"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        metric["metric"] == "Customer Satisfaction"
                            ? "${(metric["value"] as double).toStringAsFixed(1)}/5.0"
                            : "${(metric["value"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            isTargetMet ? Icons.check_circle : Icons.warning,
                            size: 12,
                            color: isTargetMet ? successColor : warningColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Target: ${metric["metric"] == "Customer Satisfaction" ? (metric["target"] as double).toStringAsFixed(1) : (metric["target"] as double).toStringAsFixed(0)}${metric["metric"] == "Customer Satisfaction" ? "" : "%"}",
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
              }).toList(),
            ),

            // Performance Trend Line Chart
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monthly Performance Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Container(
                    height: 250,
                    child: Column(
                      children: [
                        // Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 12,
                                  height: 2,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Actual",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 12,
                                  height: 2,
                                  color: dangerColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Target",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        // Chart Area
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: performanceData.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> data = entry.value;
                              double actualHeight = ((data["actual"] as double) / 100) * 180;
                              double targetHeight = ((data["target"] as double) / 100) * 180;
                              
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Value labels
                                      Container(
                                        height: 40,
                                        child: Column(
                                          children: [
                                            Text(
                                              "${(data["actual"] as double).toStringAsFixed(0)}%",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${data["projects"]} projects",
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bars container
                                      Container(
                                        height: 180,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            // Target line
                                            Positioned(
                                              bottom: targetHeight,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                height: 2,
                                                color: dangerColor,
                                              ),
                                            ),
                                            // Actual bar
                                            Container(
                                              width: 20,
                                              height: actualHeight,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    primaryColor,
                                                    primaryColor.withAlpha(150),
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(radiusXs),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      // Month label
                                      Text(
                                        "${data["month"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
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
            ),

            // Team Performance Radar Chart Alternative
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team Performance Comparison",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    spacing: spSm,
                    children: teamMetrics.map((team) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (team["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: team["color"] as Color,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${team["team"]} Team",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            // Metrics Grid
                            ResponsiveGridView(
                              padding: EdgeInsets.zero,
                              minItemWidth: 200,
                              children: [
                                _buildMetricItem("Efficiency", team["efficiency"] as double, "%"),
                                _buildMetricItem("Satisfaction", team["satisfaction"] as double, "/5"),
                                _buildMetricItem("Delivery", team["delivery"] as double, "%"),
                                _buildMetricItem("Quality", team["quality"] as double, "%"),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Weekly Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Progress Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: weeklyProgress.map((week) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(5),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${week["week"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(week["productivity"] as double).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (week["issues"] as int) <= 2 ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${week["issues"]} issues",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: (week["issues"] as int) <= 2 ? successColor : warningColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.assessment,
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

  Widget _buildMetricItem(String label, double value, String unit) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "${value.toStringAsFixed(1)}$unit",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
