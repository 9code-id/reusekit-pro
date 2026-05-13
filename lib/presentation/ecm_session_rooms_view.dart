import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmSessionRoomsView extends StatefulWidget {
  const EcmSessionRoomsView({super.key});

  @override
  State<EcmSessionRoomsView> createState() => _EcmSessionRoomsViewState();
}

class _EcmSessionRoomsViewState extends State<EcmSessionRoomsView> {
  List<Map<String, dynamic>> rooms = [
    {
      "id": 1,
      "name": "Main Auditorium",
      "capacity": 500,
      "current_occupancy": 347,
      "type": "Auditorium",
      "status": "Active",
      "session": "Opening Keynote",
      "presenter": "Dr. John Smith",
      "start_time": DateTime.now().subtract(Duration(minutes: 30)),
      "end_time": DateTime.now().add(Duration(minutes: 30)),
      "equipment": ["Projector", "Sound System", "Live Stream", "Recording"],
      "temperature": 22.5,
      "humidity": 45,
      "air_quality": "Good",
      "booking_rate": 95.0
    },
    {
      "id": 2,
      "name": "Conference Room A",
      "capacity": 150,
      "current_occupancy": 89,
      "type": "Conference Room",
      "status": "Active",
      "session": "AI in Healthcare Panel",
      "presenter": "Panel Discussion",
      "start_time": DateTime.now().subtract(Duration(minutes: 15)),
      "end_time": DateTime.now().add(Duration(minutes: 45)),
      "equipment": ["Smart Board", "Video Conference", "Microphones"],
      "temperature": 23.1,
      "humidity": 42,
      "air_quality": "Excellent",
      "booking_rate": 87.5
    },
    {
      "id": 3,
      "name": "Workshop Studio B",
      "capacity": 80,
      "current_occupancy": 0,
      "type": "Workshop Room",
      "status": "Available",
      "session": "Next: Digital Marketing Workshop",
      "presenter": "Sarah Johnson",
      "start_time": DateTime.now().add(Duration(hours: 1)),
      "end_time": DateTime.now().add(Duration(hours: 3)),
      "equipment": ["Interactive Whiteboard", "Tablets", "WiFi Hotspot"],
      "temperature": 21.8,
      "humidity": 38,
      "air_quality": "Good",
      "booking_rate": 72.3
    },
    {
      "id": 4,
      "name": "Meeting Room C",
      "capacity": 25,
      "current_occupancy": 18,
      "type": "Meeting Room",
      "status": "Active",
      "session": "VIP Executive Briefing",
      "presenter": "CEO Panel",
      "start_time": DateTime.now().subtract(Duration(minutes: 45)),
      "end_time": DateTime.now().add(Duration(minutes: 15)),
      "equipment": ["Video Wall", "Conference Phone", "Smart Lighting"],
      "temperature": 22.9,
      "humidity": 40,
      "air_quality": "Excellent",
      "booking_rate": 91.2
    },
    {
      "id": 5,
      "name": "Breakout Space D",
      "capacity": 40,
      "current_occupancy": 0,
      "type": "Breakout Room",
      "status": "Maintenance",
      "session": "Under Maintenance",
      "presenter": "Technical Team",
      "start_time": DateTime.now().add(Duration(hours: 2)),
      "end_time": DateTime.now().add(Duration(hours: 4)),
      "equipment": ["Portable Screens", "Mobile Furniture", "Charging Stations"],
      "temperature": 20.5,
      "humidity": 50,
      "air_quality": "Fair",
      "booking_rate": 68.7
    },
    {
      "id": 6,
      "name": "Innovation Lab",
      "capacity": 60,
      "current_occupancy": 35,
      "type": "Lab",
      "status": "Active",
      "session": "Tech Demo & Showcase",
      "presenter": "Innovation Team",
      "start_time": DateTime.now().subtract(Duration(hours: 1)),
      "end_time": DateTime.now().add(Duration(hours: 2)),
      "equipment": ["VR Headsets", "3D Printers", "Demo Stations", "AR Displays"],
      "temperature": 23.8,
      "humidity": 35,
      "air_quality": "Good",
      "booking_rate": 85.4
    }
  ];

  String selectedStatus = "All";
  String selectedType = "All";
  String searchQuery = "";

