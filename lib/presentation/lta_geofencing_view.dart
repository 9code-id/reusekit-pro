import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaGeofencingView extends StatefulWidget {
  const LtaGeofencingView({super.key});

  @override
  State<LtaGeofencingView> createState() => _LtaGeofencingViewState();
}

class _LtaGeofencingViewState extends State<LtaGeofencingView> {
  String selectedZoneType = "Delivery Zone";
  bool alertsEnabled = true;
  bool autoNotifications = true;
  String selectedVehicle = "TRK-001";

  final List<Map<String, dynamic>> geofenceZones = [
    {
      "id": "GZ001",
      "name": "Downtown Delivery Zone",
      "type": "Delivery Zone",
      "radius": 2.5,
      "center": {"lat": 40.7128, "lng": -74.0060},
      "status": "Active",
      "vehicles": 12,
      "violations": 3,
      "color": "primary"
    },
    {
      "id": "GZ002", 
      "name": "Airport Restricted Area",
      "type": "Restricted Zone",
      "radius": 5.0,
      "center": {"lat": 40.6892, "lng": -74.1745},
      "status": "Active",
      "vehicles": 0,
      "violations": 0,
      "color": "danger"
    },
    {
      "id": "GZ003",
      "name": "Warehouse District",
      "type": "Loading Zone", 
      "radius": 1.8,
      "center": {"lat": 40.7282, "lng": -74.0776},
      "status": "Active",
      "vehicles": 8,
      "violations": 1,
      "color": "success"
    },
    {
      "id": "GZ004",
      "name": "School Safety Zone",
      "type": "Safety Zone",
      "radius": 0.5,
      "center": {"lat": 40.7589, "lng": -73.9851},
      "status": "Monitoring",
      "vehicles": 2,
      "violations": 0,
      "color": "warning"
    },
    {
      "id": "GZ005",
      "name": "City Center Mall",
      "type": "Delivery Zone",
      "radius": 1.2,
      "center": {"lat": 40.7505, "lng": -73.9934},
      "status": "Inactive",
      "vehicles": 0,
      "violations": 0,
      "color": "disabled"
    }
  ];

