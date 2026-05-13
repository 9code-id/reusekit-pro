import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHumidityView extends StatefulWidget {
  const WcaHumidityView({super.key});

  @override
  State<WcaHumidityView> createState() => _WcaHumidityViewState();
}

class _WcaHumidityViewState extends State<WcaHumidityView> {
  String selectedLocation = "New Orleans, LA";
  bool isLoading = false;

  Map<String, dynamic> currentHumidity = {
    "percentage": 78,
    "dewPoint": 72,
    "condition": "Very Humid",
    "level": "High",
    "comfort": "Uncomfortable",
    "icon": "💧",
    "lastUpdated": "3:20 PM",
  };

  List<Map<String, dynamic>> hourlyHumidity = [
    {"time": "Now", "humidity": 78, "dewPoint": 72, "condition": "Very Humid"},
    {"time": "3 PM", "humidity": 82, "dewPoint": 74, "condition": "Extremely Humid"},
    {"time": "4 PM", "humidity": 85, "dewPoint": 76, "condition": "Oppressive"},
    {"time": "5 PM", "humidity": 80, "dewPoint": 73, "condition": "Very Humid"},
    {"time": "6 PM", "humidity": 75, "dewPoint": 70, "condition": "Humid"},
    {"time": "7 PM", "humidity": 72, "dewPoint": 68, "condition": "Humid"},
    {"time": "8 PM", "humidity": 68, "dewPoint": 65, "condition": "Moderate"},
    {"time": "9 PM", "humidity": 65, "dewPoint": 62, "condition": "Moderate"},
    {"time": "10 PM", "humidity": 70, "dewPoint": 65, "condition": "Humid"},
    {"time": "11 PM", "humidity": 74, "dewPoint": 68, "condition": "Humid"},
  ];

  List<Map<String, dynamic>> weeklyHumidity = [
    {"day": "Today", "avg": 78, "high": 85, "low": 65},
    {"day": "Tue", "avg": 75, "high": 82, "low": 68},
    {"day": "Wed", "avg": 80, "high": 88, "low": 72},
    {"day": "Thu", "avg": 85, "high": 92, "low": 78},
    {"day": "Fri", "avg": 82, "high": 89, "low": 75},
    {"day": "Sat", "avg": 76, "high": 83, "low": 69},
    {"day": "Sun", "avg": 73, "high": 80, "low": 66},
  ];

  List<Map<String, dynamic>> humidityLevels = [
    {
      "range": "0-30%",
      "level": "Very Dry",
      "description": "May cause static electricity and dry skin",
      "color": "warning",
      "effects": ["Dry skin", "Static electricity", "Respiratory irritation"],
    },
    {
      "range": "30-50%",
      "level": "Dry",
      "description": "Comfortable for most people",
      "color": "success",
      "effects": ["Comfortable", "Good for health", "Low mold risk"],
    },
    {
      "range": "50-70%",
      "level": "Ideal",
      "description": "Perfect humidity range for comfort and health",
      "color": "success",
      "effects": ["Most comfortable", "Optimal health", "Good sleep quality"],
    },
    {
      "range": "70-85%",
      "level": "High",
      "description": "Feels muggy and uncomfortable",
      "color": "warning",
      "effects": ["Feels sticky", "Reduced comfort", "Increased sweating"],
    },
    {
      "range": "85-100%",
      "level": "Very High",
      "description": "Oppressive and unhealthy conditions",
      "color": "danger",
      "effects": ["Very uncomfortable", "Health issues", "Mold growth risk"],
    },
  ];

