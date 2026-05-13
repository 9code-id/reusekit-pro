import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaGeofencingView extends StatefulWidget {
  const DlaGeofencingView({super.key});

  @override
  State<DlaGeofencingView> createState() => _DlaGeofencingViewState();
}

class _DlaGeofencingViewState extends State<DlaGeofencingView> {
  bool isGeofencingEnabled = true;
  String selectedZoneFilter = "All";
  
  List<Map<String, dynamic>> zoneFilters = [
    {"label": "All", "count": 8},
    {"label": "Active", "count": 5},
    {"label": "Inactive", "count": 3},
  ];

  List<Map<String, dynamic>> geofenceZones = [
    {
      "name": "Main Warehouse Zone",
      "address": "1234 Industrial Drive, Commerce City",
      "radius": "500m",
      "type": "Warehouse",
      "status": "Active",
      "vehicles": 3,
      "alerts": 0,
      "lastTriggered": "2 hours ago"
    },
    {
      "name": "Downtown Delivery Zone",
      "address": "456 Central Avenue, Downtown",
      "radius": "1.2km",
      "type": "Delivery Zone",
      "status": "Active",
      "vehicles": 2,
      "alerts": 1,
      "lastTriggered": "15 minutes ago"
    },
    {
      "name": "Restricted Area - Airport",
      "address": "789 Airport Road",
      "radius": "2.5km",
      "type": "Restricted",
      "status": "Active", 
      "vehicles": 0,
      "alerts": 3,
      "lastTriggered": "1 day ago"
    },
    {
      "name": "Gas Station Service Zone",
      "address": "321 Highway 101",
      "radius": "200m",
      "type": "Service",
      "status": "Inactive",
      "vehicles": 1,
      "alerts": 0,
      "lastTriggered": "3 days ago"
    },
    {
      "name": "Customer Pickup Zone",
      "address": "654 Oak Street Business Center",
      "radius": "300m",
      "type": "Pickup",
      "status": "Active",
      "vehicles": 0,
      "alerts": 0,
      "lastTriggered": "6 hours ago"
    },
  ];

  List<Map<String, dynamic>> recentAlerts = [
    {
      "type": "Entry",
      "zone": "Downtown Delivery Zone",
      "vehicle": "DL-001",
      "time": "15 minutes ago",
      "severity": "Info"
    },
    {
      "type": "Exit",
      "zone": "Main Warehouse Zone", 
      "vehicle": "DL-002",
      "time": "2 hours ago",
      "severity": "Info"
    },
    {
      "type": "Unauthorized Entry",
      "zone": "Restricted Area - Airport",
      "vehicle": "DL-003",
      "time": "1 day ago",
      "severity": "High"
    },
    {
      "type": "Speed Violation",
      "zone": "Downtown Delivery Zone",
      "vehicle": "DL-001",
      "time": "2 days ago",
      "severity": "Medium"
    },
  ];

  Map<String, dynamic> geofenceStats = {
    "totalZones": 8,
    "activeZones": 5,
    "alertsToday": 4,
    "vehiclesTracked": 6
  };

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredZones = selectedZoneFilter == "All" 
        ? geofenceZones 
        : geofenceZones.where((zone) => 
            zone["status"] == selectedZoneFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Geofencing"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new geofence zone");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeofencingStatus(),
            SizedBox(height: spMd),
            _buildGeofenceStats(),
            SizedBox(height: spMd),
            _buildZoneFilters(),
            SizedBox(height: spMd),
            _buildRecentAlerts(),
            SizedBox(height: spMd),
            _buildGeofenceZones(filteredZones),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          ss("Map view opened");
        },
        child: Icon(Icons.map, color: Colors.white),
      ),
    );
  }

  Widget _buildGeofencingStatus() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isGeofencingEnabled ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isGeofencingEnabled ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isGeofencingEnabled ? successColor : dangerColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isGeofencingEnabled ? Icons.location_searching : Icons.location_disabled,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGeofencingEnabled ? "Geofencing Active" : "Geofencing Disabled",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isGeofencingEnabled ? successColor : dangerColor,
                  ),
                ),
                Text(
                  isGeofencingEnabled 
                      ? "Monitoring ${geofenceStats["activeZones"]} active zones"
                      : "Enable geofencing to monitor zones",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isGeofencingEnabled,
            onChanged: (value) {
              isGeofencingEnabled = value;
              setState(() {});
              ss(value ? "Geofencing enabled" : "Geofencing disabled");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGeofenceStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.location_city, color: primaryColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${geofenceStats["totalZones"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Zones",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${geofenceStats["activeZones"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Active",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(Icons.warning, color: warningColor, size: 32),
                SizedBox(height: spSm),
                Text(
                  "${geofenceStats["alertsToday"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Alerts Today",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildZoneFilters() {
    return QCategoryPicker(
      items: zoneFilters.map((filter) => {
        "label": "${filter["label"]} (${filter["count"]})",
        "value": filter["label"],
      }).toList(),
      value: selectedZoneFilter,
      onChanged: (index, label, value, item) {
        selectedZoneFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildRecentAlerts() {
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
            children: [
              Text(
                "Recent Alerts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("View all alerts");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: List.generate(recentAlerts.take(3).length, (index) {
              final alert = recentAlerts[index];
              Color severityColor = alert["severity"] == "High" ? dangerColor :
                                  alert["severity"] == "Medium" ? warningColor :
                                  infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: index < 2 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: severityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: severityColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: severityColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        alert["type"] == "Entry" ? Icons.login :
                        alert["type"] == "Exit" ? Icons.logout :
                        alert["type"] == "Unauthorized Entry" ? Icons.block :
                        Icons.speed,
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
                            "${alert["type"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${alert["zone"]} • Vehicle ${alert["vehicle"]}",
                            style: TextStyle(
                              fontSize: 12,
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
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: severityColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${alert["severity"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${alert["time"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGeofenceZones(List<Map<String, dynamic>> zones) {
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
            children: [
              Text(
                "Geofence Zones",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${zones.length} zones",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: List.generate(zones.length, (index) {
              final zone = zones[index];
              Color typeColor = zone["type"] == "Warehouse" ? primaryColor :
                               zone["type"] == "Restricted" ? dangerColor :
                               zone["type"] == "Service" ? warningColor :
                               zone["type"] == "Pickup" ? infoColor :
                               successColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: index < zones.length - 1 ? spMd : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            zone["type"] == "Warehouse" ? Icons.warehouse :
                            zone["type"] == "Restricted" ? Icons.block :
                            zone["type"] == "Service" ? Icons.local_gas_station :
                            zone["type"] == "Pickup" ? Icons.business :
                            Icons.location_on,
                            color: typeColor,
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
                                      "${zone["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: zone["status"] == "Active" ? successColor : dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${zone["address"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ss("Zone settings for ${zone["name"]}");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(Icons.settings, color: primaryColor, size: 18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.radio_button_unchecked, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Radius: ${zone["radius"]}",
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
                              Icon(Icons.local_shipping, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${zone["vehicles"]} vehicles",
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
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                size: 14,
                                color: (zone["alerts"] as int) > 0 ? warningColor : disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${zone["alerts"]} alerts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (zone["alerts"] as int) > 0 ? warningColor : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Last: ${zone["lastTriggered"]}",
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
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: typeColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${zone["type"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: zone["status"] == "Active" ? successColor : dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${zone["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
