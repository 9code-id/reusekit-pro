import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaVisibilityView extends StatefulWidget {
  const WcaVisibilityView({super.key});

  @override
  State<WcaVisibilityView> createState() => _WcaVisibilityViewState();
}

class _WcaVisibilityViewState extends State<WcaVisibilityView> {
  String selectedLocation = "New York, NY";
  bool isLoading = false;
  String selectedUnit = "Kilometers";

  List<Map<String, dynamic>> unitOptions = [
    {"label": "Kilometers", "value": "Kilometers"},
    {"label": "Miles", "value": "Miles"},
    {"label": "Nautical Miles", "value": "Nautical Miles"},
  ];

  Map<String, dynamic> visibilityData = {
    "current": 10.5,
    "status": "Excellent",
    "description": "Clear atmospheric conditions with excellent visibility",
    "lastUpdated": "5 minutes ago",
  };

  List<Map<String, dynamic>> visibilityLevels = [
    {
      "range": "0-1 km",
      "level": "Very Poor",
      "description": "Dense fog, heavy rain, or snow",
      "conditions": ["Dense fog", "Heavy snowfall", "Severe storms"],
      "color": Colors.red,
      "icon": Icons.visibility_off,
      "isCurrent": false,
    },
    {
      "range": "1-4 km",
      "level": "Poor",
      "description": "Fog, light rain, or haze",
      "conditions": ["Light fog", "Light rain", "Haze"],
      "color": Colors.orange,
      "icon": Icons.blur_on,
      "isCurrent": false,
    },
    {
      "range": "4-10 km",
      "level": "Moderate",
      "description": "Light haze or scattered clouds",
      "conditions": ["Light haze", "Scattered clouds", "Light mist"],
      "color": Colors.yellow,
      "icon": Icons.cloud,
      "isCurrent": false,
    },
    {
      "range": "10-20 km",
      "level": "Good",
      "description": "Clear with minimal atmospheric interference",
      "conditions": ["Clear skies", "Light clouds", "Good air quality"],
      "color": Colors.green,
      "icon": Icons.visibility,
      "isCurrent": true,
    },
    {
      "range": "20+ km",
      "level": "Excellent",
      "description": "Exceptional clarity and atmospheric conditions",
      "conditions": ["Perfect clarity", "Excellent air quality", "Optimal conditions"],
      "color": Colors.blue,
      "icon": Icons.remove_red_eye,
      "isCurrent": false,
    },
  ];

  List<Map<String, dynamic>> hourlyVisibility = [
    {
      "time": "Now",
      "hour": "14:00",
      "visibility": 10.5,
      "conditions": "Clear",
      "icon": Icons.visibility,
      "isNow": true,
    },
    {
      "time": "15:00",
      "hour": "15:00",
      "visibility": 9.8,
      "conditions": "Clear",
      "icon": Icons.visibility,
      "isNow": false,
    },
    {
      "time": "16:00",
      "hour": "16:00",
      "visibility": 8.2,
      "conditions": "Light Haze",
      "icon": Icons.blur_on,
      "isNow": false,
    },
    {
      "time": "17:00",
      "hour": "17:00",
      "visibility": 6.5,
      "conditions": "Haze",
      "icon": Icons.blur_on,
      "isNow": false,
    },
    {
      "time": "18:00",
      "hour": "18:00",
      "visibility": 4.2,
      "conditions": "Fog",
      "icon": Icons.cloud,
      "isNow": false,
    },
    {
      "time": "19:00",
      "hour": "19:00",
      "visibility": 2.8,
      "conditions": "Dense Fog",
      "icon": Icons.visibility_off,
      "isNow": false,
    },
  ];

