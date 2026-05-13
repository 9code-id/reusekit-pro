import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAvailabilityView extends StatefulWidget {
  const HhaAvailabilityView({super.key});

  @override
  State<HhaAvailabilityView> createState() => _HhaAvailabilityViewState();
}

class _HhaAvailabilityViewState extends State<HhaAvailabilityView> {
  String selectedRoomType = "All";
  String selectedFloor = "All";
  DateTime selectedDate = DateTime.now();
  int availabilityFilter = 0; // 0: All, 1: Available, 2: Occupied, 3: Maintenance
  
  List<Map<String, dynamic>> roomTypes = [
    {"label": "All", "value": "All"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Deluxe", "value": "Deluxe"},
    {"label": "Suite", "value": "Suite"},
    {"label": "Presidential", "value": "Presidential"},
  ];

  List<Map<String, dynamic>> floors = [
    {"label": "All", "value": "All"},
    {"label": "Floor 1", "value": "1"},
    {"label": "Floor 2", "value": "2"},
    {"label": "Floor 3", "value": "3"},
    {"label": "Floor 4", "value": "4"},
    {"label": "Floor 5", "value": "5"},
  ];

  List<Map<String, dynamic>> availabilityStats = [
    {
      "title": "Total Rooms",
      "value": 120,
      "icon": Icons.hotel,
      "color": primaryColor,
    },
    {
      "title": "Available",
      "value": 87,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Occupied",
      "value": 28,
      "icon": Icons.person,
      "color": warningColor,
    },
    {
      "title": "Maintenance",
      "value": 5,
      "icon": Icons.build,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> rooms = [
    {
      "roomNumber": "101",
      "type": "Standard",
      "floor": "1",
      "status": "Available",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "price": 150.0,
      "amenities": ["WiFi", "AC", "TV"],
      "lastCleaned": "2 hours ago",
    },
    {
      "roomNumber": "102",
      "type": "Standard",
      "floor": "1", 
      "status": "Occupied",
      "guest": "John Smith",
      "checkIn": "2024-01-15",
      "checkOut": "2024-01-18",
      "price": 150.0,
      "amenities": ["WiFi", "AC", "TV"],
      "lastCleaned": "8 hours ago",
    },
    {
      "roomNumber": "201",
      "type": "Deluxe",
      "floor": "2",
      "status": "Available",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "price": 250.0,
      "amenities": ["WiFi", "AC", "TV", "Balcony"],
      "lastCleaned": "1 hour ago",
    },
    {
      "roomNumber": "301",
      "type": "Suite",
      "floor": "3",
      "status": "Maintenance",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "price": 400.0,
      "amenities": ["WiFi", "AC", "TV", "Kitchen", "Living Room"],
      "lastCleaned": "12 hours ago",
    },
    {
      "roomNumber": "401",
      "type": "Presidential",
      "floor": "4",
      "status": "Occupied",
      "guest": "Sarah Johnson",
      "checkIn": "2024-01-14",
      "checkOut": "2024-01-20",
      "price": 800.0,
      "amenities": ["WiFi", "AC", "TV", "Kitchen", "Living Room", "Jacuzzi"],
      "lastCleaned": "6 hours ago",
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    return rooms.where((room) {
      bool typeMatch = selectedRoomType == "All" || room["type"] == selectedRoomType;
      bool floorMatch = selectedFloor == "All" || room["floor"] == selectedFloor;
      bool statusMatch = availabilityFilter == 0 || _getStatusIndex(room["status"] as String) == availabilityFilter;
      
      return typeMatch && floorMatch && statusMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Availability"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Availability updated");
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
            // Date Picker
            QDatePicker(
              label: "Check Date",
              value: selectedDate,
              onChanged: (value) {
                selectedDate = value;
                setState(() {});
              },
            ),
            
            // Filters
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Room Type",
                    items: roomTypes,
                    value: selectedRoomType,
                    onChanged: (value, label) {
                      selectedRoomType = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Floor",
                    items: floors,
                    value: selectedFloor,
                    onChanged: (value, label) {
                      selectedFloor = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Status Filter
            QCategoryPicker(
              label: "Availability Status",
              items: [
                {"label": "All", "value": "0"},
                {"label": "Available", "value": "1"},
                {"label": "Occupied", "value": "2"},
                {"label": "Maintenance", "value": "3"},
              ],
              value: "$availabilityFilter",
              onChanged: (index, label, value, item) {
                availabilityFilter = int.parse(value);
                setState(() {});
              },
            ),
            
            // Availability Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: availabilityStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        stat["icon"] as IconData,
                        color: stat["color"] as Color,
                        size: 32,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            // Room List Header
            Row(
              children: [
                Text(
                  "Room Details",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredRooms.length} rooms",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            // Room List
            Column(
              spacing: spSm,
              children: filteredRooms.map((room) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor(room["status"] as String),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${room["roomNumber"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Floor ${room["floor"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${room["type"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(room["status"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${room["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor(room["status"] as String),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "\$${((room["price"] as double).toDouble()).currency}/night",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      if (room["guest"] != null) ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Guest: ${room["guest"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Check-in: ${room["checkIn"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.logout,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Check-out: ${room["checkOut"]}",
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
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amenities:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  (room["amenities"] as List).join(", "),
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
                              Text(
                                "Last Cleaned:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${room["lastCleaned"]}",
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
                        spacing: spSm,
                        children: [
                          if (room["status"] == "Available")
                            Expanded(
                              child: QButton(
                                label: "Book Room",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Room ${room["roomNumber"]} booking initiated");
                                },
                              ),
                            ),
                          if (room["status"] == "Occupied")
                            Expanded(
                              child: QButton(
                                label: "View Guest",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Viewing guest details for room ${room["roomNumber"]}");
                                },
                              ),
                            ),
                          if (room["status"] == "Maintenance")
                            Expanded(
                              child: QButton(
                                label: "Update Status",
                                size: bs.sm,
                                onPressed: () {
                                  ss("Maintenance status updated for room ${room["roomNumber"]}");
                                },
                              ),
                            ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              ss("More options for room ${room["roomNumber"]}");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return warningColor;
      case "Maintenance":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getStatusIndex(String status) {
    switch (status) {
      case "Available":
        return 1;
      case "Occupied":
        return 2;
      case "Maintenance":
        return 3;
      default:
        return 0;
    }
  }
}
