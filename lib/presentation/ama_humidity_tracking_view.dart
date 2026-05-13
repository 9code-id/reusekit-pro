import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaHumidityTrackingView extends StatefulWidget {
  const AmaHumidityTrackingView({super.key});

  @override
  State<AmaHumidityTrackingView> createState() => _AmaHumidityTrackingViewState();
}

class _AmaHumidityTrackingViewState extends State<AmaHumidityTrackingView> {
  String selectedTimeRange = "24h";
  String selectedZone = "All Zones";
  bool isAutoControlEnabled = true;
  double currentHumidity = 62.5;
  double avgHumidity = 58.7;
  double maxHumidity = 78.2;
  double minHumidity = 42.1;
  
  List<String> timeRanges = ["1h", "6h", "12h", "24h", "7d", "30d"];
  List<String> zones = ["All Zones", "Greenhouse A", "Greenhouse B", "Outdoor Field", "Storage Area"];
  
  List<Map<String, dynamic>> humiditySensors = [
    {
      "id": "humidity_001",
      "name": "Greenhouse Zone A",
      "location": "North Section",
      "current_humidity": 62.5,
      "current_temp": 24.5,
      "status": "online",
      "battery": 87,
      "last_update": "2024-11-22 10:30:00",
      "ideal_range": {"min": 60.0, "max": 70.0},
      "control_system": true,
    },
    {
      "id": "humidity_002", 
      "name": "Greenhouse Zone B",
      "location": "South Section",
      "current_humidity": 58.3,
      "current_temp": 23.8,
      "status": "online",
      "battery": 73,
      "last_update": "2024-11-22 10:29:00",
      "ideal_range": {"min": 55.0, "max": 65.0},
      "control_system": true,
    },
    {
      "id": "humidity_003",
      "name": "Outdoor Field Monitor",
      "location": "West Farm",
      "current_humidity": 45.7,
      "current_temp": 22.1,
      "status": "online",
      "battery": 94,
      "last_update": "2024-11-22 10:28:00",
      "ideal_range": {"min": 40.0, "max": 60.0},
      "control_system": false,
    },
    {
      "id": "humidity_004",
      "name": "Storage Facility",
      "location": "Main Building",
      "current_humidity": 35.2,
      "current_temp": 18.7,
      "status": "warning",
      "battery": 25,
      "last_update": "2024-11-22 09:45:00",
      "ideal_range": {"min": 30.0, "max": 40.0},
      "control_system": true,
    },
    {
      "id": "humidity_005",
      "name": "Seedling Nursery",
      "location": "East Section",
      "current_humidity": 78.9,
      "current_temp": 26.3,
      "status": "alert",
      "battery": 69,
      "last_update": "2024-11-22 10:31:00",
      "ideal_range": {"min": 65.0, "max": 75.0},
      "control_system": true,
    },
  ];

  List<Map<String, dynamic>> humidityAlerts = [
    {
      "sensor_name": "Seedling Nursery",
      "alert_type": "High Humidity",
      "current_value": 78.9,
      "threshold": 75.0,
      "severity": "critical",
      "timestamp": "2024-11-22 10:31:00",
      "duration": "12 minutes",
      "action_taken": "Ventilation activated",
    },
    {
      "sensor_name": "Storage Facility",
      "alert_type": "Low Battery",
      "current_value": 25,
      "threshold": 30,
      "severity": "warning",
      "timestamp": "2024-11-22 09:45:00",
      "duration": "45 minutes",
      "action_taken": "Maintenance notification sent",
    },
    {
      "sensor_name": "Outdoor Field Monitor",
      "alert_type": "Low Humidity",
      "current_value": 38.5,
      "threshold": 40.0,
      "severity": "medium",
      "timestamp": "2024-11-22 07:20:00",
      "duration": "Resolved",
      "action_taken": "Irrigation system triggered",
    },
  ];

