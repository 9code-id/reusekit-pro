import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaTyphoonTrackerView extends StatefulWidget {
  const WcaTyphoonTrackerView({super.key});

  @override
  State<WcaTyphoonTrackerView> createState() => _WcaTyphoonTrackerViewState();
}

class _WcaTyphoonTrackerViewState extends State<WcaTyphoonTrackerView> {
  String selectedRegion = "Western Pacific";
  String trackingMode = "Real-time";
  bool showTrajectories = true;
  bool show3DModel = false;
  
  List<Map<String, dynamic>> regions = [
    {"label": "Western Pacific", "value": "Western Pacific"},
    {"label": "Northwest Pacific", "value": "Northwest Pacific"},
    {"label": "South Pacific", "value": "South Pacific"},
    {"label": "Indian Ocean", "value": "Indian Ocean"},
  ];

  List<Map<String, dynamic>> trackingModes = [
    {"label": "Real-time", "value": "Real-time"},
    {"label": "Forecast", "value": "Forecast"},
    {"label": "Historical", "value": "Historical"},
  ];

  List<Map<String, dynamic>> activeTyphoons = [
    {
      "name": "Super Typhoon Mawar",
      "intensity": "Super Typhoon",
      "category": 5,
      "maxWinds": 180,
      "pressure": 905,
      "latitude": 13.5,
      "longitude": 144.8,
      "direction": "Northwest",
      "speed": 20,
      "status": "Extremely Dangerous",
      "lastUpdate": "30 minutes ago",
      "threatLevel": "Extreme",
      "estimatedLandfall": "12 hours",
      "affectedAreas": ["Guam", "Saipan", "Philippines"],
    },
    {
      "name": "Typhoon Guchol",
      "intensity": "Typhoon",
      "category": 2,
      "maxWinds": 115,
      "pressure": 950,
      "latitude": 20.2,
      "longitude": 125.4,
      "direction": "North",
      "speed": 25,
      "status": "Major Typhoon",
      "lastUpdate": "1 hour ago",
      "threatLevel": "High",
      "estimatedLandfall": "36 hours",
      "affectedAreas": ["Taiwan", "Japan"],
    },
    {
      "name": "Tropical Storm Talim",
      "intensity": "Tropical Storm",
      "category": 0,
      "maxWinds": 75,
      "pressure": 985,
      "latitude": 15.8,
      "longitude": 120.2,
      "direction": "Northeast",
      "speed": 15,
      "status": "Tropical Storm",
      "lastUpdate": "45 minutes ago",
      "threatLevel": "Moderate",
      "estimatedLandfall": "24 hours",
      "affectedAreas": ["Philippines", "Hong Kong"],
    },
  ];

