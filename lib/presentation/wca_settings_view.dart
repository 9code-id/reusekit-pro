import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaSettingsView extends StatefulWidget {
  const WcaSettingsView({super.key});

  @override
  State<WcaSettingsView> createState() => _WcaSettingsViewState();
}

class _WcaSettingsViewState extends State<WcaSettingsView> {
  bool pushNotifications = true;
  bool weatherAlerts = true;
  bool locationServices = true;
  bool backgroundRefresh = true;
  bool autoRefresh = true;
  bool preciseLocation = true;
  bool personalizedWeather = true;
  String temperatureUnit = "Celsius";
  String windSpeedUnit = "km/h";
  String pressureUnit = "hPa";
  String precipitationUnit = "mm";
  String distanceUnit = "km";
  String refreshInterval = "30";

  List<Map<String, dynamic>> temperatureItems = [
    {"label": "Celsius (°C)", "value": "Celsius"},
    {"label": "Fahrenheit (°F)", "value": "Fahrenheit"},
    {"label": "Kelvin (K)", "value": "Kelvin"},
  ];

  List<Map<String, dynamic>> windSpeedItems = [
    {"label": "Kilometers per hour (km/h)", "value": "km/h"},
    {"label": "Miles per hour (mph)", "value": "mph"},
    {"label": "Meters per second (m/s)", "value": "m/s"},
    {"label": "Knots", "value": "knots"},
  ];

  List<Map<String, dynamic>> pressureItems = [
    {"label": "Hectopascals (hPa)", "value": "hPa"},
    {"label": "Millibars (mb)", "value": "mb"},
    {"label": "Inches of Mercury (inHg)", "value": "inHg"},
    {"label": "Millimeters of Mercury (mmHg)", "value": "mmHg"},
  ];

  List<Map<String, dynamic>> precipitationItems = [
    {"label": "Millimeters (mm)", "value": "mm"},
    {"label": "Inches (in)", "value": "in"},
  ];

  List<Map<String, dynamic>> distanceItems = [
    {"label": "Kilometers (km)", "value": "km"},
    {"label": "Miles (mi)", "value": "mi"},
  ];

  List<Map<String, dynamic>> refreshItems = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "2 hours", "value": "120"},
    {"label": "Manual only", "value": "manual"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              // Reset to defaults
              si("Settings reset to default values");
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
            // General Settings Section
            Text(
              "General Settings",
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
                    label: "Auto Refresh",
                    items: [
                      {
                        "label": "Automatically refresh weather data",
                        "value": true,
                        "checked": autoRefresh,
                      }
                    ],
                    value: [
                      if (autoRefresh)
                        {
                          "label": "Automatically refresh weather data",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoRefresh = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Refresh Interval",
                    items: refreshItems,
                    value: refreshInterval,
                    onChanged: (value, label) {
                      refreshInterval = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Background Refresh",
                    items: [
                      {
                        "label": "Update weather data in background",
                        "value": true,
                        "checked": backgroundRefresh,
                      }
                    ],
                    value: [
                      if (backgroundRefresh)
                        {
                          "label": "Update weather data in background",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      backgroundRefresh = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Units Settings Section
            Text(
              "Units & Measurements",
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
                    label: "Temperature Unit",
                    items: temperatureItems,
                    value: temperatureUnit,
                    onChanged: (value, label) {
                      temperatureUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Wind Speed Unit",
                    items: windSpeedItems,
                    value: windSpeedUnit,
                    onChanged: (value, label) {
                      windSpeedUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Pressure Unit",
                    items: pressureItems,
                    value: pressureUnit,
                    onChanged: (value, label) {
                      pressureUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Precipitation Unit",
                    items: precipitationItems,
                    value: precipitationUnit,
                    onChanged: (value, label) {
                      precipitationUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Distance Unit",
                    items: distanceItems,
                    value: distanceUnit,
                    onChanged: (value, label) {
                      distanceUnit = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Privacy & Location Section
            Text(
              "Privacy & Location",
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
                    label: "Location Services",
                    items: [
                      {
                        "label": "Allow app to access your location",
                        "value": true,
                        "checked": locationServices,
                      }
                    ],
                    value: [
                      if (locationServices)
                        {
                          "label": "Allow app to access your location",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      locationServices = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Precise Location",
                    items: [
                      {
                        "label": "Use precise location for more accurate weather",
                        "value": true,
                        "checked": preciseLocation,
                      }
                    ],
                    value: [
                      if (preciseLocation)
                        {
                          "label": "Use precise location for more accurate weather",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      preciseLocation = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Personalized Weather",
                    items: [
                      {
                        "label": "Customize weather data based on your preferences",
                        "value": true,
                        "checked": personalizedWeather,
                      }
                    ],
                    value: [
                      if (personalizedWeather)
                        {
                          "label": "Customize weather data based on your preferences",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      personalizedWeather = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Notifications Section
            Text(
              "Notifications",
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
                    label: "Push Notifications",
                    items: [
                      {
                        "label": "Receive weather notifications",
                        "value": true,
                        "checked": pushNotifications,
                      }
                    ],
                    value: [
                      if (pushNotifications)
                        {
                          "label": "Receive weather notifications",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      pushNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Weather Alerts",
                    items: [
                      {
                        "label": "Receive severe weather alerts",
                        "value": true,
                        "checked": weatherAlerts,
                      }
                    ],
                    value: [
                      if (weatherAlerts)
                        {
                          "label": "Receive severe weather alerts",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      weatherAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Notification Settings",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(WcaNotificationSettingsView());
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Alert Preferences",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(WcaAlertPreferencesView());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // About & Support Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
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
                        "App Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Units Settings",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(WcaUnitsSettingsView());
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Data Sources",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo(WcaDataSourcesView());
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "About Weather App",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo(WcaAboutView());
                      },
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () {
                ss("Settings saved successfully!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
