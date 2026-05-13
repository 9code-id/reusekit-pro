import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHealth1View extends StatefulWidget {
  const GrlHealth1View({super.key});

  @override
  State<GrlHealth1View> createState() => _GrlHealth1ViewState();
}

class _GrlHealth1ViewState extends State<GrlHealth1View> {
  int currentTab = 0;
  String selectedTimeframe = "today";
  
  List<Map<String, dynamic>> healthMetrics = [
    {
      "title": "Heart Rate",
      "value": "72",
      "unit": "bpm",
      "status": "normal",
      "icon": Icons.favorite,
      "color": dangerColor,
      "trend": "stable",
      "lastUpdated": "2 min ago",
      "range": "60-100 bpm",
      "details": {
        "resting": 68,
        "active": 120,
        "max": 185,
        "zones": ["Fat Burn: 102-119", "Cardio: 119-136", "Peak: 136+"],
      },
    },
    {
      "title": "Blood Pressure",
      "value": "118/76",
      "unit": "mmHg",
      "status": "optimal",
      "icon": Icons.bloodtype,
      "color": successColor,
      "trend": "improving",
      "lastUpdated": "1 hour ago",
      "range": "<120/80 mmHg",
      "details": {
        "systolic": 118,
        "diastolic": 76,
        "category": "Normal",
        "recommendation": "Maintain current lifestyle",
      },
    },
    {
      "title": "Blood Sugar",
      "value": "94",
      "unit": "mg/dL",
      "status": "normal",
      "icon": Icons.water_drop,
      "color": infoColor,
      "trend": "stable",
      "lastUpdated": "30 min ago",
      "range": "70-99 mg/dL",
      "details": {
        "fasting": 94,
        "postMeal": 140,
        "hba1c": 5.2,
        "target": "Less than 100 mg/dL",
      },
    },
    {
      "title": "Body Temperature",
      "value": "98.6",
      "unit": "°F",
      "status": "normal",
      "icon": Icons.thermostat,
      "color": warningColor,
      "trend": "stable",
      "lastUpdated": "15 min ago",
      "range": "97.8-99.1 °F",
      "details": {
        "celsius": 37.0,
        "fahrenheit": 98.6,
        "status": "Normal body temperature",
        "note": "Temperature varies throughout the day",
      },
    },
  ];

  List<Map<String, dynamic>> vitalSigns = [
    {
      "name": "Respiratory Rate",
      "value": 16,
      "unit": "breaths/min",
      "range": "12-20",
      "status": "normal",
      "color": successColor,
    },
    {
      "name": "Oxygen Saturation",
      "value": 98,
      "unit": "%",
      "range": "95-100%",
      "status": "normal",
      "color": infoColor,
    },
    {
      "name": "BMI",
      "value": 22.5,
      "unit": "kg/m²",
      "range": "18.5-24.9",
      "status": "normal",
      "color": successColor,
    },
    {
      "name": "Hydration",
      "value": 75,
      "unit": "%",
      "range": "60-80%",
      "status": "good",
      "color": infoColor,
    },
  ];

  List<Map<String, dynamic>> healthAlerts = [
    {
      "type": "reminder",
      "title": "Medication Reminder",
      "message": "Time to take your morning vitamins",
      "time": "9:00 AM",
      "priority": "medium",
      "icon": Icons.medication,
      "color": warningColor,
    },
    {
      "type": "alert",
      "title": "Hydration Alert",
      "message": "You haven't logged water intake in 3 hours",
      "time": "2 hours ago",
      "priority": "low",
      "icon": Icons.water_drop,
      "color": infoColor,
    },
    {
      "type": "achievement",
      "title": "Health Goal Achieved",
      "message": "You've maintained normal BP for 7 days!",
      "time": "1 day ago",
      "priority": "high",
      "icon": Icons.emoji_events,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Log Symptoms",
      "icon": Icons.note_add,
      "color": primaryColor,
      "description": "Record how you feel",
    },
    {
      "title": "Take Reading",
      "icon": Icons.monitor_heart,
      "color": dangerColor,
      "description": "Measure vitals",
    },
    {
      "title": "Medication",
      "icon": Icons.medication,
      "color": warningColor,
      "description": "Log medicine intake",
    },
    {
      "title": "Emergency",
      "icon": Icons.local_hospital,
      "color": dangerColor,
      "description": "Emergency contacts",
    },
  ];