  List<Map<String, dynamic>> factorsAffecting = [
    {
      "factor": "Weather Conditions",
      "impact": "High",
      "current": "Clear skies",
      "icon": Icons.wb_sunny,
      "color": Colors.green,
      "description": "No precipitation or fog present",
    },
    {
      "factor": "Air Quality",
      "impact": "Medium",
      "current": "Good (AQI: 42)",
      "icon": Icons.air,
      "color": Colors.green,
      "description": "Low pollution levels",
    },
    {
      "factor": "Humidity",
      "impact": "Low",
      "current": "65%",
      "icon": Icons.water_drop,
      "color": Colors.blue,
      "description": "Moderate humidity levels",
    },
    {
      "factor": "Wind Speed",
      "impact": "Low",
      "current": "12 km/h",
      "icon": Icons.air_sharp,
      "color": Colors.teal,
      "description": "Light breeze clearing atmosphere",
    },
    {
      "factor": "Temperature",
      "impact": "Low",
      "current": "22°C",
      "icon": Icons.thermostat,
      "color": Colors.orange,
      "description": "Stable temperature conditions",
    },
    {
      "factor": "Atmospheric Pressure",
      "impact": "Medium",
      "current": "1013 hPa",
      "icon": Icons.speed,
      "color": Colors.purple,
      "description": "Normal pressure levels",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visibility Conditions"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _showUnitsDialog();
            },
          ),
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () async {
              isLoading = true;
              setState(() {});
              await Future.delayed(Duration(seconds: 1));
              isLoading = false;
              setState(() {});
              ss("Visibility data updated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowLg],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          selectedLocation,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isLoading)
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      else
                        Text(
                          "${visibilityData["lastUpdated"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withAlpha(160),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${visibilityData["current"]} km",
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${visibilityData["status"]} Visibility",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                            Text(
                              "${visibilityData["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.visibility,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Hourly Visibility Forecast",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120,
                    child: QHorizontalScroll(
                      children: hourlyVisibility.map((hour) {
                        bool isNow = hour["isNow"];
                        double visibility = hour["visibility"];
                        Color visColor = _getVisibilityColor(visibility);
                        
                        return Container(
                          width: 100,
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isNow ? primaryColor.withAlpha(20) : Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusMd),
                            border: Border.all(
                              color: isNow ? primaryColor : disabledOutlineBorderColor,
                              width: isNow ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${hour["time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isNow ? FontWeight.bold : FontWeight.w600,
                                      color: isNow ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  if (!isNow)
                                    Text(
                                      "${hour["hour"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                              Icon(
                                hour["icon"],
                                size: 24,
                                color: visColor,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${visibility.toStringAsFixed(1)} km",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${hour["conditions"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: disabledBoldColor,
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bar_chart,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Visibility Scale",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: visibilityLevels.map((level) {
                      bool isCurrent = level["isCurrent"];
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCurrent ? (level["color"] as Color).withAlpha(20) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isCurrent ? level["color"] : disabledOutlineBorderColor,
                            width: isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (level["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                level["icon"],
                                size: 20,
                                color: level["color"],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${level["level"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${level["range"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: level["color"],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (isCurrent) ...[
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "CURRENT",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    "${level["description"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: 4,
                                    children: (level["conditions"] as List<String>).map((condition) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (level["color"] as Color).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          border: Border.all(
                                            color: (level["color"] as Color).withAlpha(50),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          condition,
                                          style: TextStyle(
                                            fontSize: 8,
                                            color: level["color"],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Factors Affecting Visibility",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: factorsAffecting.map((factor) {
                      Color impactColor = _getImpactColor(factor["impact"]);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (factor["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: (factor["color"] as Color).withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  factor["icon"],
                                  size: 16,
                                  color: factor["color"],
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${factor["factor"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: impactColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${factor["impact"]}",
                                    style: TextStyle(
                                      fontSize: 7,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${factor["current"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: factor["color"],
                              ),
                            ),
                            Text(
                              "${factor["description"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Visibility Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Visibility is the distance at which objects can be clearly identified. It's affected by weather conditions, air quality, and atmospheric particles. Current excellent visibility indicates ideal conditions for outdoor activities and travel.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getVisibilityColor(double visibility) {
    if (visibility >= 20) return Colors.blue;
    if (visibility >= 10) return Colors.green;
    if (visibility >= 4) return Colors.yellow[700]!;
    if (visibility >= 1) return Colors.orange;
    return Colors.red;
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showUnitsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Distance Unit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: unitOptions.map((option) {
              return RadioListTile<String>(
                title: Text("${option["label"]}"),
                value: option["value"],
                groupValue: selectedUnit,
                onChanged: (value) {
                  selectedUnit = value!;
                  setState(() {});
                  Navigator.pop(context);
                  ss("Units changed to $selectedUnit");
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