  final List<Map<String, dynamic>> recentAlerts = [
    {
      "id": "AL001",
      "vehicle": "TRK-001",
      "driver": "John Smith",
      "zone": "Downtown Delivery Zone",
      "type": "Entry",
      "time": "2 minutes ago",
      "status": "Normal"
    },
    {
      "id": "AL002",
      "vehicle": "VAN-005",
      "driver": "Mike Johnson", 
      "zone": "Airport Restricted Area",
      "type": "Violation",
      "time": "15 minutes ago",
      "status": "Critical"
    },
    {
      "id": "AL003",
      "vehicle": "TRK-003",
      "driver": "Sarah Davis",
      "zone": "Warehouse District",
      "type": "Exit",
      "time": "32 minutes ago",
      "status": "Normal"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geofencing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_location_alt),
            onPressed: () => _showCreateGeofenceDialog(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showGeofenceSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Active Zones",
                    "${geofenceZones.where((z) => z["status"] == "Active").length}",
                    Icons.location_on,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Vehicles Tracked",
                    "${geofenceZones.fold(0, (sum, zone) => sum + (zone["vehicles"] as int))}",
                    Icons.local_shipping,
                    successColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Today's Alerts",
                    "${recentAlerts.length}",
                    Icons.notifications_active,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Violations",
                    "${geofenceZones.fold(0, (sum, zone) => sum + (zone["violations"] as int))}",
                    Icons.warning,
                    dangerColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Zone Filter
            Text(
              "Geofence Zones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QCategoryPicker(
              items: [
                {"label": "All Zones", "value": "All"},
                {"label": "Delivery Zone", "value": "Delivery Zone"},
                {"label": "Restricted Zone", "value": "Restricted Zone"},
                {"label": "Loading Zone", "value": "Loading Zone"},
                {"label": "Safety Zone", "value": "Safety Zone"},
              ],
              value: selectedZoneType,
              onChanged: (index, label, value, item) {
                selectedZoneType = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Geofence Zones List
            ...geofenceZones
                .where((zone) => selectedZoneType == "All" || zone["type"] == selectedZoneType)
                .map((zone) => _buildGeofenceZoneCard(zone)),

            SizedBox(height: spLg),

            // Recent Alerts Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //navigateTo('LtaGeofenceAlertsView');
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            ...recentAlerts.map((alert) => _buildAlertCard(alert)),

            SizedBox(height: spLg),

            // Quick Actions
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
                    label: "Create New Zone",
                    icon: Icons.add_location,
                    size: bs.md,
                    onPressed: () => _showCreateGeofenceDialog(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Zone Analytics",
                    icon: Icons.analytics,
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('LtaGeofenceAnalyticsView');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeofenceZoneCard(Map<String, dynamic> zone) {
    Color statusColor = zone["status"] == "Active" 
        ? successColor 
        : zone["status"] == "Monitoring"
            ? warningColor
            : disabledBoldColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: zone["color"] == "primary" ? primaryColor :
                   zone["color"] == "success" ? successColor :
                   zone["color"] == "warning" ? warningColor :
                   zone["color"] == "danger" ? dangerColor : disabledBoldColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${zone["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${zone["type"]} • ${zone["radius"]} km radius",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${zone["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildZoneInfoItem(
                  Icons.local_shipping,
                  "${zone["vehicles"]} Vehicles",
                ),
              ),
              Expanded(
                child: _buildZoneInfoItem(
                  Icons.warning,
                  "${zone["violations"]} Violations",
                ),
              ),
              Expanded(
                child: _buildZoneInfoItem(
                  Icons.location_on,
                  "${zone["id"]}",
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showZoneDetails(zone),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editGeofenceZone(zone),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showZoneMenu(zone),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildZoneInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color alertColor = alert["status"] == "Critical" ? dangerColor : primaryColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 3,
            color: alertColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: alertColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              alert["type"] == "Entry" ? Icons.login :
              alert["type"] == "Exit" ? Icons.logout :
              Icons.warning,
              color: alertColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${alert["vehicle"]} - ${alert["driver"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${alert["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["type"]} • ${alert["zone"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateGeofenceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Geofence Zone"),
        content: Text("Create new geofence zone functionality would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Geofence zone created successfully");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showZoneDetails(Map<String, dynamic> zone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${zone["name"]} Details",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text("Zone details and map view would be displayed here."),
          ],
        ),
      ),
    );
  }

  void _editGeofenceZone(Map<String, dynamic> zone) {
    si("Edit zone: ${zone["name"]}");
  }

  void _showZoneMenu(Map<String, dynamic> zone) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Zone"),
              onTap: () {
                back();
                _editGeofenceZone(zone);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate Zone"),
              onTap: () {
                back();
                si("Zone duplicated");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Zone", style: TextStyle(color: dangerColor)),
              onTap: () async {
                back();
                bool isConfirmed = await confirm("Are you sure you want to delete this zone?");
                if (isConfirmed) {
                  ss("Zone deleted successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showGeofenceSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Geofence Settings",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QSwitch(
                items: [
                  {
                    "label": "Enable Real-time Alerts",
                    "value": true,
                    "checked": alertsEnabled,
                  }
                ],
                value: [if (alertsEnabled) {"label": "Enable Real-time Alerts", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setModalState(() {
                    alertsEnabled = values.isNotEmpty;
                  });
                },
              ),
              SizedBox(height: spSm),
              QSwitch(
                items: [
                  {
                    "label": "Auto-send Notifications",
                    "value": true,
                    "checked": autoNotifications,
                  }
                ],
                value: [if (autoNotifications) {"label": "Auto-send Notifications", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  setModalState(() {
                    autoNotifications = values.isNotEmpty;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
