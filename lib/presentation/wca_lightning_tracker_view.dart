import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaLightningTrackerView extends StatefulWidget {
  const WcaLightningTrackerView({super.key});

  @override
  State<WcaLightningTrackerView> createState() => _WcaLightningTrackerViewState();
}

class _WcaLightningTrackerViewState extends State<WcaLightningTrackerView> {
  String selectedRegion = "North America";
  String alertLevel = "Medium";
  bool soundAlerts = true;
  bool pushNotifications = true;
  
  List<Map<String, dynamic>> regions = [
    {"label": "North America", "value": "North America"},
    {"label": "Europe", "value": "Europe"},
    {"label": "Asia", "value": "Asia"},
    {"label": "Australia", "value": "Australia"},
    {"label": "South America", "value": "South America"},
  ];

  List<Map<String, dynamic>> lightningStrikes = [
    {
      "id": "L001",
      "timestamp": "14:32:15",
      "location": "Denver, CO",
      "latitude": 39.7392,
      "longitude": -104.9903,
      "intensity": "High",
      "distance": "2.3 km",
      "direction": "Northeast",
      "magnitude": 85000,
      "type": "Cloud-to-Ground",
    },
    {
      "id": "L002", 
      "timestamp": "14:31:42",
      "location": "Boulder, CO",
      "latitude": 40.0150,
      "longitude": -105.2705,
      "intensity": "Medium",
      "distance": "8.7 km",
      "direction": "North",
      "magnitude": 62000,
      "type": "Intra-Cloud",
    },
    {
      "id": "L003",
      "timestamp": "14:30:58",
      "location": "Aurora, CO", 
      "latitude": 39.7294,
      "longitude": -104.8319,
      "intensity": "High",
      "distance": "5.1 km",
      "direction": "Southeast",
      "magnitude": 78000,
      "type": "Cloud-to-Ground",
    },
    {
      "id": "L004",
      "timestamp": "14:29:33",
      "location": "Thornton, CO",
      "latitude": 39.8681,
      "longitude": -104.9722,
      "intensity": "Low",
      "distance": "12.4 km",
      "direction": "Northwest",
      "magnitude": 35000,
      "type": "Cloud-to-Cloud",
    },
    {
      "id": "L005",
      "timestamp": "14:28:07",
      "location": "Westminster, CO",
      "latitude": 39.8367,
      "longitude": -105.0372,
      "intensity": "Very High",
      "distance": "1.8 km",
      "direction": "West",
      "magnitude": 95000,
      "type": "Cloud-to-Ground",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lightning Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAlertStatus(),
            _buildRegionSelector(),
            _buildLightningMap(),
            _buildRealTimeStats(),
            _buildRecentStrikes(),
            _buildSafetyTips(),
            _buildThreatLevel(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertStatus() {
    Color alertColor = _getAlertColor(alertLevel);
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: alertColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: alertColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: alertColor,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lightning Alert Level",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${alertLevel.toUpperCase()}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: alertColor,
                  ),
                ),
                Text(
                  "Active storms detected in your area",
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
              color: alertColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Text(
              "LIVE",
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
  }

  Widget _buildRegionSelector() {
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
            "Monitoring Region",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Region",
            items: regions,
            value: selectedRegion,
            onChanged: (value, label) {
              selectedRegion = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLightningMap() {
    return Container(
      height: 250,
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
              Icon(Icons.flash_on, color: warningColor),
              SizedBox(width: spSm),
              Text(
                "Lightning Activity Map",
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
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Auto-refresh: ON",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
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
                  // Lightning strike markers
                  ...lightningStrikes.take(3).map((strike) {
                    return Positioned(
                      left: ((strike["longitude"] as double) + 105) * 2.5,
                      top: (40 - (strike["latitude"] as double)) * 3,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getIntensityColor("${strike["intensity"]}"),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getIntensityColor("${strike["intensity"]}").withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.flash_on,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.my_location,
                          size: 24,
                          color: primaryColor,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${selectedRegion}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
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

  Widget _buildRealTimeStats() {
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
            "Real-Time Statistics",
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${lightningStrikes.length}",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Strikes/Hour",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "1.8km",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Closest Strike",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "95kA",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Peak Current",
                        style: TextStyle(
                          fontSize: 12,
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
                        "73%",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Cloud-to-Ground",
                        style: TextStyle(
                          fontSize: 12,
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

  Widget _buildRecentStrikes() {
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
                "Recent Lightning Strikes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  si("View all lightning strikes");
                },
              ),
            ],
          ),
          ...lightningStrikes.take(3).map((strike) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getIntensityColor("${strike["intensity"]}"),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: _getIntensityColor("${strike["intensity"]}"),
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${strike["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${strike["type"]} • ${strike["intensity"]} • ${strike["distance"]}",
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
                      Text(
                        "${strike["timestamp"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${((strike["magnitude"] as int) / 1000).toInt()}kA",
                        style: TextStyle(
                          fontSize: 12,
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

  Widget _buildSafetyTips() {
    List<Map<String, dynamic>> safetyTips = [
      {
        "icon": Icons.home,
        "title": "Stay Indoors",
        "description": "Remain inside buildings or hard-top vehicles",
      },
      {
        "icon": Icons.phone_android,
        "title": "Avoid Electronics",
        "description": "Stay away from corded phones and electrical equipment",
      },
      {
        "icon": Icons.water_drop,
        "title": "Avoid Water",
        "description": "Don't shower, bathe, or use plumbing during storms",
      },
      {
        "icon": Icons.nature,
        "title": "Avoid Open Areas",
        "description": "Stay away from fields, hills, and isolated trees",
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
              Icon(Icons.security, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Lightning Safety Tips",
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

  Widget _buildThreatLevel() {
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
            "Threat Assessment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildThreatIndicator("Low", Colors.green, false),
                    _buildThreatIndicator("Medium", Colors.orange, true),
                    _buildThreatIndicator("High", Colors.red, false),
                    _buildThreatIndicator("Extreme", Colors.purple, false),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: warningColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Medium threat level detected. Lightning activity is moderate with potential for dangerous strikes within 10km radius.",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreatIndicator(String label, Color color, bool isActive) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isActive ? color : disabledColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isActive ? color : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getAlertColor(String level) {
    switch (level.toLowerCase()) {
      case 'low':
        return successColor;
      case 'medium':
        return warningColor;
      case 'high':
        return dangerColor;
      default:
        return infoColor;
    }
  }

  Color _getIntensityColor(String intensity) {
    switch (intensity.toLowerCase()) {
      case 'very high':
        return Colors.purple;
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return infoColor;
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Lightning Tracker Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QSwitch(
              items: [
                {
                  "label": "Sound Alerts",
                  "value": true,
                  "checked": soundAlerts,
                }
              ],
              value: [
                if (soundAlerts)
                  {"label": "Sound Alerts", "value": true, "checked": true}
              ],
              onChanged: (values, ids) {
                soundAlerts = values.isNotEmpty;
                setState(() {});
              },
            ),
            SizedBox(height: spSm),
            QSwitch(
              items: [
                {
                  "label": "Push Notifications",
                  "value": true,
                  "checked": pushNotifications,
                }
              ],
              value: [
                if (pushNotifications)
                  {"label": "Push Notifications", "value": true, "checked": true}
              ],
              onChanged: (values, ids) {
                pushNotifications = values.isNotEmpty;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Settings saved");
            },
          ),
        ],
      ),
    );
  }
}
