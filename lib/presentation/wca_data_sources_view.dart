import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaDataSourcesView extends StatefulWidget {
  const WcaDataSourcesView({super.key});

  @override
  State<WcaDataSourcesView> createState() => _WcaDataSourcesViewState();
}

class _WcaDataSourcesViewState extends State<WcaDataSourcesView> {
  String primaryDataSource = "OpenWeatherMap";
  String backupDataSource = "AccuWeather";
  bool useMultipleSources = true;
  bool autoSwitchSources = true;
  bool showDataSourceInfo = false;
  String dataRefreshInterval = "15";
  String forecastAccuracy = "High";
  bool enableLocalStations = true;
  bool useSatelliteData = true;
  bool useRadarData = true;

  final List<Map<String, dynamic>> weatherSources = [
    {
      "name": "OpenWeatherMap",
      "description": "Global weather data provider with comprehensive coverage",
      "accuracy": "95%",
      "coverage": "Global",
      "updateFrequency": "10 minutes",
      "features": ["Current weather", "Hourly forecast", "7-day forecast", "Historical data"],
      "icon": Icons.cloud,
      "color": Colors.blue,
      "enabled": true,
    },
    {
      "name": "AccuWeather",
      "description": "Professional weather forecasting service with local expertise",
      "accuracy": "93%",
      "coverage": "Global",
      "updateFrequency": "15 minutes",
      "features": ["Current weather", "Extended forecast", "Severe weather alerts", "MinuteCast"],
      "icon": Icons.thunderstorm,
      "color": Colors.orange,
      "enabled": true,
    },
    {
      "name": "Weather Underground",
      "description": "Crowdsourced weather data with local weather stations",
      "accuracy": "91%",
      "coverage": "North America & Europe",
      "updateFrequency": "5 minutes",
      "features": ["Hyperlocal weather", "Personal weather stations", "Historical data"],
      "icon": Icons.terrain,
      "color": Colors.green,
      "enabled": false,
    },
    {
      "name": "National Weather Service",
      "description": "Official US government weather service",
      "accuracy": "96%",
      "coverage": "United States",
      "updateFrequency": "30 minutes",
      "features": ["Official forecasts", "Weather warnings", "Marine forecasts"],
      "icon": Icons.account_balance,
      "color": Colors.red,
      "enabled": false,
    },
    {
      "name": "Environment Canada",
      "description": "Official Canadian government weather service",
      "accuracy": "95%",
      "coverage": "Canada",
      "updateFrequency": "30 minutes",
      "features": ["Official forecasts", "Weather warnings", "Climate data"],
      "icon": Icons.flag,
      "color": Colors.redAccent,
      "enabled": false,
    },
    {
      "name": "Met Office",
      "description": "UK's national weather service",
      "accuracy": "94%",
      "coverage": "United Kingdom",
      "updateFrequency": "15 minutes",
      "features": ["UK forecasts", "Weather warnings", "Climate data"],
      "icon": Icons.umbrella,
      "color": Colors.indigo,
      "enabled": false,
    },
  ];

  List<Map<String, dynamic>> primarySourceItems = [
    {"label": "OpenWeatherMap", "value": "OpenWeatherMap"},
    {"label": "AccuWeather", "value": "AccuWeather"},
    {"label": "Weather Underground", "value": "WeatherUnderground"},
    {"label": "National Weather Service", "value": "NWS"},
  ];

