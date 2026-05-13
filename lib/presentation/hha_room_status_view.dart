import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomStatusView extends StatefulWidget {
  const HhaRoomStatusView({super.key});

  @override
  State<HhaRoomStatusView> createState() => _HhaRoomStatusViewState();
}

class _HhaRoomStatusViewState extends State<HhaRoomStatusView> {
  String selectedFilter = "all";
  String selectedFloor = "all";

  // Room status data
  List<Map<String, dynamic>> roomStatus = [
    {
      "number": "101",
      "type": "Presidential Suite",
      "floor": 1,
      "status": "occupied",
      "guest": "Mr. David Wilson",
      "checkIn": "15:00",
      "checkOut": "11:00",
      "nextGuest": "Mrs. Thompson",
      "nextCheckIn": "16:00",
      "housekeeping": "completed",
      "maintenance": "none",
      "lastCleaned": "14:30",
      "revenue": 850.00,
    },
    {
      "number": "102",
      "type": "Deluxe Suite", 
      "floor": 1,
      "status": "checkout",
      "guest": null,
      "checkIn": null,
      "checkOut": "10:30",
      "nextGuest": "Mr. Anderson",
      "nextCheckIn": "15:00",
      "housekeeping": "pending",
      "maintenance": "none",
      "lastCleaned": null,
      "revenue": 0.00,
    },
    {
      "number": "205",
      "type": "Deluxe Suite",
      "floor": 2,
      "status": "occupied",
      "guest": "Mr. John Smith",
      "checkIn": "14:00",
      "checkOut": "11:00",
      "nextGuest": null,
      "nextCheckIn": null,
      "housekeeping": "completed",
      "maintenance": "none",
      "lastCleaned": "13:45",
      "revenue": 450.00,
    },
    {
      "number": "302",
      "type": "Standard Room",
      "floor": 3,
      "status": "dirty",
      "guest": null,
      "checkIn": null,
      "checkOut": "11:30",
      "nextGuest": "Ms. Johnson",
      "nextCheckIn": "15:30",
      "housekeeping": "pending",
      "maintenance": "none",
      "lastCleaned": null,
      "revenue": 0.00,
    },
    {
      "number": "314",
      "type": "Standard Room",
      "floor": 3,
      "status": "cleaning",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "nextGuest": "Mr. Williams",
      "nextCheckIn": "16:00",
      "housekeeping": "in_progress",
      "maintenance": "none",
      "lastCleaned": null,
      "revenue": 0.00,
    },
    {
      "number": "412",
      "type": "Deluxe Room",
      "floor": 4,
      "status": "available",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "nextGuest": null,
      "nextCheckIn": null,
      "housekeeping": "completed",
      "maintenance": "none",
      "lastCleaned": "12:00",
      "revenue": 0.00,
    },
    {
      "number": "158",
      "type": "Standard Room",
      "floor": 1,
      "status": "maintenance",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "nextGuest": null,
      "nextCheckIn": null,
      "housekeeping": "pending",
      "maintenance": "hvac_repair",
      "lastCleaned": "10:00",
      "revenue": 0.00,
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    List<Map<String, dynamic>> filtered = roomStatus;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((room) => room["status"] == selectedFilter).toList();
    }
    
    if (selectedFloor != "all") {
      int floor = int.parse(selectedFloor);
      filtered = filtered.where((room) => room["floor"] == floor).toList();
    }
    
    return filtered;
  }

