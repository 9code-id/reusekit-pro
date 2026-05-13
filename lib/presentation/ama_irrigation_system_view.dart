import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaIrrigationSystemView extends StatefulWidget {
  const AmaIrrigationSystemView({super.key});

  @override
  State<AmaIrrigationSystemView> createState() => _AmaIrrigationSystemViewState();
}

class _AmaIrrigationSystemViewState extends State<AmaIrrigationSystemView> {
  int selectedSystem = 0;
  bool autoMode = true;
  String selectedZone = "all";
  
  List<Map<String, dynamic>> irrigationSystems = [
    {
      "id": "IS001",
      "name": "North Field Drip System",
      "type": "Drip Irrigation",
      "zone": "North Field",
      "status": "Active",
      "statusColor": successColor,
      "coverage": "15.5 hectares",
      "flowRate": "2.5 L/min",
      "pressure": "2.1 bar",
      "waterUsage": "850 L/hour",
      "efficiency": 92,
      "lastMaintenance": "2024-05-20",
      "nextMaintenance": "2024-07-20",
      "isRunning": true,
      "schedule": "06:00 - 08:00, 18:00 - 20:00",
      "sensors": [
        {"name": "Soil Moisture", "value": "65%", "status": "Normal"},
        {"name": "Flow Rate", "value": "2.3 L/min", "status": "Normal"},
        {"name": "Pressure", "value": "2.1 bar", "status": "Normal"}
      ]
    },
    {
      "id": "IS002",
      "name": "South Field Sprinkler",
      "type": "Sprinkler System",
      "zone": "South Field",
      "status": "Scheduled",
      "statusColor": warningColor,
      "coverage": "22.3 hectares",
      "flowRate": "15.8 L/min",
      "pressure": "3.2 bar",
      "waterUsage": "2840 L/hour",
      "efficiency": 78,
      "lastMaintenance": "2024-04-15",
      "nextMaintenance": "2024-06-15",
      "isRunning": false,
      "schedule": "05:30 - 07:30, 19:00 - 21:00",
      "sensors": [
        {"name": "Soil Moisture", "value": "45%", "status": "Low"},
        {"name": "Flow Rate", "value": "0 L/min", "status": "Offline"},
        {"name": "Pressure", "value": "0 bar", "status": "Offline"}
      ]
    },
    {
      "id": "IS003",
      "name": "Greenhouse Misting",
      "type": "Micro Sprinkler",
      "zone": "Greenhouse A",
      "status": "Active",
      "statusColor": successColor,
      "coverage": "0.8 hectares",
      "flowRate": "0.8 L/min",
      "pressure": "1.5 bar",
      "waterUsage": "48 L/hour",
      "efficiency": 96,
      "lastMaintenance": "2024-06-01",
      "nextMaintenance": "2024-08-01",
      "isRunning": true,
      "schedule": "Every 2 hours for 15 min",
      "sensors": [
        {"name": "Humidity", "value": "82%", "status": "High"},
        {"name": "Temperature", "value": "26°C", "status": "Normal"},
        {"name": "Flow Rate", "value": "0.8 L/min", "status": "Normal"}
      ]
    },
    {
      "id": "IS004",
      "name": "East Field Flood",
      "type": "Flood Irrigation",
      "zone": "East Field",
      "status": "Maintenance",
      "statusColor": dangerColor,
      "coverage": "18.7 hectares",
      "flowRate": "45.2 L/min",
      "pressure": "0.8 bar",
      "waterUsage": "2712 L/hour",
      "efficiency": 65,
      "lastMaintenance": "2024-06-10",
      "nextMaintenance": "2024-06-20",
      "isRunning": false,
      "schedule": "Once weekly - 6 hours",
      "sensors": [
        {"name": "Water Level", "value": "0 cm", "status": "Empty"},
        {"name": "Gate Status", "value": "Closed", "status": "Normal"},
        {"name": "Flow Rate", "value": "0 L/min", "status": "Offline"}
      ]
    }
  ];

  List<Map<String, dynamic>> systemFilters = [
    {"label": "All Systems", "value": "all"},
    {"label": "North Field", "value": "North Field"},
    {"label": "South Field", "value": "South Field"},
    {"label": "Greenhouse A", "value": "Greenhouse A"},
    {"label": "East Field", "value": "East Field"}
  ];

