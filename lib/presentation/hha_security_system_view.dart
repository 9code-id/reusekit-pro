import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSecuritySystemView extends StatefulWidget {
  const HhaSecuritySystemView({super.key});

  @override
  State<HhaSecuritySystemView> createState() => _HhaSecuritySystemViewState();
}

class _HhaSecuritySystemViewState extends State<HhaSecuritySystemView> {
  String selectedZone = "All";
  String selectedStatus = "All";
  String selectedSystemType = "All";

  List<Map<String, dynamic>> zoneOptions = [
    {"label": "All", "value": "All"},
    {"label": "Main Hospital", "value": "main_hospital"},
    {"label": "Emergency Wing", "value": "emergency_wing"},
    {"label": "Surgical Tower", "value": "surgical_tower"},
    {"label": "Parking Areas", "value": "parking"},
    {"label": "Perimeter", "value": "perimeter"},
    {"label": "Administrative", "value": "admin"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "active"},
    {"label": "Armed", "value": "armed"},
    {"label": "Disarmed", "value": "disarmed"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Alarm", "value": "alarm"},
    {"label": "Offline", "value": "offline"},
  ];

  List<Map<String, dynamic>> systemTypeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Access Control", "value": "access_control"},
    {"label": "CCTV", "value": "cctv"},
    {"label": "Intrusion Detection", "value": "intrusion"},
    {"label": "Fire Safety", "value": "fire_safety"},
    {"label": "Panic Button", "value": "panic"},
    {"label": "Environmental", "value": "environmental"},
  ];

