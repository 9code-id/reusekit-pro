import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaSurveillanceView extends StatefulWidget {
  const HhaSurveillanceView({super.key});

  @override
  State<HhaSurveillanceView> createState() => _HhaSurveillanceViewState();
}

class _HhaSurveillanceViewState extends State<HhaSurveillanceView> {
  String searchQuery = "";
  String selectedZone = "All Zones";
  String selectedStatus = "All";
  String selectedRecordingMode = "All";

  List<Map<String, dynamic>> zones = [
    {"label": "All Zones", "value": "All Zones"},
    {"label": "Main Entrance", "value": "Main Entrance"},
    {"label": "Reception Area", "value": "Reception Area"},
    {"label": "Corridors", "value": "Corridors"},
    {"label": "Patient Rooms", "value": "Patient Rooms"},
    {"label": "Emergency Exit", "value": "Emergency Exit"},
    {"label": "Parking Area", "value": "Parking Area"},
    {"label": "Staff Areas", "value": "Staff Areas"},
    {"label": "ICU Ward", "value": "ICU Ward"},
    {"label": "Operating Theater", "value": "Operating Theater"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Online", "value": "Online"},
    {"label": "Offline", "value": "Offline"},
    {"label": "Recording", "value": "Recording"},
    {"label": "Maintenance", "value": "Maintenance"},
  ];

  List<Map<String, dynamic>> recordingModeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Continuous", "value": "Continuous"},
    {"label": "Motion Detection", "value": "Motion Detection"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Manual", "value": "Manual"},
  ];

  List<Map<String, dynamic>> cameras = [
    {
      "id": "CAM-001",
      "name": "Main Entrance Camera 1",
      "zone": "Main Entrance",
      "location": "Front Door - North",
      "status": "Online",
      "recordingMode": "Continuous",
      "resolution": "4K Ultra HD",
      "lastMotion": "2 minutes ago",
      "diskSpace": 85.2,
      "uptime": "99.8%",
      "alerts": 0,
      "viewCount": 234,
      "type": "PTZ Camera",
      "nightVision": true,
      "audioRecording": true,
    },
    {
      "id": "CAM-002",
      "name": "Reception Area Camera",
      "zone": "Reception Area",
      "location": "Front Desk - Center",
      "status": "Recording",
      "recordingMode": "Motion Detection",
      "resolution": "1080p Full HD",
      "lastMotion": "5 minutes ago",
      "diskSpace": 67.8,
      "uptime": "98.5%",
      "alerts": 2,
      "viewCount": 189,
      "type": "Fixed Camera",
      "nightVision": false,
      "audioRecording": true,
    },
    {
      "id": "CAM-003",
      "name": "ICU Ward Corridor",
      "zone": "ICU Ward",
      "location": "ICU - Hallway",
      "status": "Online",
      "recordingMode": "Continuous",
      "resolution": "4K Ultra HD",
      "lastMotion": "1 minute ago",
      "diskSpace": 92.1,
      "uptime": "99.9%",
      "alerts": 1,
      "viewCount": 156,
      "type": "Dome Camera",
      "nightVision": true,
      "audioRecording": false,
    },
    {
      "id": "CAM-004",
      "name": "Emergency Exit East",
      "zone": "Emergency Exit",
      "location": "East Wing - Exit Door",
      "status": "Offline",
      "recordingMode": "Motion Detection",
      "resolution": "1080p Full HD",
      "lastMotion": "1 hour ago",
      "diskSpace": 45.3,
      "uptime": "89.2%",
      "alerts": 5,
      "viewCount": 67,
      "type": "Fixed Camera",
      "nightVision": true,
      "audioRecording": false,
    },
    {
      "id": "CAM-005",
      "name": "Operating Theater 1",
      "zone": "Operating Theater",
      "location": "OT-1 - Overhead",
      "status": "Recording",
      "recordingMode": "Scheduled",
      "resolution": "4K Ultra HD",
      "lastMotion": "Active now",
      "diskSpace": 78.9,
      "uptime": "100%",
      "alerts": 0,
      "viewCount": 89,
      "type": "Surgical Camera",
      "nightVision": false,
      "audioRecording": true,
    },
    {
      "id": "CAM-006",
      "name": "Parking Area North",
      "zone": "Parking Area",
      "location": "North Parking - Overview",
      "status": "Online",
      "recordingMode": "Motion Detection",
      "resolution": "1080p Full HD",
      "lastMotion": "10 minutes ago",
      "diskSpace": 58.7,
      "uptime": "96.3%",
      "alerts": 1,
      "viewCount": 123,
      "type": "PTZ Camera",
      "nightVision": true,
      "audioRecording": false,
    },
    {
      "id": "CAM-007",
      "name": "Patient Room Wing A",
      "zone": "Patient Rooms",
      "location": "Wing A - Corridor",
      "status": "Maintenance",
      "recordingMode": "Continuous",
      "resolution": "1080p Full HD",
      "lastMotion": "2 hours ago",
      "diskSpace": 34.2,
      "uptime": "85.1%",
      "alerts": 3,
      "viewCount": 145,
      "type": "Dome Camera",
      "nightVision": true,
      "audioRecording": false,
    },
    {
      "id": "CAM-008",
      "name": "Staff Break Room",
      "zone": "Staff Areas",
      "location": "Break Room - Corner",
      "status": "Online",
      "recordingMode": "Manual",
      "resolution": "720p HD",
      "lastMotion": "30 minutes ago",
      "diskSpace": 23.4,
      "uptime": "92.7%",
      "alerts": 0,
      "viewCount": 56,
      "type": "Fixed Camera",
      "nightVision": false,
      "audioRecording": false,
    },
  ];

  List<Map<String, dynamic>> get filteredCameras {
    return cameras.where((camera) {
      final matchesSearch = camera["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          camera["zone"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          camera["location"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesZone = selectedZone == "All Zones" || camera["zone"] == selectedZone;
      final matchesStatus = selectedStatus == "All" || camera["status"] == selectedStatus;
      final matchesRecordingMode = selectedRecordingMode == "All" || camera["recordingMode"] == selectedRecordingMode;
      
      return matchesSearch && matchesZone && matchesStatus && matchesRecordingMode;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Online":
        return successColor;
      case "Recording":
        return primaryColor;
      case "Offline":
        return dangerColor;
      case "Maintenance":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusAction(String status) {
    switch (status) {
      case "Online":
        return "Start Recording";
      case "Recording":
        return "View Live";
      case "Offline":
        return "Reconnect";
      case "Maintenance":
        return "Complete Maintenance";
      default:
        return "Check Status";
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusCounts = {
      "Online": cameras.where((c) => c["status"] == "Online").length,
      "Recording": cameras.where((c) => c["status"] == "Recording").length,
      "Offline": cameras.where((c) => c["status"] == "Offline").length,
      "Maintenance": cameras.where((c) => c["status"] == "Maintenance").length,
    };

    final totalAlerts = cameras.fold<int>(0, (sum, camera) => sum + (camera["alerts"] as int));
    final averageUptime = cameras.fold<double>(0, (sum, camera) => sum + double.parse(camera["uptime"].toString().replaceAll('%', ''))) / cameras.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance System"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              ss("Camera management opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              ss("Surveillance settings opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search Cameras",
                  value: searchQuery,
                  hint: "Search by name, zone, or location...",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Zone",
                        items: zones,
                        value: selectedZone,
                        onChanged: (value, label) {
                          selectedZone = value;
                          setState(() {});
                        },
                      ),
                    ),
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
                  label: "Recording Mode",
                  items: recordingModeOptions,
                  value: selectedRecordingMode,
                  onChanged: (value, label) {
                    selectedRecordingMode = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Status Overview Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                Container(
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
                          Icon(
                            Icons.videocam,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Online Cameras",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${statusCounts["Online"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active & Monitoring",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.fiber_manual_record,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Recording",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${statusCounts["Recording"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Currently Recording",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Alerts",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalAlerts",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Unresolved Issues",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(
                            Icons.trending_up,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "System Uptime",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${averageUptime.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Average Uptime",
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

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Live Feed",
                          icon: Icons.play_circle,
                          size: bs.sm,
                          onPressed: () {
                            ss("Opening live feed viewer");
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {
                            ss("Generating surveillance report");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Camera List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Cameras (${filteredCameras.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: spSm),
                ...filteredCameras.map((camera) {
                  final statusColor = _getStatusColor(camera["status"]);
                  final statusAction = _getStatusAction(camera["status"]);
                  
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${camera["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${camera["id"]} • ${camera["location"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${camera["status"]}",
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
                          spacing: spLg,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Zone",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${camera["zone"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Resolution",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${camera["resolution"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Recording Mode",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${camera["recordingMode"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spLg,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Motion",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${camera["lastMotion"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Disk Usage",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${(camera["diskSpace"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Uptime",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${camera["uptime"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if ((camera["alerts"] as int) > 0) ...[
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: dangerColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${camera["alerts"]} active alert${(camera["alerts"] as int) > 1 ? 's' : ''}",
                                  style: TextStyle(
                                    color: dangerColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            if (camera["nightVision"] == true)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Night Vision",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if (camera["audioRecording"] == true)
                              Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Audio",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(right: spXs),
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${camera["type"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${camera["viewCount"]} views",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          spacing: spSm,
                          children: [
                            Expanded(
                              child: QButton(
                                label: statusAction,
                                size: bs.sm,
                                onPressed: () {
                                  ss("$statusAction for ${camera["name"]}");
                                },
                              ),
                            ),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                ss("Camera options for ${camera["name"]}");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
