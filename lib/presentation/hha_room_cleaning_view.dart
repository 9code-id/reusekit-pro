import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomCleaningView extends StatefulWidget {
  const HhaRoomCleaningView({super.key});

  @override
  State<HhaRoomCleaningView> createState() => _HhaRoomCleaningViewState();
}

class _HhaRoomCleaningViewState extends State<HhaRoomCleaningView> {
  int currentTab = 0;
  String selectedStatus = "all";
  String selectedFloor = "all";
  String selectedType = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> rooms = [
    {
      "roomNumber": "101",
      "floor": 1,
      "type": "Standard",
      "status": "cleaning",
      "priority": "high",
      "guestCheckOut": "10:30 AM",
      "nextCheckIn": "3:00 PM",
      "cleaningTime": "45 min",
      "assignedTo": "Maria Santos",
      "tasks": ["Bathroom", "Bedroom", "Amenities"],
      "completedTasks": 1,
      "totalTasks": 8,
      "notes": "Extra towels requested",
      "maintenanceIssues": false
    },
    {
      "roomNumber": "205",
      "floor": 2,
      "type": "Deluxe",
      "status": "inspection",
      "priority": "medium",
      "guestCheckOut": "11:00 AM",
      "nextCheckIn": "4:00 PM",
      "cleaningTime": "35 min",
      "assignedTo": "Ana Rodriguez",
      "tasks": ["Final Check", "Inventory", "Setup"],
      "completedTasks": 7,
      "totalTasks": 8,
      "notes": "Room ready for inspection",
      "maintenanceIssues": false
    },
    {
      "roomNumber": "312",
      "floor": 3,
      "type": "Suite",
      "status": "maintenance",
      "priority": "high",
      "guestCheckOut": "9:45 AM",
      "nextCheckIn": "5:00 PM",
      "cleaningTime": "60 min",
      "assignedTo": "Carlos Lopez",
      "tasks": ["Deep Clean", "Repair", "Inventory"],
      "completedTasks": 3,
      "totalTasks": 10,
      "notes": "AC unit needs repair",
      "maintenanceIssues": true
    },
    {
      "roomNumber": "418",
      "floor": 4,
      "type": "Executive",
      "status": "ready",
      "priority": "low",
      "guestCheckOut": "10:15 AM",
      "nextCheckIn": "6:00 PM",
      "cleaningTime": "50 min",
      "assignedTo": "Diana Chen",
      "tasks": ["Complete"],
      "completedTasks": 12,
      "totalTasks": 12,
      "notes": "Room ready for guest",
      "maintenanceIssues": false
    },
    {
      "roomNumber": "523",
      "floor": 5,
      "type": "Presidential",
      "status": "cleaning",
      "priority": "high",
      "guestCheckOut": "12:00 PM",
      "nextCheckIn": "2:00 PM",
      "cleaningTime": "90 min",
      "assignedTo": "Elena Volkov",
      "tasks": ["Living Room", "Kitchen", "Bedrooms"],
      "completedTasks": 8,
      "totalTasks": 15,
      "notes": "VIP guest arriving",
      "maintenanceIssues": false
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Cleaning", "value": "cleaning"},
    {"label": "Inspection", "value": "inspection"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Ready", "value": "ready"}
  ];

  List<Map<String, dynamic>> floorOptions = [
    {"label": "All Floors", "value": "all"},
    {"label": "Floor 1", "value": "1"},
    {"label": "Floor 2", "value": "2"},
    {"label": "Floor 3", "value": "3"},
    {"label": "Floor 4", "value": "4"},
    {"label": "Floor 5", "value": "5"}
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Deluxe", "value": "Deluxe"},
    {"label": "Suite", "value": "Suite"},
    {"label": "Executive", "value": "Executive"},
    {"label": "Presidential", "value": "Presidential"}
  ];

  List<Map<String, dynamic>> get filteredRooms {
    return rooms.where((room) {
      bool matchesStatus = selectedStatus == "all" || room["status"] == selectedStatus;
      bool matchesFloor = selectedFloor == "all" || room["floor"].toString() == selectedFloor;
      bool matchesType = selectedType == "all" || room["type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty || 
          room["roomNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (room["assignedTo"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesFloor && matchesType && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'cleaning':
        return warningColor;
      case 'inspection':
        return infoColor;
      case 'maintenance':
        return dangerColor;
      case 'ready':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Cleaning",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Rooms", icon: Icon(Icons.hotel)),
        Tab(text: "Active", icon: Icon(Icons.cleaning_services)),
        Tab(text: "Completed", icon: Icon(Icons.check_circle)),
      ],
      tabChildren: [
        _buildAllRoomsTab(),
        _buildActiveTab(),
        _buildCompletedTab(),
      ],
    );
  }

  Widget _buildAllRoomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter Section
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search rooms or staff...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          // Filter Options
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: floorOptions,
                  value: selectedFloor,
                  onChanged: (value, label) {
                    selectedFloor = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Rooms",
                "${rooms.length}",
                Icons.hotel,
                primaryColor,
              ),
              _buildSummaryCard(
                "In Cleaning",
                "${rooms.where((r) => r["status"] == "cleaning").length}",
                Icons.cleaning_services,
                warningColor,
              ),
              _buildSummaryCard(
                "Ready",
                "${rooms.where((r) => r["status"] == "ready").length}",
                Icons.check_circle,
                successColor,
              ),
              _buildSummaryCard(
                "Maintenance",
                "${rooms.where((r) => r["status"] == "maintenance").length}",
                Icons.build,
                dangerColor,
              ),
            ],
          ),

          // Room List
          ...filteredRooms.map((room) => _buildRoomCard(room)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeRooms = rooms.where((room) => 
        room["status"] == "cleaning" || room["status"] == "inspection"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Active Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.cleaning_services, color: warningColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Cleaning Tasks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "${activeRooms.length} rooms currently being cleaned",
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
          ),

          // Active Rooms
          ...activeRooms.map((room) => _buildActiveRoomCard(room)),
        ],
      ),
    );
  }

  Widget _buildCompletedTab() {
    List<Map<String, dynamic>> completedRooms = rooms.where((room) => 
        room["status"] == "ready"
    ).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Completed Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(60)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completed Today",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${completedRooms.length} rooms ready for guests",
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
          ),

          // Completed Rooms
          ...completedRooms.map((room) => _buildCompletedRoomCard(room)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
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
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Room Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(room["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Room ${room["roomNumber"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(room["status"]),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(room["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${room["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(room["priority"]),
                  ),
                ),
              ),
              Spacer(),
              if (room["maintenanceIssues"] as bool)
                Icon(Icons.warning, color: dangerColor, size: 20),
            ],
          ),

          // Room Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${room["type"]} - Floor ${room["floor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Assigned to: ${room["assignedTo"]}",
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
                  Text(
                    "Est. ${room["cleaningTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Next: ${room["nextCheckIn"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${room["completedTasks"]}/${room["totalTasks"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: (room["completedTasks"] as int) / (room["totalTasks"] as int),
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getStatusColor(room["status"]),
                ),
              ),
            ],
          ),

          // Notes
          if (room["notes"] != null && (room["notes"] as String).isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${room["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to room details
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // Show more options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRoomCard(Map<String, dynamic> room) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.cleaning_services, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Room ${room["roomNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(room["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${room["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(room["status"]),
                  ),
                ),
              ),
            ],
          ),

          Text(
            "${room["assignedTo"]} • ${room["type"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Current Tasks
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (room["tasks"] as List).map((task) => Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "$task",
                style: TextStyle(
                  fontSize: 10,
                  color: infoColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )).toList(),
          ),

          // Time Information
          Row(
            children: [
              Icon(Icons.access_time, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Est. ${room["cleaningTime"]} remaining",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Next guest: ${room["nextCheckIn"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Update Progress",
                  size: bs.sm,
                  onPressed: () {
                    // Update progress
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.chat,
                size: bs.sm,
                onPressed: () {
                  // Message staff
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedRoomCard(Map<String, dynamic> room) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: successColor.withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Room ${room["roomNumber"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Spacer(),
              Text(
                "READY",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${room["type"]} - Floor ${room["floor"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Cleaned by: ${room["assignedTo"]}",
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
                  Text(
                    "Completed in ${room["cleaningTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Next guest: ${room["nextCheckIn"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Report",
                  size: bs.sm,
                  onPressed: () {
                    // View cleaning report
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  // Re-inspect room
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