  final List<String> statuses = ["All", "Active", "Available", "Maintenance", "Booked"];
  final List<String> roomTypes = ["All", "Auditorium", "Conference Room", "Workshop Room", "Meeting Room", "Breakout Room", "Lab"];

  List<Map<String, dynamic>> get filteredRooms {
    return rooms.where((room) {
      final matchesStatus = selectedStatus == "All" || room["status"] == selectedStatus;
      final matchesType = selectedType == "All" || room["type"] == selectedType;
      final matchesSearch = searchQuery.isEmpty || 
          "${room["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${room["session"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Available":
        return infoColor;
      case "Maintenance":
        return warningColor;
      case "Booked":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRoomTypeIcon(String type) {
    switch (type) {
      case "Auditorium":
        return Icons.theater_comedy;
      case "Conference Room":
        return Icons.meeting_room;
      case "Workshop Room":
        return Icons.build;
      case "Meeting Room":
        return Icons.group;
      case "Breakout Room":
        return Icons.groups;
      case "Lab":
        return Icons.science;
      default:
        return Icons.room;
    }
  }

  Color _getAirQualityColor(String quality) {
    switch (quality) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _manageRoom(Map<String, dynamic> room) {
    // Navigate to room management
    // navigateTo(EcmRoomManagementView(room: room));
  }

  void _viewRoomDetails(Map<String, dynamic> room) {
    // Navigate to room details
    // navigateTo(EcmRoomDetailsView(room: room));
  }

  void _controlRoomEnvironment(Map<String, dynamic> room) {
    // Navigate to environment controls
    // navigateTo(EcmRoomEnvironmentView(room: room));
  }

  Widget _buildOverviewCard() {
    final totalRooms = rooms.length;
    final activeRooms = rooms.where((r) => r["status"] == "Active").length;
    final availableRooms = rooms.where((r) => r["status"] == "Available").length;
    final totalCapacity = rooms.fold(0, (sum, r) => sum + (r["capacity"] as int));
    final totalOccupancy = rooms.fold(0, (sum, r) => sum + (r["current_occupancy"] as int));

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Overview",
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
                child: _buildOverviewItem("Total Rooms", totalRooms.toString(), Icons.room, primaryColor),
              ),
              Expanded(
                child: _buildOverviewItem("Active", activeRooms.toString(), Icons.play_circle, successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewItem("Available", availableRooms.toString(), Icons.check_circle, infoColor),
              ),
              Expanded(
                child: _buildOverviewItem("Occupancy", "${((totalOccupancy / totalCapacity) * 100).toStringAsFixed(0)}%", Icons.people, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    final occupancyPercentage = ((room["current_occupancy"] as int) / (room["capacity"] as int)) * 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        _getRoomTypeIcon("${room["type"]}"),
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${room["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${room["type"]} • ${room["capacity"]} capacity",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${room["status"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${room["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor("${room["status"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${room["session"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Presenter: ${room["presenter"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${(room["start_time"] as DateTime).kkmm} - ${(room["end_time"] as DateTime).kkmm}",
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
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Occupancy",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: occupancyPercentage / 100,
                                  backgroundColor: Colors.grey.withAlpha(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    occupancyPercentage > 80 ? dangerColor :
                                    occupancyPercentage > 60 ? warningColor : successColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${room["current_occupancy"]}/${room["capacity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Environment",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.thermostat, size: 14, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "${room["temperature"]}°C",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.air, size: 14, color: _getAirQualityColor("${room["air_quality"]}")),
                              SizedBox(width: spXs),
                              Text(
                                "${room["air_quality"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getAirQualityColor("${room["air_quality"]}"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (room["equipment"] as List).map<Widget>((equipment) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$equipment",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () => _viewRoomDetails(room),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Manage",
                  icon: Icons.settings,
                  size: bs.sm,
                  onPressed: () => _manageRoom(room),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _controlRoomEnvironment(room),
                  child: Icon(
                    Icons.tune,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Session Rooms"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_home),
            onPressed: () {
              // Navigate to add room
              // navigateTo(EcmAddRoomView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCard(),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search rooms...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
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
                  child: QDropdownField(
                    label: "Status",
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Room Type",
                    items: roomTypes.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            if (filteredRooms.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.meeting_room,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No rooms found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or add a new room",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredRooms.map((room) {
                  return _buildRoomCard(room);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
