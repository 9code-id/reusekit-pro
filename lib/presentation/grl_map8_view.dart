import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMap8View extends StatefulWidget {
  @override
  State<GrlMap8View> createState() => _GrlMap8ViewState();
}

class _GrlMap8ViewState extends State<GrlMap8View> {
  String selectedIncidentType = "all";
  bool loading = false;
  
  final List<Map<String, dynamic>> emergencyIncidents = [
    {
      "id": "INC001",
      "type": "fire",
      "severity": "high",
      "title": "Structure Fire",
      "description": "Two-alarm fire at residential building",
      "location": "123 Market Street",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "reportedAt": "2 min ago",
      "status": "active",
      "responders": 12,
      "estimatedResolution": "45 min",
      "reporter": "Anonymous",
      "verified": true,
    },
    {
      "id": "INC002",
      "type": "medical",
      "severity": "medium",
      "title": "Medical Emergency",
      "description": "Cardiac arrest reported",
      "location": "456 Oak Avenue",
      "latitude": 37.7649,
      "longitude": -122.4094,
      "reportedAt": "8 min ago",
      "status": "responding",
      "responders": 4,
      "estimatedResolution": "20 min",
      "reporter": "John Doe",
      "verified": true,
    },
    {
      "id": "INC003",
      "type": "accident",
      "severity": "medium",
      "title": "Traffic Accident",
      "description": "Multi-vehicle collision blocking traffic",
      "location": "Pine St & 5th Ave",
      "latitude": 37.7849,
      "longitude": -122.4294,
      "reportedAt": "15 min ago",
      "status": "resolved",
      "responders": 6,
      "estimatedResolution": "Resolved",
      "reporter": "Traffic Control",
      "verified": true,
    },
    {
      "id": "INC004",
      "type": "crime",
      "severity": "low",
      "title": "Theft Report",
      "description": "Break-in reported at local business",
      "location": "789 Castro Street",
      "latitude": 37.7549,
      "longitude": -122.4394,
      "reportedAt": "25 min ago",
      "status": "investigating",
      "responders": 2,
      "estimatedResolution": "2 hours",
      "reporter": "Business Owner",
      "verified": false,
    },
    {
      "id": "INC005",
      "type": "hazard",
      "severity": "low",
      "title": "Gas Leak",
      "description": "Possible gas leak reported by residents",
      "location": "321 Elm Street",
      "latitude": 37.7949,
      "longitude": -122.3994,
      "reportedAt": "35 min ago",
      "status": "investigating",
      "responders": 3,
      "estimatedResolution": "30 min",
      "reporter": "Resident",
      "verified": false,
    },
  ];

  final List<Map<String, dynamic>> emergencyContacts = [
    {
      "service": "Fire Department",
      "phone": "911",
      "nonEmergency": "(415) 558-3200",
      "icon": Icons.local_fire_department,
      "color": Colors.red,
    },
    {
      "service": "Police Department",
      "phone": "911",
      "nonEmergency": "(415) 553-0123",
      "icon": Icons.local_police,
      "color": Colors.blue,
    },
    {
      "service": "Medical Emergency",
      "phone": "911",
      "nonEmergency": "(415) 206-8000",
      "icon": Icons.local_hospital,
      "color": Colors.green,
    },
    {
      "service": "Public Works",
      "phone": "(311)",
      "nonEmergency": "(415) 701-2311",
      "icon": Icons.build,
      "color": Colors.orange,
    },
  ];

  List<Map<String, dynamic>> filteredIncidents = [];
  Map<String, dynamic>? selectedIncident;

  @override
  void initState() {
    super.initState();
    filteredIncidents = emergencyIncidents;
  }

