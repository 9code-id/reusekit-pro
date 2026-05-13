import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSecuritySystemView extends StatefulWidget {
  const CmaSecuritySystemView({super.key});

  @override
  State<CmaSecuritySystemView> createState() => _CmaSecuritySystemViewState();
}

class _CmaSecuritySystemViewState extends State<CmaSecuritySystemView> {
  String selectedVehicle = "2023 Toyota Camry - ABC123";
  bool isSystemArmed = true;
  bool motionDetectionEnabled = true;
  bool glassBreakDetectionEnabled = true;
  bool sirenEnabled = true;
  bool smartphoneAlertsEnabled = true;
  
  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "2023 Toyota Camry - ABC123", "value": "2023 Toyota Camry - ABC123"},
    {"label": "2021 Honda Civic - XYZ789", "value": "2021 Honda Civic - XYZ789"},
    {"label": "2020 Ford Explorer - DEF456", "value": "2020 Ford Explorer - DEF456"},
  ];

  Map<String, dynamic> systemStatus = {
    "status": "Armed",
    "lastArmed": "2024-12-19 08:30",
    "batteryLevel": 95,
    "signalStrength": 4,
    "lastService": "2024-11-15",
    "nextService": "2025-05-15",
    "systemVersion": "v2.3.1",
    "sensorsActive": 12,
    "zonesProtected": 8
  };

  List<Map<String, dynamic>> securityEvents = [
    {
      "id": "evt_001",
      "timestamp": "2024-12-19 14:25",
      "type": "Motion Detected",
      "severity": "Medium",
      "location": "Driver Side Door",
      "description": "Motion sensor triggered near driver door",
      "status": "Resolved",
      "response": "Owner verified - false alarm"
    },
    {
      "id": "evt_002",
      "timestamp": "2024-12-18 22:15",
      "type": "System Armed",
      "severity": "Info",
      "location": "Remote",
      "description": "System armed via smartphone app",
      "status": "Normal",
      "response": "None required"
    },
    {
      "id": "evt_003",
      "timestamp": "2024-12-18 18:30",
      "type": "Low Battery",
      "severity": "Low",
      "location": "Backup Siren",
      "description": "Backup siren battery below 20%",
      "status": "Pending",
      "response": "Schedule battery replacement"
    },
    {
      "id": "evt_004",
      "timestamp": "2024-12-17 23:45",
      "type": "Glass Break",
      "severity": "High",
      "location": "Rear Window",
      "description": "Glass break sensor triggered",
      "status": "Investigated",
      "response": "Police dispatched - no damage found"
    },
    {
      "id": "evt_005",
      "timestamp": "2024-12-17 09:12",
      "type": "System Disarmed",
      "severity": "Info",
      "location": "Key Fob",
      "description": "System disarmed with authorized key fob",
      "status": "Normal",
      "response": "None required"
    }
  ];

  List<Map<String, dynamic>> installedComponents = [
    {
      "name": "Control Module",
      "status": "Online",
      "batteryLevel": 95,
      "lastUpdate": "2024-12-19 08:30",
      "location": "Dashboard",
      "type": "Primary"
    },
    {
      "name": "Door Sensors (4x)",
      "status": "Online",
      "batteryLevel": 88,
      "lastUpdate": "2024-12-19 08:30",
      "location": "All Doors",
      "type": "Sensor"
    },
    {
      "name": "Motion Detector",
      "status": "Online",
      "batteryLevel": 92,
      "lastUpdate": "2024-12-19 08:30",
      "location": "Interior",
      "type": "Sensor"
    },
    {
      "name": "Glass Break Sensors (4x)",
      "status": "Online",
      "batteryLevel": 90,
      "lastUpdate": "2024-12-19 08:30",
      "location": "All Windows",
      "type": "Sensor"
    },
    {
      "name": "Shock Sensor",
      "status": "Online",
      "batteryLevel": 85,
      "lastUpdate": "2024-12-19 08:30",
      "location": "Frame",
      "type": "Sensor"
    },
    {
      "name": "GPS Tracker",
      "status": "Online",
      "batteryLevel": 96,
      "lastUpdate": "2024-12-19 08:30",
      "location": "Hidden",
      "type": "Tracker"
    },
    {
      "name": "Backup Siren",
      "status": "Low Battery",
      "batteryLevel": 18,
      "lastUpdate": "2024-12-18 22:15",
      "location": "Engine Bay",
      "type": "Alert"
    },
    {
      "name": "LED Status Indicator",
      "status": "Online",
      "batteryLevel": null,
      "lastUpdate": "2024-12-19 08:30",
      "location": "Dashboard",
      "type": "Indicator"
    }
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      case "Info":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Online":
        return successColor;
      case "Low Battery":
        return warningColor;
      case "Offline":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security System"),
        actions: [
          IconButton(
            icon: Icon(isSystemArmed ? Icons.security : Icons.no_encryption),
            onPressed: () {
              isSystemArmed = !isSystemArmed;
              setState(() {});
              ss(isSystemArmed ? "Security system armed" : "Security system disarmed");
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
            // Vehicle Selection
            QDropdownField(
              label: "Select Vehicle",
              items: vehicleOptions,
              value: selectedVehicle,
              onChanged: (value, label) {
                selectedVehicle = value;
                setState(() {});
              },
            ),

            // System Status Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    isSystemArmed ? successColor : warningColor,
                    isSystemArmed ? successColor.withAlpha(180) : warningColor.withAlpha(180)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSystemArmed ? Icons.security : Icons.no_encryption,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "System Status: ${isSystemArmed ? 'ARMED' : 'DISARMED'}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${systemStatus["batteryLevel"]}%",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Battery",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) =>
                                Icon(
                                  Icons.signal_cellular_4_bar,
                                  color: index < systemStatus["signalStrength"] 
                                    ? Colors.white 
                                    : Colors.white30,
                                  size: 16,
                                ),
                              ),
                            ),
                            Text(
                              "Signal",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${systemStatus["sensorsActive"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Sensors",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isSystemArmed)
                    Text(
                      "Armed since ${DateTime.parse(systemStatus["lastArmed"]).dMMMy} at ${DateTime.parse(systemStatus["lastArmed"]).kkmm}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isSystemArmed ? "Disarm" : "Arm",
                          icon: isSystemArmed ? Icons.no_encryption : Icons.security,
                          size: bs.md,
                          onPressed: () {
                            isSystemArmed = !isSystemArmed;
                            setState(() {});
                            ss(isSystemArmed ? "System armed successfully" : "System disarmed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Panic",
                          icon: Icons.warning,
                          size: bs.md,
                          onPressed: () {
                            se("PANIC ALARM ACTIVATED!");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // System Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Motion Detection",
                        "value": "motion",
                        "checked": motionDetectionEnabled,
                      }
                    ],
                    value: [
                      if (motionDetectionEnabled)
                        {"label": "Motion Detection", "value": "motion", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      motionDetectionEnabled = values.any((v) => v["value"] == "motion");
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Glass Break Detection",
                        "value": "glass",
                        "checked": glassBreakDetectionEnabled,
                      }
                    ],
                    value: [
                      if (glassBreakDetectionEnabled)
                        {"label": "Glass Break Detection", "value": "glass", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      glassBreakDetectionEnabled = values.any((v) => v["value"] == "glass");
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Siren Alert",
                        "value": "siren",
                        "checked": sirenEnabled,
                      }
                    ],
                    value: [
                      if (sirenEnabled)
                        {"label": "Siren Alert", "value": "siren", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      sirenEnabled = values.any((v) => v["value"] == "siren");
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Smartphone Alerts",
                        "value": "phone",
                        "checked": smartphoneAlertsEnabled,
                      }
                    ],
                    value: [
                      if (smartphoneAlertsEnabled)
                        {"label": "Smartphone Alerts", "value": "phone", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      smartphoneAlertsEnabled = values.any((v) => v["value"] == "phone");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // System Components
            Text(
              "System Components",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...installedComponents.map((component) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(component["status"]),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(component["status"]).withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        component["type"] == "Primary" ? Icons.settings :
                        component["type"] == "Sensor" ? Icons.sensors :
                        component["type"] == "Tracker" ? Icons.gps_fixed :
                        component["type"] == "Alert" ? Icons.volume_up :
                        Icons.visibility,
                        color: _getStatusColor(component["status"]),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${component["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${component["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(component["status"]).withAlpha(40),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${component["status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(component["status"]),
                                  ),
                                ),
                              ),
                              if (component["batteryLevel"] != null) ...[
                                SizedBox(width: spSm),
                                Icon(Icons.battery_full, size: 12, color: disabledBoldColor),
                                SizedBox(width: 2),
                                Text(
                                  "${component["batteryLevel"]}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (component["status"] == "Low Battery")
                      QButton(
                        icon: Icons.warning,
                        size: bs.sm,
                        onPressed: () {
                          sw("Component requires battery replacement");
                        },
                      ),
                  ],
                ),
              );
            }).toList(),

            // Recent Events
            Text(
              "Recent Security Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...securityEvents.take(3).map((event) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getSeverityColor(event["severity"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(event["severity"]).withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${event["severity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getSeverityColor(event["severity"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${event["type"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${DateTime.parse(event["timestamp"]).dMMMy} ${DateTime.parse(event["timestamp"]).kkmm}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${event["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${event["location"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${event["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (event["response"] != "None required")
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, size: 14, color: infoColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["response"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),

            // View All Events Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View All Events",
                icon: Icons.list,
                size: bs.md,
                onPressed: () {
                  si("Opening complete event history...");
                },
              ),
            ),

            // Emergency Contacts
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, dangerColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emergency, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Response",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Your security system is connected to 24/7 monitoring. In case of emergency, response teams will be automatically dispatched.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call Support",
                          icon: Icons.phone,
                          size: bs.md,
                          onPressed: () {
                            ss("Calling security support...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Test System",
                          icon: Icons.check_circle,
                          size: bs.md,
                          onPressed: () {
                            ss("Running system diagnostics...");
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
      ),
    );
  }
}
