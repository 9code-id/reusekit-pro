import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaSprinklerControlView extends StatefulWidget {
  const AmaSprinklerControlView({super.key});

  @override
  State<AmaSprinklerControlView> createState() => _AmaSprinklerControlViewState();
}

class _AmaSprinklerControlViewState extends State<AmaSprinklerControlView> {
  int selectedZone = 0;
  bool masterControl = false;
  int operationMode = 0; // 0: Manual, 1: Scheduled, 2: Auto
  
  List<Map<String, dynamic>> sprinklerZones = [
    {
      "id": "SZ001",
      "name": "North Field Zone A",
      "area": "3.2 hectares",
      "sprinklerCount": 24,
      "activeSprinklers": 24,
      "status": "Running",
      "statusColor": successColor,
      "waterPressure": 2.8,
      "flowRate": 45.6,
      "coverage": 95,
      "duration": "45 minutes",
      "timeRemaining": "32 minutes",
      "schedule": "06:00, 18:00",
      "isActive": true,
      "soilMoisture": 72,
      "temperature": 28.5,
      "lastActivated": "2024-06-15 06:00",
      "sprinklerHeads": [
        {"id": "SP001", "status": "Active", "pressure": 2.9, "flow": 1.9},
        {"id": "SP002", "status": "Active", "pressure": 2.8, "flow": 1.8},
        {"id": "SP003", "status": "Active", "pressure": 2.7, "flow": 1.9},
        {"id": "SP004", "status": "Blocked", "pressure": 0.5, "flow": 0.2}
      ]
    },
    {
      "id": "SZ002", 
      "name": "North Field Zone B",
      "area": "2.8 hectares",
      "sprinklerCount": 20,
      "activeSprinklers": 18,
      "status": "Scheduled",
      "statusColor": warningColor,
      "waterPressure": 0.0,
      "flowRate": 0.0,
      "coverage": 90,
      "duration": "40 minutes",
      "timeRemaining": "0 minutes",
      "schedule": "06:30, 18:30",
      "isActive": false,
      "soilMoisture": 58,
      "temperature": 29.1,
      "lastActivated": "2024-06-14 18:30",
      "sprinklerHeads": [
        {"id": "SP005", "status": "Ready", "pressure": 0.0, "flow": 0.0},
        {"id": "SP006", "status": "Ready", "pressure": 0.0, "flow": 0.0},
        {"id": "SP007", "status": "Maintenance", "pressure": 0.0, "flow": 0.0},
        {"id": "SP008", "status": "Maintenance", "pressure": 0.0, "flow": 0.0}
      ]
    },
    {
      "id": "SZ003",
      "name": "South Field Zone A", 
      "area": "4.1 hectares",
      "sprinklerCount": 32,
      "activeSprinklers": 30,
      "status": "Ready",
      "statusColor": infoColor,
      "waterPressure": 0.0,
      "flowRate": 0.0,
      "coverage": 94,
      "duration": "50 minutes",
      "timeRemaining": "0 minutes", 
      "schedule": "05:30, 17:30",
      "isActive": false,
      "soilMoisture": 45,
      "temperature": 30.2,
      "lastActivated": "2024-06-14 17:30",
      "sprinklerHeads": [
        {"id": "SP009", "status": "Ready", "pressure": 0.0, "flow": 0.0},
        {"id": "SP010", "status": "Ready", "pressure": 0.0, "flow": 0.0},
        {"id": "SP011", "status": "Ready", "pressure": 0.0, "flow": 0.0},
        {"id": "SP012", "status": "Offline", "pressure": 0.0, "flow": 0.0}
      ]
    },
    {
      "id": "SZ004",
      "name": "Greenhouse Perimeter",
      "area": "0.6 hectares",
      "sprinklerCount": 8,
      "activeSprinklers": 8,
      "status": "Running",
      "statusColor": successColor,
      "waterPressure": 1.9,
      "flowRate": 12.4,
      "coverage": 100,
      "duration": "20 minutes",
      "timeRemaining": "8 minutes",
      "schedule": "Every 4 hours",
      "isActive": true,
      "soilMoisture": 85,
      "temperature": 26.8,
      "lastActivated": "2024-06-15 14:00",
      "sprinklerHeads": [
        {"id": "SP013", "status": "Active", "pressure": 1.9, "flow": 1.6},
        {"id": "SP014", "status": "Active", "pressure": 1.8, "flow": 1.5},
        {"id": "SP015", "status": "Active", "pressure": 1.9, "flow": 1.6},
        {"id": "SP016", "status": "Active", "pressure": 1.8, "flow": 1.5}
      ]
    }
  ];

