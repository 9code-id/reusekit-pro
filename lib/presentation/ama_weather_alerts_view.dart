import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaWeatherAlertsView extends StatefulWidget {
  const AmaWeatherAlertsView({super.key});

  @override
  State<AmaWeatherAlertsView> createState() => _AmaWeatherAlertsViewState();
}

class _AmaWeatherAlertsViewState extends State<AmaWeatherAlertsView> {
  int selectedSeverity = 0;
  bool showActiveOnly = true;
  
  List<Map<String, dynamic>> weatherAlerts = [
    {
      "id": "WA001",
      "title": "Heavy Rain Warning",
      "description": "Heavy rainfall expected for the next 48 hours. Consider postponing field operations.",
      "severity": "High",
      "severityColor": Colors.red,
      "type": "Rain",
      "location": "North Field",
      "startTime": "2024-06-15 14:00",
      "endTime": "2024-06-17 18:00",
      "isActive": true,
      "recommendations": [
        "Avoid harvesting activities",
        "Secure loose equipment",
        "Check drainage systems"
      ],
      "temperature": "22°C - 28°C",
      "humidity": "85%",
      "windSpeed": "45 km/h",
      "precipitation": "75mm"
    },
    {
      "id": "WA002", 
      "title": "Frost Alert",
      "description": "Temperature expected to drop below 2°C tonight. Protect sensitive crops.",
      "severity": "Critical",
      "severityColor": Colors.purple,
      "type": "Temperature",
      "location": "South Field",
      "startTime": "2024-06-15 22:00",
      "endTime": "2024-06-16 08:00",
      "isActive": true,
      "recommendations": [
        "Cover vulnerable plants",
        "Run irrigation if available",
        "Monitor greenhouse temperatures"
      ],
      "temperature": "-1°C - 5°C",
      "humidity": "92%",
      "windSpeed": "12 km/h",
      "precipitation": "0mm"
    },
    {
      "id": "WA003",
      "title": "Strong Wind Advisory",
      "description": "Wind speeds up to 60 km/h expected. Secure equipment and structures.",
      "severity": "Medium",
      "severityColor": Colors.orange,
      "type": "Wind",
      "location": "All Fields",
      "startTime": "2024-06-16 10:00",
      "endTime": "2024-06-16 20:00",
      "isActive": true,
      "recommendations": [
        "Secure greenhouse panels",
        "Postpone spraying operations",
        "Check fence stability"
      ],
      "temperature": "18°C - 25°C",
      "humidity": "65%",
      "windSpeed": "60 km/h",
      "precipitation": "5mm"
    },
    {
      "id": "WA004",
      "title": "Heat Wave Warning",
      "description": "Extreme temperatures above 38°C for next 3 days. Increase irrigation.",
      "severity": "High",
      "severityColor": Colors.red,
      "type": "Temperature",
      "location": "East Field",
      "startTime": "2024-06-17 09:00",
      "endTime": "2024-06-20 19:00",
      "isActive": false,
      "recommendations": [
        "Increase watering frequency",
        "Provide shade for livestock",
        "Work during cooler hours"
      ],
      "temperature": "38°C - 45°C",
      "humidity": "35%",
      "windSpeed": "15 km/h",
      "precipitation": "0mm"
    }
  ];

  List<Map<String, dynamic>> severityFilters = [
    {"label": "All Alerts", "value": "all"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"}
  ];

  List<Map<String, dynamic>> getFilteredAlerts() {
    List<Map<String, dynamic>> filtered = weatherAlerts;
    
    if (showActiveOnly) {
      filtered = filtered.where((alert) => alert["isActive"] as bool).toList();
    }
    
    if (selectedSeverity > 0) {
      String severityFilter = severityFilters[selectedSeverity]["value"];
      filtered = filtered.where((alert) => alert["severity"] == severityFilter).toList();
    }
    
    return filtered;
  }

  Color getSeverityColor(String severity) {
    switch (severity) {
      case "Critical":
        return Colors.purple;
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.blue;
      default:
        return primaryColor;
    }
  }

  IconData getWeatherIcon(String type) {
    switch (type) {
      case "Rain":
        return Icons.water_drop;
      case "Temperature":
        return Icons.thermostat;
      case "Wind":
        return Icons.air;
      case "Snow":
        return Icons.ac_unit;
      default:
        return Icons.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAlerts = getFilteredAlerts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notification settings
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh alerts
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.red.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weatherAlerts.where((a) => (a["isActive"] as bool) && a["severity"] == "Critical").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
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
                      border: Border.all(color: Colors.orange.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.priority_high,
                          color: Colors.orange,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weatherAlerts.where((a) => (a["isActive"] as bool) && (a["severity"] == "High" || a["severity"] == "Medium")).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange,
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${weatherAlerts.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters Section
            Text(
              "Filter Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityFilters,
                    value: severityFilters[selectedSeverity]["value"],
                    onChanged: (value, label) {
                      selectedSeverity = severityFilters.indexWhere((item) => item["value"] == value);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Active Only",
                        "value": true,
                        "checked": showActiveOnly,
                      }
                    ],
                    value: [
                      if (showActiveOnly)
                        {
                          "label": "Show Active Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showActiveOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Alerts List
            Text(
              "Weather Alerts (${filteredAlerts.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredAlerts.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No weather alerts match your criteria",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Your farm is currently safe from severe weather conditions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredAlerts.map((alert) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: alert["severityColor"] as Color,
                      ),
                    ),
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: (alert["severityColor"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        getWeatherIcon("${alert["type"]}"),
                        color: alert["severityColor"] as Color,
                        size: 24,
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${alert["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (alert["severityColor"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${alert["severity"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: alert["severityColor"] as Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spXs),
                        Text(
                          "${alert["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${alert["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (alert["isActive"] as bool) ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                (alert["isActive"] as bool) ? "Active" : "Inactive",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: (alert["isActive"] as bool) ? successColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Time Period
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Active Period",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${alert["startTime"]} - ${alert["endTime"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Weather Details
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thermostat,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${alert["temperature"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Temp",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.water_drop,
                                          color: Colors.cyan,
                                          size: 16,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${alert["humidity"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.air,
                                          color: Colors.green,
                                          size: 16,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${alert["windSpeed"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Wind",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: Colors.indigo.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.grain,
                                          color: Colors.indigo,
                                          size: 16,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "${alert["precipitation"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "Rain",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Recommendations
                            Text(
                              "Recommendations:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(alert["recommendations"] as List).map((rec) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      margin: EdgeInsets.only(top: 8, right: spXs),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        rec,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Acknowledge",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Acknowledge alert
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Share Alert",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Share alert with team
                                    },
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add custom alert
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
