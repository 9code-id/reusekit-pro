import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth10View extends StatefulWidget {
  @override
  State<GrlHealth10View> createState() => _GrlHealth10ViewState();
}

class _GrlHealth10ViewState extends State<GrlHealth10View> {
  String selectedPeriod = "week";
  String selectedMetric = "all";

  List<Map<String, dynamic>> healthStats = [
    {
      "metric": "Steps",
      "current": 8542,
      "target": 10000,
      "unit": "steps",
      "change": 15.3,
      "icon": Icons.directions_walk,
      "color": Colors.green
    },
    {
      "metric": "Heart Rate",
      "current": 72,
      "target": 80,
      "unit": "bpm",
      "change": -2.1,
      "icon": Icons.favorite,
      "color": Colors.red
    },
    {
      "metric": "Sleep",
      "current": 7.5,
      "target": 8.0,
      "unit": "hours",
      "change": 8.2,
      "icon": Icons.bedtime,
      "color": Colors.purple
    },
    {
      "metric": "Water",
      "current": 2.1,
      "target": 2.5,
      "unit": "liters",
      "change": 12.5,
      "icon": Icons.water_drop,
      "color": Colors.blue
    },
    {
      "metric": "Calories",
      "current": 1850,
      "target": 2000,
      "unit": "kcal",
      "change": -5.8,
      "icon": Icons.local_fire_department,
      "color": Colors.orange
    },
    {
      "metric": "Weight",
      "current": 68.5,
      "target": 65.0,
      "unit": "kg",
      "change": -2.1,
      "icon": Icons.monitor_weight,
      "color": Colors.indigo
    }
  ];