  List<Map<String, dynamic>> operationModes = [
    {"label": "Manual Control", "value": 0},
    {"label": "Scheduled", "value": 1},
    {"label": "Auto Sensor", "value": 2}
  ];

  Color getSprinklerStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Ready":
        return infoColor;
      case "Blocked":
      case "Offline":
        return dangerColor;
      case "Maintenance":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData getSprinklerStatusIcon(String status) {
    switch (status) {
      case "Active":
        return Icons.water_drop;
      case "Ready":
        return Icons.play_circle;
      case "Blocked":
        return Icons.block;
      case "Offline":
        return Icons.power_off;
      case "Maintenance":
        return Icons.build;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentZone = sprinklerZones[selectedZone];
    int runningZones = sprinklerZones.where((z) => z["status"] == "Running").length;
    int totalSprinklers = sprinklerZones.map((z) => z["sprinklerCount"] as int).reduce((a, b) => a + b);
    int activeSprinklers = sprinklerZones.map((z) => z["activeSprinklers"] as int).reduce((a, b) => a + b);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sprinkler Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              // Navigate to scheduling
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // System settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // System Status Cards
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
                          Icons.play_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$runningZones/${sprinklerZones.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active Zones",
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
                          Icons.shower,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$activeSprinklers/$totalSprinklers",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Sprinklers",
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
                          "${sprinklerZones.where((z) => z["isActive"] as bool).map((z) => z["flowRate"] as double).fold(0.0, (a, b) => a + b).toStringAsFixed(1)}L/min",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Flow Rate",
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
            
            // Master Control Panel
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
                    "Master Control",
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
                              "label": "Master Enable",
                              "value": true,
                              "checked": masterControl,
                            }
                          ],
                          value: [
                            if (masterControl)
                              {
                                "label": "Master Enable",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            masterControl = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Operation Mode",
                          items: operationModes,
                          value: operationMode,
                          onChanged: (value, label) {
                            operationMode = value;
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
                          label: "Start All Zones",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Start all zones
                          } : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Stop All Zones",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Stop all zones
                          } : null,
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
            
            // Zone Selection
            Text(
              "Select Zone",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: sprinklerZones.map((zone) => {
                "label": "${zone["name"]}",
                "value": sprinklerZones.indexOf(zone),
              }).toList(),
              value: selectedZone,
              onChanged: (index, label, value, item) {
                selectedZone = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Zone Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: currentZone["statusColor"] as Color,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Zone Header
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: currentZone["statusColor"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentZone["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentZone["area"]} • ${currentZone["sprinklerCount"]} sprinklers",
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (currentZone["statusColor"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentZone["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: currentZone["statusColor"] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Zone Metrics
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
                                Icons.compress,
                                color: Colors.blue,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentZone["waterPressure"]} bar",
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
                                Icons.speed,
                                color: Colors.cyan,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentZone["flowRate"]} L/min",
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
                                Icons.grass,
                                color: Colors.green,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentZone["soilMoisture"]}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Soil Moisture",
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
                            color: Colors.orange.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.thermostat,
                                color: Colors.orange,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentZone["temperature"]}°C",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Temperature",
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
                  
                  // Running Information
                  if (currentZone["isActive"] as bool) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Currently Running",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Time Remaining: ${currentZone["timeRemaining"]} / ${currentZone["duration"]}",
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
                    SizedBox(height: spSm),
                  ],
                  
                  // Schedule Information
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
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
                                "${currentZone["schedule"]} (${currentZone["duration"]})",
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
                  
                  // Zone Controls
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: (currentZone["isActive"] as bool) ? "Stop Zone" : "Start Zone",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Toggle zone
                          } : null,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Test Zone",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Test zone for 5 minutes
                          } : null,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Zone Settings",
                          size: bs.sm,
                          onPressed: () {
                            // Zone configuration
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Individual Sprinkler Heads
            Text(
              "Sprinkler Heads (Sample)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ...(currentZone["sprinklerHeads"] as List).map((sprinkler) {
              Color statusColor = getSprinklerStatusColor("${sprinkler["status"]}");
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: statusColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        getSprinklerStatusIcon("${sprinkler["status"]}"),
                        color: statusColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sprinkler["id"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${sprinkler["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: statusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (sprinkler["status"] == "Active") ...[
                      Text(
                        "${sprinkler["pressure"]} bar",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${sprinkler["flow"]} L/min",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // Individual sprinkler control
                      },
                      child: Icon(
                        Icons.settings,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
