import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaOceanConditionsView extends StatefulWidget {
  const WcaOceanConditionsView({super.key});

  @override
  State<WcaOceanConditionsView> createState() => _WcaOceanConditionsViewState();
}

class _WcaOceanConditionsViewState extends State<WcaOceanConditionsView> {
  String selectedRegion = "Pacific Northwest";
  String selectedDepth = "Surface";
  int selectedTimeframe = 24;

  List<Map<String, dynamic>> regions = [
    {"label": "Pacific Northwest", "value": "Pacific Northwest"},
    {"label": "California Coast", "value": "California Coast"},
    {"label": "Gulf of Mexico", "value": "Gulf of Mexico"},
    {"label": "Atlantic Coast", "value": "Atlantic Coast"},
    {"label": "Great Lakes", "value": "Great Lakes"},
  ];

  List<Map<String, dynamic>> depthLevels = [
    {"label": "Surface", "value": "Surface"},
    {"label": "10 meters", "value": "10 meters"},
    {"label": "50 meters", "value": "50 meters"},
    {"label": "100 meters", "value": "100 meters"},
    {"label": "200 meters", "value": "200 meters"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "12 Hours", "value": 12},
    {"label": "24 Hours", "value": 24},
    {"label": "48 Hours", "value": 48},
    {"label": "7 Days", "value": 168},
  ];

  List<Map<String, dynamic>> oceanMetrics = [
    {
      "title": "Water Temperature",
      "value": "64.2",
      "unit": "°F",
      "change": "+1.3°F",
      "status": "Normal",
      "color": primaryColor,
      "icon": Icons.thermostat,
    },
    {
      "title": "Salinity",
      "value": "34.5",
      "unit": "ppt",
      "change": "+0.2 ppt",
      "status": "Typical",
      "color": infoColor,
      "icon": Icons.water,
    },
    {
      "title": "Current Speed",
      "value": "0.8",
      "unit": "knots",
      "change": "-0.1 knots",
      "status": "Moderate",
      "color": successColor,
      "icon": Icons.timeline,
    },
    {
      "title": "Dissolved Oxygen",
      "value": "8.2",
      "unit": "mg/L",
      "change": "+0.3 mg/L",
      "status": "Good",
      "color": successColor,
      "icon": Icons.air,
    },
  ];

  List<Map<String, dynamic>> hourlyConditions = [
    {
      "time": "00:00",
      "temperature": 63.8,
      "currentSpeed": 0.7,
      "currentDirection": "SW",
      "visibility": "12 mi",
      "waveHeight": "2-3 ft",
    },
    {
      "time": "06:00",
      "temperature": 63.5,
      "currentSpeed": 0.9,
      "currentDirection": "W",
      "visibility": "15 mi",
      "waveHeight": "3-4 ft",
    },
    {
      "time": "12:00",
      "temperature": 64.8,
      "currentSpeed": 1.1,
      "currentDirection": "NW",
      "visibility": "10 mi",
      "waveHeight": "4-5 ft",
    },
    {
      "time": "18:00",
      "temperature": 65.2,
      "currentSpeed": 0.8,
      "currentDirection": "N",
      "visibility": "8 mi",
      "waveHeight": "3-4 ft",
    },
  ];

  List<Map<String, dynamic>> marineLife = [
    {
      "species": "Pacific Salmon",
      "status": "Active",
      "depth": "10-30 meters",
      "likelihood": "High",
      "color": successColor,
      "icon": Icons.phishing,
    },
    {
      "species": "Dungeness Crab",
      "status": "Season Peak",
      "depth": "20-50 meters",
      "likelihood": "Excellent",
      "color": successColor,
      "icon": Icons.water_damage,
    },
    {
      "species": "Gray Whales",
      "status": "Migration",
      "depth": "Surface",
      "likelihood": "Moderate",
      "color": warningColor,
      "icon": Icons.waves,
    },
    {
      "species": "Sea Lions",
      "status": "Feeding",
      "depth": "Surface-20m",
      "likelihood": "High",
      "color": successColor,
      "icon": Icons.pets,
    },
  ];

  List<Map<String, dynamic>> environmentalAlerts = [
    {
      "type": "Harmful Algal Bloom",
      "severity": "Advisory",
      "location": "Coastal Areas",
      "description": "Elevated algae levels detected in nearshore waters",
      "impact": "May affect shellfish harvesting",
      "color": warningColor,
      "icon": Icons.warning,
    },
    {
      "type": "Water Quality",
      "severity": "Notice",
      "location": "Bay Area",
      "description": "Slightly elevated turbidity due to recent storms",
      "impact": "Reduced underwater visibility",
      "color": infoColor,
      "icon": Icons.info,
    },
  ];

  List<Map<String, dynamic>> oceanCurrents = [
    {
      "layer": "Surface Current",
      "direction": "Northwest",
      "speed": "1.2 knots",
      "temperature": "64.2°F",
      "depth": "0-10m",
    },
    {
      "layer": "Thermocline",
      "direction": "West",
      "speed": "0.6 knots",
      "temperature": "58.5°F",
      "depth": "10-50m",
    },
    {
      "layer": "Deep Current",
      "direction": "Southeast",
      "speed": "0.3 knots",
      "temperature": "45.8°F",
      "depth": "50-200m",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ocean Conditions"),
        actions: [
          IconButton(
            icon: Icon(Icons.satellite_alt),
            onPressed: () {
              si("Satellite imagery view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing ocean data...");
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
                  colors: [
                    infoColor.withAlpha(20),
                    successColor.withAlpha(20),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.waves,
                    color: infoColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ocean Monitoring System",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Real-time oceanographic data and marine environment monitoring",
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
                    label: "Depth Level",
                    items: depthLevels,
                    value: selectedDepth,
                    onChanged: (value, label) {
                      selectedDepth = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            if (environmentalAlerts.isNotEmpty) ...[
              Text(
                "Environmental Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),

              Column(
                spacing: spSm,
                children: environmentalAlerts.map((alert) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: alert["color"].withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: alert["color"].withAlpha(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              alert["icon"],
                              color: alert["color"],
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${alert["type"]} - ${alert["severity"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: alert["color"],
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${alert["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${alert["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Impact: ${alert["impact"]}",
                          style: TextStyle(
                            color: alert["color"],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            Text(
              "Current Ocean Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: oceanMetrics.map((metric) {
                return Container(
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
                            metric["icon"],
                            color: metric["color"],
                            size: 24,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: metric["color"].withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${metric["change"]}",
                              style: TextStyle(
                                color: metric["color"],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${metric["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: metric["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${metric["status"]}",
                          style: TextStyle(
                            color: metric["color"],
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

            Text(
              "Ocean Current Layers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: oceanCurrents.map((current) {
                return Container(
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
                          Text(
                            "${current["layer"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${current["depth"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Direction: ${current["direction"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Speed: ${current["speed"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${current["temperature"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
              "24-Hour Conditions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: hourlyConditions.map((condition) {
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${condition["time"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          fontSize: fsH6,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.thermostat,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["temperature"]}°F",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.timeline,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["currentSpeed"]} ${condition["currentDirection"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: successColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["visibility"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.waves,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${condition["waveHeight"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
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
              "Marine Life Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: marineLife.map((life) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: life["color"],
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        life["icon"],
                        color: life["color"],
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${life["species"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: life["color"].withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${life["likelihood"]}",
                                    style: TextStyle(
                                      color: life["color"],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Status: ${life["status"]} • Depth: ${life["depth"]}",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Sources",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Ocean data collected from NOAA buoys, satellite imagery, and research vessels. Updated every 3 hours.",
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
    );
  }
}
