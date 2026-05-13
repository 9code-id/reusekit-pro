import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaTemperatureMonitoringView extends StatefulWidget {
  const AmaTemperatureMonitoringView({super.key});

  @override
  State<AmaTemperatureMonitoringView> createState() => _AmaTemperatureMonitoringViewState();
}

class _AmaTemperatureMonitoringViewState extends State<AmaTemperatureMonitoringView> {
  String selectedTimeRange = "24h";
  String selectedSensor = "All Sensors";
  bool isRealTimeEnabled = true;
  double currentTemperature = 24.5;
  double avgTemperature = 23.2;
  double maxTemperature = 28.1;
  double minTemperature = 18.3;
  
  List<String> timeRanges = ["1h", "6h", "12h", "24h", "7d", "30d"];
  
  List<Map<String, dynamic>> temperatureSensors = [
    {
      "id": "sensor_001",
      "name": "Greenhouse Zone A",
      "location": "North Section",
      "current_temp": 24.5,
      "status": "online",
      "battery": 89,
      "last_update": "2024-11-22 10:30:00",
      "ideal_range": {"min": 20.0, "max": 26.0},
    },
    {
      "id": "sensor_002", 
      "name": "Greenhouse Zone B",
      "location": "South Section",
      "current_temp": 23.8,
      "status": "online",
      "battery": 76,
      "last_update": "2024-11-22 10:29:00",
      "ideal_range": {"min": 20.0, "max": 26.0},
    },
    {
      "id": "sensor_003",
      "name": "Outdoor Field 1",
      "location": "West Farm",
      "current_temp": 22.1,
      "status": "online",
      "battery": 92,
      "last_update": "2024-11-22 10:28:00",
      "ideal_range": {"min": 18.0, "max": 30.0},
    },
    {
      "id": "sensor_004",
      "name": "Storage Room",
      "location": "Main Building",
      "current_temp": 18.7,
      "status": "warning",
      "battery": 23,
      "last_update": "2024-11-22 09:45:00",
      "ideal_range": {"min": 15.0, "max": 20.0},
    },
    {
      "id": "sensor_005",
      "name": "Seedling Nursery",
      "location": "East Section",
      "current_temp": 26.3,
      "status": "alert",
      "battery": 67,
      "last_update": "2024-11-22 10:31:00",
      "ideal_range": {"min": 22.0, "max": 25.0},
    },
  ];

  List<Map<String, dynamic>> temperatureAlerts = [
    {
      "sensor_name": "Seedling Nursery",
      "alert_type": "High Temperature",
      "current_value": 26.3,
      "threshold": 25.0,
      "severity": "critical",
      "timestamp": "2024-11-22 10:31:00",
      "duration": "5 minutes",
    },
    {
      "sensor_name": "Storage Room",
      "alert_type": "Low Battery",
      "current_value": 23,
      "threshold": 25,
      "severity": "warning",
      "timestamp": "2024-11-22 09:45:00",
      "duration": "45 minutes",
    },
    {
      "sensor_name": "Greenhouse Zone A",
      "alert_type": "Temperature Spike",
      "current_value": 28.1,
      "threshold": 26.0,
      "severity": "medium",
      "timestamp": "2024-11-22 08:15:00",
      "duration": "Resolved",
    },
  ];

