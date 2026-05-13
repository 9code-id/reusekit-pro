import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWindView extends StatefulWidget {
  const WcaWindView({super.key});

  @override
  State<WcaWindView> createState() => _WcaWindViewState();
}

class _WcaWindViewState extends State<WcaWindView> {
  String selectedLocation = "Chicago, IL";
  String windUnit = "mph";
  bool isLoading = false;

  Map<String, dynamic> currentWind = {
    "speed": 18,
    "direction": "NW",
    "directionDegrees": 315,
    "gusts": 25,
    "beaufortScale": 5,
    "description": "Fresh Breeze",
    "icon": "💨",
    "lastUpdated": "4:30 PM",
  };

  List<Map<String, dynamic>> hourlyWind = [
    {"time": "Now", "speed": 18, "direction": "NW", "gusts": 25, "degrees": 315},
    {"time": "3 PM", "speed": 16, "direction": "NW", "gusts": 22, "degrees": 320},
    {"time": "4 PM", "speed": 20, "direction": "NW", "gusts": 28, "degrees": 310},
    {"time": "5 PM", "speed": 22, "direction": "N", "gusts": 30, "degrees": 300},
    {"time": "6 PM", "speed": 19, "direction": "N", "gusts": 26, "degrees": 295},
    {"time": "7 PM", "speed": 15, "direction": "NE", "gusts": 21, "degrees": 290},
    {"time": "8 PM", "speed": 12, "direction": "NE", "gusts": 18, "degrees": 285},
    {"time": "9 PM", "speed": 10, "direction": "E", "gusts": 15, "degrees": 280},
    {"time": "10 PM", "speed": 8, "direction": "E", "gusts": 12, "degrees": 275},
    {"time": "11 PM", "speed": 6, "direction": "SE", "gusts": 10, "degrees": 270},
  ];

  List<Map<String, dynamic>> dailyWind = [
    {"day": "Today", "avgSpeed": 18, "maxGust": 28, "direction": "NW"},
    {"day": "Tue", "avgSpeed": 22, "maxGust": 35, "direction": "N"},
    {"day": "Wed", "avgSpeed": 15, "maxGust": 24, "direction": "NE"},
    {"day": "Thu", "avgSpeed": 8, "maxGust": 14, "direction": "E"},
    {"day": "Fri", "avgSpeed": 12, "maxGust": 18, "direction": "SE"},
    {"day": "Sat", "avgSpeed": 16, "maxGust": 22, "direction": "S"},
    {"day": "Sun", "avgSpeed": 14, "maxGust": 20, "direction": "SW"},
  ];

  List<Map<String, dynamic>> beaufortScale = [
    {
      "scale": 0,
      "range": "0-1 mph",
      "description": "Calm",
      "landConditions": "Smoke rises vertically",
      "seaConditions": "Mirror-like sea",
      "color": "success",
    },
    {
      "scale": 1,
      "range": "1-3 mph",
      "description": "Light Air",
      "landConditions": "Smoke drifts slightly",
      "seaConditions": "Small ripples",
      "color": "success",
    },
    {
      "scale": 2,
      "range": "4-7 mph",
      "description": "Light Breeze",
      "landConditions": "Leaves rustle gently",
      "seaConditions": "Small wavelets",
      "color": "success",
    },
    {
      "scale": 3,
      "range": "8-12 mph",
      "description": "Gentle Breeze",
      "landConditions": "Leaves and twigs move",
      "seaConditions": "Large wavelets",
      "color": "info",
    },
    {
      "scale": 4,
      "range": "13-18 mph",
      "description": "Moderate Breeze",
      "landConditions": "Small branches move",
      "seaConditions": "Small waves",
      "color": "info",
    },
    {
      "scale": 5,
      "range": "19-24 mph",
      "description": "Fresh Breeze",
      "landConditions": "Small trees sway",
      "seaConditions": "Moderate waves",
      "color": "warning",
    },
    {
      "scale": 6,
      "range": "25-31 mph",
      "description": "Strong Breeze",
      "landConditions": "Large branches move",
      "seaConditions": "Large waves",
      "color": "warning",
    },
    {
      "scale": 7,
      "range": "32-38 mph",
      "description": "Near Gale",
      "landConditions": "Whole trees move",
      "seaConditions": "Sea heaps up",
      "color": "danger",
    },
    {
      "scale": 8,
      "range": "39-46 mph",
      "description": "Gale",
      "landConditions": "Twigs break off",
      "seaConditions": "Moderately high waves",
      "color": "danger",
    },
  ];

