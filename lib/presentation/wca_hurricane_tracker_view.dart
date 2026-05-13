import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaHurricaneTrackerView extends StatefulWidget {
  const WcaHurricaneTrackerView({super.key});

  @override
  State<WcaHurricaneTrackerView> createState() => _WcaHurricaneTrackerViewState();
}

class _WcaHurricaneTrackerViewState extends State<WcaHurricaneTrackerView> {
  String selectedBasin = "Atlantic";
  String trackingPeriod = "Current Season";
  bool showPaths = true;
  bool show3DView = false;
  
  List<Map<String, dynamic>> basins = [
    {"label": "Atlantic", "value": "Atlantic"},
    {"label": "Eastern Pacific", "value": "Eastern Pacific"},
    {"label": "Western Pacific", "value": "Western Pacific"},
    {"label": "Indian Ocean", "value": "Indian Ocean"},
    {"label": "Southern Hemisphere", "value": "Southern Hemisphere"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Current Season", "value": "Current Season"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Next 5 Days", "value": "Next 5 Days"},
  ];

  List<Map<String, dynamic>> activeHurricanes = [
    {
      "name": "Hurricane Ida",
      "category": 4,
      "maxWinds": 150,
      "pressure": 930,
      "latitude": 29.2,
      "longitude": -89.4,
      "direction": "North",
      "speed": 12,
      "status": "Major Hurricane",
      "lastUpdate": "2 hours ago",
      "threatLevel": "Extreme",
      "estimatedLandfall": "6 hours",
    },
    {
      "name": "Tropical Storm Julia",
      "category": 0,
      "maxWinds": 65,
      "pressure": 995,
      "latitude": 15.8,
      "longitude": -61.2,
      "direction": "Northwest",
      "speed": 18,
      "status": "Tropical Storm",
      "lastUpdate": "45 minutes ago",
      "threatLevel": "Moderate",
      "estimatedLandfall": "24 hours",
    },
    {
      "name": "Hurricane Karen",
      "category": 2,
      "maxWinds": 105,
      "pressure": 965,
      "latitude": 22.1,
      "longitude": -58.7,
      "direction": "Northeast",
      "speed": 15,
      "status": "Hurricane",
      "lastUpdate": "1 hour ago",
      "threatLevel": "High",
      "estimatedLandfall": "48 hours",
    },
  ];