  List<Map<String, dynamic>> refreshIntervalItems = [
    {"label": "5 minutes", "value": "5"},
    {"label": "10 minutes", "value": "10"},
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "1 hour", "value": "60"},
  ];

  List<Map<String, dynamic>> accuracyItems = [
    {"label": "High Accuracy", "value": "High"},
    {"label": "Balanced", "value": "Balanced"},
    {"label": "Fast Updates", "value": "Fast"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Sources"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing data source status...");
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
            // Data Sources Overview
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
                        Icons.cloud_sync,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Weather Data Sources",
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
                    "Configure which weather data providers to use for the most accurate and reliable weather information",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Available Data Sources
            Text(
              "Available Data Sources",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spSm,
              children: weatherSources.map((source) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: source["enabled"] 
                          ? (source["color"] as Color).withAlpha(100)
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            source["icon"],
                            color: source["enabled"] 
                                ? source["color"] 
                                : disabledBoldColor,
                            size: 32,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  source["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: source["enabled"] 
                                        ? primaryColor 
                                        : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  source["description"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: source["enabled"],
                            onChanged: (value) {
                              setState(() {
                                source["enabled"] = value;
                              });
                            },
                          ),
                        ],
                      ),
                      
                      if (source["enabled"]) ...[
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (source["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Accuracy",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      source["accuracy"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: source["color"],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (source["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Coverage",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      source["coverage"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: source["color"],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (source["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Updates",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      source["updateFrequency"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: source["color"],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        Text(
                          "Features:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          children: (source["features"] as List<String>).map((feature) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: (source["color"] as Color).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: source["color"],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            // Data Source Configuration
            Text(
              "Data Source Configuration",
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
                    label: "Primary Data Source",
                    items: primarySourceItems,
                    value: primaryDataSource,
                    onChanged: (value, label) {
                      primaryDataSource = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Backup Data Source",
                    items: primarySourceItems,
                    value: backupDataSource,
                    onChanged: (value, label) {
                      backupDataSource = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Use Multiple Sources",
                    items: [
                      {
                        "label": "Combine data from multiple sources for better accuracy",
                        "value": true,
                        "checked": useMultipleSources,
                      }
                    ],
                    value: [
                      if (useMultipleSources)
                        {
                          "label": "Combine data from multiple sources for better accuracy",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      useMultipleSources = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Auto-Switch Sources",
                    items: [
                      {
                        "label": "Automatically switch to backup source if primary fails",
                        "value": true,
                        "checked": autoSwitchSources,
                      }
                    ],
                    value: [
                      if (autoSwitchSources)
                        {
                          "label": "Automatically switch to backup source if primary fails",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoSwitchSources = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Data Quality Settings
            Text(
              "Data Quality Settings",
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
                    label: "Data Refresh Interval",
                    items: refreshIntervalItems,
                    value: dataRefreshInterval,
                    onChanged: (value, label) {
                      dataRefreshInterval = value;
                      setState(() {});
                    },
                  ),
                  
                  QDropdownField(
                    label: "Forecast Accuracy Mode",
                    items: accuracyItems,
                    value: forecastAccuracy,
                    onChanged: (value, label) {
                      forecastAccuracy = value;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Local Weather Stations",
                    items: [
                      {
                        "label": "Include data from local weather stations",
                        "value": true,
                        "checked": enableLocalStations,
                      }
                    ],
                    value: [
                      if (enableLocalStations)
                        {
                          "label": "Include data from local weather stations",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableLocalStations = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Satellite Data",
                    items: [
                      {
                        "label": "Use satellite imagery for weather analysis",
                        "value": true,
                        "checked": useSatelliteData,
                      }
                    ],
                    value: [
                      if (useSatelliteData)
                        {
                          "label": "Use satellite imagery for weather analysis",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      useSatelliteData = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  
                  QSwitch(
                    label: "Radar Data",
                    items: [
                      {
                        "label": "Include weather radar data for precipitation tracking",
                        "value": true,
                        "checked": useRadarData,
                      }
                    ],
                    value: [
                      if (useRadarData)
                        {
                          "label": "Include weather radar data for precipitation tracking",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      useRadarData = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Display Settings
            Text(
              "Display Settings",
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
              child: QSwitch(
                label: "Show Data Source Info",
                items: [
                  {
                    "label": "Display data source information in weather reports",
                    "value": true,
                    "checked": showDataSourceInfo,
                  }
                ],
                value: [
                  if (showDataSourceInfo)
                    {
                      "label": "Display data source information in weather reports",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  showDataSourceInfo = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),

            // Data Source Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Source Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "All selected data sources are currently online and providing accurate weather data",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Check Data Source Status",
                      size: bs.sm,
                      onPressed: () {
                        si("Checking data source connectivity...");
                      },
                    ),
                  ),
                ],
              ),
            ),

            QButton(
              label: "Save Data Source Settings",
              size: bs.md,
              onPressed: () {
                ss("Data source settings saved successfully!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
