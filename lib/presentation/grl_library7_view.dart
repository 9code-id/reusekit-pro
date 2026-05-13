import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLibrary7View extends StatefulWidget {
  @override
  State<GrlLibrary7View> createState() => _GrlLibrary7ViewState();
}

class _GrlLibrary7ViewState extends State<GrlLibrary7View> {
  String searchQuery = "";
  String selectedFloor = "All Floors";
  String selectedStatus = "All";

  List<Map<String, dynamic>> floors = [
    {"label": "All Floors", "value": "All Floors"},
    {"label": "Ground Floor", "value": "Ground Floor"},
    {"label": "First Floor", "value": "First Floor"},
    {"label": "Second Floor", "value": "Second Floor"},
    {"label": "Third Floor", "value": "Third Floor"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "Occupied", "value": "Occupied"},
    {"label": "Reserved", "value": "Reserved"},
  ];

  List<Map<String, dynamic>> studySpaces = [
    {
      "id": 1,
      "name": "Silent Study Room A",
      "type": "Private Room",
      "floor": "Ground Floor",
      "capacity": 4,
      "features": ["Whiteboard", "Power Outlets", "AC", "WiFi"],
      "status": "Available",
      "nextAvailable": "",
      "currentUser": "",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 5.0,
      "image": "https://picsum.photos/400/300?random=1&keyword=study",
      "description": "Quiet private room perfect for group study sessions",
    },
    {
      "id": 2,
      "name": "Collaboration Space B",
      "type": "Group Area",
      "floor": "First Floor",
      "capacity": 8,
      "features": ["Smart TV", "Video Conference", "Whiteboard", "Power Outlets"],
      "status": "Occupied",
      "nextAvailable": "14:30",
      "currentUser": "Research Team Alpha",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 8.0,
      "image": "https://picsum.photos/400/300?random=2&keyword=collaboration",
      "description": "Modern collaboration space with advanced technology",
    },
    {
      "id": 3,
      "name": "Quiet Desk 12",
      "type": "Individual Desk",
      "floor": "Second Floor",
      "capacity": 1,
      "features": ["Desk Lamp", "Power Outlet", "Storage"],
      "status": "Available",
      "nextAvailable": "",
      "currentUser": "",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 2.0,
      "image": "https://picsum.photos/400/300?random=3&keyword=desk",
      "description": "Individual study desk in quiet environment",
    },
    {
      "id": 4,
      "name": "Multimedia Lab",
      "type": "Computer Lab",
      "floor": "Third Floor",
      "capacity": 20,
      "features": ["Computers", "Software Suite", "Projector", "Sound System"],
      "status": "Reserved",
      "nextAvailable": "16:00",
      "currentUser": "",
      "reservedBy": "Digital Media Class",
      "reservedTime": "13:00-16:00",
      "hourlyRate": 15.0,
      "image": "https://picsum.photos/400/300?random=4&keyword=computer",
      "description": "Fully equipped multimedia laboratory for digital projects",
    },
    {
      "id": 5,
      "name": "Reading Lounge C",
      "type": "Lounge Area",
      "floor": "First Floor",
      "capacity": 12,
      "features": ["Comfortable Seating", "Natural Light", "Coffee Station"],
      "status": "Available",
      "nextAvailable": "",
      "currentUser": "",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 0.0,
      "image": "https://picsum.photos/400/300?random=5&keyword=lounge",
      "description": "Relaxing space for casual reading and light study",
    },
    {
      "id": 6,
      "name": "Meeting Room Alpha",
      "type": "Meeting Room",
      "floor": "Second Floor",
      "capacity": 6,
      "features": ["Conference Table", "Projector", "Video Conference", "AC"],
      "status": "Occupied",
      "nextAvailable": "15:45",
      "currentUser": "Library Committee",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 10.0,
      "image": "https://picsum.photos/400/300?random=6&keyword=meeting",
      "description": "Professional meeting space for formal discussions",
    },
    {
      "id": 7,
      "name": "Creative Workshop",
      "type": "Workshop Space",
      "floor": "Ground Floor",
      "capacity": 15,
      "features": ["Art Supplies", "Flexible Seating", "Storage", "Natural Light"],
      "status": "Available",
      "nextAvailable": "",
      "currentUser": "",
      "reservedBy": "",
      "reservedTime": "",
      "hourlyRate": 12.0,
      "image": "https://picsum.photos/400/300?random=7&keyword=creative",
      "description": "Flexible space designed for creative projects and workshops",
    },
    {
      "id": 8,
      "name": "Phone Booth 3",
      "type": "Private Booth",
      "floor": "Third Floor",
      "capacity": 1,
      "features": ["Soundproof", "Phone", "Power Outlet"],
      "status": "Reserved",
      "nextAvailable": "14:15",
      "currentUser": "",
      "reservedBy": "John Smith",
      "reservedTime": "13:30-14:15",
      "hourlyRate": 3.0,
      "image": "https://picsum.photos/400/300?random=8&keyword=booth",
      "description": "Private soundproof booth for phone calls and video meetings",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return successColor;
      case "Occupied":
        return dangerColor;
      case "Reserved":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Private Room":
        return primaryColor;
      case "Group Area":
        return successColor;
      case "Individual Desk":
        return infoColor;
      case "Computer Lab":
        return secondaryColor;
      case "Lounge Area":
        return warningColor;
      case "Meeting Room":
        return dangerColor;
      case "Workshop Space":
        return primaryColor;
      case "Private Booth":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  List<Map<String, dynamic>> get filteredSpaces {
    List<Map<String, dynamic>> filtered = studySpaces;

    if (selectedFloor != "All Floors") {
      filtered = filtered.where((space) => space["floor"] == selectedFloor).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((space) => space["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((space) =>
          (space["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (space["type"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Spaces"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search and Filters
            QTextField(
              label: "Search spaces",
              value: searchQuery,
              hint: "Search by name or type",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            Row(
              children: [
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

            // Quick Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${studySpaces.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Spaces",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${studySpaces.where((s) => s["status"] == "Available").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: disabledColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${studySpaces.where((s) => s["status"] == "Occupied").length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Occupied",
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
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Floor Map",
                      size: bs.sm,
                      icon: Icons.map,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // Space Types Filter
            Text(
              "Browse by Type",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QHorizontalScroll(
              children: studySpaces
                  .map((space) => space["type"] as String)
                  .toSet()
                  .map((type) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: _getTypeColor(type).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: _getTypeColor(type)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getTypeIcon(type),
                        size: 16,
                        color: _getTypeColor(type),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getTypeColor(type),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Results
            Text(
              "${filteredSpaces.length} Spaces Found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),

            // Spaces List
            Column(
              spacing: spSm,
              children: filteredSpaces.map((space) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: space["status"] == "Available"
                        ? Border.all(color: successColor.withAlpha(100))
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Space Image
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Stack(
                          children: [
                            Image.network(
                              "${space["image"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(space["type"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getTypeIcon(space["type"] as String),
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${space["type"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(space["status"] as String),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${space["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Space Details
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${space["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if ((space["hourlyRate"] as double) > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "\$${(space["hourlyRate"] as double).toStringAsFixed(0)}/hr",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "FREE",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            Text(
                              "${space["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Space Info
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${space["floor"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Capacity: ${space["capacity"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            // Current Status Info
                            if (space["status"] == "Occupied" && (space["currentUser"] as String).isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 16,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "Currently used by: ${space["currentUser"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if ((space["nextAvailable"] as String).isNotEmpty)
                                      Text(
                                        "Until ${space["nextAvailable"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: dangerColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                            if (space["status"] == "Reserved" && (space["reservedBy"] as String).isNotEmpty)
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "Reserved by: ${space["reservedBy"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: warningColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if ((space["reservedTime"] as String).isNotEmpty)
                                      Text(
                                        "${space["reservedTime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: warningColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                            // Features
                            if ((space["features"] as List).isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Features:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (space["features"] as List).map((feature) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          border: Border.all(color: infoColor.withAlpha(50)),
                                        ),
                                        child: Text(
                                          "$feature",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: space["status"] == "Available"
                                        ? "Reserve Now"
                                        : space["status"] == "Occupied"
                                            ? "Join Queue"
                                            : "View Details",
                                    size: bs.md,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.info_outline,
                                  size: bs.md,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
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

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Private Room":
        return Icons.meeting_room;
      case "Group Area":
        return Icons.groups;
      case "Individual Desk":
        return Icons.desk;
      case "Computer Lab":
        return Icons.computer;
      case "Lounge Area":
        return Icons.weekend;
      case "Meeting Room":
        return Icons.business_center;
      case "Workshop Space":
        return Icons.build;
      case "Private Booth":
        return Icons.phone_in_talk;
      default:
        return Icons.location_on;
    }
  }
}
