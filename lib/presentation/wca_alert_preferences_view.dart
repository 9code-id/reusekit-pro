import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaAlertPreferencesView extends StatefulWidget {
  const WcaAlertPreferencesView({super.key});

  @override
  State<WcaAlertPreferencesView> createState() => _WcaAlertPreferencesViewState();
}

class _WcaAlertPreferencesViewState extends State<WcaAlertPreferencesView> {
  String temperatureThreshold = "40";
  String windSpeedThreshold = "50";
  String precipitationThreshold = "10";
  String uvIndexThreshold = "8";
  String aqiThreshold = "100";
  String humidityThreshold = "80";
  String pressureChangeThreshold = "10";
  String visibilityThreshold = "1";
  
  bool alertForHeat = true;
  bool alertForCold = true;
  bool alertForRain = true;
  bool alertForSnow = true;
  bool alertForWind = true;
  bool alertForFog = true;
  bool alertForStorm = true;
  bool alertForUV = true;
  bool alertForAirQuality = true;
  bool alertForHumidity = false;
  bool alertForPressure = false;
  bool alertForVisibility = true;
  
  String alertSeverity = "High";
  String alertDistance = "50";
  String alertAdvanceTime = "30";
  bool alertOnlyForCurrentLocation = true;
  bool alertForSavedLocations = false;
  bool alertDuringQuietHours = false;
  bool alertForMinorChanges = false;

  List<Map<String, dynamic>> severityItems = [
    {"label": "Critical Only", "value": "Critical"},
    {"label": "High Severity", "value": "High"},
    {"label": "Medium Severity", "value": "Medium"},
    {"label": "All Alerts", "value": "All"},
  ];

  List<Map<String, dynamic>> distanceItems = [
    {"label": "10 km", "value": "10"},
    {"label": "25 km", "value": "25"},
    {"label": "50 km", "value": "50"},
    {"label": "100 km", "value": "100"},
    {"label": "200 km", "value": "200"},
  ];

  List<Map<String, dynamic>> advanceTimeItems = [
    {"label": "Immediate", "value": "0"},
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "2 hours", "value": "120"},
  ];

  final List<Map<String, dynamic>> alertTypes = [
    {
      "icon": Icons.thermostat,
      "title": "Temperature Alerts",
      "subtitle": "Extreme heat and cold warnings",
      "color": Colors.orange,
      "enabled": true,
    },
    {
      "icon": Icons.air,
      "title": "Wind Alerts",
      "subtitle": "High wind speed warnings",
      "color": Colors.blue,
      "enabled": true,
    },
    {
      "icon": Icons.grain,
      "title": "Precipitation Alerts",
      "subtitle": "Rain and snow warnings",
      "color": Colors.cyan,
      "enabled": true,
    },
    {
      "icon": Icons.flash_on,
      "title": "Storm Alerts",
      "subtitle": "Thunderstorm and severe weather",
      "color": Colors.purple,
      "enabled": true,
    },
    {
      "icon": Icons.wb_sunny,
      "title": "UV Index Alerts",
      "subtitle": "High UV radiation warnings",
      "color": Colors.yellow,
      "enabled": true,
    },
    {
      "icon": Icons.masks,
      "title": "Air Quality Alerts",
      "subtitle": "Poor air quality warnings",
      "color": Colors.green,
      "enabled": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert Preferences"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            onPressed: () {
              si("Alert preferences reset to defaults");
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
            // Alert Types Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Alert Types",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Configure which types of weather alerts you want to receive",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Alert Types Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: alertTypes.map((alertType) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: alertType["enabled"] 
                          ? (alertType["color"] as Color).withAlpha(100)
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            alertType["icon"],
                            color: alertType["enabled"] 
                                ? alertType["color"] 
                                : disabledBoldColor,
                            size: 32,
                          ),
                          Spacer(),
                          Switch(
                            value: alertType["enabled"],
                            onChanged: (value) {
                              setState(() {
                                alertType["enabled"] = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        alertType["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: alertType["enabled"] 
                              ? primaryColor 
                              : disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        alertType["subtitle"],
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

            // Alert Thresholds Section
            Text(
              "Alert Thresholds",
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
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "High Temperature (°C)",
                          value: temperatureThreshold,
                          onChanged: (value) {
                            temperatureThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Wind Speed (km/h)",
                          value: windSpeedThreshold,
                          onChanged: (value) {
                            windSpeedThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Precipitation (mm/h)",
                          value: precipitationThreshold,
                          onChanged: (value) {
                            precipitationThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "UV Index",
                          value: uvIndexThreshold,
                          onChanged: (value) {
                            uvIndexThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QNumberField(
                          label: "Air Quality Index",
                          value: aqiThreshold,
                          onChanged: (value) {
                            aqiThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QNumberField(
                          label: "Visibility (km)",
                          value: visibilityThreshold,
                          onChanged: (value) {
                            visibilityThreshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Alert Settings Section
            Text(
              "Alert Settings",
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
                children: [
                  QDropdownField(
                    label: "Alert Severity Level",
                    items: severityItems,
                    value: alertSeverity,
                    onChanged: (value, label) {
                      alertSeverity = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Alert Distance Radius",
                    items: distanceItems,
                    value: alertDistance,
                    onChanged: (value, label) {
                      alertDistance = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Alert Advance Time",
                    items: advanceTimeItems,
                    value: alertAdvanceTime,
                    onChanged: (value, label) {
                      alertAdvanceTime = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Location-Based Alerts Section
            Text(
              "Location-Based Alerts",
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
                children: [
                  QSwitch(
                    label: "Current Location Alerts",
                    items: [
                      {
                        "label": "Receive alerts for your current location",
                        "value": true,
                        "checked": alertOnlyForCurrentLocation,
                      }
                    ],
                    value: [
                      if (alertOnlyForCurrentLocation)
                        {
                          "label": "Receive alerts for your current location",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      alertOnlyForCurrentLocation = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Saved Locations Alerts",
                    items: [
                      {
                        "label": "Receive alerts for all saved locations",
                        "value": true,
                        "checked": alertForSavedLocations,
                      }
                    ],
                    value: [
                      if (alertForSavedLocations)
                        {
                          "label": "Receive alerts for all saved locations",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      alertForSavedLocations = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Advanced Alert Options Section
            Text(
              "Advanced Options",
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
                children: [
                  QSwitch(
                    label: "Alerts During Quiet Hours",
                    items: [
                      {
                        "label": "Allow critical alerts during quiet hours",
                        "value": true,
                        "checked": alertDuringQuietHours,
                      }
                    ],
                    value: [
                      if (alertDuringQuietHours)
                        {
                          "label": "Allow critical alerts during quiet hours",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      alertDuringQuietHours = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Minor Weather Changes",
                    items: [
                      {
                        "label": "Receive alerts for minor weather changes",
                        "value": true,
                        "checked": alertForMinorChanges,
                      }
                    ],
                    value: [
                      if (alertForMinorChanges)
                        {
                          "label": "Receive alerts for minor weather changes",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      alertForMinorChanges = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Test Alert Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Test Your Alert Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Send a test notification to verify your alert preferences are working correctly",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Test Alert",
                      size: bs.sm,
                      onPressed: () {
                        ss("Test weather alert sent successfully!");
                      },
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Alert Preferences",
              size: bs.md,
              onPressed: () {
                ss("Alert preferences saved successfully!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
