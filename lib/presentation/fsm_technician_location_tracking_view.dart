import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianLocationTrackingView extends StatefulWidget {
  const FsmTechnicianLocationTrackingView({super.key});

  @override
  State<FsmTechnicianLocationTrackingView> createState() => _FsmTechnicianLocationTrackingViewState();
}

class _FsmTechnicianLocationTrackingViewState extends State<FsmTechnicianLocationTrackingView> {
  String selectedTechnician = "All";
  String selectedStatus = "All";
  bool enableNotifications = true;
  bool trackingEnabled = true;
  DateTime trackingDate = DateTime.now();
  String viewMode = "List";

  List<Map<String, dynamic>> technicians = [
    {
      "id": "TECH-001",
      "name": "John Smith",
      "phone": "+1 555-0101",
      "specialization": "HVAC",
      "status": "On Route",
      "currentLat": 37.7749,
      "currentLng": -122.4194,
      "currentAddress": "123 Market St, San Francisco, CA",
      "lastUpdate": "2024-01-15 14:30:25",
      "accuracy": 5,
      "battery": 85,
      "speed": 35,
      "heading": 45,
      "currentJob": {
        "id": "JOB-001",
        "client": "ABC Corporation",
        "address": "456 Mission St, San Francisco, CA",
        "estimatedArrival": "15:00",
        "status": "En Route"
      },
      "todayJobs": 4,
      "completedJobs": 2,
      "hoursWorked": 6.5,
      "lastKnownLocation": "Downtown San Francisco",
      "geofenceStatus": "Inside Service Area",
    },
    {
      "id": "TECH-002",
      "name": "Mike Johnson",
      "phone": "+1 555-0102",
      "specialization": "Electrical",
      "status": "At Customer",
      "currentLat": 37.7849,
      "currentLng": -122.4094,
      "currentAddress": "789 Powell St, San Francisco, CA",
      "lastUpdate": "2024-01-15 14:28:10",
      "accuracy": 3,
      "battery": 92,
      "speed": 0,
      "heading": 0,
      "currentJob": {
        "id": "JOB-002",
        "client": "XYZ Industries",
        "address": "789 Powell St, San Francisco, CA",
        "estimatedArrival": "14:30",
        "status": "In Progress"
      },
      "todayJobs": 3,
      "completedJobs": 1,
      "hoursWorked": 4.2,
      "lastKnownLocation": "Union Square Area",
      "geofenceStatus": "At Customer Site",
    },
    {
      "id": "TECH-003",
      "name": "Sarah Wilson",
      "phone": "+1 555-0103",
      "specialization": "Plumbing",
      "status": "Break",
      "currentLat": 37.7649,
      "currentLng": -122.4294,
      "currentAddress": "321 Valencia St, San Francisco, CA",
      "lastUpdate": "2024-01-15 14:32:15",
      "accuracy": 8,
      "battery": 78,
      "speed": 0,
      "heading": 0,
      "currentJob": null,
      "todayJobs": 5,
      "completedJobs": 3,
      "hoursWorked": 7.8,
      "lastKnownLocation": "Mission District",
      "geofenceStatus": "Break Area",
    },
    {
      "id": "TECH-004",
      "name": "David Brown",
      "phone": "+1 555-0104",
      "specialization": "General Maintenance",
      "status": "Offline",
      "currentLat": 37.7549,
      "currentLng": -122.4394,
      "currentAddress": "Unknown",
      "lastUpdate": "2024-01-15 13:45:30",
      "accuracy": 0,
      "battery": 15,
      "speed": 0,
      "heading": 0,
      "currentJob": null,
      "todayJobs": 2,
      "completedJobs": 2,
      "hoursWorked": 8.0,
      "lastKnownLocation": "Office Parking",
      "geofenceStatus": "Outside Coverage",
    },
  ];

