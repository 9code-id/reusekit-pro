import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmGeofencingView extends StatefulWidget {
  const FsmGeofencingView({super.key});

  @override
  State<FsmGeofencingView> createState() => _FsmGeofencingViewState();
}

class _FsmGeofencingViewState extends State<FsmGeofencingView> {
  String selectedGeofenceType = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool enableNotifications = true;
  bool enableAutoAlerts = true;
  bool trackEntryExit = true;
  
  String newGeofenceName = "";
  String newGeofenceType = "customer_site";
  double newGeofenceRadius = 100.0;
  String newGeofenceAddress = "";
  double newGeofenceLatitude = 37.7749;
  double newGeofenceLongitude = -122.4194;
  
  List<Map<String, dynamic>> geofences = [
    {
      "id": "GF001",
      "name": "Downtown Service Area",
      "type": "service_area",
      "address": "123 Main St, Downtown",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "radius": 500.0,
      "status": "active",
      "createdDate": "2024-03-01",
      "assignedTechnicians": 5,
      "totalEvents": 47,
      "todayEvents": 8,
      "lastTriggered": "2024-03-15 14:30",
      "alertsEnabled": true,
      "description": "Main downtown business district coverage area"
    },
    {
      "id": "GF002", 
      "name": "ABC Corporation HQ",
      "type": "customer_site",
      "address": "456 Corporate Blvd, Business Park",
      "latitude": 37.7849,
      "longitude": -122.4094,
      "radius": 150.0,
      "status": "active",
      "createdDate": "2024-02-15",
      "assignedTechnicians": 3,
      "totalEvents": 23,
      "todayEvents": 2,
      "lastTriggered": "2024-03-15 10:15",
      "alertsEnabled": true,
      "description": "Primary customer site with multiple service contracts"
    },
    {
      "id": "GF003",
      "name": "Tech Manufacturing Plant",
      "type": "customer_site", 
      "address": "789 Industrial Way, Tech Park",
      "latitude": 37.7649,
      "longitude": -122.4294,
      "radius": 200.0,
      "status": "active",
      "createdDate": "2024-01-20",
      "assignedTechnicians": 4,
      "totalEvents": 31,
      "todayEvents": 5,
      "lastTriggered": "2024-03-15 16:45",
      "alertsEnabled": true,
      "description": "Critical manufacturing facility requiring immediate response"
    },
    {
      "id": "GF004",
      "name": "East Side Depot",
      "type": "depot",
      "address": "321 Warehouse Dr, East Side",
      "latitude": 37.7549,
      "longitude": -122.3994,
      "radius": 100.0,
      "status": "active",
      "createdDate": "2024-02-28",
      "assignedTechnicians": 8,
      "totalEvents": 156,
      "todayEvents": 12,
      "lastTriggered": "2024-03-15 17:20",
      "alertsEnabled": true,
      "description": "Equipment and parts storage facility"
    },
    {
      "id": "GF005",
      "name": "Restricted Zone Alpha",
      "type": "restricted_area",
      "address": "987 Security Blvd, Government District", 
      "latitude": 37.7949,
      "longitude": -122.4394,
      "radius": 250.0,
      "status": "active",
      "createdDate": "2024-03-05",
      "assignedTechnicians": 2,
      "totalEvents": 8,
      "todayEvents": 0,
      "lastTriggered": "2024-03-12 09:30",
      "alertsEnabled": true,
      "description": "High security area requiring special clearance"
    },
    {
      "id": "GF006",
      "name": "Old Service Center",
      "type": "depot",
      "address": "654 Legacy St, Old Town",
      "latitude": 37.7349,
      "longitude": -122.4494,
      "radius": 75.0,
      "status": "inactive",
      "createdDate": "2023-12-15",
      "assignedTechnicians": 0,
      "totalEvents": 89,
      "todayEvents": 0,
      "lastTriggered": "2024-02-28 11:45",
      "alertsEnabled": false,
      "description": "Decommissioned service center"
    }
  ];

