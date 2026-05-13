import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHeartHealthView extends StatefulWidget {
  const HcaHeartHealthView({super.key});

  @override
  State<HcaHeartHealthView> createState() => _HcaHeartHealthViewState();
}

class _HcaHeartHealthViewState extends State<HcaHeartHealthView> {
  int currentTab = 0;
  String selectedPeriod = "Today";
  List<String> periods = ["Today", "Week", "Month"];

  List<Map<String, dynamic>> vitals = [
    {
      "id": 1,
      "type": "Heart Rate",
      "value": 72,
      "unit": "BPM",
      "time": "08:30 AM",
      "date": "2024-06-19",
      "status": "Normal",
      "icon": Icons.favorite,
      "color": dangerColor
    },
    {
      "id": 2,
      "type": "Blood Pressure",
      "systolic": 120,
      "diastolic": 80,
      "unit": "mmHg",
      "time": "08:30 AM",
      "date": "2024-06-19",
      "status": "Normal",
      "icon": Icons.monitor_heart,
      "color": successColor
    },
    {
      "id": 3,
      "type": "Oxygen Saturation",
      "value": 98,
      "unit": "%",
      "time": "08:35 AM",
      "date": "2024-06-19",
      "status": "Normal",
      "icon": Icons.air,
      "color": infoColor
    },
    {
      "id": 4,
      "type": "Resting Heart Rate",
      "value": 65,
      "unit": "BPM",
      "time": "07:00 AM",
      "date": "2024-06-19",
      "status": "Excellent",
      "icon": Icons.bedtime,
      "color": primaryColor
    }
  ];

  List<Map<String, dynamic>> activities = [
    {
      "activity": "Morning Walk",
      "duration": "30 min",
      "heartRate": {"avg": 85, "max": 105, "min": 70},
      "calories": 180,
      "time": "07:00 AM",
      "intensity": "Light",
      "completed": true
    },
    {
      "activity": "Cardio Workout",
      "duration": "45 min",
      "heartRate": {"avg": 135, "max": 160, "min": 110},
      "calories": 350,
      "time": "06:00 PM",
      "intensity": "Moderate",
      "completed": false
    },
    {
      "activity": "Yoga Session",
      "duration": "60 min",
      "heartRate": {"avg": 75, "max": 90, "min": 65},
      "calories": 200,
      "time": "07:30 PM",
      "intensity": "Light",
      "completed": false
    }
  ];