  List<Map<String, dynamic>> locationHistory = [
    {
      "timestamp": "2024-01-15 14:30:25",
      "technician": "John Smith",
      "event": "Location Update",
      "location": "Market St & 3rd St",
      "coordinates": "37.7749, -122.4194",
      "accuracy": 5,
      "speed": 35,
      "activity": "Driving",
    },
    {
      "timestamp": "2024-01-15 14:28:10",
      "technician": "Mike Johnson",
      "event": "Arrived at Customer",
      "location": "XYZ Industries",
      "coordinates": "37.7849, -122.4094",
      "accuracy": 3,
      "speed": 0,
      "activity": "On Foot",
    },
    {
      "timestamp": "2024-01-15 14:25:45",
      "technician": "Sarah Wilson",
      "event": "Break Started",
      "location": "Valencia St Cafe",
      "coordinates": "37.7649, -122.4294",
      "accuracy": 8,
      "speed": 0,
      "activity": "Stationary",
    },
    {
      "timestamp": "2024-01-15 14:20:30",
      "technician": "John Smith",
      "event": "Departed Customer",
      "location": "ABC Corporation",
      "coordinates": "37.7650, -122.4200",
      "accuracy": 4,
      "speed": 0,
      "activity": "On Foot",
    },
    {
      "timestamp": "2024-01-15 13:45:30",
      "technician": "David Brown",
      "event": "GPS Signal Lost",
      "location": "Office Parking Lot",
      "coordinates": "37.7549, -122.4394",
      "accuracy": 0,
      "speed": 0,
      "activity": "Unknown",
    },
  ];