  List<Map<String, dynamic>> seasonStats = [
    {"label": "Total Named Storms", "value": 18, "normal": 14},
    {"label": "Hurricanes", "value": 8, "normal": 7},
    {"label": "Major Hurricanes", "value": 4, "normal": 3},
    {"label": "Landfalls", "value": 6, "normal": 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hurricane Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Hurricane data updated");
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showAlertSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildActiveAlert(),
            _buildBasinSelector(),
            _buildHurricaneMap(),
            _buildActiveStorms(),
            _buildSeasonStatistics(),
            _buildStormDetails(),
            _buildSafetyInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAlert() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: dangerColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: dangerColor,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HURRICANE WARNING",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Category 4 Hurricane Ida approaching landfall",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Expected landfall in 6 hours • Winds 150 mph",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Details",
            size: bs.sm,
            onPressed: () {
              _showStormDetails(activeHurricanes[0]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBasinSelector() {
    return Container(
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
          Text(
            "Hurricane Basin",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Basin",
                  items: basins,
                  value: selectedBasin,
                  onChanged: (value, label) {
                    selectedBasin = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periods,
                  value: trackingPeriod,
                  onChanged: (value, label) {
                    trackingPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHurricaneMap() {
    return Container(
      height: 280,
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
              Icon(Icons.waves, color: dangerColor),
              SizedBox(width: spSm),
              Text(
                "${selectedBasin} Hurricane Tracking",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showPaths = !showPaths;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: showPaths ? primaryColor.withAlpha(20) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Paths",
                        style: TextStyle(
                          fontSize: 10,
                          color: showPaths ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  GestureDetector(
                    onTap: () {
                      show3DView = !show3DView;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: show3DView ? primaryColor.withAlpha(20) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "3D",
                        style: TextStyle(
                          fontSize: 10,
                          color: show3DView ? primaryColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Stack(
                children: [
                  // Hurricane markers
                  ...activeHurricanes.take(3).map((hurricane) {
                    return Positioned(
                      left: ((hurricane["longitude"] as double) + 90) * 2,
                      top: (35 - (hurricane["latitude"] as double)) * 3.5,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _getCategoryColor((hurricane["category"] as int)),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getCategoryColor((hurricane["category"] as int)).withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "${hurricane["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  // Hurricane paths (if enabled)
                  if (showPaths)
                    ...activeHurricanes.take(2).map((hurricane) {
                      return Positioned(
                        left: ((hurricane["longitude"] as double) + 90) * 2,
                        top: (35 - (hurricane["latitude"] as double)) * 3.5,
                        child: Container(
                          width: 100,
                          height: 2,
                          color: _getCategoryColor((hurricane["category"] as int)).withAlpha(120),
                        ),
                      );
                    }).toList(),
                  // Legend
                  Positioned(
                    bottom: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLegendItem("TS", Colors.blue),
                          SizedBox(width: spXs),
                          _buildLegendItem("1-2", Colors.yellow),
                          SizedBox(width: spXs),
                          _buildLegendItem("3-5", Colors.red),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveStorms() {
    return Container(
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
          Text(
            "Active Storms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activeHurricanes.map((hurricane) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getCategoryColor((hurricane["category"] as int)),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getCategoryColor((hurricane["category"] as int)),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: hurricane["category"] == 0
                          ? Text(
                              "TS",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "${hurricane["category"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${hurricane["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${hurricane["status"]} • ${hurricane["maxWinds"]} mph winds",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Moving ${hurricane["direction"]} at ${hurricane["speed"]} mph",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                          color: _getThreatColor("${hurricane["threatLevel"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${hurricane["threatLevel"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getThreatColor("${hurricane["threatLevel"]}"),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Landfall: ${hurricane["estimatedLandfall"]}",
                        style: TextStyle(
                          fontSize: 10,
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
    );
  }

  Widget _buildSeasonStatistics() {
    return Container(
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
          Text(
            "2024 Hurricane Season Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: seasonStats.map((stat) {
              bool isAboveNormal = (stat["value"] as int) > (stat["normal"] as int);
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isAboveNormal 
                      ? warningColor.withAlpha(20) 
                      : successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isAboveNormal ? warningColor : successColor,
                      ),
                    ),
                    Text(
                      "${stat["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Normal: ${stat["normal"]} (${isAboveNormal ? '+' : ''}${(stat["value"] as int) - (stat["normal"] as int)})",
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
        ],
      ),
    );
  }

  Widget _buildStormDetails() {
    final mainStorm = activeHurricanes[0];
    return Container(
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
          Text(
            "Storm Details - ${mainStorm["name"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${mainStorm["maxWinds"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Max Winds (mph)",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${mainStorm["pressure"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Pressure (mb)",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Position: ${mainStorm["latitude"]}°N, ${(mainStorm["longitude"] as double).abs()}°W",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.navigation, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Movement: ${mainStorm["direction"]} at ${mainStorm["speed"]} mph",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.update, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Last Update: ${mainStorm["lastUpdate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
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
  }

  Widget _buildSafetyInformation() {
    List<Map<String, dynamic>> safetyTips = [
      {
        "icon": Icons.home,
        "title": "Evacuation Planning",
        "description": "Know your evacuation zone and route",
      },
      {
        "icon": Icons.inventory,
        "title": "Emergency Kit",
        "description": "Prepare supplies for at least 3 days",
      },
      {
        "icon": Icons.power_off,
        "title": "Utility Safety",
        "description": "Turn off utilities if instructed",
      },
      {
        "icon": Icons.chat,
        "title": "Stay Informed",
        "description": "Monitor weather alerts and updates",
      },
    ];

    return Container(
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
              Icon(Icons.safety_check, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Hurricane Safety Tips",
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
            minItemWidth: 200,
            children: safetyTips.map((tip) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Icon(
                      tip["icon"] as IconData,
                      color: successColor,
                      size: 24,
                    ),
                    Text(
                      "${tip["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${tip["description"]}",
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
        ],
      ),
    );
  }

  Color _getCategoryColor(int category) {
    switch (category) {
      case 0:
        return Colors.blue; // Tropical Storm
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      case 5:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getThreatColor(String threat) {
    switch (threat.toLowerCase()) {
      case 'extreme':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'moderate':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showStormDetails(Map<String, dynamic> storm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${storm["name"]} Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category: ${storm["category"]}"),
            Text("Max Winds: ${storm["maxWinds"]} mph"),
            Text("Pressure: ${storm["pressure"]} mb"),
            Text("Status: ${storm["status"]}"),
            Text("Threat Level: ${storm["threatLevel"]}"),
            Text("Estimated Landfall: ${storm["estimatedLandfall"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _showAlertSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hurricane Alerts"),
        content: Text("Configure your hurricane alert preferences"),
        actions: [
          QButton(
            label: "Settings",
            size: bs.sm,
            onPressed: () {
              back();
              si("Alert settings");
            },
          ),
        ],
      ),
    );
  }
}