  List<Map<String, dynamic>> riskFactors = [
    {
      "factor": "Age",
      "value": "45 years",
      "risk": "Low",
      "description": "Age-related cardiovascular risk is low",
      "controllable": false,
      "color": successColor
    },
    {
      "factor": "BMI",
      "value": "26.2",
      "risk": "Moderate",
      "description": "Slightly overweight, weight management recommended",
      "controllable": true,
      "color": warningColor
    },
    {
      "factor": "Smoking",
      "value": "Non-smoker",
      "risk": "Low",
      "description": "Excellent! Continue being smoke-free",
      "controllable": true,
      "color": successColor
    },
    {
      "factor": "Family History",
      "value": "Present",
      "risk": "Moderate",
      "description": "Family history of heart disease requires monitoring",
      "controllable": false,
      "color": warningColor
    },
    {
      "factor": "Exercise",
      "value": "Regular",
      "risk": "Low",
      "description": "Regular exercise significantly reduces heart disease risk",
      "controllable": true,
      "color": successColor
    },
    {
      "factor": "Stress Level",
      "value": "Moderate",
      "risk": "Moderate",
      "description": "Stress management techniques recommended",
      "controllable": true,
      "color": warningColor
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "category": "Exercise",
      "title": "Aerobic Activity",
      "description": "150 minutes of moderate aerobic activity per week",
      "target": "150 min/week",
      "current": "120 min/week",
      "priority": "High",
      "icon": Icons.directions_run,
      "color": primaryColor
    },
    {
      "category": "Diet",
      "title": "Heart-Healthy Foods",
      "description": "Include more fruits, vegetables, whole grains, and lean proteins",
      "target": "5 servings/day",
      "current": "3 servings/day",
      "priority": "High",
      "icon": Icons.restaurant,
      "color": successColor
    },
    {
      "category": "Sleep",
      "title": "Quality Sleep",
      "description": "7-9 hours of quality sleep for heart recovery",
      "target": "7-9 hours",
      "current": "6.5 hours",
      "priority": "Medium",
      "icon": Icons.bedtime,
      "color": infoColor
    },
    {
      "category": "Stress",
      "title": "Stress Management",
      "description": "Regular meditation, deep breathing, or relaxation techniques",
      "target": "Daily practice",
      "current": "3x/week",
      "priority": "Medium",
      "icon": Icons.self_improvement,
      "color": warningColor
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Excellent":
        return successColor;
      case "Normal":
        return primaryColor;
      case "Borderline":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRiskColor(String risk) {
    switch (risk) {
      case "Low":
        return successColor;
      case "Moderate":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Heart Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Vitals", icon: Icon(Icons.favorite)),
        Tab(text: "Activities", icon: Icon(Icons.fitness_center)),
        Tab(text: "Risk Assessment", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heart Health Score
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [dangerColor, dangerColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Heart Health Score",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
                                "78",
                                style: TextStyle(
                                  fontSize: fsH1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Good Health",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            value: 0.78,
                            strokeWidth: 8,
                            backgroundColor: Colors.white.withAlpha(100),
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Keep up the good work! Regular exercise and healthy diet are improving your heart health.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(220),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Today's Vitals
              Text(
                "Today's Vitals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: vitals.take(4).map((vital) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: vital["color"] as Color,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              vital["icon"] as IconData,
                              color: vital["color"] as Color,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${vital["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        if (vital["type"] == "Blood Pressure") ...[
                          Text(
                            "${vital["systolic"]}/${vital["diastolic"]}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: vital["color"] as Color,
                            ),
                          ),
                        ] else ...[
                          Text(
                            "${vital["value"]}",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: vital["color"] as Color,
                            ),
                          ),
                        ],
                        Text(
                          "${vital["unit"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(vital["status"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${vital["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(vital["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: spLg),

              // Heart Rate Zones
              Text(
                "Heart Rate Zones",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              Container(
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
                      "Target Heart Rate Zones",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Resting Zone
                    Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: infoColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Resting (60-70 BPM)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "Recovery & Rest",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Fat Burn Zone
                    Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Fat Burn (105-123 BPM)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "Light Exercise",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Cardio Zone
                    Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Cardio (123-141 BPM)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "Aerobic Fitness",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Peak Zone
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Peak (141+ BPM)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "High Intensity",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Quick Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Record Vitals",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Add Reading",
                          size: bs.sm,
                          onPressed: () {
                            ss("New vital reading added");
                          },
                        ),
                      ],
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
                        Icon(
                          Icons.schedule,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Medication Reminder",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        QButton(
                          label: "Set Reminder",
                          size: bs.sm,
                          onPressed: () {
                            ss("Medication reminder set");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Vitals Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Reading Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Reading",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("New vital reading added");
                  },
                ),
              ),

              SizedBox(height: spLg),

              // Period Filter
              QCategoryPicker(
                items: periods.map((period) => {
                  "label": period,
                  "value": period,
                }).toList(),
                value: selectedPeriod,
                onChanged: (index, label, value, item) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spLg),

              // Vitals List
              Text(
                "Recent Vitals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...vitals.map((vital) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: vital["color"] as Color,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (vital["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          vital["icon"] as IconData,
                          color: vital["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${vital["type"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                if (vital["type"] == "Blood Pressure") ...[
                                  Text(
                                    "${vital["systolic"]}/${vital["diastolic"]} ${vital["unit"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: vital["color"] as Color,
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    "${vital["value"]} ${vital["unit"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: vital["color"] as Color,
                                    ),
                                  ),
                                ],
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(vital["status"]).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${vital["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor(vital["status"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${vital["time"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(vital["date"]).dMMMy}",
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
            ],
          ),
        ),

        // Activities Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Activities
              Text(
                "Today's Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...activities.map((activity) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: activity["completed"] as bool ? successColor : warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: activity["completed"] as bool 
                                  ? successColor.withAlpha(30) 
                                  : warningColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              activity["completed"] as bool ? Icons.check_circle : Icons.schedule,
                              color: activity["completed"] as bool ? successColor : warningColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["activity"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${activity["duration"]} • ${activity["time"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(activity["intensity"]).withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${activity["intensity"]} Intensity",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getPriorityColor(activity["intensity"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Activity Stats
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Heart Rate",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Avg: ${(activity["heartRate"] as Map)["avg"]} BPM",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  "Max: ${(activity["heartRate"] as Map)["max"]} | Min: ${(activity["heartRate"] as Map)["min"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Calories Burned",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${activity["calories"]} cal",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: activity["completed"] as bool ? "View Details" : "Start Activity",
                          size: bs.sm,
                          onPressed: () {
                            if (!(activity["completed"] as bool)) {
                              activity["completed"] = true;
                              setState(() {});
                              ss("Activity started!");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Add Activity Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add New Activity",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    ss("New activity added");
                  },
                ),
              ),
            ],
          ),
        ),

        // Risk Assessment Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Risk Factors
              Text(
                "Cardiovascular Risk Factors",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...riskFactors.map((factor) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: factor["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (factor["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              factor["controllable"] as bool ? Icons.tune : Icons.info,
                              color: factor["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${factor["factor"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${factor["value"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                            decoration: BoxDecoration(
                              color: _getRiskColor(factor["risk"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${factor["risk"]} Risk",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getRiskColor(factor["risk"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (factor["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${factor["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      if (factor["controllable"] as bool) ...[
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Manage Factor",
                            size: bs.sm,
                            onPressed: () {
                              ss("Managing ${factor["factor"]}");
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),

              SizedBox(height: spLg),

              // Health Recommendations
              Text(
                "Health Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              ...recommendations.map((rec) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: rec["color"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (rec["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              rec["icon"] as IconData,
                              color: rec["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${rec["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${rec["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                              color: _getPriorityColor(rec["priority"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${rec["priority"]} Priority",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor(rec["priority"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${rec["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Target: ${rec["target"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Current: ${rec["current"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          QButton(
                            label: "Start Plan",
                            size: bs.sm,
                            onPressed: () {
                              ss("${rec["title"]} plan started!");
                            },
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
      ],
    );
  }
}