  List<Map<String, dynamic>> alerts = [
    {
      "id": "ALERT-001",
      "technician": "David Brown",
      "type": "GPS Signal Lost",
      "severity": "High",
      "timestamp": "2024-01-15 13:45:30",
      "description": "GPS signal lost for more than 45 minutes",
      "resolved": false,
    },
    {
      "id": "ALERT-002",
      "technician": "Sarah Wilson",
      "type": "Extended Break",
      "severity": "Medium",
      "timestamp": "2024-01-15 14:25:45",
      "description": "Break time exceeded 30 minutes",
      "resolved": false,
    },
    {
      "id": "ALERT-003",
      "technician": "John Smith",
      "type": "Speed Limit",
      "severity": "Low",
      "timestamp": "2024-01-15 14:15:20",
      "description": "Exceeded speed limit by 10 mph",
      "resolved": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Location Tracking"),
        actions: [
          IconButton(
            icon: Icon(trackingEnabled ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleTracking,
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // View notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildTrackingOverview(),
            _buildTrackingControls(),
            _buildTechnicianList(),
            _buildLocationAlerts(),
            _buildLocationHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingOverview() {
    int activeTechnicians = technicians.where((t) => t["status"] != "Offline").length;
    int onRoute = technicians.where((t) => t["status"] == "On Route").length;
    int atCustomer = technicians.where((t) => t["status"] == "At Customer").length;
    int activeAlerts = alerts.where((a) => !a["resolved"]).length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tracking Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(child: _buildOverviewCard("Active", "$activeTechnicians", successColor, Icons.person)),
              SizedBox(width: spSm),
              Expanded(child: _buildOverviewCard("On Route", "$onRoute", infoColor, Icons.directions_car)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildOverviewCard("At Customer", "$atCustomer", primaryColor, Icons.location_on)),
              SizedBox(width: spSm),
              Expanded(child: _buildOverviewCard("Alerts", "$activeAlerts", dangerColor, Icons.warning)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
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
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tracking Controls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Technician",
                  items: [
                    {"label": "All Technicians", "value": "All"},
                    ...technicians.map((t) => {
                      "label": "${t["name"]} - ${t["specialization"]}",
                      "value": t["id"],
                    }),
                  ],
                  value: selectedTechnician,
                  onChanged: (value, label) {
                    selectedTechnician = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "All"},
                    {"label": "On Route", "value": "On Route"},
                    {"label": "At Customer", "value": "At Customer"},
                    {"label": "Break", "value": "Break"},
                    {"label": "Offline", "value": "Offline"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Real-time Tracking",
                      "value": true,
                      "checked": trackingEnabled,
                    }
                  ],
                  value: [
                    if (trackingEnabled)
                      {
                        "label": "Real-time Tracking",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      trackingEnabled = values.isNotEmpty;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Push Notifications",
                      "value": true,
                      "checked": enableNotifications,
                    }
                  ],
                  value: [
                    if (enableNotifications)
                      {
                        "label": "Push Notifications",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    setState(() {
                      enableNotifications = values.isNotEmpty;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicianList() {
    List<Map<String, dynamic>> filteredTechnicians = technicians;
    
    if (selectedTechnician != "All") {
      filteredTechnicians = technicians.where((t) => t["id"] == selectedTechnician).toList();
    }
    
    if (selectedStatus != "All") {
      filteredTechnicians = filteredTechnicians.where((t) => t["status"] == selectedStatus).toList();
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Technician Locations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...filteredTechnicians.map((tech) => _buildTechnicianItem(tech)),
        ],
      ),
    );
  }

  Widget _buildTechnicianItem(Map<String, dynamic> tech) {
    Color statusColor;
    IconData statusIcon;
    
    switch (tech["status"]) {
      case "On Route":
        statusColor = infoColor;
        statusIcon = Icons.directions_car;
        break;
      case "At Customer":
        statusColor = successColor;
        statusIcon = Icons.location_on;
        break;
      case "Break":
        statusColor = warningColor;
        statusIcon = Icons.pause_circle;
        break;
      default:
        statusColor = disabledBoldColor;
        statusIcon = Icons.signal_wifi_off;
    }

    Color batteryColor = tech["battery"] > 20 ? successColor : dangerColor;
    Color accuracyColor = tech["accuracy"] <= 10 ? successColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  statusIcon,
                  color: statusColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tech["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${tech["specialization"]} • ${tech["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${tech["geofenceStatus"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${tech["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  if (tech["speed"] > 0) ...[
                    Text(
                      "${tech["speed"]} mph",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: primaryColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${tech["currentAddress"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                          Icon(Icons.battery_std, size: 16, color: batteryColor),
                          SizedBox(width: spXs),
                          Text(
                            "${tech["battery"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: batteryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.gps_fixed, size: 16, color: accuracyColor),
                          SizedBox(width: spXs),
                          Text(
                            "±${tech["accuracy"]}m",
                            style: TextStyle(
                              fontSize: 12,
                              color: accuracyColor,
                              fontWeight: FontWeight.w600,
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
                      child: Text(
                        "Jobs: ${tech["completedJobs"]}/${tech["todayJobs"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Hours: ${tech["hoursWorked"]}h",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (tech["currentJob"] != null) ...[
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Job: ${tech["currentJob"]["client"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "ETA: ${tech["currentJob"]["estimatedArrival"]} • ${tech["currentJob"]["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Track Live",
                  size: bs.sm,
                  onPressed: () => _trackTechnician(tech),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Contact",
                  size: bs.sm,
                  onPressed: () => _contactTechnician(tech),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "History",
                  size: bs.sm,
                  onPressed: () => _viewHistory(tech),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAlerts() {
    List<Map<String, dynamic>> activeAlerts = alerts.where((a) => !a["resolved"]).toList();
    
    if (activeAlerts.isEmpty) return SizedBox();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Location Alerts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...activeAlerts.map((alert) => _buildAlertItem(alert)),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor;
    IconData alertIcon;
    
    switch (alert["severity"]) {
      case "High":
        severityColor = dangerColor;
        alertIcon = Icons.error;
        break;
      case "Medium":
        severityColor = warningColor;
        alertIcon = Icons.warning;
        break;
      default:
        severityColor = infoColor;
        alertIcon = Icons.info;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: severityColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: severityColor.withAlpha(51)),
      ),
      child: Row(
        children: [
          Icon(
            alertIcon,
            color: severityColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["type"]} - ${alert["technician"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${alert["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${alert["timestamp"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
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
              GestureDetector(
                onTap: () => _resolveAlert(alert),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Resolve",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationHistory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // View all history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...locationHistory.take(5).map((history) => _buildHistoryItem(history)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> history) {
    Color eventColor;
    IconData eventIcon;
    
    switch (history["event"]) {
      case "Arrived at Customer":
        eventColor = successColor;
        eventIcon = Icons.place;
        break;
      case "Departed Customer":
        eventColor = infoColor;
        eventIcon = Icons.directions_car;
        break;
      case "Break Started":
        eventColor = warningColor;
        eventIcon = Icons.pause;
        break;
      case "Location Update":
        eventColor = primaryColor;
        eventIcon = Icons.location_on;
        break;
      default:
        eventColor = dangerColor;
        eventIcon = Icons.signal_wifi_off;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            eventIcon,
            color: eventColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${history["event"]} - ${history["technician"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${history["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${history["coordinates"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                    if (history["accuracy"] > 0) ...[
                      Text(
                        " • ±${history["accuracy"]}m",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${history["timestamp"].substring(11, 16)}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${history["activity"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleTracking() {
    trackingEnabled = !trackingEnabled;
    setState(() {});
    
    if (trackingEnabled) {
      ss("Real-time tracking enabled");
    } else {
      si("Real-time tracking paused");
    }
  }

  void _trackTechnician(Map<String, dynamic> tech) {
    ss("Tracking ${tech["name"]} on live map");
  }

  void _contactTechnician(Map<String, dynamic> tech) {
    ss("Calling ${tech["name"]} at ${tech["phone"]}");
  }

  void _viewHistory(Map<String, dynamic> tech) {
    // Navigate to detailed history
  }

  void _resolveAlert(Map<String, dynamic> alert) {
    setState(() {
      alert["resolved"] = true;
    });
    ss("Alert resolved successfully");
  }
}