  List<Map<String, dynamic>> seasonalData = [
    {"month": "Jan", "count": 0},
    {"month": "Feb", "count": 1},
    {"month": "Mar", "count": 1},
    {"month": "Apr", "count": 2},
    {"month": "May", "count": 3},
    {"month": "Jun", "count": 4},
    {"month": "Jul", "count": 6},
    {"month": "Aug", "count": 8},
    {"month": "Sep", "count": 7},
    {"month": "Oct", "count": 5},
    {"month": "Nov", "count": 3},
    {"month": "Dec", "count": 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Typhoon Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.satellite),
            onPressed: () {
              show3DModel = !show3DModel;
              setState(() {});
              si(show3DModel ? "3D satellite view enabled" : "3D satellite view disabled");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Typhoon data refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCriticalAlert(),
            _buildTrackingControls(),
            _buildTyphoonMap(),
            _buildActiveTyphoons(),
            _buildIntensityChart(),
            _buildSeasonalActivity(),
            _buildWarningAreas(),
            _buildPreparationGuide(),
          ],
        ),
      ),
    );
  }

  Widget _buildCriticalAlert() {
    final superTyphoon = activeTyphoons[0];
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.purple.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: Colors.purple, width: 2),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.dangerous,
                color: Colors.purple,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SUPER TYPHOON ALERT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      "${superTyphoon["name"]} - Category ${superTyphoon["category"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "URGENT",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.purple.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Max Winds: ${superTyphoon["maxWinds"]} mph",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "Landfall: ${superTyphoon["estimatedLandfall"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: dangerColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "Affected: ${(superTyphoon["affectedAreas"] as List).join(", ")}",
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

  Widget _buildTrackingControls() {
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
            "Tracking Configuration",
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
                  label: "Region",
                  items: regions,
                  value: selectedRegion,
                  onChanged: (value, label) {
                    selectedRegion = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Mode",
                  items: trackingModes,
                  value: trackingMode,
                  onChanged: (value, label) {
                    trackingMode = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Trajectories",
                      "value": true,
                      "checked": showTrajectories,
                    }
                  ],
                  value: [
                    if (showTrajectories)
                      {"label": "Show Trajectories", "value": true, "checked": true}
                  ],
                  onChanged: (values, ids) {
                    showTrajectories = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              Icon(
                Icons.timeline,
                color: showTrajectories ? primaryColor : disabledBoldColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTyphoonMap() {
    return Container(
      height: 300,
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
              Icon(Icons.cyclone, color: Colors.purple),
              SizedBox(width: spSm),
              Text(
                "${selectedRegion} Typhoon Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (show3DModel)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "3D VIEW",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                  // Typhoon markers
                  ...activeTyphoons.map((typhoon) {
                    return Positioned(
                      left: ((typhoon["longitude"] as double) - 100) * 1.8,
                      top: (30 - (typhoon["latitude"] as double)) * 4,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _getTyphoonColor((typhoon["category"] as int)),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getTyphoonColor((typhoon["category"] as int)).withAlpha(120),
                              blurRadius: 12,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: typhoon["category"] == 0
                              ? Icon(
                                  Icons.storm,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Text(
                                  "${typhoon["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    );
                  }).toList(),
                  // Trajectory paths
                  if (showTrajectories)
                    ...activeTyphoons.take(2).map((typhoon) {
                      return Positioned(
                        left: ((typhoon["longitude"] as double) - 100) * 1.8,
                        top: (30 - (typhoon["latitude"] as double)) * 4,
                        child: Container(
                          width: 120,
                          height: 3,
                          decoration: BoxDecoration(
                            color: _getTyphoonColor((typhoon["category"] as int)).withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      );
                    }).toList(),
                  // Legend
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem("TS", Colors.blue),
                          _buildLegendItem("Cat 1-2", Colors.green),
                          _buildLegendItem("Cat 3-4", Colors.orange),
                          _buildLegendItem("Cat 5", Colors.purple),
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
        SizedBox(width: 4),
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

  Widget _buildActiveTyphoons() {
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
              Text(
                "Active Typhoons & Storms",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${activeTyphoons.length} Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          ...activeTyphoons.map((typhoon) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getTyphoonColor((typhoon["category"] as int)),
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: _getTyphoonColor((typhoon["category"] as int)),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: typhoon["category"] == 0
                              ? Text(
                                  "TS",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "${typhoon["category"]}",
                                  style: TextStyle(
                                    fontSize: 18,
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
                              "${typhoon["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${typhoon["intensity"]} • ${typhoon["maxWinds"]} mph",
                              style: TextStyle(
                                fontSize: 14,
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
                              color: _getThreatColor("${typhoon["threatLevel"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${typhoon["threatLevel"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getThreatColor("${typhoon["threatLevel"]}"),
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${typhoon["lastUpdate"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.speed, color: primaryColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Moving ${typhoon["direction"]} at ${typhoon["speed"]} mph",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: dangerColor, size: 16),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Threatens: ${(typhoon["affectedAreas"] as List).join(", ")}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.schedule, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Estimated landfall: ${typhoon["estimatedLandfall"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
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
        ],
      ),
    );
  }

  Widget _buildIntensityChart() {
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
            "Intensity Distribution",
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
                    color: Colors.blue.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Tropical Storm",
                        textAlign: TextAlign.center,
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
                    color: Colors.orange.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "Major Typhoon",
                        textAlign: TextAlign.center,
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
                    color: Colors.purple.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        "Super Typhoon",
                        textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  Widget _buildSeasonalActivity() {
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
            "2024 Typhoon Season Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: seasonalData.map((data) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: ((data["count"] as int) * 10).toDouble(),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${data["month"]}",
                          style: TextStyle(
                            fontSize: 8,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Text(
            "Peak season: July - October",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningAreas() {
    List<Map<String, dynamic>> warnings = [
      {"area": "Guam", "level": "Extreme", "population": "170K"},
      {"area": "Philippines", "level": "High", "population": "110M"},
      {"area": "Taiwan", "level": "High", "population": "23M"},
      {"area": "Japan", "level": "Moderate", "population": "125M"},
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
              Icon(Icons.warning, color: warningColor),
              SizedBox(width: spSm),
              Text(
                "Warning Areas",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...warnings.map((warning) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: _getThreatColor("${warning["level"]}").withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getThreatColor("${warning["level"]}"),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${warning["area"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Population: ${warning["population"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getThreatColor("${warning["level"]}"),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${warning["level"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPreparationGuide() {
    List<Map<String, dynamic>> preparationSteps = [
      {
        "icon": Icons.emergency,
        "title": "Emergency Kit",
        "description": "Water, food, medicines for 72 hours minimum",
      },
      {
        "icon": Icons.radio,
        "title": "Communication",
        "description": "Battery radio, charged phones, emergency contacts",
      },
      {
        "icon": Icons.home_repair_service,
        "title": "Home Protection",
        "description": "Secure windows, clear drains, check roof",
      },
      {
        "icon": Icons.directions_run,
        "title": "Evacuation Plan",
        "description": "Know routes, shelters, and family meeting points",
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
              Icon(Icons.checklist, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Typhoon Preparation Guide",
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
            children: preparationSteps.map((step) {
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
                      step["icon"] as IconData,
                      color: successColor,
                      size: 24,
                    ),
                    Text(
                      "${step["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${step["description"]}",
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

  Color _getTyphoonColor(int category) {
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
        return Colors.purple;
      case 'high':
        return dangerColor;
      case 'moderate':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