  List<Map<String, dynamic>> securitySystems = [
    {
      "id": "SEC001",
      "name": "Main Entrance Access Control",
      "type": "Access Control",
      "zone": "Main Hospital",
      "location": "Main Lobby",
      "status": "Active",
      "lastActivity": "2024-12-15 16:45",
      "connectedDevices": 8,
      "alertsToday": 0,
      "systemHealth": "Optimal",
      "batteryLevel": 95,
      "signalStrength": "Strong",
      "authorizedUsers": 342,
      "accessAttempts": 156,
      "deniedAccess": 3,
      "maintenanceDate": "2024-11-20",
      "nextMaintenance": "2025-02-20",
      "vendor": "HID Global",
      "model": "VertX V1000",
      "installationDate": "2023-01-15",
      "warrantyExpiry": "2026-01-15",
      "responsiblePerson": "Security Manager - John Davidson",
      "contactInfo": "ext. 5001",
      "notes": "Primary access control for main hospital entrance",
    },
    {
      "id": "SEC002",
      "name": "ICU Ward Surveillance System",
      "type": "CCTV",
      "zone": "Main Hospital",
      "location": "ICU 3rd Floor",
      "status": "Active",
      "lastActivity": "2024-12-15 16:50",
      "connectedDevices": 12,
      "alertsToday": 1,
      "systemHealth": "Good",
      "batteryLevel": null,
      "signalStrength": "Strong",
      "authorizedUsers": 45,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-12-01",
      "nextMaintenance": "2025-03-01",
      "vendor": "Axis Communications",
      "model": "P3245-LV Network Camera",
      "installationDate": "2023-06-10",
      "warrantyExpiry": "2026-06-10",
      "responsiblePerson": "IT Security - Sarah Chen",
      "contactInfo": "ext. 2500",
      "notes": "24/7 monitoring with motion detection and night vision",
    },
    {
      "id": "SEC003",
      "name": "Emergency Exit Intrusion Detection",
      "type": "Intrusion Detection",
      "zone": "Emergency Wing",
      "location": "Emergency Exit Doors",
      "status": "Armed",
      "lastActivity": "2024-12-15 14:30",
      "connectedDevices": 6,
      "alertsToday": 0,
      "systemHealth": "Optimal",
      "batteryLevel": 88,
      "signalStrength": "Strong",
      "authorizedUsers": null,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-10-15",
      "nextMaintenance": "2025-01-15",
      "vendor": "Bosch Security",
      "model": "DS160 Motion Detector",
      "installationDate": "2022-11-20",
      "warrantyExpiry": "2025-11-20",
      "responsiblePerson": "Security Officer - Mark Wilson",
      "contactInfo": "ext. 5010",
      "notes": "Monitors emergency exits for unauthorized access",
    },
    {
      "id": "SEC004",
      "name": "OR Fire Safety System",
      "type": "Fire Safety",
      "zone": "Surgical Tower",
      "location": "Operating Rooms",
      "status": "Active",
      "lastActivity": "2024-12-15 16:00",
      "connectedDevices": 15,
      "alertsToday": 0,
      "systemHealth": "Optimal",
      "batteryLevel": 92,
      "signalStrength": "Strong",
      "authorizedUsers": null,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-11-30",
      "nextMaintenance": "2025-02-28",
      "vendor": "Simplex Fire",
      "model": "4100ES System",
      "installationDate": "2023-03-15",
      "warrantyExpiry": "2028-03-15",
      "responsiblePerson": "Fire Safety Coordinator - Lisa Martinez",
      "contactInfo": "ext. 5020",
      "notes": "Advanced fire detection with gas suppression capability",
    },
    {
      "id": "SEC005",
      "name": "Nurse Station Panic System",
      "type": "Panic Button",
      "zone": "Main Hospital",
      "location": "All Nurse Stations",
      "status": "Active",
      "lastActivity": "2024-12-14 22:15",
      "connectedDevices": 18,
      "alertsToday": 2,
      "systemHealth": "Good",
      "batteryLevel": 76,
      "signalStrength": "Strong",
      "authorizedUsers": 125,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-12-05",
      "nextMaintenance": "2025-03-05",
      "vendor": "Rauland-Borg",
      "model": "Responder 5 System",
      "installationDate": "2023-08-20",
      "warrantyExpiry": "2026-08-20",
      "responsiblePerson": "Nursing Supervisor - Jennifer Liu",
      "contactInfo": "ext. 3000",
      "notes": "Silent alarm system for emergency situations",
    },
    {
      "id": "SEC006",
      "name": "Parking Garage Security",
      "type": "CCTV",
      "zone": "Parking Areas",
      "location": "Underground Parking",
      "status": "Active",
      "lastActivity": "2024-12-15 16:55",
      "connectedDevices": 24,
      "alertsToday": 3,
      "systemHealth": "Good",
      "batteryLevel": null,
      "signalStrength": "Strong",
      "authorizedUsers": null,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-11-25",
      "nextMaintenance": "2025-02-25",
      "vendor": "Hikvision",
      "model": "DS-2CD2385FWD-I",
      "installationDate": "2023-04-10",
      "warrantyExpiry": "2026-04-10",
      "responsiblePerson": "Parking Security - Robert Davis",
      "contactInfo": "ext. 5030",
      "notes": "High-definition surveillance for vehicle and pedestrian safety",
    },
    {
      "id": "SEC007",
      "name": "Environmental Monitoring System",
      "type": "Environmental",
      "zone": "All Zones",
      "location": "Hospital-wide",
      "status": "Active",
      "lastActivity": "2024-12-15 16:58",
      "connectedDevices": 48,
      "alertsToday": 1,
      "systemHealth": "Optimal",
      "batteryLevel": 94,
      "signalStrength": "Strong",
      "authorizedUsers": 25,
      "accessAttempts": null,
      "deniedAccess": null,
      "maintenanceDate": "2024-12-10",
      "nextMaintenance": "2025-01-10",
      "vendor": "Johnson Controls",
      "model": "Metasys System",
      "installationDate": "2022-09-15",
      "warrantyExpiry": "2027-09-15",
      "responsiblePerson": "Facilities Manager - David Thompson",
      "contactInfo": "ext. 1100",
      "notes": "Monitors temperature, humidity, air quality, and energy usage",
    },
    {
      "id": "SEC008",
      "name": "Pharmacy Vault Security",
      "type": "Access Control",
      "zone": "Main Hospital",
      "location": "Pharmacy Department",
      "status": "Armed",
      "lastActivity": "2024-12-15 15:30",
      "connectedDevices": 4,
      "alertsToday": 0,
      "systemHealth": "Optimal",
      "batteryLevel": 98,
      "signalStrength": "Strong",
      "authorizedUsers": 12,
      "accessAttempts": 8,
      "deniedAccess": 0,
      "maintenanceDate": "2024-11-10",
      "nextMaintenance": "2025-02-10",
      "vendor": "Kaba",
      "model": "E-Plex 5000 Series",
      "installationDate": "2023-02-28",
      "warrantyExpiry": "2026-02-28",
      "responsiblePerson": "Pharmacy Director - Dr. Patricia Adams",
      "contactInfo": "ext. 2600",
      "notes": "High-security access control for controlled substances storage",
    },
  ];

