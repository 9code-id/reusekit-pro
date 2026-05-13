import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWindDirectionView extends StatefulWidget {
  const WcaWindDirectionView({super.key});

  @override
  State<WcaWindDirectionView> createState() => _WcaWindDirectionViewState();
}

class _WcaWindDirectionViewState extends State<WcaWindDirectionView> {
  String selectedLocation = "Kansas City, MO";
  bool isLoading = false;

  Map<String, dynamic> currentWind = {
    "direction": "NW",
    "degrees": 315,
    "speed": 15,
    "description": "Northwest Wind",
    "meteorologicalDirection": "From Northwest",
    "variability": "Steady",
    "icon": "🧭",
    "lastUpdated": "5:10 PM",
  };

  List<Map<String, dynamic>> hourlyDirection = [
    {"time": "Now", "direction": "NW", "degrees": 315, "speed": 15, "variability": "Steady"},
    {"time": "3 PM", "direction": "NW", "degrees": 320, "speed": 14, "variability": "Steady"},
    {"time": "4 PM", "direction": "NW", "degrees": 310, "speed": 16, "variability": "Variable"},
    {"time": "5 PM", "direction": "N", "degrees": 305, "speed": 18, "variability": "Steady"},
    {"time": "6 PM", "direction": "N", "degrees": 300, "speed": 17, "variability": "Steady"},
    {"time": "7 PM", "direction": "N", "degrees": 295, "speed": 15, "variability": "Variable"},
    {"time": "8 PM", "direction": "NE", "degrees": 290, "speed": 12, "variability": "Steady"},
    {"time": "9 PM", "direction": "NE", "degrees": 285, "speed": 10, "variability": "Variable"},
    {"time": "10 PM", "direction": "E", "degrees": 280, "speed": 8, "variability": "Light"},
    {"time": "11 PM", "direction": "E", "degrees": 275, "speed": 6, "variability": "Light"},
  ];

  List<Map<String, dynamic>> compassDirections = [
    {"name": "North", "abbr": "N", "degrees": 0, "description": "True North"},
    {"name": "Northeast", "abbr": "NE", "degrees": 45, "description": "Northeast"},
    {"name": "East", "abbr": "E", "degrees": 90, "description": "Due East"},
    {"name": "Southeast", "abbr": "SE", "degrees": 135, "description": "Southeast"},
    {"name": "South", "abbr": "S", "degrees": 180, "description": "True South"},
    {"name": "Southwest", "abbr": "SW", "degrees": 225, "description": "Southwest"},
    {"name": "West", "abbr": "W", "degrees": 270, "description": "Due West"},
    {"name": "Northwest", "abbr": "NW", "degrees": 315, "description": "Northwest"},
  ];

  List<Map<String, dynamic>> directionEffects = [
    {
      "title": "Temperature Effect",
      "current": "Cooler Air Mass",
      "description": "Northwest winds typically bring cooler, drier air",
      "icon": Icons.thermostat,
      "color": "info",
    },
    {
      "title": "Weather Pattern",
      "current": "High Pressure",
      "description": "Northwest flow often indicates fair weather",
      "icon": Icons.wb_sunny,
      "color": "success",
    },
    {
      "title": "Air Quality",
      "current": "Good Dispersion",
      "description": "Wind direction helps clear pollutants",
      "icon": Icons.air,
      "color": "success",
    },
    {
      "title": "Seasonal Impact",
      "current": "Continental Air",
      "description": "Bringing dry continental air mass",
      "icon": Icons.landscape,
      "color": "info",
    },
  ];

