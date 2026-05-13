import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaWidgetsView extends StatefulWidget {
  const WcaWidgetsView({super.key});

  @override
  State<WcaWidgetsView> createState() => _WcaWidgetsViewState();
}

class _WcaWidgetsViewState extends State<WcaWidgetsView> {
  String selectedCategory = "All";
  bool showPreview = true;

  List<Map<String, dynamic>> categories = [
    {"label": "All Widgets", "value": "All"},
    {"label": "Weather", "value": "Weather"},
    {"label": "Forecast", "value": "Forecast"},
    {"label": "Alerts", "value": "Alerts"},
    {"label": "Maps", "value": "Maps"},
    {"label": "Charts", "value": "Charts"},
  ];

  List<Map<String, dynamic>> widgets = [
    {
      "id": "current_weather",
      "name": "Current Weather",
      "description": "Display current weather conditions with temperature, humidity, and wind speed",
      "category": "Weather",
      "size": "Medium",
      "isActive": true,
      "location": "New York",
      "data": {
        "temperature": 22,
        "condition": "Sunny",
        "humidity": 65,
        "windSpeed": 8,
      },
      "customizable": true,
      "premium": false,
    },
    {
      "id": "daily_forecast",
      "name": "Daily Forecast",
      "description": "5-day weather forecast with high/low temperatures and conditions",
      "category": "Forecast",
      "size": "Large",
      "isActive": true,
      "location": "New York",
      "data": {
        "forecast": [
          {"day": "Today", "high": 24, "low": 16, "condition": "Sunny"},
          {"day": "Tomorrow", "high": 26, "low": 18, "condition": "Cloudy"},
          {"day": "Wed", "high": 23, "low": 15, "condition": "Rainy"},
        ]
      },
      "customizable": true,
      "premium": false,
    },
    {
      "id": "weather_alerts",
      "name": "Weather Alerts",
      "description": "Important weather warnings and alerts for your location",
      "category": "Alerts",
      "size": "Medium",
      "isActive": false,
      "location": "New York",
      "data": {
        "alerts": [
          {"type": "UV Warning", "level": "High"},
          {"type": "Air Quality", "level": "Moderate"},
        ]
      },
      "customizable": false,
      "premium": false,
    },
    {
      "id": "temperature_chart",
      "name": "Temperature Chart",
      "description": "24-hour temperature trend with hourly breakdown",
      "category": "Charts",
      "size": "Large",
      "isActive": true,
      "location": "New York",
      "data": {
        "hourlyTemp": [20, 21, 22, 23, 24, 25, 24, 23, 22, 21, 20, 19]
      },
      "customizable": true,
      "premium": true,
    },
    {
      "id": "weather_map",
      "name": "Weather Map",
      "description": "Interactive weather map with radar and satellite view",
      "category": "Maps",
      "size": "Large",
      "isActive": false,
      "location": "New York",
      "data": {
        "mapType": "radar",
        "layers": ["precipitation", "clouds"],
      },
      "customizable": true,
      "premium": true,
    },
    {
      "id": "air_quality",
      "name": "Air Quality Index",
      "description": "Real-time air quality monitoring and health recommendations",
      "category": "Weather",
      "size": "Small",
      "isActive": true,
      "location": "New York",
      "data": {
        "aqi": 45,
        "quality": "Good",
        "pm25": 12,
        "pm10": 18,
      },
      "customizable": false,
      "premium": false,
    },
    {
      "id": "sunrise_sunset",
      "name": "Sun & Moon",
      "description": "Sunrise, sunset times and moon phase information",
      "category": "Weather",
      "size": "Medium",
      "isActive": true,
      "location": "New York",
      "data": {
        "sunrise": "06:24",
        "sunset": "19:47",
        "moonPhase": "Waxing Crescent",
      },
      "customizable": false,
      "premium": false,
    },
    {
      "id": "precipitation_radar",
      "name": "Precipitation Radar",
      "description": "Live precipitation radar with 2-hour forecast",
      "category": "Maps",
      "size": "Large",
      "isActive": false,
      "location": "New York",
      "data": {
        "precipitation": 0,
        "forecast": [0, 10, 25, 40, 20, 5, 0],
      },
      "customizable": true,
      "premium": true,
    },
  ];

  void _toggleWidget(String widgetId) {
    int index = widgets.indexWhere((w) => w["id"] == widgetId);
    if (index != -1) {
      widgets[index]["isActive"] = !(widgets[index]["isActive"] as bool);
      setState(() {});
      
      if (widgets[index]["isActive"] as bool) {
        ss("${widgets[index]["name"]} widget activated");
      } else {
        ss("${widgets[index]["name"]} widget deactivated");
      }
    }
  }

  void _configureWidget(Map<String, dynamic> widget) {
    //navigateTo ('WcaWidgetSettingsView')
  }

