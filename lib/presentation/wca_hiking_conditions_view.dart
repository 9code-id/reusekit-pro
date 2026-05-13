import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHikingConditionsView extends StatefulWidget {
  const WcaHikingConditionsView({super.key});

  @override
  State<WcaHikingConditionsView> createState() => _WcaHikingConditionsViewState();
}

class _WcaHikingConditionsViewState extends State<WcaHikingConditionsView> {
  String selectedTrail = "Mountain Peak Trail";
  String selectedDifficulty = "Moderate";

  List<Map<String, dynamic>> trails = [
    {"label": "Mountain Peak Trail", "value": "Mountain Peak Trail"},
    {"label": "Forest Loop", "value": "Forest Loop"},
    {"label": "Riverside Path", "value": "Riverside Path"},
    {"label": "Alpine Ridge", "value": "Alpine Ridge"},
  ];

  List<Map<String, dynamic>> difficulties = [
    {"label": "Easy", "value": "Easy"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "Difficult", "value": "Difficult"},
    {"label": "Expert", "value": "Expert"},
  ];

  Map<String, dynamic> trailConditions = {
    "overallRating": "Excellent",
    "safetyLevel": "Safe",
    "trailStatus": "Open",
    "difficulty": "Moderate",
    "distance": "8.5 km",
    "elevation": "450m gain",
    "estimatedTime": "3.5 hours",
    "lastUpdated": "2 hours ago"
  };

  Map<String, dynamic> weatherConditions = {
    "temperature": 22,
    "feelsLike": 25,
    "windSpeed": 12,
    "windDirection": "NW",
    "humidity": 58,
    "uvIndex": 6,
    "visibility": 20,
    "precipitation": 5,
    "dewPoint": 14
  };

  List<Map<String, dynamic>> trailSegments = [
    {
      "name": "Trailhead to Base Camp",
      "distance": "2.1 km",
      "elevation": "120m gain",
      "difficulty": "Easy",
      "conditions": "Good",
      "hazards": [],
      "estimatedTime": "45 min"
    },
    {
      "name": "Base Camp to Ridge",
      "distance": "3.2 km",
      "elevation": "250m gain",
      "difficulty": "Moderate",
      "conditions": "Good",
      "hazards": ["Loose rocks"],
      "estimatedTime": "1.5 hours"
    },
    {
      "name": "Ridge to Summit",
      "distance": "2.8 km",
      "elevation": "180m gain",
      "difficulty": "Difficult",
      "conditions": "Fair",
      "hazards": ["Steep sections", "Weather exposure"],
      "estimatedTime": "1.25 hours"
    },
    {
      "name": "Summit Return",
      "distance": "0.4 km",
      "elevation": "0m",
      "difficulty": "Easy",
      "conditions": "Excellent",
      "hazards": [],
      "estimatedTime": "15 min"
    }
  ];

  List<Map<String, dynamic>> safetyAlerts = [
    {
      "type": "Weather Alert",
      "severity": "Low",
      "message": "Light winds expected, good hiking conditions",
      "action": "No special precautions needed"
    },
    {
      "type": "Trail Condition",
      "severity": "Medium",
      "message": "Loose rocks reported near ridge section",
      "action": "Use caution and proper footwear"
    }
  ];

  List<Map<String, dynamic>> equipment = [
    {"item": "Water", "amount": "2.5L", "essential": true},
    {"item": "Snacks/Food", "amount": "Trail mix, sandwich", "essential": true},
    {"item": "First Aid Kit", "amount": "Basic supplies", "essential": true},
    {"item": "Sun Protection", "amount": "Hat, sunscreen", "essential": true},
    {"item": "Weather Protection", "amount": "Light jacket", "essential": false},
    {"item": "Navigation", "amount": "Map, GPS", "essential": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hiking Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.emergency),
            onPressed: () {
              si("Emergency contacts displayed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.hiking,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hiking Trail Conditions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Real-time trail and weather information",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Trail",
                    items: trails,
                    value: selectedTrail,
                    onChanged: (value, label) {
                      selectedTrail = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Difficulty Filter",
                    items: difficulties,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getRatingColor(trailConditions["overallRating"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getRatingColor(trailConditions["overallRating"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getStatusIcon(trailConditions["trailStatus"]),
                        color: _getRatingColor(trailConditions["overallRating"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trail Conditions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${trailConditions["overallRating"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(trailConditions["overallRating"]),
                    ),
                  ),
                  Text(
                    "Status: ${trailConditions["trailStatus"]} | Safety: ${trailConditions["safetyLevel"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "Trail Information",
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
                Container(
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
                          Icon(
                            Icons.straighten,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Distance",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${trailConditions["distance"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Elevation Gain",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${trailConditions["elevation"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Est. Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${trailConditions["estimatedTime"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.signal_cellular_alt,
                            color: _getDifficultyColor(trailConditions["difficulty"]),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Difficulty",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${trailConditions["difficulty"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Text(
              "Current Weather",
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
                Container(
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
                          Icon(
                            Icons.thermostat,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Temperature",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["temperature"]}°C",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Feels like ${weatherConditions["feelsLike"]}°C",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.air,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Wind",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["windSpeed"]} km/h",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Direction: ${weatherConditions["windDirection"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "UV Index",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["uvIndex"]}/10",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        _getUVDescription(weatherConditions["uvIndex"]),
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Visibility",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["visibility"]} km",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Excellent visibility",
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

            Text(
              "Trail Segments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: trailSegments.map((segment) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getConditionColor(segment["conditions"]).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${segment["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: fsH6,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getConditionColor(segment["conditions"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${segment["conditions"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${segment["distance"]} | ${segment["elevation"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "${segment["estimatedTime"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(segment["difficulty"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${segment["difficulty"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getDifficultyColor(segment["difficulty"]),
                              ),
                            ),
                          ),
                          if ((segment["hazards"] as List).isNotEmpty) ...[
                            SizedBox(width: spSm),
                            Icon(
                              Icons.warning,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                (segment["hazards"] as List).join(", "),
                                style: TextStyle(
                                  color: warningColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (safetyAlerts.isNotEmpty) ...[
              Text(
                "Safety Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: safetyAlerts.map((alert) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getSeverityColor(alert["severity"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: _getSeverityColor(alert["severity"]).withAlpha(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getAlertIcon(alert["type"]),
                              color: _getSeverityColor(alert["severity"]),
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${alert["type"]} - ${alert["severity"]} Risk",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getSeverityColor(alert["severity"]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${alert["message"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "Action: ${alert["action"]}",
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            Text(
              "Recommended Equipment",
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
                spacing: spSm,
                children: equipment.map((item) {
                  return Row(
                    children: [
                      Icon(
                        item["essential"] ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: item["essential"] ? successColor : infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${item["item"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${item["amount"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
    );
  }

  Color _getRatingColor(String rating) {
    switch (rating) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Moderate":
        return infoColor;
      case "Difficult":
        return warningColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConditionColor(String condition) {
    switch (condition) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Low":
        return infoColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Open":
        return Icons.check_circle;
      case "Closed":
        return Icons.cancel;
      case "Limited":
        return Icons.warning;
      default:
        return Icons.help;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case "Weather Alert":
        return Icons.cloud;
      case "Trail Condition":
        return Icons.terrain;
      case "Safety Alert":
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  String _getUVDescription(int uvIndex) {
    if (uvIndex <= 2) return "Low";
    if (uvIndex <= 5) return "Moderate";
    if (uvIndex <= 7) return "High";
    if (uvIndex <= 10) return "Very High";
    return "Extreme";
  }
}