  void _filterIncidents(String type) {
    selectedIncidentType = type;
    if (type == "all") {
      filteredIncidents = emergencyIncidents;
    } else {
      filteredIncidents = emergencyIncidents.where((incident) => incident["type"] == type).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Map"),
        backgroundColor: dangerColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              _showEmergencyContacts();
            },
          ),
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              _showReportIncident();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Emergency Alert Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency Services Active",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${emergencyIncidents.where((i) => i["status"] == "active").length} active incidents • ${emergencyIncidents.where((i) => i["status"] == "responding").length} units responding",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "CALL 911",
                  size: bs.sm,
                  onPressed: () {
                    _call911();
                  },
                ),
              ],
            ),
          ),
          
          // Incident Type Filter
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Severity Overview
                Row(
                  children: [
                    _buildSeverityCard("${emergencyIncidents.where((i) => i["severity"] == "high").length}", "High", dangerColor),
                    SizedBox(width: spSm),
                    _buildSeverityCard("${emergencyIncidents.where((i) => i["severity"] == "medium").length}", "Medium", warningColor),
                    SizedBox(width: spSm),
                    _buildSeverityCard("${emergencyIncidents.where((i) => i["severity"] == "low").length}", "Low", infoColor),
                    SizedBox(width: spSm),
                    _buildSeverityCard("${emergencyIncidents.where((i) => i["status"] == "active").length}", "Active", primaryColor),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Type Filter
                QHorizontalScroll(
                  children: [
                    _buildIncidentTypeChip("all", "All Incidents", Icons.report),
                    _buildIncidentTypeChip("fire", "Fire", Icons.local_fire_department),
                    _buildIncidentTypeChip("medical", "Medical", Icons.local_hospital),
                    _buildIncidentTypeChip("accident", "Accident", Icons.car_crash),
                    _buildIncidentTypeChip("crime", "Crime", Icons.local_police),
                    _buildIncidentTypeChip("hazard", "Hazard", Icons.warning),
                  ],
                ),
              ],
            ),
          ),
          
          // Emergency Map
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[50]!, Colors.orange[50]!],
                ),
              ),
              child: Stack(
                children: [
                  // Map Background
                  Center(
                    child: Text(
                      "Live Emergency Map",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  
                  // Incident Markers
                  ...filteredIncidents.map((incident) {
                    return Positioned(
                      left: ((incident["longitude"] as double) + 122.4194) * 800,
                      top: (37.7749 - (incident["latitude"] as double)) * 1500 + 120,
                      child: GestureDetector(
                        onTap: () {
                          _selectIncident(incident);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getSeverityColor("${incident["severity"]}"),
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowLg],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getIncidentIcon("${incident["type"]}"),
                                color: Colors.white,
                                size: 20,
                              ),
                              if (incident["status"] == "active") ...[
                                SizedBox(height: 2),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Response Zone Indicators
                  ...filteredIncidents.where((i) => i["status"] == "active").map((incident) {
                    return Positioned(
                      left: ((incident["longitude"] as double) + 122.4194) * 800 - 50,
                      top: (37.7749 - (incident["latitude"] as double)) * 1500 + 70,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _getSeverityColor("${incident["severity"]}").withAlpha(50),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    );
                  }).toList(),
                  
                  // Map Controls
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Column(
                      spacing: spSm,
                      children: [
                        _buildMapButton(Icons.add, () {
                          ss("Zoom in");
                        }),
                        _buildMapButton(Icons.remove, () {
                          ss("Zoom out");
                        }),
                        _buildMapButton(Icons.my_location, () {
                          ss("Show my location");
                        }),
                        _buildMapButton(Icons.refresh, () {
                          _refreshIncidents();
                        }),
                      ],
                    ),
                  ),
                  
                  // Legend
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Incident Severity",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          _buildLegendItem(dangerColor, "High Priority"),
                          _buildLegendItem(warningColor, "Medium Priority"),
                          _buildLegendItem(infoColor, "Low Priority"),
                          _buildLegendItem(successColor, "Resolved"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Incident Details Panel
          if (selectedIncident != null)
            Container(
              height: 200,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                boxShadow: [shadowSm],
              ),
              child: _buildIncidentDetails(selectedIncident!),
            ),
          
          // Active Incidents List
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Active Incidents",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredIncidents.length} incidents",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredIncidents.length,
                      itemBuilder: (context, index) {
                        final incident = filteredIncidents[index];
                        return _buildIncidentCard(incident);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: color.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentTypeChip(String value, String label, IconData icon) {
    final isSelected = selectedIncidentType == value;
    return GestureDetector(
      onTap: () {
        _filterIncidents(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? dangerColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? dangerColor : disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
            SizedBox(width: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Icon(
          icon,
          color: dangerColor,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentCard(Map<String, dynamic> incident) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: selectedIncident?["id"] == incident["id"]
            ? Border.all(color: dangerColor, width: 2)
            : null,
      ),
      child: GestureDetector(
        onTap: () {
          _selectIncident(incident);
        },
        child: Row(
          children: [
            // Severity Indicator
            Container(
              width: 4,
              height: 50,
              decoration: BoxDecoration(
                color: _getSeverityColor("${incident["severity"]}"),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
            SizedBox(width: spSm),
            
            // Incident Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getSeverityColor("${incident["severity"]}").withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                _getIncidentIcon("${incident["type"]}"),
                color: _getSeverityColor("${incident["severity"]}"),
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            
            // Incident Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${incident["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${incident["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusLabel("${incident["status"]}"),
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${incident["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${incident["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${incident["reportedAt"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.people, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${incident["responders"]} responders",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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

  Widget _buildIncidentDetails(Map<String, dynamic> incident) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getSeverityColor("${incident["severity"]}"),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                _getIncidentIcon("${incident["type"]}"),
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${incident["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${incident["id"]} • ${incident["reportedAt"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                selectedIncident = null;
                setState(() {});
              },
              child: Icon(
                Icons.close,
                color: disabledBoldColor,
                size: 20,
              ),
            ),
          ],
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "${incident["description"]}",
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
                    "Location",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${incident["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "ETA",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${incident["estimatedResolution"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        
        SizedBox(height: spMd),
        
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Get Directions",
                icon: Icons.directions,
                size: bs.sm,
                onPressed: () {
                  ss("Opening directions to incident location");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Report Update",
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showReportUpdate(incident);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return dangerColor;
      case "responding":
        return warningColor;
      case "investigating":
        return infoColor;
      case "resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "ACTIVE";
      case "responding":
        return "RESPONDING";
      case "investigating":
        return "INVESTIGATING";
      case "resolved":
        return "RESOLVED";
      default:
        return "UNKNOWN";
    }
  }

  IconData _getIncidentIcon(String type) {
    switch (type) {
      case "fire":
        return Icons.local_fire_department;
      case "medical":
        return Icons.local_hospital;
      case "accident":
        return Icons.car_crash;
      case "crime":
        return Icons.local_police;
      case "hazard":
        return Icons.warning;
      default:
        return Icons.report;
    }
  }

  void _selectIncident(Map<String, dynamic> incident) {
    selectedIncident = incident;
    setState(() {});
  }

  void _refreshIncidents() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Emergency data updated");
    });
  }

  void _call911() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Emergency Call",
          style: TextStyle(color: dangerColor),
        ),
        content: Text("This would dial 911 for emergency services."),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              ss("Calling 911...");
            },
            child: Text(
              "Call Now",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContacts() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Emergency Contacts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...emergencyContacts.map((contact) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (contact["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: (contact["color"] as Color).withAlpha(30),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      contact["icon"] as IconData,
                      color: contact["color"] as Color,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${contact["service"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Emergency: ${contact["phone"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Non-Emergency: ${contact["nonEmergency"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.phone,
                      size: bs.sm,
                      onPressed: () {
                        ss("Calling ${contact["service"]}");
                      },
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

  void _showReportIncident() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Report Emergency",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Incident Type",
              value: "",
              hint: "Fire, Medical, Accident, Crime, Hazard",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Location",
              value: "",
              hint: "Street address or landmark",
              onChanged: (value) {},
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: "",
              hint: "Describe the emergency situation",
              onChanged: (value) {},
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Report",
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Emergency report submitted");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportUpdate(Map<String, dynamic> incident) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update Incident ${incident["id"]}",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Status Update",
              value: "",
              hint: "Provide additional information",
              onChanged: (value) {},
            ),
            SizedBox(height: spMd),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Update",
                size: bs.md,
                onPressed: () {
                  back();
                  ss("Incident update submitted");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