  List<Map<String, dynamic>> hourlyData = [
    {"time": "06:00", "temp": 18.5, "humidity": 65},
    {"time": "07:00", "temp": 19.2, "humidity": 63},
    {"time": "08:00", "temp": 21.1, "humidity": 60},
    {"time": "09:00", "temp": 23.4, "humidity": 58},
    {"time": "10:00", "temp": 24.5, "humidity": 55},
    {"time": "11:00", "temp": 25.8, "humidity": 52},
    {"time": "12:00", "temp": 27.2, "humidity": 48},
    {"time": "13:00", "temp": 28.1, "humidity": 45},
    {"time": "14:00", "temp": 27.9, "humidity": 47},
    {"time": "15:00", "temp": 26.7, "humidity": 50},
    {"time": "16:00", "temp": 25.3, "humidity": 53},
    {"time": "17:00", "temp": 23.8, "humidity": 57},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Monitoring"),
        actions: [
          IconButton(
            icon: Icon(
              isRealTimeEnabled ? Icons.pause : Icons.play_arrow,
              color: isRealTimeEnabled ? dangerColor : successColor,
            ),
            onPressed: () {
              isRealTimeEnabled = !isRealTimeEnabled;
              setState(() {});
              if (isRealTimeEnabled) {
                ss("Real-time monitoring enabled");
              } else {
                sw("Real-time monitoring paused");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Temperature monitoring settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Real-time Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isRealTimeEnabled ? successColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isRealTimeEnabled ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isRealTimeEnabled ? Icons.sensors : Icons.sensors_off,
                    color: isRealTimeEnabled ? successColor : warningColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      isRealTimeEnabled 
                        ? "Real-time monitoring active • Last update: ${DateTime.now().kkmm}"
                        : "Real-time monitoring paused",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isRealTimeEnabled ? successColor : warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Temperature Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildTempCard(
                    "Current",
                    "${currentTemperature.toStringAsFixed(1)}°C",
                    Icons.device_thermostat,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTempCard(
                    "Average",
                    "${avgTemperature.toStringAsFixed(1)}°C",
                    Icons.trending_flat,
                    infoColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: _buildTempCard(
                    "Maximum",
                    "${maxTemperature.toStringAsFixed(1)}°C",
                    Icons.trending_up,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildTempCard(
                    "Minimum",
                    "${minTemperature.toStringAsFixed(1)}°C",
                    Icons.trending_down,
                    successColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Time Range Selector
            Text(
              "Time Range",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(timeRanges.length, (index) {
                  final range = timeRanges[index];
                  final isSelected = selectedTimeRange == range;
                  
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: InkWell(
                      onTap: () {
                        selectedTimeRange = range;
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: isSelected ? [shadowSm] : null,
                        ),
                        child: Text(
                          range,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Temperature Chart Placeholder
            Container(
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
                    "Temperature Trend (${selectedTimeRange})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          color: primaryColor,
                          size: 48,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Temperature Chart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Real-time temperature data visualization",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Active Alerts
            Container(
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
                      Expanded(
                        child: Text(
                          "Active Alerts",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${temperatureAlerts.length}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(temperatureAlerts.length, (index) {
                    final alert = temperatureAlerts[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getAlertColor(alert["severity"]).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getAlertColor(alert["severity"]).withAlpha(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getAlertColor(alert["severity"]),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getAlertIcon(alert["alert_type"]),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alert["sensor_name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${alert["alert_type"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _getAlertColor(alert["severity"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Current: ${alert["current_value"]}${alert["alert_type"].contains("Temperature") ? "°C" : "%"} • Duration: ${alert["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getAlertColor(alert["severity"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${alert["severity"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Sensor Status List
            Container(
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
                    "Sensor Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(temperatureSensors.length, (index) {
                    final sensor = temperatureSensors[index];
                    final isInRange = (sensor["current_temp"] as double) >= (sensor["ideal_range"]["min"] as double) &&
                                     (sensor["current_temp"] as double) <= (sensor["ideal_range"]["max"] as double);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                        boxShadow: [shadowXs],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getSensorStatusColor(sensor["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.device_thermostat,
                              color: _getSensorStatusColor(sensor["status"]),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sensor["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${sensor["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _getSensorStatusColor(sensor["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${sensor["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: _getSensorStatusColor(sensor["status"]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.battery_full,
                                      size: 12,
                                      color: (sensor["battery"] as int) > 30 ? successColor : dangerColor,
                                    ),
                                    Text(
                                      "${sensor["battery"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: (sensor["battery"] as int) > 30 ? successColor : dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(sensor["current_temp"] as double).toStringAsFixed(1)}°C",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isInRange ? successColor : dangerColor,
                                ),
                              ),
                              Text(
                                "Range: ${(sensor["ideal_range"]["min"] as double).toStringAsFixed(1)}-${(sensor["ideal_range"]["max"] as double).toStringAsFixed(1)}°C",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Updated: ${DateTime.parse(sensor["last_update"]).kkmm}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              si("Sensor ${sensor["name"]} details");
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          si("Add new temperature sensor");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTempCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getAlertColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'warning':
        return warningColor;
      case 'medium':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getAlertIcon(String alertType) {
    if (alertType.contains("Temperature")) {
      return Icons.device_thermostat;
    } else if (alertType.contains("Battery")) {
      return Icons.battery_alert;
    } else {
      return Icons.warning;
    }
  }

  Color _getSensorStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
        return successColor;
      case 'warning':
        return warningColor;
      case 'alert':
        return dangerColor;
      case 'offline':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}