  Map<String, int> get statusCounts {
    return {
      "available": roomStatus.where((r) => r["status"] == "available").length,
      "occupied": roomStatus.where((r) => r["status"] == "occupied").length,
      "cleaning": roomStatus.where((r) => r["status"] == "cleaning").length,
      "dirty": roomStatus.where((r) => r["status"] == "dirty").length,
      "checkout": roomStatus.where((r) => r["status"] == "checkout").length,
      "maintenance": roomStatus.where((r) => r["status"] == "maintenance").length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Room status refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Summary
            Text(
              "Status Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatusSummaryCard("Available", statusCounts["available"]!, successColor, Icons.check_circle),
                _buildStatusSummaryCard("Occupied", statusCounts["occupied"]!, primaryColor, Icons.person),
                _buildStatusSummaryCard("Cleaning", statusCounts["cleaning"]!, warningColor, Icons.cleaning_services),
                _buildStatusSummaryCard("Dirty", statusCounts["dirty"]!, Colors.orange, Icons.warning),
                _buildStatusSummaryCard("Checkout", statusCounts["checkout"]!, Colors.blue, Icons.logout),
                _buildStatusSummaryCard("Maintenance", statusCounts["maintenance"]!, dangerColor, Icons.build),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Room Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  label: "Bulk Update",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    si("Bulk update feature coming soon");
                  },
                ),
              ],
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Available", "value": "available"},
                      {"label": "Occupied", "value": "occupied"},
                      {"label": "Cleaning", "value": "cleaning"},
                      {"label": "Dirty", "value": "dirty"},
                      {"label": "Check-out", "value": "checkout"},
                      {"label": "Maintenance", "value": "maintenance"},
                    ],
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Floor",
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

            // Room Status Cards
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
                      color: _getStatusColor(room["status"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Room Header
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
                                      color: _getStatusColor(room["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${room["status"]}".replaceAll("_", " ").toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(room["status"]),
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
                        if ((room["revenue"] as double) > 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${((room["revenue"] as double).toDouble()).toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "today",
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

                    // Current Guest Info
                    if (room["guest"] != null)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Current: ${room["guest"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            if (room["checkOut"] != null)
                              Text(
                                "Checkout: ${room["checkOut"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ),

                    // Next Guest Info
                    if (room["nextGuest"] != null) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Next: ${room["nextGuest"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ),
                            Text(
                              "Checkin: ${room["nextCheckIn"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Housekeeping & Maintenance Status
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.cleaning_services,
                                size: 16,
                                color: _getHousekeepingColor(room["housekeeping"]),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Housekeeping: ${room["housekeeping"]}".replaceAll("_", " "),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getHousekeepingColor(room["housekeeping"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (room["maintenance"] != "none")
                          Row(
                            children: [
                              Icon(
                                Icons.build,
                                size: 16,
                                color: dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${room["maintenance"]}".replaceAll("_", " "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    if (room["lastCleaned"] != null) ...[
                      SizedBox(height: spXs),
                      Text(
                        "Last cleaned: ${room["lastCleaned"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],

                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: _getStatusActionLabel(room["status"]),
                            size: bs.sm,
                            onPressed: () {
                              _handleStatusAction(room);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            _showRoomOptions(room);
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
      ),
    );
  }

  Widget _buildStatusSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return successColor;
      case "occupied":
        return primaryColor;
      case "cleaning":
        return warningColor;
      case "dirty":
        return Colors.orange;
      case "checkout":
        return Colors.blue;
      case "maintenance":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getHousekeepingColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return Colors.orange;
      default:
        return disabledColor;
    }
  }

  String _getStatusActionLabel(String status) {
    switch (status) {
      case "available":
        return "Assign Guest";
      case "occupied":
        return "Guest Details";
      case "cleaning":
        return "Mark Clean";
      case "dirty":
        return "Start Cleaning";
      case "checkout":
        return "Prepare Room";
      case "maintenance":
        return "Update Status";
      default:
        return "Update";
    }
  }

  void _handleStatusAction(Map<String, dynamic> room) {
    String action = _getStatusActionLabel(room["status"]);
    ss("$action completed for Room ${room["number"]}");
  }

  void _showRoomOptions(Map<String, dynamic> room) {
    si("Room ${room["number"]} options: Housekeeping, Maintenance, Guest Info");
  }
}