  List<Map<String, dynamic>> getFilteredSystems() {
    if (selectedZone == "all") {
      return irrigationSystems;
    }
    return irrigationSystems.where((system) => system["zone"] == selectedZone).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Scheduled":
        return warningColor;
      case "Maintenance":
        return dangerColor;
      case "Offline":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData getSystemIcon(String type) {
    switch (type) {
      case "Drip Irrigation":
        return Icons.water_drop;
      case "Sprinkler System":
        return Icons.shower;
      case "Micro Sprinkler":
        return Icons.grain;
      case "Flood Irrigation":
        return Icons.waves;
      default:
        return Icons.water;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSystems = getFilteredSystems();
    int activeSystems = irrigationSystems.where((s) => s["status"] == "Active").length;
    int totalSystems = irrigationSystems.length;
    double avgEfficiency = irrigationSystems.map((s) => s["efficiency"] as int).reduce((a, b) => a + b) / totalSystems;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Irrigation Systems"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to system settings
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to irrigation history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // System Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activeSystems/$totalSystems",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Systems",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
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
                          Icons.speed,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${avgEfficiency.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg Efficiency",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
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
                      border: Border.all(color: infoColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.water,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(irrigationSystems.where((s) => s["isRunning"] as bool).map((s) => double.parse((s["waterUsage"] as String).replaceAll(" L/hour", ""))).fold(0.0, (a, b) => a + b)).toStringAsFixed(0)}L",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Current Usage",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Control Panel
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "System Control",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Auto Mode",
                              "value": true,
                              "checked": autoMode,
                            }
                          ],
                          value: [
                            if (autoMode)
                              {
                                "label": "Auto Mode",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            autoMode = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Zone Filter",
                          items: systemFilters,
                          value: selectedZone,
                          onChanged: (value, label) {
                            selectedZone = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Start All",
                          size: bs.sm,
                          onPressed: () {
                            // Start all systems
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Stop All",
                          size: bs.sm,
                          onPressed: () {
                            // Stop all systems
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Emergency Stop",
                          size: bs.sm,
                          onPressed: () {
                            // Emergency stop
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Systems List
            Text(
              "Irrigation Systems (${filteredSystems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ...filteredSystems.map((system) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: system["statusColor"] as Color,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  leading: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (system["statusColor"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      getSystemIcon("${system["type"]}"),
                      color: system["statusColor"] as Color,
                      size: 24,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${system["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (system["statusColor"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${system["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: system["statusColor"] as Color,
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
                        "${system["type"]} • ${system["zone"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.area_chart,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${system["coverage"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Efficiency: ${system["efficiency"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (system["efficiency"] as int) > 80 ? successColor : warningColor,
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
                          // System Metrics
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
                                        Icons.speed,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${system["flowRate"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Flow Rate",
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
                                        Icons.compress,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${system["pressure"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Pressure",
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
                                      SizedBox(height: 4),
                                      Text(
                                        "${system["waterUsage"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Usage",
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
                          
                          // Schedule Information
                          Container(
                            padding: EdgeInsets.all(spXs),
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
                                        "Schedule",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${system["schedule"]}",
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
                          
                          // Sensor Data
                          Text(
                            "Sensor Readings:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(system["sensors"] as List).map((sensor) {
                            Color statusColor = sensor["status"] == "Normal" ? successColor : 
                                              sensor["status"] == "Low" || sensor["status"] == "High" ? warningColor : dangerColor;
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      sensor["name"],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${sensor["value"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "(${sensor["status"]})",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          
                          SizedBox(height: spSm),
                          
                          // Maintenance Info
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last Maintenance",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${system["lastMaintenance"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Next Maintenance",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${system["nextMaintenance"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Control Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: (system["isRunning"] as bool) ? "Stop" : "Start",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Toggle system
                                  },
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: QButton(
                                  label: "Schedule",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Modify schedule
                                  },
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: QButton(
                                  label: "Settings",
                                  size: bs.sm,
                                  onPressed: () {
                                    // System settings
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
          // Add new irrigation system
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
