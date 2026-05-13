import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaDripIrrigationView extends StatefulWidget {
  const AmaDripIrrigationView({super.key});

  @override
  State<AmaDripIrrigationView> createState() => _AmaDripIrrigationViewState();
}

class _AmaDripIrrigationViewState extends State<AmaDripIrrigationView> {
  int selectedSystem = 0;
  bool masterControl = true;
  int controlMode = 1; // 0: Manual, 1: Automatic, 2: Scheduled
  
  List<Map<String, dynamic>> dripSystems = [
    {
      "id": "DS001",
      "name": "Tomato Rows 1-10",
      "crop": "Tomatoes",
      "area": "2.4 hectares",
      "lineCount": 20,
      "emitterCount": 480,
      "status": "Running",
      "statusColor": successColor,
      "waterPressure": 1.8,
      "flowRate": 24.5,
      "efficiency": 94,
      "duration": "120 minutes",
      "timeRemaining": "85 minutes",
      "schedule": "06:00, 12:00, 18:00",
      "isActive": true,
      "soilMoisture": 68,
      "fertilizerConcentration": 1.2,
      "lastMaintenance": "2024-06-10",
      "waterUsage": 2940,
      "costPerHour": 12.45,
      "zones": [
        {"name": "Zone A", "lines": 5, "status": "Active", "flow": 6.2, "pressure": 1.8},
        {"name": "Zone B", "lines": 5, "status": "Active", "flow": 6.1, "pressure": 1.7},
        {"name": "Zone C", "lines": 5, "status": "Active", "flow": 6.0, "pressure": 1.8},
        {"name": "Zone D", "lines": 5, "status": "Active", "flow": 6.2, "pressure": 1.9}
      ],
      "sensors": [
        {"type": "Soil Moisture", "value": 68, "unit": "%", "status": "Optimal"},
        {"type": "pH Level", "value": 6.8, "unit": "", "status": "Good"},
        {"type": "EC Level", "value": 1.2, "unit": "mS/cm", "status": "Optimal"}
      ]
    },
    {
      "id": "DS002",
      "name": "Pepper Rows 11-18",
      "crop": "Bell Peppers",
      "area": "1.8 hectares",
      "lineCount": 16,
      "emitterCount": 384,
      "status": "Scheduled",
      "statusColor": warningColor,
      "waterPressure": 0.0,
      "flowRate": 0.0,
      "efficiency": 92,
      "duration": "90 minutes",
      "timeRemaining": "0 minutes",
      "schedule": "07:00, 13:00, 19:00",
      "isActive": false,
      "soilMoisture": 55,
      "fertilizerConcentration": 1.0,
      "lastMaintenance": "2024-06-08",
      "waterUsage": 0,
      "costPerHour": 9.80,
      "zones": [
        {"name": "Zone E", "lines": 4, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone F", "lines": 4, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone G", "lines": 4, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone H", "lines": 4, "status": "Ready", "flow": 0.0, "pressure": 0.0}
      ],
      "sensors": [
        {"type": "Soil Moisture", "value": 55, "unit": "%", "status": "Low"},
        {"type": "pH Level", "value": 7.1, "unit": "", "status": "Good"},
        {"type": "EC Level", "value": 1.0, "unit": "mS/cm", "status": "Good"}
      ]
    },
    {
      "id": "DS003",
      "name": "Cucumber Greenhouse",
      "crop": "Cucumbers",
      "area": "0.8 hectares",
      "lineCount": 12,
      "emitterCount": 288,
      "status": "Ready",
      "statusColor": infoColor,
      "waterPressure": 0.0,
      "flowRate": 0.0,
      "efficiency": 96,
      "duration": "60 minutes",
      "timeRemaining": "0 minutes",
      "schedule": "08:00, 14:00, 20:00",
      "isActive": false,
      "soilMoisture": 72,
      "fertilizerConcentration": 1.5,
      "lastMaintenance": "2024-06-12",
      "waterUsage": 0,
      "costPerHour": 8.25,
      "zones": [
        {"name": "Zone I", "lines": 3, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone J", "lines": 3, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone K", "lines": 3, "status": "Ready", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone L", "lines": 3, "status": "Ready", "flow": 0.0, "pressure": 0.0}
      ],
      "sensors": [
        {"type": "Soil Moisture", "value": 72, "unit": "%", "status": "Optimal"},
        {"type": "pH Level", "value": 6.5, "unit": "", "status": "Optimal"},
        {"type": "EC Level", "value": 1.5, "unit": "mS/cm", "status": "High"}
      ]
    },
    {
      "id": "DS004",
      "name": "Herb Garden",
      "crop": "Mixed Herbs",
      "area": "0.3 hectares",
      "lineCount": 6,
      "emitterCount": 144,
      "status": "Maintenance",
      "statusColor": dangerColor,
      "waterPressure": 0.0,
      "flowRate": 0.0,
      "efficiency": 89,
      "duration": "45 minutes",
      "timeRemaining": "0 minutes",
      "schedule": "06:30, 12:30, 18:30",
      "isActive": false,
      "soilMoisture": 45,
      "fertilizerConcentration": 0.8,
      "lastMaintenance": "2024-06-05",
      "waterUsage": 0,
      "costPerHour": 4.50,
      "zones": [
        {"name": "Zone M", "lines": 2, "status": "Maintenance", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone N", "lines": 2, "status": "Maintenance", "flow": 0.0, "pressure": 0.0},
        {"name": "Zone O", "lines": 2, "status": "Maintenance", "flow": 0.0, "pressure": 0.0}
      ],
      "sensors": [
        {"type": "Soil Moisture", "value": 45, "unit": "%", "status": "Critical"},
        {"type": "pH Level", "value": 7.5, "unit": "", "status": "High"},
        {"type": "EC Level", "value": 0.8, "unit": "mS/cm", "status": "Low"}
      ]
    }
  ];

  List<Map<String, dynamic>> controlModes = [
    {"label": "Manual Control", "value": 0},
    {"label": "Automatic", "value": 1},
    {"label": "Scheduled", "value": 2}
  ];

  Color getSensorStatusColor(String status) {
    switch (status) {
      case "Optimal":
        return successColor;
      case "Good":
        return infoColor;
      case "High":
      case "Low":
        return warningColor;
      case "Critical":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getZoneStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Ready":
        return infoColor;
      case "Maintenance":
        return dangerColor;
      case "Offline":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentSystem = dripSystems[selectedSystem];
    int runningSystems = dripSystems.where((s) => s["status"] == "Running").length;
    double totalEfficiency = dripSystems.map((s) => s["efficiency"] as int).reduce((a, b) => a + b) / dripSystems.length;
    double totalWaterUsage = dripSystems.map((s) => s["waterUsage"] as int).fold(0.0, (a, b) => a + b);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Drip Irrigation"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            onPressed: () {
              // Irrigation analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              // Schedule management
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
                          Icons.play_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$runningSystems/${dripSystems.length}",
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
                          "${totalEfficiency.toStringAsFixed(1)}%",
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
                          Icons.water_drop,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(totalWaterUsage / 1000).toStringAsFixed(1)}K L",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Water Usage",
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
                              "label": "Master Control",
                              "value": true,
                              "checked": masterControl,
                            }
                          ],
                          value: [
                            if (masterControl)
                              {
                                "label": "Master Control",
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
                          label: "Control Mode",
                          items: controlModes,
                          value: controlMode,
                          onChanged: (value, label) {
                            controlMode = value;
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
                          onPressed: masterControl ? () {
                            // Start all systems
                          } : null,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Stop All",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Stop all systems
                          } : null,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Flush Lines",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Flush all lines
                          } : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // System Selection
            Text(
              "Select System",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: dripSystems.map((system) => {
                "label": "${system["name"]}",
                "value": dripSystems.indexOf(system),
              }).toList(),
              value: selectedSystem,
              onChanged: (index, label, value, item) {
                selectedSystem = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // System Details
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: currentSystem["statusColor"] as Color,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // System Header
                  Row(
                    children: [
                      Icon(
                        Icons.water_drop,
                        color: currentSystem["statusColor"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentSystem["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentSystem["crop"]} • ${currentSystem["area"]}",
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
                          color: (currentSystem["statusColor"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentSystem["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: currentSystem["statusColor"] as Color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
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
                                Icons.compress,
                                color: Colors.blue,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentSystem["waterPressure"]} bar",
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
                                "${currentSystem["flowRate"]} L/min",
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
                                Icons.eco,
                                color: Colors.green,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${currentSystem["efficiency"]}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Efficiency",
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
                                Icons.monetization_on,
                                color: Colors.orange,
                                size: 16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$${currentSystem["costPerHour"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Cost/Hour",
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
                  
                  // Running Status
                  if (currentSystem["isActive"] as bool) ...[
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
                                  "Time Remaining: ${currentSystem["timeRemaining"]} / ${currentSystem["duration"]}",
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
                  
                  // System Info
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lines",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentSystem["lineCount"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Emitters",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentSystem["emitterCount"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Schedule",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentSystem["schedule"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // System Controls
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: (currentSystem["isActive"] as bool) ? "Stop System" : "Start System",
                          size: bs.sm,
                          onPressed: masterControl && currentSystem["status"] != "Maintenance" ? () {
                            // Toggle system
                          } : null,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Test Run",
                          size: bs.sm,
                          onPressed: masterControl ? () {
                            // Test run for 10 minutes
                          } : null,
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
            
            SizedBox(height: spLg),
            
            // Sensor Readings
            Text(
              "Sensor Readings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Row(
              children: (currentSystem["sensors"] as List).map<Widget>((sensor) {
                Color statusColor = getSensorStatusColor("${sensor["status"]}");
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: spXs),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(color: statusColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${sensor["type"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${sensor["value"]}${sensor["unit"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        Text(
                          "${sensor["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spLg),
            
            // Zone Details
            Text(
              "Zone Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ...(currentSystem["zones"] as List).map((zone) {
              Color zoneColor = getZoneStatusColor("${zone["status"]}");
              
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: zoneColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: zoneColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: zoneColor,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${zone["name"]}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${zone["lines"]} lines • ${zone["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: zoneColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (zone["status"] == "Active") ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${zone["flow"]} L/min",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${zone["pressure"]} bar",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // Zone control
                      },
                      child: Icon(
                        Icons.tune,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new drip system
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