  void _previewWidget(Map<String, dynamic> widget) {
    //navigateTo ('WcaHomeScreenWidgetView')
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Weather":
        return Icons.thermostat;
      case "Forecast":
        return Icons.schedule;
      case "Alerts":
        return Icons.warning;
      case "Maps":
        return Icons.map;
      case "Charts":
        return Icons.show_chart;
      default:
        return Icons.widgets;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Weather":
        return primaryColor;
      case "Forecast":
        return infoColor;
      case "Alerts":
        return warningColor;
      case "Maps":
        return successColor;
      case "Charts":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSizeColor(String size) {
    switch (size) {
      case "Small":
        return successColor;
      case "Medium":
        return warningColor;
      case "Large":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> get filteredWidgets {
    if (selectedCategory == "All") {
      return widgets;
    }
    return widgets.where((w) => w["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> activeWidgets = widgets.where((w) => w["isActive"] as bool).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen Widgets"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: () {
              //navigateTo ('WcaHomeScreenWidgetView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo ('WcaWidgetSettingsView')
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
                        "Widget Categories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Filter by Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show Widget Preview",
                        "value": true,
                        "checked": showPreview,
                      }
                    ],
                    value: [
                      if (showPreview)
                        {
                          "label": "Show Widget Preview",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showPreview = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Active Widgets Summary
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
                      Icon(Icons.dashboard, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Active Widgets (${activeWidgets.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Weather",
                          "${activeWidgets.where((w) => w["category"] == "Weather").length}",
                          Icons.thermostat,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Forecast",
                          "${activeWidgets.where((w) => w["category"] == "Forecast").length}",
                          Icons.schedule,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Charts",
                          "${activeWidgets.where((w) => w["category"] == "Charts").length}",
                          Icons.show_chart,
                          dangerColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Maps",
                          "${activeWidgets.where((w) => w["category"] == "Maps").length}",
                          Icons.map,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Widget List
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
                      Icon(Icons.widgets, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Available Widgets",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredWidgets.length} widgets",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredWidgets.map((widget) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (widget["isActive"] as bool) 
                          ? primaryColor.withAlpha(10) 
                          : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: (widget["isActive"] as bool)
                            ? primaryColor.withAlpha(30)
                            : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor("${widget["category"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getCategoryIcon("${widget["category"]}"),
                                  color: _getCategoryColor("${widget["category"]}"),
                                  size: 20,
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
                                          "${widget["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (widget["premium"] as bool) ...[
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: warningColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "PRO",
                                              style: TextStyle(
                                                color: warningColor,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      "${widget["description"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: widget["isActive"] as bool,
                                onChanged: (value) => _toggleWidget("${widget["id"]}"),
                                activeColor: primaryColor,
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor("${widget["category"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${widget["category"]}",
                                  style: TextStyle(
                                    color: _getCategoryColor("${widget["category"]}"),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getSizeColor("${widget["size"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${widget["size"]}",
                                  style: TextStyle(
                                    color: _getSizeColor("${widget["size"]}"),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                              SizedBox(width: 2),
                              Text(
                                "${widget["location"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              if (widget["customizable"] as bool)
                                Text(
                                  "Customizable",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),
                          
                          if (showPreview && (widget["isActive"] as bool))
                            Container(
                              margin: EdgeInsets.only(top: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: _buildWidgetPreview(widget),
                            ),
                          
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Configure",
                                  size: bs.sm,
                                  onPressed: (widget["customizable"] as bool) 
                                    ? () => _configureWidget(widget)
                                    : null,
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.preview,
                                size: bs.sm,
                                onPressed: () => _previewWidget(widget),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.info,
                                size: bs.sm,
                                onPressed: () {
                                  si("Widget: ${widget["name"]}\nCategory: ${widget["category"]}\nSize: ${widget["size"]}");
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

            // Quick Actions
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
                    "Quick Actions",
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
                        child: QButton(
                          label: "Enable All",
                          icon: Icons.check_circle,
                          size: bs.sm,
                          onPressed: () {
                            for (var widget in widgets) {
                              widget["isActive"] = true;
                            }
                            setState(() {});
                            ss("All widgets enabled");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Disable All",
                          icon: Icons.cancel,
                          size: bs.sm,
                          onPressed: () {
                            for (var widget in widgets) {
                              widget["isActive"] = false;
                            }
                            setState(() {});
                            ss("All widgets disabled");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Preview Home Screen",
                      icon: Icons.phone_android,
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo ('WcaHomeScreenWidgetView')
                      },
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

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetPreview(Map<String, dynamic> widget) {
    String widgetId = widget["id"] as String;
    Map<String, dynamic> data = widget["data"] as Map<String, dynamic>;
    
    switch (widgetId) {
      case "current_weather":
        return Column(
          children: [
            Text(
              "Current Weather Preview",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wb_sunny, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "${data["temperature"]}°C",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            Text(
              "${data["condition"]} • ${data["humidity"]}% humidity",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        );
        
      case "daily_forecast":
        List<dynamic> forecast = data["forecast"] as List<dynamic>;
        return Column(
          children: [
            Text(
              "Daily Forecast Preview",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: forecast.take(3).map((day) {
                return Column(
                  children: [
                    Text(
                      "${day["day"]}",
                      style: TextStyle(
                        fontSize: 8,
                        color: disabledBoldColor,
                      ),
                    ),
                    Icon(Icons.wb_sunny, color: warningColor, size: 16),
                    Text(
                      "${day["high"]}°",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
        
      case "air_quality":
        return Column(
          children: [
            Text(
              "Air Quality Preview",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.air, color: successColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "AQI: ${data["aqi"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
            Text(
              "${data["quality"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        );
        
      default:
        return Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getCategoryIcon("${widget["category"]}"),
                color: _getCategoryColor("${widget["category"]}"),
                size: 24,
              ),
              SizedBox(height: spXs),
              Text(
                "Widget Preview",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
    }
  }
}