  List<Map<String, dynamic>> weeklyTrends = [
    {"day": "Mon", "heartRate": 70, "bloodPressure": 115, "temperature": 98.4},
    {"day": "Tue", "heartRate": 68, "bloodPressure": 118, "temperature": 98.6},
    {"day": "Wed", "heartRate": 72, "bloodPressure": 120, "temperature": 98.5},
    {"day": "Thu", "heartRate": 71, "bloodPressure": 116, "temperature": 98.7},
    {"day": "Fri", "heartRate": 69, "bloodPressure": 118, "temperature": 98.6},
    {"day": "Sat", "heartRate": 73, "bloodPressure": 119, "temperature": 98.8},
    {"day": "Sun", "heartRate": 72, "bloodPressure": 118, "temperature": 98.6},
  ];

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "normal":
      case "optimal":
      case "good":
        return successColor;
      case "high":
      case "elevated":
        return warningColor;
      case "critical":
      case "low":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getTrendIcon(String trend) {
    switch (trend) {
      case "improving":
        return Icons.trending_up;
      case "declining":
        return Icons.trending_down;
      case "stable":
      default:
        return Icons.trending_flat;
    }
  }

  void _showMetricDetails(Map<String, dynamic> metric) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: spSm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Icon(
                    metric["icon"],
                    color: metric["color"],
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${metric["title"]} Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Current Reading
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: (metric["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: metric["color"]),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Current Reading",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${metric["value"]}",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${metric["unit"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Range: ${metric["range"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(metric["status"]).withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${metric["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getStatusColor(metric["status"]),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: spSm),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    getTrendIcon(metric["trend"]),
                                    color: metric["color"],
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${metric["trend"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: metric["color"],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Detailed Information
                    Text(
                      "Detailed Information",
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
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: (metric["details"] as Map<String, dynamic>).entries.map((entry) {
                          return Row(
                            children: [
                              Text(
                                "${entry.key}:".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${entry.value}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // Last Updated
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Last updated: ${metric["lastUpdated"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Monitor"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Health Status Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Health Status",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "All vitals are within normal range",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.health_and_safety,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: quickActions.map((action) {
                return GestureDetector(
                  onTap: () {
                    ss("${action["title"]} selected");
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(color: (action["color"] as Color).withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            action["icon"],
                            color: action["color"],
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["description"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Primary Health Metrics
            Text(
              "Primary Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                return GestureDetector(
                  onTap: () => _showMetricDetails(metric),
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(color: (metric["color"] as Color).withAlpha(100)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              metric["icon"],
                              color: metric["color"],
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${metric["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(metric["status"]).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${metric["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 8,
                                  color: getStatusColor(metric["status"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Text(
                              "${metric["value"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${metric["unit"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              getTrendIcon(metric["trend"]),
                              color: metric["color"],
                              size: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Range: ${metric["range"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Updated ${metric["lastUpdated"]}",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Additional Vital Signs
            Text(
              "Additional Vital Signs",
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
                children: vitalSigns.map((vital) {
                  return Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: vital["color"],
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${vital["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Range: ${vital["range"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${vital["value"]} ${vital["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (vital["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${vital["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 8,
                                color: vital["color"],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Health Alerts
            Text(
              "Health Alerts & Reminders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: healthAlerts.map((alert) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (alert["color"] as Color).withAlpha(25),
                    border: Border.all(color: alert["color"]),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: alert["color"],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          alert["icon"],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${alert["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${alert["message"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${alert["time"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (alert["type"] == "reminder")
                        QButton(
                          label: "Done",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Weekly Trends Chart
            Text(
              "Weekly Trends",
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
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.show_chart,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Heart Rate Trend (BPM)",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Last 7 days",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: weeklyTrends.map((day) {
                        double maxValue = weeklyTrends.map((d) => d["heartRate"] as int).reduce((a, b) => a > b ? a : b).toDouble();
                        double height = ((day["heartRate"] as int) / maxValue) * 80;
                        
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${day["heartRate"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 20,
                              height: height,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${day["day"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Export Data Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Export Health Data",
                onPressed: () {
                  ss("Health data exported successfully!");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
