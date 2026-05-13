import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaStatisticsView extends StatefulWidget {
  const EmaStatisticsView({super.key});

  @override
  State<EmaStatisticsView> createState() => _EmaStatisticsViewState();
}

class _EmaStatisticsViewState extends State<EmaStatisticsView> {
  String selectedPeriod = "This Month";
  String selectedMetric = "All Metrics";
  
  List<String> periods = ["This Week", "This Month", "Last 3 Months", "This Year"];
  List<String> metrics = ["All Metrics", "Completion Rate", "Mood Trends", "Stress Levels", "Sleep Quality"];

  Map<String, dynamic> statisticsData = {
    "completionRate": 85.5,
    "totalAssessments": 342,
    "completedAssessments": 292,
    "averageMood": 7.2,
    "averageStress": 4.1,
    "averageSleep": 6.8,
    "streakDays": 14,
    "longestStreak": 28,
    "weeklyTrend": 2.3, // positive trend
    "monthlyTrend": -0.5, // negative trend
  };

  List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "mood": 7.5, "stress": 3.2, "sleep": 7.0, "completed": true},
    {"day": "Tue", "mood": 6.8, "stress": 4.1, "sleep": 6.5, "completed": true},
    {"day": "Wed", "mood": 8.2, "stress": 2.8, "sleep": 7.5, "completed": true},
    {"day": "Thu", "mood": 7.1, "stress": 3.9, "sleep": 6.2, "completed": false},
    {"day": "Fri", "mood": 8.5, "stress": 2.1, "sleep": 7.8, "completed": true},
    {"day": "Sat", "mood": 8.9, "stress": 1.5, "sleep": 8.2, "completed": true},
    {"day": "Sun", "mood": 7.8, "stress": 2.9, "sleep": 7.3, "completed": true},
  ];

  List<Map<String, dynamic>> insights = [
    {
      "title": "Mood Improvement",
      "description": "Your mood scores have increased by 12% over the past month",
      "type": "positive",
      "icon": Icons.trending_up,
      "value": "+12%",
    },
    {
      "title": "Sleep Quality",
      "description": "Average sleep quality is above your target of 7.0",
      "type": "positive",
      "icon": Icons.bedtime,
      "value": "6.8/10",
    },
    {
      "title": "Stress Management",
      "description": "Stress levels need attention, especially on weekdays",
      "type": "warning",
      "icon": Icons.warning,
      "value": "4.1/10",
    },
    {
      "title": "Consistency",
      "description": "Excellent assessment completion rate this month",
      "type": "positive",
      "icon": Icons.check_circle,
      "value": "85.5%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMA Statistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share statistics
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('StatisticsSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Overview Cards
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "EMA Statistics Overview",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Your assessment progress and insights",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(statisticsData["completionRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Completion Rate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${statisticsData["streakDays"]}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Current Streak",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(statisticsData["averageMood"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Average Mood",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    label: "Metric",
                    items: metrics.map((metric) => {
                      "label": metric,
                      "value": metric,
                    }).toList(),
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Key Metrics Grid
            Text(
              "Key Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "Total Assessments", 
                  "${statisticsData["totalAssessments"]}", 
                  Icons.assignment, 
                  primaryColor,
                  "+${((statisticsData["totalAssessments"] as int) * 0.12).toInt()} this month"
                ),
                _buildMetricCard(
                  "Completed", 
                  "${statisticsData["completedAssessments"]}", 
                  Icons.check_circle, 
                  successColor,
                  "${(statisticsData["completionRate"] as double).toStringAsFixed(1)}% completion rate"
                ),
                _buildMetricCard(
                  "Average Stress", 
                  "${(statisticsData["averageStress"] as double).toStringAsFixed(1)}/10", 
                  Icons.psychology, 
                  warningColor,
                  "Target: < 3.0"
                ),
                _buildMetricCard(
                  "Sleep Quality", 
                  "${(statisticsData["averageSleep"] as double).toStringAsFixed(1)}/10", 
                  Icons.bedtime, 
                  infoColor,
                  "Target: > 7.0"
                ),
                _buildMetricCard(
                  "Current Streak", 
                  "${statisticsData["streakDays"]} days", 
                  Icons.local_fire_department, 
                  dangerColor,
                  "Best: ${statisticsData["longestStreak"]} days"
                ),
                _buildMetricCard(
                  "Weekly Trend", 
                  "${(statisticsData["weeklyTrend"] as double) >= 0 ? '+' : ''}${(statisticsData["weeklyTrend"] as double).toStringAsFixed(1)}%", 
                  (statisticsData["weeklyTrend"] as double) >= 0 ? Icons.trending_up : Icons.trending_down, 
                  (statisticsData["weeklyTrend"] as double) >= 0 ? successColor : dangerColor,
                  "vs last week"
                ),
              ],
            ),

            // Weekly Progress Chart
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
                    "Weekly Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: weeklyData.map((data) {
                        double mood = data["mood"];
                        bool completed = data["completed"];
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: (mood / 10) * 150,
                                  decoration: BoxDecoration(
                                    color: completed ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: completed ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${mood.toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 10,
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

            // Insights Section
            Text(
              "Key Insights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Column(
              spacing: spSm,
              children: insights.map((insight) {
                Color insightColor = _getInsightColor(insight["type"]);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: insightColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: insightColor.withAlpha(15),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          insight["icon"],
                          size: 24,
                          color: insightColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${insight["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${insight["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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
                          color: insightColor.withAlpha(15),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${insight["value"]}",
                          style: TextStyle(
                            color: insightColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Achievement Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Achievements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.local_fire_department,
                                color: dangerColor,
                                size: 20,
                              ),
                              Text(
                                "14 Day Streak",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.star,
                                color: warningColor,
                                size: 20,
                              ),
                              Text(
                                "85% Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: successColor,
                                size: 20,
                              ),
                              Text(
                                "Improved",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
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
            ),

            // Export Options
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Export & Share",
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
                          label: "Export Data",
                          size: bs.sm,
                          onPressed: () {
                            _exportStatistics();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Share Report",
                          size: bs.sm,
                          onPressed: () {
                            _shareStatistics();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
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

  Color _getInsightColor(String type) {
    switch (type) {
      case "positive":
        return successColor;
      case "warning":
        return warningColor;
      case "negative":
        return dangerColor;
      default:
        return infoColor;
    }
  }

  void _exportStatistics() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Statistics exported successfully!");
    });
  }

  void _shareStatistics() {
    ss("Statistics shared successfully!");
  }
}