  List<Map<String, dynamic>> windEffects = [
    {
      "title": "Outdoor Activities",
      "current": "Challenging",
      "description": "Fresh breeze may affect outdoor activities",
      "icon": Icons.sports_soccer,
      "color": "warning",
    },
    {
      "title": "Air Quality",
      "current": "Good Dispersion",
      "description": "Wind helps disperse pollutants",
      "icon": Icons.air,
      "color": "success",
    },
    {
      "title": "Temperature Feel",
      "current": "Wind Chill Effect",
      "description": "Wind makes it feel cooler than actual temperature",
      "icon": Icons.thermostat,
      "color": "info",
    },
    {
      "title": "Driving Conditions",
      "current": "Use Caution",
      "description": "Strong winds may affect vehicle stability",
      "icon": Icons.directions_car,
      "color": "warning",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wind Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              windUnit = windUnit == "mph" ? "kmh" : "mph";
              setState(() {});
              si("Wind unit changed to $windUnit");
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
                        colors: [infoColor, primaryColor],
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
                                windUnit,
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
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Transform.rotate(
                                  angle: (currentWind["directionDegrees"] as int) * 3.14159 / 180,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spLg),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Wind Speed",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${_convertWindSpeed(currentWind["speed"])}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "From ${currentWind["direction"]}",
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
                            _buildWindInfo(
                              "Gusts",
                              "${_convertWindSpeed(currentWind["gusts"])}",
                              Icons.air,
                            ),
                            _buildWindInfo(
                              "Beaufort",
                              "Scale ${currentWind["beaufortScale"]}",
                              Icons.speed,
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentWind["description"]}",
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
                    "Hourly Wind Forecast",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QHorizontalScroll(
                    children: hourlyWind.map((hour) {
                      bool isNow = hour["time"] == "Now";
                      Color windColor = _getWindSpeedColor(hour["speed"]);
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
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: windColor.withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Transform.rotate(
                                  angle: (hour["degrees"] as int) * 3.14159 / 180,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: windColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${_convertWindSpeed(hour["speed"])}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isNow ? primaryColor : Colors.black,
                              ),
                            ),
                            Text(
                              "${hour["direction"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "G:${_convertWindSpeed(hour["gusts"])}",
                              style: TextStyle(
                                fontSize: 9,
                                color: windColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    "7-Day Wind Outlook",
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
                      children: dailyWind.map((day) {
                        bool isToday = day["day"] == "Today";
                        Color windColor = _getWindSpeedColor(day["avgSpeed"]);
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
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: windColor.withAlpha(20),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${day["direction"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: windColor,
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
                                          "Avg: ${_convertWindSpeed(day["avgSpeed"])}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: spMd),
                                        Text(
                                          "Gusts: ${_convertWindSpeed(day["maxGust"])}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: windColor,
                                            fontWeight: FontWeight.w600,
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
                    "Current Wind Effects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: windEffects.map((effect) {
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
                    "Beaufort Wind Scale",
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
                      children: beaufortScale.take(6).map((scale) {
                        Color scaleColor = _getColorFromString(scale["color"]);
                        bool isCurrent = scale["scale"] == currentWind["beaufortScale"];
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isCurrent ? scaleColor.withAlpha(20) : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isCurrent ? scaleColor.withAlpha(50) : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: scaleColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${scale["scale"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
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
                                          "${scale["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isCurrent ? scaleColor : Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${scale["range"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${scale["landConditions"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isCurrent)
                                Icon(
                                  Icons.radio_button_checked,
                                  color: scaleColor,
                                  size: 16,
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  QButton(
                    label: "Refresh Wind Data",
                    size: bs.md,
                    onPressed: () {
                      isLoading = true;
                      setState(() {});
                      Future.delayed(Duration(seconds: 2), () {
                        isLoading = false;
                        setState(() {});
                        ss("Wind data updated");
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildWindInfo(String label, String value, IconData icon) {
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

  String _convertWindSpeed(int mph) {
    if (windUnit == "kmh") {
      return "${(mph * 1.60934).round()} km/h";
    }
    return "$mph mph";
  }

  Color _getWindSpeedColor(int speed) {
    if (speed < 8) return successColor;
    if (speed < 19) return infoColor;
    if (speed < 32) return warningColor;
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
}
