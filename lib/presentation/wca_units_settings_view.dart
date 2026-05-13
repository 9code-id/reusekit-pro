import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaUnitsSettingsView extends StatefulWidget {
  const WcaUnitsSettingsView({super.key});

  @override
  State<WcaUnitsSettingsView> createState() => _WcaUnitsSettingsViewState();
}

class _WcaUnitsSettingsViewState extends State<WcaUnitsSettingsView> {
  String temperatureUnit = "Celsius";
  String windSpeedUnit = "km/h";
  String pressureUnit = "hPa";
  String precipitationUnit = "mm";
  String distanceUnit = "km";
  String visibilityUnit = "km";
  String timeFormat = "24";
  String dateFormat = "DD/MM/YYYY";
  bool useMetricSystem = true;
  bool showFeelsLike = true;
  bool showHumidity = true;
  bool showPressure = true;
  bool showWindDirection = true;
  bool showUVIndex = true;

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
    {"label": "Beaufort scale", "value": "beaufort"},
  ];

  List<Map<String, dynamic>> pressureItems = [
    {"label": "Hectopascals (hPa)", "value": "hPa"},
    {"label": "Millibars (mb)", "value": "mb"},
    {"label": "Inches of Mercury (inHg)", "value": "inHg"},
    {"label": "Millimeters of Mercury (mmHg)", "value": "mmHg"},
    {"label": "Kilopascals (kPa)", "value": "kPa"},
  ];

  List<Map<String, dynamic>> precipitationItems = [
    {"label": "Millimeters (mm)", "value": "mm"},
    {"label": "Inches (in)", "value": "in"},
    {"label": "Centimeters (cm)", "value": "cm"},
  ];

  List<Map<String, dynamic>> distanceItems = [
    {"label": "Kilometers (km)", "value": "km"},
    {"label": "Miles (mi)", "value": "mi"},
    {"label": "Meters (m)", "value": "m"},
    {"label": "Feet (ft)", "value": "ft"},
  ];

  List<Map<String, dynamic>> timeFormatItems = [
    {"label": "24-hour format", "value": "24"},
    {"label": "12-hour format", "value": "12"},
  ];

  List<Map<String, dynamic>> dateFormatItems = [
    {"label": "DD/MM/YYYY", "value": "DD/MM/YYYY"},
    {"label": "MM/DD/YYYY", "value": "MM/DD/YYYY"},
    {"label": "YYYY-MM-DD", "value": "YYYY-MM-DD"},
    {"label": "DD-MM-YYYY", "value": "DD-MM-YYYY"},
  ];

  void _setMetricUnits() {
    setState(() {
      temperatureUnit = "Celsius";
      windSpeedUnit = "km/h";
      pressureUnit = "hPa";
      precipitationUnit = "mm";
      distanceUnit = "km";
      visibilityUnit = "km";
      useMetricSystem = true;
    });
    ss("Switched to metric units");
  }

  void _setImperialUnits() {
    setState(() {
      temperatureUnit = "Fahrenheit";
      windSpeedUnit = "mph";
      pressureUnit = "inHg";
      precipitationUnit = "in";
      distanceUnit = "mi";
      visibilityUnit = "mi";
      useMetricSystem = false;
    });
    ss("Switched to imperial units");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Units & Measurements"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              _setMetricUnits();
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
            // Quick Setup Section
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
                  Text(
                    "Quick Setup",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Choose a preset to quickly configure all units",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Metric System",
                          size: bs.sm,
                          onPressed: _setMetricUnits,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Imperial System",
                          size: bs.sm,
                          onPressed: _setImperialUnits,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Temperature Section
            Text(
              "Temperature",
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
                  
                  QSwitch(
                    label: "Display Options",
                    items: [
                      {
                        "label": "Show 'Feels Like' temperature",
                        "value": true,
                        "checked": showFeelsLike,
                      }
                    ],
                    value: [
                      if (showFeelsLike)
                        {
                          "label": "Show 'Feels Like' temperature",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showFeelsLike = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Wind Section
            Text(
              "Wind",
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
                    label: "Wind Speed Unit",
                    items: windSpeedItems,
                    value: windSpeedUnit,
                    onChanged: (value, label) {
                      windSpeedUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Wind Direction",
                    items: [
                      {
                        "label": "Show wind direction compass",
                        "value": true,
                        "checked": showWindDirection,
                      }
                    ],
                    value: [
                      if (showWindDirection)
                        {
                          "label": "Show wind direction compass",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showWindDirection = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Pressure Section
            Text(
              "Atmospheric Pressure",
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
                    label: "Pressure Unit",
                    items: pressureItems,
                    value: pressureUnit,
                    onChanged: (value, label) {
                      pressureUnit = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Pressure Display",
                    items: [
                      {
                        "label": "Show atmospheric pressure readings",
                        "value": true,
                        "checked": showPressure,
                      }
                    ],
                    value: [
                      if (showPressure)
                        {
                          "label": "Show atmospheric pressure readings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showPressure = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Precipitation Section
            Text(
              "Precipitation",
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
              child: QDropdownField(
                label: "Precipitation Unit",
                items: precipitationItems,
                value: precipitationUnit,
                onChanged: (value, label) {
                  precipitationUnit = value;
                  setState(() {});
                },
              ),
            ),

            // Distance & Visibility Section
            Text(
              "Distance & Visibility",
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
              child: QDropdownField(
                label: "Distance Unit",
                items: distanceItems,
                value: distanceUnit,
                onChanged: (value, label) {
                  distanceUnit = value;
                  setState(() {});
                },
              ),
            ),

            // Time & Date Section
            Text(
              "Time & Date Format",
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
                    label: "Time Format",
                    items: timeFormatItems,
                    value: timeFormat,
                    onChanged: (value, label) {
                      timeFormat = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Date Format",
                    items: dateFormatItems,
                    value: dateFormat,
                    onChanged: (value, label) {
                      dateFormat = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Additional Display Options
            Text(
              "Additional Display Options",
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
                    label: "Humidity",
                    items: [
                      {
                        "label": "Show humidity percentage",
                        "value": true,
                        "checked": showHumidity,
                      }
                    ],
                    value: [
                      if (showHumidity)
                        {
                          "label": "Show humidity percentage",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showHumidity = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "UV Index",
                    items: [
                      {
                        "label": "Show UV index readings",
                        "value": true,
                        "checked": showUVIndex,
                      }
                    ],
                    value: [
                      if (showUVIndex)
                        {
                          "label": "Show UV index readings",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showUVIndex = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Unit Preferences",
              size: bs.md,
              onPressed: () {
                ss("Unit preferences saved successfully!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