  List<Map<String, dynamic>> weeklyData = [
    {"day": "Mon", "steps": 8200, "heartRate": 70, "sleep": 7.2, "calories": 1900},
    {"day": "Tue", "steps": 9100, "heartRate": 73, "sleep": 7.8, "calories": 1950},
    {"day": "Wed", "steps": 7800, "heartRate": 69, "sleep": 6.9, "calories": 1800},
    {"day": "Thu", "steps": 8900, "heartRate": 75, "sleep": 8.1, "calories": 2100},
    {"day": "Fri", "steps": 9500, "heartRate": 71, "sleep": 7.5, "calories": 1850},
    {"day": "Sat", "steps": 10200, "heartRate": 68, "sleep": 8.3, "calories": 2000},
    {"day": "Sun", "steps": 8542, "heartRate": 72, "sleep": 7.5, "calories": 1850}
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Week Warrior",
      "description": "7 days of meeting step goals",
      "icon": Icons.emoji_events,
      "color": Colors.amber,
      "achieved": true,
      "date": "2024-03-15"
    },
    {
      "title": "Heart Healthy",
      "description": "Maintain healthy heart rate for 30 days",
      "icon": Icons.favorite,
      "color": Colors.red,
      "achieved": true,
      "date": "2024-03-10"
    },
    {
      "title": "Sleep Master",
      "description": "Get 8+ hours sleep for 7 consecutive days",
      "icon": Icons.bedtime,
      "color": Colors.purple,
      "achieved": false,
      "progress": 0.4
    },
    {
      "title": "Hydration Hero",
      "description": "Meet daily water goals for 14 days",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "achieved": false,
      "progress": 0.7
    }
  ];

  List<Map<String, dynamic>> healthInsights = [
    {
      "type": "positive",
      "title": "Great Progress!",
      "message": "Your step count increased by 15% this week compared to last week.",
      "icon": Icons.trending_up,
      "color": Colors.green
    },
    {
      "type": "warning",
      "title": "Sleep Pattern",
      "message": "You've been getting less than 8 hours of sleep. Consider going to bed earlier.",
      "icon": Icons.warning,
      "color": Colors.orange
    },
    {
      "type": "info",
      "title": "Heart Rate Stability",
      "message": "Your resting heart rate has been consistently in the healthy range.",
      "icon": Icons.info,
      "color": Colors.blue
    },
    {
      "type": "suggestion",
      "title": "Hydration Reminder",
      "message": "Try to increase your water intake by 500ml to meet your daily goal.",
      "icon": Icons.lightbulb,
      "color": Colors.purple
    }
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Week", "value": "week"},
    {"label": "Month", "value": "month"},
    {"label": "3 Months", "value": "3months"},
    {"label": "Year", "value": "year"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Analytics"),
        actions: [
          Icon(Icons.share),
          SizedBox(width: spSm),
          Icon(Icons.settings),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header with Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Health Analytics Dashboard",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Track your progress and health trends",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "Overall Score: 85%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Period Selector
            Row(
              children: [
                Text(
                  "Analytics Period",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: periodOptions.map((period) {
                      bool isSelected = selectedPeriod == period["value"];
                      return GestureDetector(
                        onTap: () {
                          selectedPeriod = period["value"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${period["label"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            // Health Metrics Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthStats.map((stat) {
                double progress = (stat["current"] as num) / (stat["target"] as num);
                bool isOnTrack = progress >= 0.8;
                Color progressColor = isOnTrack ? Colors.green : Colors.orange;
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
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
                              color: progressColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              isOnTrack ? "ON TRACK" : "BEHIND",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: progressColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["metric"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "${stat["current"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${stat["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Goal: ${stat["target"]} ${stat["unit"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: progress > 1 ? 1 : progress,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      ),
                      Row(
                        children: [
                          Icon(
                            (stat["change"] as double) > 0 
                                ? Icons.trending_up 
                                : Icons.trending_down,
                            color: (stat["change"] as double) > 0 
                                ? Colors.green 
                                : Colors.red,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(stat["change"] as double) > 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (stat["change"] as double) > 0 
                                  ? Colors.green 
                                  : Colors.red,
                            ),
                          ),
                          Text(
                            " vs last $selectedPeriod",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Weekly Trend Chart
            Text(
              "Weekly Trend",
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Text(
                        "Steps This Week",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Avg: ${(weeklyData.map((d) => d["steps"] as int).reduce((a, b) => a + b) / weeklyData.length).toInt()} steps",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: weeklyData.map((data) {
                        int steps = data["steps"] as int;
                        double normalizedHeight = (steps / 12000) * 100;
                        bool isToday = data["day"] == "Sun";
                        
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: normalizedHeight,
                                  decoration: BoxDecoration(
                                    color: isToday ? primaryColor : primaryColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    color: isToday ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(steps / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledColor,
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

            // Achievements
            Text(
              "Achievements",
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: achievements.map((achievement) {
                  bool isAchieved = achievement["achieved"] as bool;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isAchieved 
                          ? (achievement["color"] as Color).withAlpha(30)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isAchieved 
                                ? (achievement["color"] as Color).withAlpha(100)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            achievement["icon"] as IconData,
                            color: isAchieved 
                                ? achievement["color"] as Color
                                : Colors.grey.shade600,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${achievement["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isAchieved ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${achievement["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (!isAchieved && achievement.containsKey("progress"))
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: spXs),
                                    LinearProgressIndicator(
                                      value: achievement["progress"] as double,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        achievement["color"] as Color,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${((achievement["progress"] as double) * 100).toInt()}% Complete",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (isAchieved)
                          Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20,
                              ),
                              Text(
                                "${achievement["date"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Health Insights
            Text(
              "Health Insights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...healthInsights.map((insight) {
              return Container(
                padding: EdgeInsets.all(spMd),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: (insight["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: (insight["color"] as Color).withAlpha(100),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      insight["icon"] as IconData,
                      color: insight["color"] as Color,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            "${insight["message"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Export Options
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
                    label: "Export PDF Report",
                    size: bs.sm,
                    onPressed: () {
                      si("Generating PDF report...");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Share with Doctor",
                    size: bs.sm,
                    onPressed: () {
                      si("Preparing health data for sharing...");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