  List<Map<String, dynamic>> dailyDirections = [
    {"day": "Today", "primary": "NW", "degrees": 315, "secondary": "N", "variability": "Low"},
    {"day": "Tue", "primary": "N", "degrees": 0, "secondary": "NE", "variability": "Medium"},
    {"day": "Wed", "primary": "NE", "degrees": 45, "secondary": "E", "variability": "High"},
    {"day": "Thu", "primary": "E", "degrees": 90, "secondary": "SE", "variability": "Low"},
    {"day": "Fri", "primary": "SE", "degrees": 135, "secondary": "S", "variability": "Medium"},
    {"day": "Sat", "primary": "S", "degrees": 180, "secondary": "SW", "variability": "Medium"},
    {"day": "Sun", "primary": "SW", "degrees": 225, "secondary": "W", "variability": "Low"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wind Direction"),
        actions: [
          IconButton(
            icon: Icon(Icons.explore),
            onPressed: () {
              si("Wind direction affects weather patterns and air quality");
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
                        colors: [primaryColor, successColor],
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
                                "${currentWind["variability"]}",
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
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(20),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white.withAlpha(50), width: 2),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Transform.rotate(
                                      angle: (currentWind["degrees"] as int) * 3.14159 / 180,
                                      child: Container(
                                        width: 4,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        margin: EdgeInsets.only(bottom: 60),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "N",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: Text(
                                        "S",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 5,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: Text(
                                        "W",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: Text(
                                        "E",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spLg),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Wind From",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${currentWind["direction"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${currentWind["degrees"]}°",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${currentWind["speed"]} mph",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "${currentWind["meteorologicalDirection"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Last updated: ${currentWind["lastUpdated"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(180),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    "Hourly Direction Change",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyDirection.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      Color variabilityColor = _getVariabilityColor(hour["variability"]);
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
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: variabilityColor.withAlpha(20),
                                shape: BoxShape.circle,
                                border: Border.all(color: variabilityColor.withAlpha(50)),
                              ),
                              child: Center(
                                child: Transform.rotate(
                                  angle: (hour["degrees"] as int) * 3.14159 / 180,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: variabilityColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${hour["direction"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isNow ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "${hour["degrees"]}°",
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
                    "Wind Direction Effects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: directionEffects.map((effect) {
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
                    "7-Day Direction Forecast",
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
                      children: dailyDirections.map((day) {
                        bool isToday = day["day"] == "Today";
                        Color variabilityColor = _getVariabilityColor(day["variability"]);
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isToday ? primaryColor.withAlpha(10) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
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
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: variabilityColor.withAlpha(20),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: variabilityColor.withAlpha(50)),
                                ),
                                child: Center(
                                  child: Transform.rotate(
                                    angle: (day["degrees"] as int) * 3.14159 / 180,
                                    child: Icon(
                                      Icons.arrow_upward,
                                      color: variabilityColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Primary: ${day["primary"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: spMd),
                                        Text(
                                          "Secondary: ${day["secondary"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: variabilityColor.withAlpha(30),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${day["variability"]} Variability",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: variabilityColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Text(
                    "Compass Directions Reference",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: compassDirections.map((direction) {
                      bool isCurrent = direction["abbr"] == currentWind["direction"];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isCurrent ? primaryColor.withAlpha(20) : Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isCurrent ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isCurrent ? primaryColor.withAlpha(30) : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Transform.rotate(
                                  angle: (direction["degrees"] as int) * 3.14159 / 180,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: isCurrent ? primaryColor : disabledBoldColor,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "${direction["abbr"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isCurrent ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "${direction["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${direction["degrees"]}°",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isCurrent ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
                                "Wind Direction Explanation",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Wind direction indicates where the wind is coming FROM, not where it's going. A northwest wind comes from the northwest and blows toward the southeast.",
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
                    label: "Refresh Wind Direction",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Wind direction data updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Color _getVariabilityColor(String variability) {
    switch (variability.toLowerCase()) {
      case "steady":
        return successColor;
      case "variable":
        return warningColor;
      case "light":
        return infoColor;
      case "low":
        return successColor;
      case "medium":
        return warningColor;
      case "high":
        return dangerColor;
      default:
        return primaryColor;
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
}
