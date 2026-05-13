import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaPressureView extends StatefulWidget {
  const WcaPressureView({super.key});

  @override
  State<WcaPressureView> createState() => _WcaPressureViewState();
}

class _WcaPressureViewState extends State<WcaPressureView> {
  String selectedLocation = "Denver, CO";
  String pressureUnit = "inHg";
  bool isLoading = false;

  Map<String, dynamic> currentPressure = {
    "pressure": 30.15,
    "trend": "rising",
    "change": "+0.05",
    "condition": "High Pressure",
    "weatherPattern": "Fair Weather",
    "icon": "📊",
    "lastUpdated": "4:15 PM",
  };

  List<Map<String, dynamic>> hourlyPressure = [
    {"time": "Now", "pressure": 30.15, "trend": "rising", "change": "+0.02"},
    {"time": "3 PM", "pressure": 30.13, "trend": "rising", "change": "+0.01"},
    {"time": "4 PM", "pressure": 30.17, "trend": "rising", "change": "+0.04"},
    {"time": "5 PM", "pressure": 30.19, "trend": "rising", "change": "+0.02"},
    {"time": "6 PM", "pressure": 30.21, "trend": "steady", "change": "+0.02"},
    {"time": "7 PM", "pressure": 30.20, "trend": "steady", "change": "-0.01"},
    {"time": "8 PM", "pressure": 30.18, "trend": "falling", "change": "-0.02"},
    {"time": "9 PM", "pressure": 30.16, "trend": "falling", "change": "-0.02"},
    {"time": "10 PM", "pressure": 30.14, "trend": "falling", "change": "-0.02"},
    {"time": "11 PM", "pressure": 30.12, "trend": "falling", "change": "-0.02"},
  ];

  List<Map<String, dynamic>> dailyPressure = [
    {"day": "Today", "high": 30.25, "low": 30.05, "avg": 30.15, "trend": "rising"},
    {"day": "Tue", "high": 30.18, "low": 29.98, "avg": 30.08, "trend": "falling"},
    {"day": "Wed", "high": 30.02, "low": 29.82, "avg": 29.92, "trend": "falling"},
    {"day": "Thu", "high": 29.95, "low": 29.75, "avg": 29.85, "trend": "steady"},
    {"day": "Fri", "high": 30.08, "low": 29.88, "avg": 29.98, "trend": "rising"},
    {"day": "Sat", "high": 30.22, "low": 30.02, "avg": 30.12, "trend": "rising"},
    {"day": "Sun", "high": 30.28, "low": 30.08, "avg": 30.18, "trend": "steady"},
  ];

  List<Map<String, dynamic>> pressureRanges = [
    {
      "range": "Below 29.80",
      "level": "Very Low",
      "weather": "Severe storms, hurricanes",
      "color": "danger",
      "effects": ["Strong winds", "Heavy rain", "Temperature drops"],
    },
    {
      "range": "29.80-30.00",
      "level": "Low",
      "weather": "Stormy weather, rain",
      "color": "warning",
      "effects": ["Cloudy skies", "Precipitation", "Unsettled weather"],
    },
    {
      "range": "30.00-30.20",
      "level": "Normal",
      "weather": "Fair to partly cloudy",
      "color": "success",
      "effects": ["Stable weather", "Comfortable conditions", "Light winds"],
    },
    {
      "range": "30.20-30.50",
      "level": "High",
      "weather": "Clear skies, dry",
      "color": "info",
      "effects": ["Clear skies", "Low humidity", "Calm conditions"],
    },
    {
      "range": "Above 30.50",
      "level": "Very High",
      "weather": "Extremely clear, cold",
      "color": "primary",
      "effects": ["Very clear", "Cold temperatures", "Dry air"],
    },
  ];

