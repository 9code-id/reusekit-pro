import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomAssignmentView extends StatefulWidget {
  const HhaRoomAssignmentView({super.key});

  @override
  State<HhaRoomAssignmentView> createState() => _HhaRoomAssignmentViewState();
}

class _HhaRoomAssignmentViewState extends State<HhaRoomAssignmentView> {
  int currentTab = 0;
  String selectedRoomType = "all";
  String selectedFloor = "all";

  // Available rooms
  List<Map<String, dynamic>> availableRooms = [
    {
      "number": "102",
      "type": "Deluxe Suite",
      "floor": 1,
      "capacity": 2,
      "rate": 450.00,
      "amenities": ["Balcony", "Mini Bar", "Room Service", "Ocean View"],
      "lastCleaned": "14:30",
      "status": "ready",
    },
    {
      "number": "305",
      "type": "Standard Room",
      "floor": 3,
      "capacity": 2,
      "rate": 250.00,
      "amenities": ["WiFi", "AC", "TV"],
      "lastCleaned": "13:45",
      "status": "ready",
    },
    {
      "number": "412",
      "type": "Deluxe Room",
      "floor": 4,
      "capacity": 3,
      "rate": 350.00,
      "amenities": ["Balcony", "Mini Bar", "WiFi", "AC"],
      "lastCleaned": "12:00",
      "status": "ready",
    },
    {
      "number": "208",
      "type": "Standard Room",
      "floor": 2,
      "capacity": 2,
      "rate": 250.00,
      "amenities": ["WiFi", "AC", "TV"],
      "lastCleaned": "15:15",
      "status": "ready",
    },
    {
      "number": "315",
      "type": "Deluxe Room",
      "floor": 3,
      "capacity": 3,
      "rate": 350.00,
      "amenities": ["Balcony", "Mini Bar", "WiFi", "AC"],
      "lastCleaned": "11:30",
      "status": "ready",
    },
  ];

  // Pending assignments
  List<Map<String, dynamic>> pendingAssignments = [
    {
      "guest": "Mrs. Sarah Thompson",
      "checkIn": "2024-06-16",
      "checkOut": "2024-06-19",
      "roomType": "Deluxe Suite",
      "adults": 2,
      "children": 0,
      "specialRequests": "High floor, ocean view",
      "arrivalTime": "15:00",
      "reservationId": "RES001",
      "assignedRoom": null,
    },
    {
      "guest": "Mr. Robert Anderson",
      "checkIn": "2024-06-16",
      "checkOut": "2024-06-18",
      "roomType": "Standard Room",
      "adults": 1,
      "children": 1,
      "specialRequests": "Ground floor, quiet area",
      "arrivalTime": "14:30",
      "reservationId": "RES002",
      "assignedRoom": null,
    },
    {
      "guest": "Ms. Lisa Johnson",
      "checkIn": "2024-06-16",
      "checkOut": "2024-06-20",
      "roomType": "Deluxe Room",
      "adults": 2,
      "children": 1,
      "specialRequests": "Crib required",
      "arrivalTime": "16:00",
      "reservationId": "RES003",
      "assignedRoom": null,
    },
  ];

