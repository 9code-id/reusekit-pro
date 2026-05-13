import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWidgetSettingsView extends StatefulWidget {
  const WcaWidgetSettingsView({super.key});

  @override
  State<WcaWidgetSettingsView> createState() => _WcaWidgetSettingsViewState();
}

class _WcaWidgetSettingsViewState extends State<WcaWidgetSettingsView> {
  final formKey = GlobalKey<FormState>();
  
  // Widget Configuration
  String widgetName = "My Weather Widget";
  String selectedLocation = "current";
  String updateInterval = "30";
  String displayStyle = "detailed";
  String temperatureUnit = "celsius";
  String windUnit = "kmh";
  String pressureUnit = "hpa";
  bool showBackground = true;
  bool showIcon = true;
  bool showTemperature = true;
  bool showHumidity = true;
  bool showWindSpeed = false;
  bool showPressure = false;
  bool showUVIndex = false;
  bool showVisibility = false;
  bool enableNotifications = true;
  bool autoRefresh = true;
  bool useDarkTheme = false;
  bool showBorder = true;
  String backgroundOpacity = "80";
  String cornerRadius = "12";
  String fontSize = "medium";
  String iconSize = "medium";
  
  List<Map<String, dynamic>> locationOptions = [
    {"label": "Current Location", "value": "current"},
    {"label": "New York, USA", "value": "newyork"},
    {"label": "London, UK", "value": "london"},
    {"label": "Tokyo, Japan", "value": "tokyo"},
    {"label": "Sydney, Australia", "value": "sydney"},
    {"label": "Mumbai, India", "value": "mumbai"},
  ];
  
  List<Map<String, dynamic>> intervalOptions = [
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
    {"label": "3 hours", "value": "180"},
    {"label": "6 hours", "value": "360"},
  ];
  
  List<Map<String, dynamic>> styleOptions = [
    {"label": "Minimal", "value": "minimal"},
    {"label": "Compact", "value": "compact"},
    {"label": "Detailed", "value": "detailed"},
    {"label": "Extended", "value": "extended"},
  ];
  
  List<Map<String, dynamic>> unitOptions = [
    {"label": "Celsius", "value": "celsius"},
    {"label": "Fahrenheit", "value": "fahrenheit"},
    {"label": "Kelvin", "value": "kelvin"},
  ];
  
  List<Map<String, dynamic>> windUnitOptions = [
    {"label": "km/h", "value": "kmh"},
    {"label": "m/s", "value": "ms"},
    {"label": "mph", "value": "mph"},
    {"label": "knots", "value": "knots"},
  ];
  
  List<Map<String, dynamic>> pressureUnitOptions = [
    {"label": "hPa", "value": "hpa"},
    {"label": "mmHg", "value": "mmhg"},
    {"label": "inHg", "value": "inhg"},
    {"label": "bar", "value": "bar"},
  ];
  
  List<Map<String, dynamic>> opacityOptions = [
    {"label": "0%", "value": "0"},
    {"label": "20%", "value": "20"},
    {"label": "40%", "value": "40"},
    {"label": "60%", "value": "60"},
    {"label": "80%", "value": "80"},
    {"label": "100%", "value": "100"},
  ];
  
  List<Map<String, dynamic>> radiusOptions = [
    {"label": "0px", "value": "0"},
    {"label": "4px", "value": "4"},
    {"label": "8px", "value": "8"},
    {"label": "12px", "value": "12"},
    {"label": "16px", "value": "16"},
    {"label": "20px", "value": "20"},
  ];
  
  List<Map<String, dynamic>> sizeOptions = [
    {"label": "Small", "value": "small"},
    {"label": "Medium", "value": "medium"},
    {"label": "Large", "value": "large"},
  ];