  List<Map<String, dynamic>> pressureEffects = [
    {
      "title": "Weather Pattern",
      "current": "High Pressure System",
      "description": "Clear skies and stable weather conditions",
      "icon": Icons.wb_sunny,
      "color": "success",
    },
    {
      "title": "Wind Speed",
      "current": "Light Winds",
      "description": "High pressure typically brings calm conditions",
      "icon": Icons.air,
      "color": "info",
    },
    {
      "title": "Precipitation",
      "current": "Unlikely",
      "description": "High pressure suppresses cloud formation",
      "icon": Icons.cloud_off,
      "color": "success",
    },
    {
      "title": "Health Impact",
      "current": "Generally Positive",
      "description": "Stable pressure is comfortable for most people",
      "icon": Icons.health_and_safety,
      "color": "success",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barometric Pressure"),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              pressureUnit = pressureUnit == "inHg" ? "hPa" : "inHg";
              setState(() {});
              si("Pressure unit changed to $pressureUnit");
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
                        colors: [primaryColor, infoColor],
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
                                pressureUnit,
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
                              "${currentPressure["icon"]}",
                              style: TextStyle(fontSize: 60),
                            ),
                            SizedBox(width: spMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Pressure",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${_convertPressure(currentPressure["pressure"])}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _getTrendIcon(currentPressure["trend"]),
                                      color: Colors.white.withAlpha(200),
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${currentPressure["change"]} ${pressureUnit}",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(200),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${currentPressure["condition"]} - ${currentPressure["weatherPattern"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Last updated: ${currentPressure["lastUpdated"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(180),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "Hourly Pressure Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyPressure.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      Color trendColor = _getTrendColor(hour["trend"]);
                      return Container(
                        width: 85,
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
                            Text(
                              "${_convertPressure(hour["pressure"])}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isNow ? primaryColor : Colors.black,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _getTrendIcon(hour["trend"]),
                                  color: trendColor,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${hour["change"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: trendColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    "7-Day Pressure Outlook",
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
                      children: dailyPressure.map((day) {
                        bool isToday = day["day"] == "Today";
                        Color trendColor = _getTrendColor(day["trend"]);
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
                                        "${_convertPressure(day["low"])}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: spSm),
                                          height: 4,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusXs),
                                            gradient: LinearGradient(
                                              colors: [
                                                infoColor.withAlpha(100),
                                                primaryColor.withAlpha(100),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${_convertPressure(day["high"])}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _getTrendIcon(day["trend"]),
                                        color: trendColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${day["trend"].toString().toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: trendColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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
                    "Current Pressure Effects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: pressureEffects.map((effect) {
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
                    "Pressure Range Guide",
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
                      children: pressureRanges.map((range) {
                        Color levelColor = _getColorFromString(range["color"]);
                        bool isCurrent = _isCurrentRange(range["range"]);
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
                                  Expanded(
                                    child: Text(
                                      "${range["level"]} (${range["range"]} ${pressureUnit})",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrent ? levelColor : Colors.black,
                                      ),
                                    ),
                                  ),
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
                                "${range["weather"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Wrap(
                                spacing: spXs,
                                children: (range["effects"] as List<String>).map((effect) {
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

                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Understanding Barometric Pressure",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Barometric pressure changes indicate weather pattern shifts. Rising pressure usually means improving weather, while falling pressure often brings storms.",
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
                  ),

                  QButton(
                    label: "Refresh Pressure Data",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Pressure data updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  String _convertPressure(double inHg) {
    if (pressureUnit == "hPa") {
      return "${(inHg * 33.8639).toStringAsFixed(1)} hPa";
    }
    return "${inHg.toStringAsFixed(2)} inHg";
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "rising":
        return Icons.trending_up;
      case "falling":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "rising":
        return successColor;
      case "falling":
        return dangerColor;
      default:
        return infoColor;
    }
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

  bool _isCurrentRange(String range) {
    double current = currentPressure["pressure"];
    if (range == "Below 29.80") return current < 29.80;
    if (range == "29.80-30.00") return current >= 29.80 && current < 30.00;
    if (range == "30.00-30.20") return current >= 30.00 && current < 30.20;
    if (range == "30.20-30.50") return current >= 30.20 && current < 30.50;
    if (range == "Above 30.50") return current >= 30.50;
    return false;
  }
}