  // Current assignments
  List<Map<String, dynamic>> currentAssignments = [
    {
      "guest": "Mr. David Wilson",
      "room": "101",
      "roomType": "Presidential Suite",
      "checkIn": "2024-06-15",
      "checkOut": "2024-06-20",
      "adults": 2,
      "children": 0,
      "assignedBy": "Front Desk",
      "assignedAt": "14:45",
      "status": "confirmed",
    },
    {
      "guest": "Mr. John Smith",
      "room": "205",
      "roomType": "Deluxe Suite",
      "checkIn": "2024-06-15",
      "checkOut": "2024-06-18",
      "adults": 2,
      "children": 0,
      "assignedBy": "Manager",
      "assignedAt": "13:30",
      "status": "confirmed",
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    List<Map<String, dynamic>> filtered = availableRooms;
    
    if (selectedRoomType != "all") {
      filtered = filtered.where((room) => room["type"] == selectedRoomType).toList();
    }
    
    if (selectedFloor != "all") {
      int floor = int.parse(selectedFloor);
      filtered = filtered.where((room) => room["floor"] == floor).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Assignment",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending)),
        Tab(text: "Available", icon: Icon(Icons.hotel)),
        Tab(text: "Assigned", icon: Icon(Icons.assignment_turned_in)),
        Tab(text: "Bulk Assign", icon: Icon(Icons.assignment)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildAvailableTab(),
        _buildAssignedTab(),
        _buildBulkAssignTab(),
      ],
    );
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Pending Assignments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${pendingAssignments.length} pending",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          ...pendingAssignments.map((reservation) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: warningColor,
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
                              "${reservation["guest"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reservation["reservationId"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${reservation["roomType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${reservation["checkIn"]} - ${reservation["checkOut"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Arrival: ${reservation["arrivalTime"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${reservation["adults"]} adults",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            if ((reservation["children"] as int) > 0) ...[
                              Text(
                                ", ${reservation["children"]} children",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (reservation["specialRequests"] != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${reservation["specialRequests"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
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
                        child: QButton(
                          label: "Assign Room",
                          size: bs.sm,
                          onPressed: () {
                            _showRoomSelectionDialog(reservation);
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("Options for ${reservation["guest"]}");
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
    );
  }

  Widget _buildAvailableTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Available Rooms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${filteredRooms.length} available",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),

          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Room Type",
                  items: [
                    {"label": "All Types", "value": "all"},
                    {"label": "Presidential Suite", "value": "Presidential Suite"},
                    {"label": "Deluxe Suite", "value": "Deluxe Suite"},
                    {"label": "Deluxe Room", "value": "Deluxe Room"},
                    {"label": "Standard Room", "value": "Standard Room"},
                  ],
                  value: selectedRoomType,
                  onChanged: (value, label) {
                    selectedRoomType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Floor",
                  items: [
                    {"label": "All Floors", "value": "all"},
                    {"label": "Floor 1", "value": "1"},
                    {"label": "Floor 2", "value": "2"},
                    {"label": "Floor 3", "value": "3"},
                    {"label": "Floor 4", "value": "4"},
                  ],
                  value: selectedFloor,
                  onChanged: (value, label) {
                    selectedFloor = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Available Rooms List
          ...filteredRooms.map((room) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: successColor,
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
                            Row(
                              children: [
                                Text(
                                  "Room ${room["number"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "READY",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${room["type"]} • Floor ${room["floor"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                            "\$${((room["rate"] as double).toDouble()).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "per night",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Capacity: ${room["capacity"]} guests",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.cleaning_services,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Cleaned: ${room["lastCleaned"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                (room["amenities"] as List).join(", "),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Assign to Guest",
                      size: bs.sm,
                      onPressed: () {
                        _showGuestSelectionDialog(room);
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAssignedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Current Assignments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${currentAssignments.length} assigned",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ...currentAssignments.map((assignment) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: primaryColor,
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
                              "${assignment["guest"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Room ${assignment["room"]} • ${assignment["roomType"]}",
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
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: assignment["status"] == "confirmed"
                              ? successColor.withAlpha(20)
                              : primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${assignment["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: assignment["status"] == "confirmed"
                                ? successColor
                                : primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${assignment["checkIn"]} - ${assignment["checkOut"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.people,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${assignment["adults"]} adults",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Assigned by: ${assignment["assignedBy"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "at ${assignment["assignedAt"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                        child: QButton(
                          label: "Modify Assignment",
                          size: bs.sm,
                          onPressed: () {
                            si("Modify assignment for ${assignment["guest"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.info,
                        size: bs.sm,
                        onPressed: () {
                          si("Details for ${assignment["guest"]}");
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
    );
  }

  Widget _buildBulkAssignTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bulk Assignment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
              children: [
                Text(
                  "Auto-assign all pending reservations to available rooms based on preferences and room type.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spLg),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Auto Assign All",
                        icon: Icons.auto_awesome,
                        size: bs.md,
                        onPressed: () {
                          _performBulkAssignment();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "Assignment Rules",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
                _buildRuleItem("Room type matches reservation request"),
                _buildRuleItem("Floor preference considered when available"),
                _buildRuleItem("Special requests prioritized"),
                _buildRuleItem("Recently cleaned rooms preferred"),
                _buildRuleItem("Guest capacity requirements met"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              rule,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRoomSelectionDialog(Map<String, dynamic> reservation) {
    // Filter suitable rooms for this reservation
    List<Map<String, dynamic>> suitableRooms = availableRooms
        .where((room) => room["type"] == reservation["roomType"])
        .toList();

    si("Showing ${suitableRooms.length} suitable rooms for ${reservation["guest"]}");
    ss("Room selection dialog opened");
  }

  void _showGuestSelectionDialog(Map<String, dynamic> room) {
    // Show pending guests that can be assigned to this room
    List<Map<String, dynamic>> suitableGuests = pendingAssignments
        .where((guest) => guest["roomType"] == room["type"])
        .toList();

    si("Showing ${suitableGuests.length} suitable guests for Room ${room["number"]}");
    ss("Guest selection dialog opened");
  }

  void _performBulkAssignment() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("${pendingAssignments.length} reservations auto-assigned successfully");
    });
  }
}