  List<Map<String, dynamic>> controlActions = [
    {
      "zone": "Greenhouse Zone A",
      "action": "Misting System",
      "status": "active",
      "trigger": "Humidity below 58%",
      "duration": "5 minutes",
      "timestamp": "2024-11-22 09:15:00",
    },
    {
      "zone": "Seedling Nursery", 
      "action": "Ventilation Fan",
      "status": "active",
      "trigger": "Humidity above 75%",
      "duration": "12 minutes",
      "timestamp": "2024-11-22 10:19:00",
    },
    {
      "zone": "Greenhouse Zone B",
      "action": "Dehumidifier",
      "status": "standby",
      "trigger": "Manual override",
      "duration": "Stopped",
      "timestamp": "2024-11-22 08:30:00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Humidity Tracking"),
        actions: [
          IconButton(
            icon: Icon(
              isAutoControlEnabled ? Icons.auto_mode : Icons.mode_edit,
              color: isAutoControlEnabled ? successColor : warningColor,
            ),
            onPressed: () {
              isAutoControlEnabled = !isAutoControlEnabled;
              setState(() {});
              if (isAutoControlEnabled) {
                ss("Automatic humidity control enabled");
              } else {
                sw("Switched to manual humidity control");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Humidity control settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Control Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isAutoControlEnabled ? successColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isAutoControlEnabled ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isAutoControlEnabled ? Icons.auto_mode : Icons.mode_edit,
                    color: isAutoControlEnabled ? successColor : warningColor,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAutoControlEnabled ? "Automatic Control Active" : "Manual Control Mode",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isAutoControlEnabled ? successColor : warningColor,
                          ),
                        ),
                        Text(
                          isAutoControlEnabled 
                            ? "System automatically adjusting humidity levels"
                            : "Manual control of humidity equipment",
                          style: TextStyle(
                            fontSize: 12,
                            color: isAutoControlEnabled ? successColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Humidity Overview Cards
            Row(
              children: [
                Expanded(
                  child: _buildHumidityCard(
                    "Current",
                    "${currentHumidity.toStringAsFixed(1)}%",
                    Icons.water_drop,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildHumidityCard(
                    "Average",
                    "${avgHumidity.toStringAsFixed(1)}%",
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
                  child: _buildHumidityCard(
                    "Maximum",
                    "${maxHumidity.toStringAsFixed(1)}%",
                    Icons.trending_up,
                    dangerColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildHumidityCard(
                    "Minimum",
                    "${minHumidity.toStringAsFixed(1)}%",
                    Icons.trending_down,
                    successColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time Range",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      QDropdownField(
                        label: "Select Range",
                        value: selectedTimeRange,
                        items: timeRanges.map((range) => {
                          "label": range,
                          "value": range,
                        }).toList(),
                        onChanged: (value, label) {
                          selectedTimeRange = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Zone Filter",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      QDropdownField(
                        label: "Select Zone",
                        value: selectedZone,
                        items: zones.map((zone) => {
                          "label": zone,
                          "value": zone,
                        }).toList(),
                        onChanged: (value, label) {
                          selectedZone = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Humidity Chart Placeholder
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
                    "Humidity Trend Analysis",
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
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: infoColor,
                          size: 48,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Humidity Chart (${selectedTimeRange})",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Real-time humidity data for ${selectedZone}",
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
            
            // Active Control Actions
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
                          "Active Control Actions",
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
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${controlActions.where((action) => action["status"] == "active").length} Active",
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
                  ...List.generate(controlActions.length, (index) {
                    final action = controlActions[index];
                    final isActive = action["status"] == "active";
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isActive ? successColor.withAlpha(10) : disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isActive ? successColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: isActive ? successColor : disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getActionIcon(action["action"]),
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
                                  "${action["zone"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${action["action"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isActive ? successColor : disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Trigger: ${action["trigger"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Duration: ${action["duration"]} • ${DateTime.parse(action["timestamp"]).kkmm}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isActive ? successColor : disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${action["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (isAutoControlEnabled && isActive)
                                Padding(
                                  padding: EdgeInsets.only(top: spXs),
                                  child: QButton(
                                    label: "Stop",
                                    size: bs.sm,
                                    onPressed: () {
                                      sw("${action["action"]} stopped manually");
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Humidity Alerts
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
                          "Humidity Alerts",
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
                          "${humidityAlerts.length}",
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
                  ...List.generate(humidityAlerts.length, (index) {
                    final alert = humidityAlerts[index];
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          SizedBox(height: spSm),
                          Text(
                            "Current: ${alert["current_value"]}${alert["alert_type"].contains("Humidity") ? "%" : "%"} • Duration: ${alert["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (alert["action_taken"] != null)
                            Text(
                              "Action: ${alert["action_taken"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w500,
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
                    "Humidity Sensors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...List.generate(humiditySensors.length, (index) {
                    final sensor = humiditySensors[index];
                    final isInRange = (sensor["current_humidity"] as double) >= (sensor["ideal_range"]["min"] as double) &&
                                     (sensor["current_humidity"] as double) <= (sensor["ideal_range"]["max"] as double);
                    
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
                              Icons.water_drop,
                              color: _getSensorStatusColor(sensor["status"]),
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
                                    Expanded(
                                      child: Text(
                                        "${sensor["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (sensor["control_system"])
                                      Icon(
                                        Icons.settings_remote,
                                        size: 16,
                                        color: successColor,
                                      ),
                                  ],
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
                                "${(sensor["current_humidity"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isInRange ? successColor : dangerColor,
                                ),
                              ),
                              Text(
                                "${(sensor["current_temp"] as double).toStringAsFixed(1)}°C",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Range: ${(sensor["ideal_range"]["min"] as double).toStringAsFixed(0)}-${(sensor["ideal_range"]["max"] as double).toStringAsFixed(0)}%",
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
                              si("${sensor["name"]} sensor details");
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
          si("Add new humidity sensor");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHumidityCard(String label, String value, IconData icon, Color color) {
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
    if (alertType.contains("Humidity")) {
      return Icons.water_drop;
    } else if (alertType.contains("Battery")) {
      return Icons.battery_alert;
    } else {
      return Icons.warning;
    }
  }

  IconData _getActionIcon(String action) {
    if (action.contains("Misting")) {
      return Icons.water;
    } else if (action.contains("Ventilation") || action.contains("Fan")) {
      return Icons.air;
    } else if (action.contains("Dehumidifier")) {
      return Icons.dry;
    } else {
      return Icons.settings;
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
