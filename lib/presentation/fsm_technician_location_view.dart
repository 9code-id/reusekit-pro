import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianLocationView extends StatefulWidget {
  const FsmTechnicianLocationView({super.key});

  @override
  State<FsmTechnicianLocationView> createState() => _FsmTechnicianLocationViewState();
}

class _FsmTechnicianLocationViewState extends State<FsmTechnicianLocationView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "All";
  String selectedTeam = "All Teams";
  String selectedShift = "All Shifts";
  bool isMapView = true;

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "On Job", "value": "On Job"},
    {"label": "En Route", "value": "En Route"},
    {"label": "Offline", "value": "Offline"},
  ];

  final List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Team Alpha", "value": "Team Alpha"},
    {"label": "Team Beta", "value": "Team Beta"},
    {"label": "Team Gamma", "value": "Team Gamma"},
    {"label": "Emergency Team", "value": "Emergency Team"},
  ];

  final List<Map<String, dynamic>> shiftOptions = [
    {"label": "All Shifts", "value": "All Shifts"},
    {"label": "Morning (6AM-2PM)", "value": "Morning"},
    {"label": "Afternoon (2PM-10PM)", "value": "Afternoon"},
    {"label": "Night (10PM-6AM)", "value": "Night"},
  ];

  final List<Map<String, dynamic>> technicianLocations = [
    {
      "id": "TECH001",
      "name": "John Smith",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=man",
      "status": "Available",
      "location": "Downtown Service Center",
      "latitude": 37.7749,
      "longitude": -122.4194,
      "lastUpdate": "2 minutes ago",
      "currentJob": null,
      "nextJob": "Install Network Equipment",
      "nextJobTime": "2:30 PM",
      "team": "Team Alpha",
      "shift": "Morning",
      "skills": ["Networking", "Electrical"],
      "distance": "0.5 miles",
      "eta": "5 mins",
      "batteryLevel": 85,
      "signalStrength": 4,
    },
    {
      "id": "TECH002",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "status": "On Job",
      "location": "Tech Plaza Building",
      "latitude": 37.7849,
      "longitude": -122.4094,
      "lastUpdate": "1 minute ago",
      "currentJob": "Server Maintenance",
      "jobStartTime": "1:00 PM",
      "jobDuration": "2 hours",
      "nextJob": null,
      "team": "Team Beta",
      "shift": "Afternoon",
      "skills": ["Server Management", "Cloud Services"],
      "distance": "1.2 miles",
      "eta": "8 mins",
      "batteryLevel": 72,
      "signalStrength": 5,
    },
    {
      "id": "TECH003",
      "name": "Mike Rodriguez",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "status": "En Route",
      "location": "Highway 101 North",
      "latitude": 37.7949,
      "longitude": -122.3994,
      "lastUpdate": "30 seconds ago",
      "currentJob": "Emergency Repair",
      "destination": "Corporate Office Complex",
      "estimatedArrival": "3:15 PM",
      "nextJob": null,
      "team": "Emergency Team",
      "shift": "Morning",
      "skills": ["Emergency Response", "Electrical"],
      "distance": "2.8 miles",
      "eta": "12 mins",
      "batteryLevel": 68,
      "signalStrength": 3,
    },
    {
      "id": "TECH004",
      "name": "Emily Chen",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=woman",
      "status": "Available",
      "location": "West Side Service Hub",
      "latitude": 37.7649,
      "longitude": -122.4294,
      "lastUpdate": "5 minutes ago",
      "currentJob": null,
      "nextJob": "Equipment Inspection",
      "nextJobTime": "4:00 PM",
      "team": "Team Gamma",
      "shift": "Afternoon",
      "skills": ["Quality Assurance", "Testing"],
      "distance": "1.8 miles",
      "eta": "10 mins",
      "batteryLevel": 91,
      "signalStrength": 4,
    },
    {
      "id": "TECH005",
      "name": "David Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=man",
      "status": "Offline",
      "location": "Unknown",
      "latitude": null,
      "longitude": null,
      "lastUpdate": "45 minutes ago",
      "currentJob": null,
      "nextJob": "System Update",
      "nextJobTime": "Tomorrow 9:00 AM",
      "team": "Team Alpha",
      "shift": "Night",
      "skills": ["System Administration", "Database"],
      "distance": "Unknown",
      "eta": "N/A",
      "batteryLevel": 15,
      "signalStrength": 0,
    },
    {
      "id": "TECH006",
      "name": "Lisa Thompson",
      "avatar": "https://picsum.photos/50/50?random=6&keyword=woman",
      "status": "On Job",
      "location": "Medical Center",
      "latitude": 37.7549,
      "longitude": -122.4394,
      "lastUpdate": "3 minutes ago",
      "currentJob": "Network Installation",
      "jobStartTime": "12:30 PM",
      "jobDuration": "3 hours",
      "nextJob": "Training Session",
      "nextJobTime": "5:00 PM",
      "team": "Team Beta",
      "shift": "Morning",
      "skills": ["Network Installation", "Training"],
      "distance": "2.1 miles",
      "eta": "11 mins",
      "batteryLevel": 78,
      "signalStrength": 5,
    },
  ];

  List<Map<String, dynamic>> get filteredTechnicians {
    return technicianLocations.where((tech) {
      final matchesSearch = tech["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tech["location"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          tech["team"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesFilter = selectedFilter == "All" || tech["status"] == selectedFilter;
      final matchesTeam = selectedTeam == "All Teams" || tech["team"] == selectedTeam;
      final matchesShift = selectedShift == "All Shifts" || tech["shift"] == selectedShift;
      
      return matchesSearch && matchesFilter && matchesTeam && matchesShift;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "On Job":
        return primaryColor;
      case "En Route":
        return warningColor;
      case "Offline":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Available":
        return Icons.check_circle;
      case "On Job":
        return Icons.work;
      case "En Route":
        return Icons.directions;
      case "Offline":
        return Icons.offline_bolt;
      default:
        return Icons.help;
    }
  }

  void _showTechnicianDetails(Map<String, dynamic> technician) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("${technician["avatar"]}"),
              radius: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${technician["name"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${technician["id"]}",
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor(technician["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: _getStatusColor(technician["status"]),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getStatusIcon(technician["status"]),
                      color: _getStatusColor(technician["status"]),
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${technician["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(technician["status"]),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spSm),
              
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${technician["location"]}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Last update: ${technician["lastUpdate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              if (technician["currentJob"] != null) ...[
                Text(
                  "Current Job:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${technician["currentJob"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      if (technician["jobStartTime"] != null) ...[
                        SizedBox(height: spXs),
                        Text(
                          "Started: ${technician["jobStartTime"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                      if (technician["jobDuration"] != null) ...[
                        Text(
                          "Duration: ${technician["jobDuration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spSm),
              ],
              
              if (technician["nextJob"] != null) ...[
                Text(
                  "Next Job:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${technician["nextJob"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Scheduled: ${technician["nextJobTime"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
              ],
              
              Text(
                "Team & Shift:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${technician["team"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${technician["shift"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              
              Text(
                "Device Status:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.battery_full, size: 16, color: _getBatteryColor((technician["batteryLevel"] as int))),
                  SizedBox(width: spXs),
                  Text(
                    "Battery: ${technician["batteryLevel"]}%",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: spSm),
                  Icon(Icons.signal_cellular_4_bar, size: 16, color: _getSignalColor((technician["signalStrength"] as int))),
                  SizedBox(width: spXs),
                  Text(
                    "Signal: ${technician["signalStrength"]}/5",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Contact",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Contacting ${technician["name"]}");
            },
          ),
          QButton(
            label: "Track",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Tracking ${technician["name"]} location");
            },
          ),
        ],
      ),
    );
  }

  Color _getBatteryColor(int level) {
    if (level > 50) return successColor;
    if (level > 20) return warningColor;
    return dangerColor;
  }

  Color _getSignalColor(int strength) {
    if (strength >= 4) return successColor;
    if (strength >= 2) return warningColor;
    return dangerColor;
  }

  Widget _buildLocationSummaryCards() {
    final availableCount = technicianLocations.where((t) => t["status"] == "Available").length;
    final onJobCount = technicianLocations.where((t) => t["status"] == "On Job").length;
    final enRouteCount = technicianLocations.where((t) => t["status"] == "En Route").length;
    final offlineCount = technicianLocations.where((t) => t["status"] == "Offline").length;

    return ResponsiveGridView(
      padding: EdgeInsets.all(spSm),
      minItemWidth: 160,
      children: [
        _buildSummaryCard("Available", availableCount, successColor, Icons.check_circle),
        _buildSummaryCard("On Job", onJobCount, primaryColor, Icons.work),
        _buildSummaryCard("En Route", enRouteCount, warningColor, Icons.directions),
        _buildSummaryCard("Offline", offlineCount, disabledColor, Icons.offline_bolt),
      ],
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                "$count",
                style: TextStyle(
                  fontSize: fsH3,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      margin: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
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
                        size: 48,
                        color: primaryColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Interactive Map View",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Real-time technician locations",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ...filteredTechnicians.asMap().entries.where((entry) => 
                  entry.value["latitude"] != null && entry.value["longitude"] != null
                ).map((entry) {
                  final index = entry.key;
                  final tech = entry.value;
                  final left = ((tech["longitude"] as double) + 122.4194) * 1000;
                  final top = (37.7749 - (tech["latitude"] as double)) * 2000 + 100;
                  
                  return Positioned(
                    left: left.clamp(20.0, 280.0),
                    top: top.clamp(20.0, 260.0),
                    child: GestureDetector(
                      onTap: () => _showTechnicianDetails(tech),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getStatusColor(tech["status"]),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [shadowSm],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${tech["avatar"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Tap on technician markers to view details and current status",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: filteredTechnicians.length,
      itemBuilder: (context, index) {
        final technician = filteredTechnicians[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(spSm),
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("${technician["avatar"]}"),
                  radius: 24,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: _getStatusColor(technician["status"]),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              "${technician["name"]}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(technician["status"]),
                      color: _getStatusColor(technician["status"]),
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${technician["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(technician["status"]),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${technician["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (technician["distance"] != "Unknown") ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(Icons.directions, size: 12, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${technician["distance"]} • ETA: ${technician["eta"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${technician["team"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.battery_full,
                      size: 12,
                      color: _getBatteryColor((technician["batteryLevel"] as int)),
                    ),
                    Text(
                      "${technician["batteryLevel"]}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () => _showTechnicianDetails(technician),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Locations"),
        actions: [
          IconButton(
            icon: Icon(isMapView ? Icons.list : Icons.map),
            onPressed: () {
              isMapView = !isMapView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Location data refreshed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildLocationSummaryCards(),
          
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search technicians",
                    value: searchQuery,
                    hint: "Name, location, or team",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Filter Options",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spMd),
                            
                            QDropdownField(
                              label: "Status",
                              items: filterOptions,
                              value: selectedFilter,
                              onChanged: (value, label) {
                                selectedFilter = value;
                                setState(() {});
                                back();
                              },
                            ),
                            SizedBox(height: spSm),
                            
                            QDropdownField(
                              label: "Team",
                              items: teamOptions,
                              value: selectedTeam,
                              onChanged: (value, label) {
                                selectedTeam = value;
                                setState(() {});
                                back();
                              },
                            ),
                            SizedBox(height: spSm),
                            
                            QDropdownField(
                              label: "Shift",
                              items: shiftOptions,
                              value: selectedShift,
                              onChanged: (value, label) {
                                selectedShift = value;
                                setState(() {});
                                back();
                              },
                            ),
                            SizedBox(height: spMd),
                            
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Clear Filters",
                                    size: bs.sm,
                                    onPressed: () {
                                      selectedFilter = "All";
                                      selectedTeam = "All Teams";
                                      selectedShift = "All Shifts";
                                      setState(() {});
                                      back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          
          Expanded(
            child: isMapView ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }
}