  List<Map<String, dynamic>> humidityEffects = [
    {
      "title": "Comfort Level",
      "current": "Uncomfortable",
      "description": "High humidity makes it feel hotter than actual temperature",
      "icon": Icons.sentiment_dissatisfied,
      "color": "warning",
    },
    {
      "title": "Air Quality",
      "current": "Poor",
      "description": "High humidity can worsen air quality and allergens",
      "icon": Icons.air,
      "color": "danger",
    },
    {
      "title": "Health Impact",
      "current": "Moderate Risk",
      "description": "May cause difficulty breathing for sensitive individuals",
      "icon": Icons.health_and_safety,
      "color": "warning",
    },
    {
      "title": "Mold Risk",
      "current": "High",
      "description": "Ideal conditions for mold and mildew growth",
      "icon": Icons.warning,
      "color": "danger",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Humidity"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Humidity affects comfort, health, and indoor air quality");
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [infoColor, successColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                selectedLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${currentHumidity["level"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spLg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${currentHumidity["icon"]}",
                              style: TextStyle(fontSize: 60),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Humidity",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${currentHumidity["percentage"]}%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${currentHumidity["condition"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildHumidityInfo(
                              "Dew Point",
                              "${currentHumidity["dewPoint"]}°F",
                              Icons.thermostat,
                            ),
                            _buildHumidityInfo(
                              "Comfort",
                              "${currentHumidity["comfort"]}",
                              Icons.sentiment_dissatisfied,
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Last updated: ${currentHumidity["lastUpdated"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(180),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "Hourly Humidity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyHumidity.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      Color levelColor = _getHumidityColor(hour["humidity"]);
                      return Container(
                        width: 90,
                        padding: EdgeInsets.all(spMd),
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: isNow ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isNow ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${hour["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isNow ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: levelColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  "${hour["humidity"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: levelColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "DP: ${hour["dewPoint"]}°",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    "Weekly Humidity Trend",
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
                      children: weeklyHumidity.map((day) {
                        bool isToday = day["day"] == "Today";
                        return Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text(
                                "${day["day"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                  color: isToday ? primaryColor : disabledBoldColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${day["low"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: spSm),
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusXs),
                                            gradient: LinearGradient(
                                              colors: [
                                                successColor.withAlpha(100),
                                                warningColor.withAlpha(100),
                                                dangerColor.withAlpha(100),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${day["high"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Avg: ${day["avg"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                  Text(
                    "Current Impact Assessment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: humidityEffects.map((effect) {
                      Color cardColor = _getColorFromString(effect["color"]);
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: cardColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(color: cardColor.withAlpha(50)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  effect["icon"] as IconData,
                                  color: cardColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${effect["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: cardColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "${effect["current"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${effect["description"]}",
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

                  Text(
                    "Humidity Level Guide",
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
                      children: humidityLevels.map((level) {
                        Color levelColor = _getColorFromString(level["color"]);
                        bool isCurrent = _isCurrentLevel(level["range"]);
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isCurrent ? levelColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isCurrent ? levelColor.withAlpha(50) : Colors.transparent,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: levelColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Text(
                                    "${level["level"]} (${level["range"]})",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isCurrent ? levelColor : Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  if (isCurrent)
                                    Icon(
                                      Icons.radio_button_checked,
                                      color: levelColor,
                                      size: 16,
                                    ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${level["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                children: (level["effects"] as List<String>).map((effect) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: levelColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      effect,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: levelColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  QButton(
                    label: "Refresh Humidity Data",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Humidity data updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHumidityInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withAlpha(180),
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(180),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getHumidityColor(int humidity) {
    if (humidity < 30) return warningColor;
    if (humidity < 50) return successColor;
    if (humidity < 70) return successColor;
    if (humidity < 85) return warningColor;
    return dangerColor;
  }

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case "primary":
        return primaryColor;
      case "danger":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "success":
        return successColor;
      default:
        return primaryColor;
    }
  }

  bool _isCurrentLevel(String range) {
    int currentHum = currentHumidity["percentage"];
    if (range == "0-30%") return currentHum < 30;
    if (range == "30-50%") return currentHum >= 30 && currentHum < 50;
    if (range == "50-70%") return currentHum >= 50 && currentHum < 70;
    if (range == "70-85%") return currentHum >= 70 && currentHum < 85;
    if (range == "85-100%") return currentHum >= 85;
    return false;
  }
}
