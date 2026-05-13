import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaCycloneTrackerView extends StatefulWidget {
  const WcaCycloneTrackerView({super.key});

  @override
  State<WcaCycloneTrackerView> createState() => _WcaCycloneTrackerViewState();
}

class _WcaCycloneTrackerViewState extends State<WcaCycloneTrackerView> {
  String selectedRegion = "Atlantic";
  String selectedPeriod = "Active Season";
  bool showPath = true;
  bool showIntensity = true;

  List<Map<String, dynamic>> regions = [
    {"label": "Atlantic", "value": "Atlantic"},
    {"label": "Pacific", "value": "Pacific"},
    {"label": "Indian Ocean", "value": "Indian Ocean"},
    {"label": "Western Pacific", "value": "Western Pacific"},
  ];

  List<Map<String, dynamic>> periods = [
    {"label": "Active Season", "value": "Active Season"},
    {"label": "Historical", "value": "Historical"},
    {"label": "Past 7 Days", "value": "Past 7 Days"},
    {"label": "Past 30 Days", "value": "Past 30 Days"},
  ];

  List<Map<String, dynamic>> activeCyclones = [
    {
      "name": "Hurricane Maya",
      "category": "Category 3",
      "windSpeed": 185,
      "location": "23.5°N, 78.2°W",
      "movement": "NNW at 12 mph",
      "pressure": 945,
      "status": "active",
      "lastUpdate": "2025-06-16T14:30:00Z",
      "coordinates": [
        {"lat": 20.5, "lng": -75.2},
        {"lat": 21.8, "lng": -76.5},
        {"lat": 23.5, "lng": -78.2},
      ]
    },
    {
      "name": "Tropical Storm Nora",
      "category": "Tropical Storm",
      "windSpeed": 95,
      "location": "18.2°N, 82.5°W",
      "movement": "W at 8 mph",
      "pressure": 995,
      "status": "weakening",
      "lastUpdate": "2025-06-16T12:00:00Z",
      "coordinates": [
        {"lat": 17.0, "lng": -80.0},
        {"lat": 17.8, "lng": -81.2},
        {"lat": 18.2, "lng": -82.5},
      ]
    },
    {
      "name": "Cyclone Omar",
      "category": "Category 1",
      "windSpeed": 140,
      "location": "15.8°S, 165.2°E",
      "movement": "S at 15 mph",
      "pressure": 975,
      "status": "strengthening",
      "lastUpdate": "2025-06-16T13:15:00Z",
      "coordinates": [
        {"lat": -13.5, "lng": 163.8},
        {"lat": -14.8, "lng": 164.5},
        {"lat": -15.8, "lng": 165.2},
      ]
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Category 5":
        return dangerColor;
      case "Category 4":
        return Color(0xFFFF6B35);
      case "Category 3":
        return warningColor;
      case "Category 2":
        return Color(0xFFFFD23F);
      case "Category 1":
        return infoColor;
      case "Tropical Storm":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return dangerColor;
      case "strengthening":
        return warningColor;
      case "weakening":
        return infoColor;
      case "dissipated":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cyclone Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Cyclone data refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo ('WcaCycloneAlertsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filter Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tune, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Tracking Filters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
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
                          label: "Time Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
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
                              "label": "Show Path",
                              "value": true,
                              "checked": showPath,
                            }
                          ],
                          value: [
                            if (showPath)
                              {
                                "label": "Show Path",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showPath = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Show Intensity",
                              "value": true,
                              "checked": showIntensity,
                            }
                          ],
                          value: [
                            if (showIntensity)
                              {
                                "label": "Show Intensity",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showIntensity = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Live Map Placeholder
            Container(
              height: 300,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 64,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Live Cyclone Map",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Real-time tracking of active cyclones",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Active Cyclones List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.cyclone, color: dangerColor),
                      SizedBox(width: spSm),
                      Text(
                        "Active Cyclones (${activeCyclones.length})",
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
                        child: Row(
                          children: [
                            Icon(Icons.circle, size: 8, color: dangerColor),
                            SizedBox(width: 4),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                color: dangerColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...activeCyclones.map((cyclone) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: _getCategoryColor("${cyclone["category"]}"),
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${cyclone["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${cyclone["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${cyclone["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    color: _getStatusColor("${cyclone["status"]}"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${cyclone["category"]}",
                                  style: TextStyle(
                                    color: _getCategoryColor("${cyclone["category"]}"),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${cyclone["windSpeed"]} mph",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${cyclone["location"]}",
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
                              Icon(Icons.navigation, size: 14, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${cyclone["movement"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${cyclone["pressure"]} mb",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Track Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo ('WcaCycloneDetailsView')
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.warning,
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo ('WcaCycloneAlertsView')
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.share,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Cyclone info shared");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Season Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Storms",
                          "18",
                          Icons.cyclone,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Major Hurricanes",
                          "7",
                          Icons.warning,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Currently Active",
                          "3",
                          Icons.circle,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Peak Wind",
                          "185 mph",
                          Icons.air,
                          infoColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
