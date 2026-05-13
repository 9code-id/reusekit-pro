import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaLiveTrackingView extends StatefulWidget {
  const LtaLiveTrackingView({super.key});

  @override
  State<LtaLiveTrackingView> createState() => _LtaLiveTrackingViewState();
}

class _LtaLiveTrackingViewState extends State<LtaLiveTrackingView> {
  bool loading = true;
  String selectedVehicle = "All Vehicles";
  String selectedDriver = "All Drivers";
  String viewMode = "Map";
  bool showOfflineVehicles = false;
  bool autoRefresh = true;

  List<Map<String, dynamic>> vehicleOptions = [
    {"label": "All Vehicles", "value": "All Vehicles"},
    {"label": "Truck TR-001", "value": "TR-001"},
    {"label": "Van VN-002", "value": "VN-002"},
    {"label": "Pickup PK-003", "value": "PK-003"},
    {"label": "Cargo CG-004", "value": "CG-004"},
  ];

  List<Map<String, dynamic>> driverOptions = [
    {"label": "All Drivers", "value": "All Drivers"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Johnson", "value": "david_johnson"},
    {"label": "Sarah Wilson", "value": "sarah_wilson"},
  ];

  List<Map<String, dynamic>> viewModeOptions = [
    {"label": "Map", "value": "Map"},
    {"label": "List", "value": "List"},
    {"label": "Grid", "value": "Grid"},
  ];

  List<Map<String, dynamic>> liveVehicles = [
    {
      "id": "TR-001",
      "name": "Truck TR-001",
      "driver": "John Smith",
      "status": "driving",
      "location": "Downtown District",
      "coordinates": {"lat": 37.7749, "lng": -122.4194},
      "speed": 45,
      "lastUpdate": "2024-03-15T14:30:00Z",
      "destination": "Warehouse District",
      "eta": "15 minutes",
      "battery": 85,
      "fuel": 68,
      "temperature": 22,
      "isOnline": true,
    },
    {
      "id": "VN-002",
      "name": "Van VN-002",
      "driver": "Maria Garcia",
      "status": "stopped",
      "location": "Shopping Center",
      "coordinates": {"lat": 37.7849, "lng": -122.4094},
      "speed": 0,
      "lastUpdate": "2024-03-15T14:25:00Z",
      "destination": "Delivery Zone A",
      "eta": "8 minutes",
      "battery": 92,
      "fuel": 78,
      "temperature": 20,
      "isOnline": true,
    },
    {
      "id": "PK-003",
      "name": "Pickup PK-003",
      "driver": "David Johnson",
      "status": "idle",
      "location": "Main Depot",
      "coordinates": {"lat": 37.7649, "lng": -122.4294},
      "speed": 0,
      "lastUpdate": "2024-03-15T14:20:00Z",
      "destination": "Standby",
      "eta": null,
      "battery": 67,
      "fuel": 45,
      "temperature": 24,
      "isOnline": true,
    },
    {
      "id": "CG-004",
      "name": "Cargo CG-004",
      "driver": "Sarah Wilson",
      "status": "offline",
      "location": "Unknown",
      "coordinates": {"lat": 37.7549, "lng": -122.4394},
      "speed": 0,
      "lastUpdate": "2024-03-15T13:45:00Z",
      "destination": "Unknown",
      "eta": null,
      "battery": 12,
      "fuel": 89,
      "temperature": null,
      "isOnline": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLiveTracking();
  }

  void _loadLiveTracking() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredVehicles {
    return liveVehicles.where((vehicle) {
      bool matchesVehicle = selectedVehicle == "All Vehicles" || 
          vehicle["id"] == selectedVehicle;
      
      bool matchesDriver = selectedDriver == "All Drivers" || 
          "${vehicle["driver"]}".toLowerCase().replaceAll(" ", "_") == selectedDriver;
      
      bool showOffline = showOfflineVehicles || (vehicle["isOnline"] as bool);
      
      return matchesVehicle && matchesDriver && showOffline;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "driving":
        return successColor;
      case "stopped":
        return warningColor;
      case "idle":
        return infoColor;
      case "offline":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "driving":
        return Icons.directions_car;
      case "stopped":
        return Icons.pause_circle;
      case "idle":
        return Icons.radio_button_unchecked;
      case "offline":
        return Icons.signal_wifi_off;
      default:
        return Icons.location_on;
    }
  }

  String _getTimeAgo(String lastUpdate) {
    DateTime updateTime = DateTime.parse(lastUpdate);
    DateTime now = DateTime.now();
    Duration difference = now.difference(updateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Live Tracking"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayVehicles = filteredVehicles;

    return Scaffold(
      appBar: AppBar(
        title: Text("Live Tracking"),
        actions: [
          IconButton(
            icon: Icon(autoRefresh ? Icons.refresh : Icons.refresh_outlined),
            onPressed: () {
              autoRefresh = !autoRefresh;
              setState(() {});
              if (autoRefresh) {
                ss("Auto-refresh enabled");
              } else {
                sw("Auto-refresh disabled");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Open tracking settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Status Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Fleet Status",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${liveVehicles.where((v) => v["status"] == "driving").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Driving",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
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
                            color: warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${liveVehicles.where((v) => v["status"] == "stopped").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Stopped",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
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
                            color: infoColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${liveVehicles.where((v) => v["status"] == "idle").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Idle",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
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
                            color: disabledBoldColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${liveVehicles.where((v) => v["status"] == "offline").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Offline",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters and View Mode
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Vehicle",
                    items: vehicleOptions,
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Driver",
                    items: driverOptions,
                    value: selectedDriver,
                    onChanged: (value, label) {
                      selectedDriver = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "View Mode",
                    items: viewModeOptions,
                    value: viewMode,
                    onChanged: (value, label) {
                      viewMode = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Toggle Options
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Offline Vehicles",
                        "value": true,
                        "checked": showOfflineVehicles,
                      }
                    ],
                    value: [
                      if (showOfflineVehicles)
                        {
                          "label": "Show Offline Vehicles",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOfflineVehicles = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Auto Refresh",
                        "value": true,
                        "checked": autoRefresh,
                      }
                    ],
                    value: [
                      if (autoRefresh)
                        {
                          "label": "Auto Refresh",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoRefresh = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Live Vehicles
            if (viewMode == "Map")
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Interactive Map View",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Real-time vehicle positions",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Vehicle markers simulation
                    ...displayVehicles.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> vehicle = entry.value;
                      double left = 50.0 + (index * 40.0);
                      double top = 80.0 + (index * 30.0);
                      
                      return Positioned(
                        left: left,
                        top: top,
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${vehicle["status"]}"),
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.local_shipping,
                                size: 12,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${vehicle["id"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              )
            else
              Column(
                children: displayVehicles.map((vehicle) {
                  bool isOnline = vehicle["isOnline"] as bool;
                  String status = "${vehicle["status"]}";
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getStatusColor(status),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getStatusIcon(status),
                                  size: 16,
                                  color: _getStatusColor(status),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${vehicle["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${vehicle["driver"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Location and Status Info
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: primaryColor,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            "${vehicle["location"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (vehicle["destination"] != "Standby" && vehicle["destination"] != "Unknown")
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.navigation,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "To: ${vehicle["destination"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (vehicle["eta"] != null)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${vehicle["eta"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Text(
                                    _getTimeAgo("${vehicle["lastUpdate"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          if (isOnline) ...[
                            SizedBox(height: spSm),
                            // Vehicle Stats
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.speed,
                                        size: 14,
                                        color: infoColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${vehicle["speed"]} km/h",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_gas_station,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${vehicle["fuel"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.battery_charging_full,
                                        size: 14,
                                        color: successColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${vehicle["battery"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (vehicle["temperature"] != null)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.thermostat,
                                          size: 14,
                                          color: primaryColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${vehicle["temperature"]}°C",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ],

                          SizedBox(height: spSm),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to vehicle details
                                  },
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {
                                  // Contact driver
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
                    ),
                  );
                }).toList(),
              ),

            // Quick Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
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
                          label: "Emergency Alert",
                          icon: Icons.emergency,
                          size: bs.sm,
                          onPressed: () {
                            // Send emergency alert
                          },
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QButton(
                          label: "Broadcast Message",
                          icon: Icons.campaign,
                          size: bs.sm,
                          onPressed: () {
                            // Send broadcast
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