  List<Map<String, dynamic>> recentEvents = [
    {
      "id": "EV001",
      "geofenceId": "GF004",
      "geofenceName": "East Side Depot",
      "technician": "John Smith",
      "eventType": "entry",
      "timestamp": "2024-03-15 17:20",
      "duration": "15 mins",
      "vehicle": "VH-101"
    },
    {
      "id": "EV002",
      "geofenceId": "GF003", 
      "geofenceName": "Tech Manufacturing Plant",
      "technician": "Sarah Johnson",
      "eventType": "exit",
      "timestamp": "2024-03-15 16:45",
      "duration": "2 hrs 30 mins",
      "vehicle": "VH-205"
    },
    {
      "id": "EV003",
      "geofenceId": "GF001",
      "geofenceName": "Downtown Service Area",
      "technician": "Mike Davis",
      "eventType": "entry",
      "timestamp": "2024-03-15 14:30", 
      "duration": "45 mins",
      "vehicle": "VH-103"
    },
    {
      "id": "EV004",
      "geofenceId": "GF002",
      "geofenceName": "ABC Corporation HQ",
      "technician": "Lisa Wilson",
      "eventType": "exit",
      "timestamp": "2024-03-15 10:15",
      "duration": "1 hr 20 mins",
      "vehicle": "VH-178"
    }
  ];