  void _saveWidgetSettings() {
    if (formKey.currentState!.validate()) {
      // Simulate saving widget configuration
      ss("Widget settings saved successfully");
      
      // Navigate back with saved configuration
      //navigateTo(WcaWidgetsView);
    }
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all settings to default values?");
    if (isConfirmed) {
      setState(() {
        widgetName = "My Weather Widget";
        selectedLocation = "current";
        updateInterval = "30";
        displayStyle = "detailed";
        temperatureUnit = "celsius";
        windUnit = "kmh";
        pressureUnit = "hpa";
        showBackground = true;
        showIcon = true;
        showTemperature = true;
        showHumidity = true;
        showWindSpeed = false;
        showPressure = false;
        showUVIndex = false;
        showVisibility = false;
        enableNotifications = true;
        autoRefresh = true;
        useDarkTheme = false;
        showBorder = true;
        backgroundOpacity = "80";
        cornerRadius = "12";
        fontSize = "medium";
        iconSize = "medium";
      });
      si("Settings reset to default values");
    }
  }

  Widget _buildPreviewWidget() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: useDarkTheme ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(double.parse(cornerRadius)),
        border: showBorder ? Border.all(color: disabledOutlineBorderColor) : null,
        boxShadow: [shadowSm],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: showBackground 
            ? (useDarkTheme ? Colors.black : primaryColor).withAlpha((double.parse(backgroundOpacity) * 2.55).toInt())
            : Colors.transparent,
          borderRadius: BorderRadius.circular(double.parse(cornerRadius)),
        ),
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (showIcon) ...[
                  Icon(
                    Icons.wb_sunny,
                    size: iconSize == "small" ? 16 : iconSize == "medium" ? 20 : 24,
                    color: useDarkTheme ? Colors.white : Colors.black87,
                  ),
                  SizedBox(width: spXs),
                ],
                Expanded(
                  child: Text(
                    selectedLocation == "current" ? "Current Location" : locationOptions.firstWhere((loc) => loc["value"] == selectedLocation)["label"],
                    style: TextStyle(
                      fontSize: fontSize == "small" ? 12 : fontSize == "medium" ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: useDarkTheme ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            if (showTemperature) ...[
              Text(
                temperatureUnit == "celsius" ? "24°C" : temperatureUnit == "fahrenheit" ? "75°F" : "297K",
                style: TextStyle(
                  fontSize: fontSize == "small" ? 20 : fontSize == "medium" ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: useDarkTheme ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: spXs),
            ],
            Row(
              children: [
                if (showHumidity) ...[
                  Text(
                    "65%",
                    style: TextStyle(
                      fontSize: fontSize == "small" ? 10 : fontSize == "medium" ? 12 : 14,
                      color: useDarkTheme ? Colors.white70 : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                ],
                if (showWindSpeed) ...[
                  Text(
                    windUnit == "kmh" ? "15 km/h" : windUnit == "ms" ? "4.2 m/s" : windUnit == "mph" ? "9.3 mph" : "8.1 kn",
                    style: TextStyle(
                      fontSize: fontSize == "small" ? 10 : fontSize == "medium" ? 12 : 14,
                      color: useDarkTheme ? Colors.white70 : disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Preview Section
              Text(
                "Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              _buildPreviewWidget(),
              SizedBox(height: spMd),

              // Basic Configuration
              Text(
                "Basic Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QTextField(
                label: "Widget Name",
                value: widgetName,
                validator: Validator.required,
                onChanged: (value) {
                  widgetName = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Location",
                items: locationOptions,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Update Interval",
                items: intervalOptions,
                value: updateInterval,
                onChanged: (value, label) {
                  updateInterval = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Display Style",
                items: styleOptions,
                value: displayStyle,
                onChanged: (value, label) {
                  displayStyle = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Units Configuration
              Text(
                "Units Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Temperature Unit",
                items: unitOptions,
                value: temperatureUnit,
                onChanged: (value, label) {
                  temperatureUnit = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Wind Speed Unit",
                items: windUnitOptions,
                value: windUnit,
                onChanged: (value, label) {
                  windUnit = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Pressure Unit",
                items: pressureUnitOptions,
                value: pressureUnit,
                onChanged: (value, label) {
                  pressureUnit = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Display Options
              Text(
                "Display Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Show Background",
                    "value": "background",
                    "checked": showBackground,
                  },
                  {
                    "label": "Show Weather Icon",
                    "value": "icon",
                    "checked": showIcon,
                  },
                  {
                    "label": "Show Temperature",
                    "value": "temperature",
                    "checked": showTemperature,
                  },
                  {
                    "label": "Show Humidity",
                    "value": "humidity",
                    "checked": showHumidity,
                  },
                ],
                value: [
                  if (showBackground) {"label": "Show Background", "value": "background", "checked": true},
                  if (showIcon) {"label": "Show Weather Icon", "value": "icon", "checked": true},
                  if (showTemperature) {"label": "Show Temperature", "value": "temperature", "checked": true},
                  if (showHumidity) {"label": "Show Humidity", "value": "humidity", "checked": true},
                ],
                onChanged: (values, ids) {
                  setState(() {
                    showBackground = values.any((v) => v["value"] == "background");
                    showIcon = values.any((v) => v["value"] == "icon");
                    showTemperature = values.any((v) => v["value"] == "temperature");
                    showHumidity = values.any((v) => v["value"] == "humidity");
                  });
                },
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Show Wind Speed",
                    "value": "wind",
                    "checked": showWindSpeed,
                  },
                  {
                    "label": "Show Pressure",
                    "value": "pressure",
                    "checked": showPressure,
                  },
                  {
                    "label": "Show UV Index",
                    "value": "uv",
                    "checked": showUVIndex,
                  },
                  {
                    "label": "Show Visibility",
                    "value": "visibility",
                    "checked": showVisibility,
                  },
                ],
                value: [
                  if (showWindSpeed) {"label": "Show Wind Speed", "value": "wind", "checked": true},
                  if (showPressure) {"label": "Show Pressure", "value": "pressure", "checked": true},
                  if (showUVIndex) {"label": "Show UV Index", "value": "uv", "checked": true},
                  if (showVisibility) {"label": "Show Visibility", "value": "visibility", "checked": true},
                ],
                onChanged: (values, ids) {
                  setState(() {
                    showWindSpeed = values.any((v) => v["value"] == "wind");
                    showPressure = values.any((v) => v["value"] == "pressure");
                    showUVIndex = values.any((v) => v["value"] == "uv");
                    showVisibility = values.any((v) => v["value"] == "visibility");
                  });
                },
              ),
              SizedBox(height: spMd),

              // Appearance Settings
              Text(
                "Appearance Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Use Dark Theme",
                    "value": "dark",
                    "checked": useDarkTheme,
                  },
                  {
                    "label": "Show Border",
                    "value": "border",
                    "checked": showBorder,
                  },
                ],
                value: [
                  if (useDarkTheme) {"label": "Use Dark Theme", "value": "dark", "checked": true},
                  if (showBorder) {"label": "Show Border", "value": "border", "checked": true},
                ],
                onChanged: (values, ids) {
                  setState(() {
                    useDarkTheme = values.any((v) => v["value"] == "dark");
                    showBorder = values.any((v) => v["value"] == "border");
                  });
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Background Opacity",
                items: opacityOptions,
                value: backgroundOpacity,
                onChanged: (value, label) {
                  backgroundOpacity = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Corner Radius",
                items: radiusOptions,
                value: cornerRadius,
                onChanged: (value, label) {
                  cornerRadius = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Font Size",
                items: sizeOptions,
                value: fontSize,
                onChanged: (value, label) {
                  fontSize = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spSm),
              
              QDropdownField(
                label: "Icon Size",
                items: sizeOptions,
                value: iconSize,
                onChanged: (value, label) {
                  iconSize = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),

              // Advanced Settings
              Text(
                "Advanced Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Enable Notifications",
                    "value": "notifications",
                    "checked": enableNotifications,
                  },
                  {
                    "label": "Auto Refresh",
                    "value": "refresh",
                    "checked": autoRefresh,
                  },
                ],
                value: [
                  if (enableNotifications) {"label": "Enable Notifications", "value": "notifications", "checked": true},
                  if (autoRefresh) {"label": "Auto Refresh", "value": "refresh", "checked": true},
                ],
                onChanged: (values, ids) {
                  setState(() {
                    enableNotifications = values.any((v) => v["value"] == "notifications");
                    autoRefresh = values.any((v) => v["value"] == "refresh");
                  });
                },
              ),
              SizedBox(height: spMd),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Reset Defaults",
                      size: bs.md,
                      onPressed: _resetToDefaults,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    flex: 2,
                    child: QButton(
                      label: "Save Settings",
                      size: bs.md,
                      onPressed: _saveWidgetSettings,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
