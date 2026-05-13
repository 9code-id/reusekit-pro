import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaLocationUpdatesView extends StatefulWidget {
  const LtaLocationUpdatesView({super.key});

  @override
  State<LtaLocationUpdatesView> createState() => _LtaLocationUpdatesViewState();
}

class _LtaLocationUpdatesViewState extends State<LtaLocationUpdatesView> {
  String selectedVehicle = "";
  String selectedTimeRange = "Today";
  bool showRouteHistory = true;
  bool showSpeedAlerts = true;
  bool autoRefresh = true;

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "1",
      "name": "Truck Alpha-001",
      "driver": "John Smith",
      "status": "Moving",
      "lastUpdate": DateTime.now().subtract(Duration(minutes: 2)),
      "location": "Highway 101, Mile 245",
      "speed": 65,
      "heading": "North",
      "batteryLevel": 85,
      "signalStrength": 4,
      "lat": 37.7749,
      "lng": -122.4194,
    },
    {
      "id": "2",
      "name": "Van Beta-002",
      "driver": "Mike Johnson",
      "status": "Stopped",
      "lastUpdate": DateTime.now().subtract(Duration(minutes: 5)),
      "location": "Loading Dock A, Warehouse District",
      "speed": 0,
      "heading": "East",
      "batteryLevel": 92,
      "signalStrength": 5,
      "lat": 37.8044,
      "lng": -122.2712,
    },
    {
      "id": "3",
      "name": "Truck Gamma-003",
      "driver": "Sarah Davis",
      "status": "Offline",
      "lastUpdate": DateTime.now().subtract(Duration(hours: 2)),
      "location": "Unknown",
      "speed": 0,
      "heading": "Unknown",
      "batteryLevel": 12,
      "signalStrength": 0,
      "lat": 0.0,
      "lng": 0.0,
    },
    {
      "id": "4",
      "name": "Van Delta-004",
      "driver": "Robert Wilson",
      "status": "Moving",
      "lastUpdate": DateTime.now().subtract(Duration(minutes: 1)),
      "location": "Downtown Business District",
      "speed": 35,
      "heading": "South",
      "batteryLevel": 76,
      "signalStrength": 3,
      "lat": 37.7849,
      "lng": -122.4094,
    },
  ];

  List<Map<String, dynamic>> get vehicleOptions {
    return [
      {"label": "All Vehicles", "value": ""},
      ...vehicles.map((vehicle) => {
        "label": "${vehicle["name"]} - ${vehicle["driver"]}",
        "value": vehicle["id"],
      }).toList(),
    ];
  }

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last Hour", "value": "Last Hour"},
    {"label": "Today", "value": "Today"},
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "This Week", "value": "This Week"},
  ];

  List<Map<String, dynamic>> get filteredVehicles {
    if (selectedVehicle.isEmpty) return vehicles;
    return vehicles.where((vehicle) => vehicle["id"] == selectedVehicle).toList();
  }

  List<Map<String, dynamic>> locationHistory = [
    {
      "vehicleId": "1",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "location": "Highway 101, Mile 245",
      "speed": 65,
      "event": "Speed Update",
    },
    {
      "vehicleId": "1",
      "timestamp": DateTime.now().subtract(Duration(minutes: 8)),
      "location": "Highway 101, Mile 240",
      "speed": 70,
      "event": "Location Update",
    },
    {
      "vehicleId": "2",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      "location": "Loading Dock A, Warehouse District",
      "speed": 0,
      "event": "Vehicle Stopped",
    },
    {
      "vehicleId": "4",
      "timestamp": DateTime.now().subtract(Duration(minutes: 1)),
      "location": "Downtown Business District",
      "speed": 35,
      "event": "Route Change",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Updates"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // Simulate refresh
              });
              ss("Location data refreshed");
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters and Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
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
                        label: "Time Range",
                        items: timeRanges,
                        value: selectedTimeRange,
                        onChanged: (value, label) {
                          selectedTimeRange = value;
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
                      child: QSwitch(
                        items: [
                          {
                            "label": "Auto Refresh",
                            "value": "autoRefresh",
                            "checked": autoRefresh,
                          }
                        ],
                        value: [if (autoRefresh) {"label": "Auto Refresh", "value": "autoRefresh", "checked": true}],
                        onChanged: (values, ids) {
                          autoRefresh = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show Speed Alerts",
                            "value": "speedAlerts",
                            "checked": showSpeedAlerts,
                          }
                        ],
                        value: [if (showSpeedAlerts) {"label": "Show Speed Alerts", "value": "speedAlerts", "checked": true}],
                        onChanged: (values, ids) {
                          showSpeedAlerts = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Vehicle Status Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              border: Border(
                bottom: BorderSide(color: primaryColor.withAlpha(100)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${vehicles.where((v) => v["status"] == "Moving").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Moving",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${vehicles.where((v) => v["status"] == "Stopped").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Stopped",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${vehicles.where((v) => v["status"] == "Offline").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Offline",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${filteredVehicles.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Vehicle List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  ...List.generate(filteredVehicles.length, (index) {
                    final vehicle = filteredVehicles[index];
                    
                    Color statusColor;
                    IconData statusIcon;
                    
                    switch (vehicle["status"]) {
                      case "Moving":
                        statusColor = successColor;
                        statusIcon = Icons.directions_car;
                        break;
                      case "Stopped":
                        statusColor = warningColor;
                        statusIcon = Icons.pause_circle;
                        break;
                      default:
                        statusColor = dangerColor;
                        statusIcon = Icons.signal_wifi_off;
                    }

                    final lastUpdate = vehicle["lastUpdate"] as DateTime;
                    final minutesAgo = DateTime.now().difference(lastUpdate).inMinutes;
                    final isStale = minutesAgo > 15;

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
                            color: statusColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Vehicle Header
                          Row(
                            children: [
                              Icon(
                                statusIcon,
                                color: statusColor,
                                size: 32,
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${vehicle["name"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${vehicle["status"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "Driver: ${vehicle["driver"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Location Info
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current Location",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${vehicle["location"]}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (vehicle["status"] != "Offline") ...[
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Speed",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${vehicle["speed"]} km/h",
                                              style: TextStyle(
                                                color: vehicle["speed"] > 80 ? dangerColor : Colors.black,
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
                                              "Heading",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${vehicle["heading"]}",
                                              style: TextStyle(
                                                color: Colors.black,
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
                                              "Last Update",
                                              style: TextStyle(
                                                color: isStale ? dangerColor : primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${minutesAgo}m ago",
                                              style: TextStyle(
                                                color: isStale ? dangerColor : Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),

                          if (vehicle["status"] != "Offline") ...[
                            SizedBox(height: spMd),

                            // Signal and Battery Status
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: vehicle["batteryLevel"] < 20 ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.battery_full,
                                          color: vehicle["batteryLevel"] < 20 ? dangerColor : successColor,
                                          size: 20,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Battery",
                                                style: TextStyle(
                                                  color: vehicle["batteryLevel"] < 20 ? dangerColor : successColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${vehicle["batteryLevel"]}%",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
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
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.signal_cellular_4_bar,
                                          color: infoColor,
                                          size: 20,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Signal",
                                                style: TextStyle(
                                                  color: infoColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${vehicle["signalStrength"]}/5",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if (showSpeedAlerts && vehicle["speed"] > 80) ...[
                            SizedBox(height: spMd),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "Speed Alert: Vehicle exceeding speed limit",
                                      style: TextStyle(
                                        color: dangerColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          SizedBox(height: spMd),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View on Map",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Opening map view for ${vehicle["name"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Contact Driver",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Contacting ${vehicle["driver"]}");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  // Location History Section
                  if (showRouteHistory) ...[
                    SizedBox(height: spMd),
                    Container(
                      width: double.infinity,
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
                            "Recent Location Updates",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          ...List.generate(
                            locationHistory.take(5).length,
                            (index) {
                              final history = locationHistory[index];
                              final vehicle = vehicles.firstWhere((v) => v["id"] == history["vehicleId"]);
                              
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${vehicle["name"]} - ${history["event"]}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "${history["location"]} • ${history["speed"]} km/h",
                                            style: TextStyle(
                                              color: disabledBoldColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.now().difference(history["timestamp"] as DateTime).inMinutes}m ago",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          ss("Opening live tracking dashboard");
        },
        child: Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }
}