  List<Map<String, dynamic>> geofenceTypes = [
    {"label": "All Types", "value": "all"},
    {"label": "Customer Sites", "value": "customer_site"},
    {"label": "Service Areas", "value": "service_area"},
    {"label": "Depots", "value": "depot"},
    {"label": "Restricted Areas", "value": "restricted_area"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"}
  ];

  List<Map<String, dynamic>> newGeofenceTypes = [
    {"label": "Customer Site", "value": "customer_site"},
    {"label": "Service Area", "value": "service_area"},
    {"label": "Depot", "value": "depot"},
    {"label": "Restricted Area", "value": "restricted_area"}
  ];

  List<Map<String, dynamic>> get filteredGeofences {
    return geofences.where((geofence) {
      bool matchesType = selectedGeofenceType == "all" || 
          geofence["type"] == selectedGeofenceType;
      
      bool matchesStatus = selectedStatus == "all" ||
          geofence["status"] == selectedStatus;
      
      bool matchesSearch = searchQuery.isEmpty ||
          geofence["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          geofence["address"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesType && matchesStatus && matchesSearch;
    }).toList();
  }

  void _createGeofence() {
    if (newGeofenceName.isNotEmpty && newGeofenceAddress.isNotEmpty) {
      final newGeofence = {
        "id": "GF${(geofences.length + 1).toString().padLeft(3, '0')}",
        "name": newGeofenceName,
        "type": newGeofenceType,
        "address": newGeofenceAddress,
        "latitude": newGeofenceLatitude,
        "longitude": newGeofenceLongitude,
        "radius": newGeofenceRadius,
        "status": "active",
        "createdDate": DateTime.now().toString().split(' ')[0],
        "assignedTechnicians": 0,
        "totalEvents": 0,
        "todayEvents": 0,
        "lastTriggered": "Never",
        "alertsEnabled": true,
        "description": "New geofence created"
      };
      
      geofences.insert(0, newGeofence);
      
      // Reset form
      newGeofenceName = "";
      newGeofenceType = "customer_site";
      newGeofenceRadius = 100.0;
      newGeofenceAddress = "";
      newGeofenceLatitude = 37.7749;
      newGeofenceLongitude = -122.4194;
      
      back();
      ss("Geofence created successfully");
      setState(() {});
    } else {
      se("Please fill in all required fields");
    }
  }

  void _editGeofence(Map<String, dynamic> geofence) {
    newGeofenceName = geofence["name"];
    newGeofenceType = geofence["type"];
    newGeofenceRadius = geofence["radius"];
    newGeofenceAddress = geofence["address"];
    newGeofenceLatitude = geofence["latitude"];
    newGeofenceLongitude = geofence["longitude"];
    
    _showGeofenceForm(isEdit: true, geofence: geofence);
  }

  void _updateGeofence(Map<String, dynamic> geofence) {
    if (newGeofenceName.isNotEmpty && newGeofenceAddress.isNotEmpty) {
      final index = geofences.indexWhere((g) => g["id"] == geofence["id"]);
      if (index != -1) {
        geofences[index] = {
          ...geofence,
          "name": newGeofenceName,
          "type": newGeofenceType,
          "address": newGeofenceAddress,
          "latitude": newGeofenceLatitude,
          "longitude": newGeofenceLongitude,
          "radius": newGeofenceRadius,
        };
        
        back();
        ss("Geofence updated successfully");
        setState(() {});
      }
    } else {
      se("Please fill in all required fields");
    }
  }

  void _toggleGeofenceStatus(Map<String, dynamic> geofence) {
    final index = geofences.indexWhere((g) => g["id"] == geofence["id"]);
    if (index != -1) {
      geofences[index]["status"] = geofence["status"] == "active" ? "inactive" : "active";
      ss("Geofence ${geofence["status"] == "active" ? "deactivated" : "activated"}");
      setState(() {});
    }
  }

  void _deleteGeofence(Map<String, dynamic> geofence) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this geofence?");
    if (isConfirmed) {
      geofences.removeWhere((g) => g["id"] == geofence["id"]);
      ss("Geofence deleted successfully");
      setState(() {});
    }
  }

  void _showGeofenceForm({bool isEdit = false, Map<String, dynamic>? geofence}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isEdit ? "Edit Geofence" : "Create New Geofence",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  spacing: spMd,
                  children: [
                    QTextField(
                      label: "Geofence Name",
                      value: newGeofenceName,
                      hint: "Enter geofence name",
                      validator: Validator.required,
                      onChanged: (value) {
                        newGeofenceName = value;
                        setState(() {});
                      },
                    ),
                    
                    QDropdownField(
                      label: "Geofence Type",
                      items: newGeofenceTypes,
                      value: newGeofenceType,
                      onChanged: (value, label) {
                        newGeofenceType = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Address",
                      value: newGeofenceAddress,
                      hint: "Enter address or location",
                      validator: Validator.required,
                      onChanged: (value) {
                        newGeofenceAddress = value;
                        setState(() {});
                      },
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Latitude",
                            value: newGeofenceLatitude.toString(),
                            validator: Validator.required,
                            onChanged: (value) {
                              newGeofenceLatitude = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Longitude",
                            value: newGeofenceLongitude.toString(),
                            validator: Validator.required,
                            onChanged: (value) {
                              newGeofenceLongitude = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    QNumberField(
                      label: "Radius (meters)",
                      value: newGeofenceRadius.toString(),
                      validator: Validator.required,
                      onChanged: (value) {
                        newGeofenceRadius = double.tryParse(value) ?? 100.0;
                        setState(() {});
                      },
                    ),
                    
                    // Map Preview (Simulated)
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 48,
                                  color: primaryColor,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Map Preview",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Radius: ${newGeofenceRadius.toInt()}m",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: QButton(
                              icon: Icons.my_location,
                              size: bs.sm,
                              onPressed: () {
                                si("Getting current location...");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    QButton(
                      label: isEdit ? "Update Geofence" : "Create Geofence",
                      onPressed: () {
                        if (isEdit && geofence != null) {
                          _updateGeofence(geofence);
                        } else {
                          _createGeofence();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      // Reset form when modal is closed
      newGeofenceName = "";
      newGeofenceType = "customer_site";
      newGeofenceRadius = 100.0;
      newGeofenceAddress = "";
      newGeofenceLatitude = 37.7749;
      newGeofenceLongitude = -122.4194;
      setState(() {});
    });
  }

  void _viewGeofenceDetails(Map<String, dynamic> geofence) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${geofence["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${geofence["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${geofence["assignedTechnicians"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Assigned\nTechnicians",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${geofence["totalEvents"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Total\nEvents",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${geofence["todayEvents"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Today's\nEvents",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Details
                    Text(
                      "Geofence Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category, size: 16, color: disabledBoldColor),
                              SizedBox(width: spSm),
                              Text("Type:", style: TextStyle(fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text("${geofence["type"]}".replaceAll('_', ' ').toUpperCase()),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.radio_button_checked, size: 16, color: disabledBoldColor),
                              SizedBox(width: spSm),
                              Text("Radius:", style: TextStyle(fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text("${(geofence["radius"] as double).toInt()} meters"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                              SizedBox(width: spSm),
                              Text("Last Triggered:", style: TextStyle(fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text("${geofence["lastTriggered"]}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                              SizedBox(width: spSm),
                              Text("Created:", style: TextStyle(fontWeight: FontWeight.w600)),
                              Spacer(),
                              Text("${geofence["createdDate"]}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    // Map View (Simulated)
                    Text(
                      "Location Map",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(60),
                                shape: BoxShape.circle,
                                border: Border.all(color: primaryColor, width: 2),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: primaryColor,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                                boxShadow: [shadowSm],
                              ),
                              child: Text(
                                "Radius: ${(geofence["radius"] as double).toInt()}m",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
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
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "customer_site":
        return primaryColor;
      case "service_area":
        return infoColor;
      case "depot":
        return warningColor;
      case "restricted_area":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geofencing"),
        actions: [
          GestureDetector(
            onTap: () {
              si("Opening geofencing analytics");
            },
            child: Icon(Icons.analytics),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _showGeofenceForm(),
            child: Icon(Icons.add),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Geofencing Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable notifications for geofence events",
                        "value": true,
                        "checked": enableNotifications,
                      }
                    ],
                    value: [
                      if (enableNotifications)
                        {
                          "label": "Enable notifications for geofence events",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableNotifications = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Enable automatic alerts for unauthorized entry",
                        "value": true,
                        "checked": enableAutoAlerts,
                      }
                    ],
                    value: [
                      if (enableAutoAlerts)
                        {
                          "label": "Enable automatic alerts for unauthorized entry",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      enableAutoAlerts = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Track entry and exit timestamps",
                        "value": true,
                        "checked": trackEntryExit,
                      }
                    ],
                    value: [
                      if (trackEntryExit)
                        {
                          "label": "Track entry and exit timestamps",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      trackEntryExit = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
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
                        child: QDropdownField(
                          label: "Geofence Type",
                          items: geofenceTypes,
                          value: selectedGeofenceType,
                          onChanged: (value, label) {
                            selectedGeofenceType = value;
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
                  SizedBox(height: spSm),
                  QTextField(
                    label: "Search Geofences",
                    value: searchQuery,
                    hint: "Search by name or address",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredGeofences.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Geofences",
                          textAlign: TextAlign.center,
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredGeofences.where((g) => g["status"] == "active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          textAlign: TextAlign.center,
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredGeofences.map((g) => g["todayEvents"] as int).fold(0, (sum, events) => sum + events)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Today's Events",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Geofences List
            Text(
              "Geofences (${filteredGeofences.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(filteredGeofences.length, (index) {
              final geofence = filteredGeofences[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getTypeColor(geofence["type"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${geofence["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${geofence["type"]}".replaceAll('_', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getTypeColor(geofence["type"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(geofence["status"]),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${geofence["status"]}".toUpperCase(),
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
                      "${geofence["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${(geofence["radius"] as double).toInt()}m",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Radius",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${geofence["assignedTechnicians"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Technicians",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${geofence["totalEvents"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Events",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
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
                                "${geofence["todayEvents"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: geofence["todayEvents"] > 0 ? warningColor : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Today",
                                style: TextStyle(
                                  fontSize: 10,
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
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () => _viewGeofenceDetails(geofence),
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () => _editGeofence(geofence),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: geofence["status"] == "active" ? Icons.pause : Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () => _toggleGeofenceStatus(geofence),
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () => _deleteGeofence(geofence),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            
            if (filteredGeofences.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Geofences Found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Create your first geofence or adjust your filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Geofence",
                      size: bs.sm,
                      onPressed: () => _showGeofenceForm(),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Recent Events
            Text(
              "Recent Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(recentEvents.length, (index) {
              final event = recentEvents[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: event["eventType"] == "entry" ? successColor : warningColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${event["technician"]} ${event["eventType"]} ${event["geofenceName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${event["timestamp"]} • Duration: ${event["duration"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: event["eventType"] == "entry" ? successColor : warningColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${event["eventType"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
