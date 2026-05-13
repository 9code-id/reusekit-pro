import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSkiingConditionsView extends StatefulWidget {
  const WcaSkiingConditionsView({super.key});

  @override
  State<WcaSkiingConditionsView> createState() => _WcaSkiingConditionsViewState();
}

class _WcaSkiingConditionsViewState extends State<WcaSkiingConditionsView> {
  String selectedResort = "Alpine Peaks Resort";
  String selectedSkillLevel = "Intermediate";

  List<Map<String, dynamic>> resorts = [
    {"label": "Alpine Peaks Resort", "value": "Alpine Peaks Resort"},
    {"label": "Snow Valley", "value": "Snow Valley"},
    {"label": "Mountain View Ski Area", "value": "Mountain View Ski Area"},
    {"label": "Powder Paradise", "value": "Powder Paradise"},
  ];

  List<Map<String, dynamic>> skillLevels = [
    {"label": "Beginner", "value": "Beginner"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  Map<String, dynamic> skiConditions = {
    "overallRating": "Excellent",
    "snowDepth": "145 cm",
    "newSnow24h": "8 cm",
    "snowQuality": "Powder",
    "liftsOpen": 14,
    "totalLifts": 16,
    "runsOpen": 42,
    "totalRuns": 48,
    "lastSnowfall": "Yesterday",
    "baseElevation": "1,200m",
    "summitElevation": "2,800m"
  };

  Map<String, dynamic> weatherConditions = {
    "temperature": -5,
    "feelsLike": -8,
    "windSpeed": 15,
    "windDirection": "NW",
    "humidity": 75,
    "visibility": 12,
    "snowfall": 85,
    "avalancheRisk": "Low",
    "uvIndex": 4
  };

  List<Map<String, dynamic>> liftStatus = [
    {"name": "Summit Express", "type": "Gondola", "status": "Open", "waitTime": "5 min"},
    {"name": "Valley Chair", "type": "Quad Chair", "status": "Open", "waitTime": "2 min"},
    {"name": "Alpine Lift", "type": "Chairlift", "status": "Open", "waitTime": "8 min"},
    {"name": "Beginner Hill", "type": "Magic Carpet", "status": "Open", "waitTime": "0 min"},
    {"name": "Back Bowl Express", "type": "High-Speed Quad", "status": "Closed", "waitTime": "N/A"},
    {"name": "Ridge Runner", "type": "T-Bar", "status": "Limited", "waitTime": "12 min"},
  ];

  List<Map<String, dynamic>> slopes = [
    {
      "name": "Easy Street",
      "difficulty": "Beginner",
      "status": "Open",
      "groomed": true,
      "length": "1.2 km",
      "conditions": "Excellent"
    },
    {
      "name": "Blue Ridge",
      "difficulty": "Intermediate",
      "status": "Open",
      "groomed": true,
      "length": "2.1 km",
      "conditions": "Good"
    },
    {
      "name": "Black Diamond",
      "difficulty": "Advanced",
      "status": "Open",
      "groomed": false,
      "length": "1.8 km",
      "conditions": "Powder"
    },
    {
      "name": "Double Black",
      "difficulty": "Expert",
      "status": "Closed",
      "groomed": false,
      "length": "2.5 km",
      "conditions": "Icy"
    },
    {
      "name": "Powder Bowl",
      "difficulty": "Advanced",
      "status": "Open",
      "groomed": false,
      "length": "1.5 km",
      "conditions": "Fresh Powder"
    }
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "type": "Weather",
      "severity": "Low",
      "message": "Light snowfall expected throughout the day",
      "action": "Great skiing conditions, visibility may be reduced"
    },
    {
      "type": "Lift Closure",
      "severity": "Medium",
      "message": "Back Bowl Express closed due to high winds",
      "action": "Use alternative routes via Summit Express"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skiing Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              si("Live slope cameras opened");
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
                  colors: [infoColor, infoColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.downhill_skiing,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ski Resort Conditions",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Real-time snow and slope information",
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
                    label: "Select Resort",
                    items: resorts,
                    value: selectedResort,
                    onChanged: (value, label) {
                      selectedResort = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Skill Level",
                    items: skillLevels,
                    value: selectedSkillLevel,
                    onChanged: (value, label) {
                      selectedSkillLevel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getRatingColor(skiConditions["overallRating"]).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: _getRatingColor(skiConditions["overallRating"]).withAlpha(50),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ac_unit,
                        color: _getRatingColor(skiConditions["overallRating"]),
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Snow Conditions",
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
                    "${skiConditions["overallRating"]}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(skiConditions["overallRating"]),
                    ),
                  ),
                  Text(
                    "${skiConditions["snowDepth"]} base | ${skiConditions["newSnow24h"]} new snow",
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
              "Snow Information",
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
                            Icons.height,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Snow Depth",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${skiConditions["snowDepth"]}",
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
                            Icons.ac_unit,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Snow Quality",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${skiConditions["snowQuality"]}",
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
                            Icons.elevator,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Lifts Open",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${skiConditions["liftsOpen"]}/${skiConditions["totalLifts"]}",
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
                            Icons.terrain,
                            color: warningColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Runs Open",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${skiConditions["runsOpen"]}/${skiConditions["totalRuns"]}",
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
              "Weather Conditions",
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
                            color: infoColor,
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
                            color: warningColor,
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
                            Icons.ac_unit,
                            color: infoColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Snowfall Chance",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["snowfall"]}%",
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
                            Icons.warning,
                            color: _getAvalancheColor(weatherConditions["avalancheRisk"]),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avalanche Risk",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${weatherConditions["avalancheRisk"]}",
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
              "Lift Status",
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
                children: liftStatus.map((lift) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: _getLiftStatusColor(lift["status"]).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: _getLiftStatusColor(lift["status"]).withAlpha(50),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getLiftIcon(lift["type"]),
                          color: _getLiftStatusColor(lift["status"]),
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${lift["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${lift["type"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getLiftStatusColor(lift["status"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${lift["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (lift["waitTime"] != "N/A") ...[
                              SizedBox(height: spXs),
                              Text(
                                "Wait: ${lift["waitTime"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
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
            ),

            Text(
              "Slope Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: slopes.where((slope) => 
                selectedSkillLevel == "Beginner" && slope["difficulty"] == "Beginner" ||
                selectedSkillLevel == "Intermediate" && (slope["difficulty"] == "Beginner" || slope["difficulty"] == "Intermediate") ||
                selectedSkillLevel == "Advanced" && slope["difficulty"] != "Expert" ||
                selectedSkillLevel == "Expert"
              ).map((slope) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: _getSlopeStatusColor(slope["status"]).withAlpha(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getDifficultyIcon(slope["difficulty"]),
                            color: _getDifficultyColor(slope["difficulty"]),
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${slope["name"]}",
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
                              color: _getSlopeStatusColor(slope["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${slope["status"]}",
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
                          Text(
                            "${slope["difficulty"]} | ${slope["length"]}",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          if (slope["groomed"]) ...[
                            Icon(
                              Icons.agriculture,
                              color: successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Groomed",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Conditions: ${slope["conditions"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (alerts.isNotEmpty) ...[
              Text(
                "Alerts & Notices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: alerts.map((alert) {
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
                              "${alert["type"]} - ${alert["severity"]} Priority",
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
                            "${alert["action"]}",
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
      case "Beginner":
        return successColor;
      case "Intermediate":
        return infoColor;
      case "Advanced":
        return warningColor;
      case "Expert":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLiftStatusColor(String status) {
    switch (status) {
      case "Open":
        return successColor;
      case "Closed":
        return dangerColor;
      case "Limited":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSlopeStatusColor(String status) {
    switch (status) {
      case "Open":
        return successColor;
      case "Closed":
        return dangerColor;
      case "Limited":
        return warningColor;
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

  Color _getAvalancheColor(String risk) {
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

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return Icons.circle;
      case "Intermediate":
        return Icons.change_history;
      case "Advanced":
        return Icons.crop_square;
      case "Expert":
        return Icons.star;
      default:
        return Icons.help;
    }
  }

  IconData _getLiftIcon(String type) {
    switch (type) {
      case "Gondola":
        return Icons.cable;
      case "Chairlift":
      case "Quad Chair":
      case "High-Speed Quad":
        return Icons.airline_seat_recline_normal;
      case "Magic Carpet":
        return Icons.escalator;
      case "T-Bar":
        return Icons.linear_scale;
      default:
        return Icons.elevator;
    }
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case "Weather":
        return Icons.cloud;
      case "Lift Closure":
        return Icons.elevator;
      case "Safety":
        return Icons.warning;
      default:
        return Icons.info;
    }
  }
}