  List<Map<String, dynamic>> get filteredSystems {
    return securitySystems.where((system) {
      bool matchesZone = selectedZone == "All" || system["zone"].toString().toLowerCase().replaceAll(" ", "_") == selectedZone;
      bool matchesStatus = selectedStatus == "All" || system["status"].toString().toLowerCase() == selectedStatus;
      bool matchesType = selectedSystemType == "All" || system["type"].toString().toLowerCase().replaceAll(" ", "_") == selectedSystemType;
      
      return matchesZone && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'armed':
        return primaryColor;
      case 'disarmed':
        return warningColor;
      case 'maintenance':
        return infoColor;
      case 'alarm':
        return dangerColor;
      case 'offline':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getHealthColor(String health) {
    switch (health.toLowerCase()) {
      case 'optimal':
        return successColor;
      case 'good':
        return infoColor;
      case 'fair':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'access control':
        return primaryColor;
      case 'cctv':
        return infoColor;
      case 'intrusion detection':
        return warningColor;
      case 'fire safety':
        return dangerColor;
      case 'panic button':
        return dangerColor;
      case 'environmental':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Systems"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              // Security dashboard
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // View alerts
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Security System Status Overview
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
                      Icon(
                        Icons.security,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security System Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "All Systems Operational",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    minItemWidth: 200,
                    children: [
                      _buildStatusCard(
                        "Total Systems",
                        "${securitySystems.length}",
                        primaryColor,
                        Icons.security,
                      ),
                      _buildStatusCard(
                        "Active",
                        "${securitySystems.where((s) => s["status"] == "Active").length}",
                        successColor,
                        Icons.check_circle,
                      ),
                      _buildStatusCard(
                        "Armed",
                        "${securitySystems.where((s) => s["status"] == "Armed").length}",
                        primaryColor,
                        Icons.shield,
                      ),
                      _buildStatusCard(
                        "Alerts Today",
                        "${securitySystems.fold<int>(0, (sum, s) => sum + (s["alertsToday"] as int))}",
                        warningColor,
                        Icons.warning,
                      ),
                      _buildStatusCard(
                        "Connected Devices",
                        "${securitySystems.fold<int>(0, (sum, s) => sum + (s["connectedDevices"] as int))}",
                        infoColor,
                        Icons.devices,
                      ),
                      _buildStatusCard(
                        "Maintenance Due",
                        "${securitySystems.where((s) => DateTime.parse(s["nextMaintenance"]).isBefore(DateTime.now().add(Duration(days: 30)))).length}",
                        warningColor,
                        Icons.build,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Filter Systems",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Zone",
                          items: zoneOptions,
                          value: selectedZone,
                          onChanged: (value, label) {
                            selectedZone = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "System Type",
                    items: systemTypeOptions,
                    value: selectedSystemType,
                    onChanged: (value, label) {
                      selectedSystemType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Security Systems List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Security Systems",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredSystems.length} systems found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredSystems.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final system = filteredSystems[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getTypeColor("${system["type"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${system["type"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getTypeColor("${system["type"]}"),
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
                                              color: _getStatusColor("${system["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${system["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${system["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${system["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${system["zone"]} - ${system["location"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getHealthColor("${system["systemHealth"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${system["systemHealth"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: _getHealthColor("${system["systemHealth"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    if (system["alertsToday"] != null && (system["alertsToday"] as int) > 0) ...[
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
                                          "${system["alertsToday"]} alerts",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: warningColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.devices,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${system["connectedDevices"]} devices",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.wifi,
                                              size: 12,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${system["signalStrength"]}",
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
                                  if (system["batteryLevel"] != null) ...[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.battery_std,
                                                size: 12,
                                                color: (system["batteryLevel"] as int) > 20 ? successColor : dangerColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${system["batteryLevel"]}%",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: (system["batteryLevel"] as int) > 20 ? successColor : dangerColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.schedule,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${system["lastActivity"]}",
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
                                  ],
                                  if (system["authorizedUsers"] != null) ...[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.people,
                                                size: 12,
                                                color: disabledBoldColor,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "${system["authorizedUsers"]} users",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (system["accessAttempts"] != null) ...[
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.login,
                                                  size: 12,
                                                  color: disabledBoldColor,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  "${system["accessAttempts"]} attempts",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledBoldColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border(
                                  left: BorderSide(
                                    color: infoColor,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 14,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${system["vendor"]} ${system["model"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${system["notes"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: _getActionLabel("${system["status"]}"),
                                    size: bs.sm,
                                    onPressed: () {
                                      _performAction(system);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.settings,
                                  size: bs.sm,
                                  onPressed: () {
                                    // System settings
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    // More options
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return "Monitor";
      case 'armed':
        return "Disarm";
      case 'disarmed':
        return "Arm System";
      case 'maintenance':
        return "View Status";
      case 'alarm':
        return "Acknowledge";
      case 'offline':
        return "Reconnect";
      default:
        return "View";
    }
  }

  void _performAction(Map<String, dynamic> system) {
    String status = "${system["status"]}";
    String action = _getActionLabel(status);
    ss("$action performed for ${system["name"]}");
  }
}
