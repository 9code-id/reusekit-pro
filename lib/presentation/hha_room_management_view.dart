import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaRoomManagementView extends StatefulWidget {
  const HhaRoomManagementView({super.key});

  @override
  State<HhaRoomManagementView> createState() => _HhaRoomManagementViewState();
}

class _HhaRoomManagementViewState extends State<HhaRoomManagementView> {
  int currentTab = 0;
  String selectedFilter = "all";

  // Room data
  List<Map<String, dynamic>> rooms = [
    {
      "number": "101",
      "type": "Presidential Suite",
      "floor": 1,
      "status": "occupied",
      "guest": "Mr. David Wilson",
      "checkIn": "2024-06-15",
      "checkOut": "2024-06-20",
      "rate": 850.00,
      "capacity": 4,
      "amenities": ["Jacuzzi", "Balcony", "Mini Bar", "Butler Service"],
    },
    {
      "number": "205",
      "type": "Deluxe Suite",
      "floor": 2,
      "status": "occupied",
      "guest": "Mr. John Smith",
      "checkIn": "2024-06-15",
      "checkOut": "2024-06-18",
      "rate": 450.00,
      "capacity": 2,
      "amenities": ["Balcony", "Mini Bar", "Room Service"],
    },
    {
      "number": "302",
      "type": "Standard Room",
      "floor": 3,
      "status": "dirty",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "rate": 250.00,
      "capacity": 2,
      "amenities": ["WiFi", "AC", "TV"],
    },
    {
      "number": "314",
      "type": "Standard Room",
      "floor": 3,
      "status": "cleaning",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "rate": 250.00,
      "capacity": 2,
      "amenities": ["WiFi", "AC", "TV"],
    },
    {
      "number": "412",
      "type": "Deluxe Room",
      "floor": 4,
      "status": "available",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "rate": 350.00,
      "capacity": 3,
      "amenities": ["Balcony", "Mini Bar", "WiFi", "AC"],
    },
    {
      "number": "158",
      "type": "Standard Room",
      "floor": 1,
      "status": "maintenance",
      "guest": null,
      "checkIn": null,
      "checkOut": null,
      "rate": 250.00,
      "capacity": 2,
      "amenities": ["WiFi", "AC", "TV"],
    },
  ];

  // Room types
  List<Map<String, dynamic>> roomTypes = [
    {
      "name": "Presidential Suite",
      "count": 2,
      "available": 1,
      "occupied": 1,
      "baseRate": 850.00,
      "maxCapacity": 4,
    },
    {
      "name": "Deluxe Suite", 
      "count": 8,
      "available": 6,
      "occupied": 2,
      "baseRate": 450.00,
      "maxCapacity": 2,
    },
    {
      "name": "Deluxe Room",
      "count": 15,
      "available": 12,
      "occupied": 3,
      "baseRate": 350.00,
      "maxCapacity": 3,
    },
    {
      "name": "Standard Room",
      "count": 45,
      "available": 35,
      "occupied": 10,
      "baseRate": 250.00,
      "maxCapacity": 2,
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    if (selectedFilter == "all") return rooms;
    return rooms.where((room) => room["status"] == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Room Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Rooms", icon: Icon(Icons.hotel)),
        Tab(text: "Types", icon: Icon(Icons.category)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRoomsTab(),
        _buildRoomTypesTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    Map<String, int> statusCounts = {
      "available": rooms.where((r) => r["status"] == "available").length,
      "occupied": rooms.where((r) => r["status"] == "occupied").length,
      "cleaning": rooms.where((r) => r["status"] == "cleaning").length,
      "dirty": rooms.where((r) => r["status"] == "dirty").length,
      "maintenance": rooms.where((r) => r["status"] == "maintenance").length,
    };

    double occupancyRate = (statusCounts["occupied"]! / rooms.length * 100);

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Stats
          Text(
            "Room Status Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatusCard("Available", statusCounts["available"]!, Icons.check_circle, successColor),
              _buildStatusCard("Occupied", statusCounts["occupied"]!, Icons.person, primaryColor),
              _buildStatusCard("Cleaning", statusCounts["cleaning"]!, Icons.cleaning_services, warningColor),
              _buildStatusCard("Maintenance", statusCounts["maintenance"]!, Icons.build, dangerColor),
            ],
          ),

          // Occupancy Rate
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
                    Expanded(
                      child: Text(
                        "Occupancy Rate",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${occupancyRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: occupancyRate / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    occupancyRate >= 80 ? successColor : occupancyRate >= 60 ? warningColor : dangerColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${statusCounts["occupied"]} of ${rooms.length} rooms occupied",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickActionCard(
                "Assign Room",
                "Assign available room to guest",
                Icons.assignment,
                primaryColor,
              ),
              _buildQuickActionCard(
                "Maintenance Request",
                "Report room maintenance issue",
                Icons.build,
                Colors.red,
              ),
              _buildQuickActionCard(
                "Housekeeping",
                "Schedule room cleaning",
                Icons.cleaning_services,
                Colors.blue,
              ),
              _buildQuickActionCard(
                "Room Rates",
                "Update room pricing",
                Icons.attach_money,
                Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String title, int count, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH3,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String description, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {
                si("$title module opened");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Section
          Row(
            children: [
              Expanded(
                child: Text(
                  "All Rooms",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Room",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("New room form opened");
                },
              ),
            ],
          ),
          
          // Status Filter
          QHorizontalScroll(
            children: [
              _buildFilterChip("all", "All Rooms"),
              _buildFilterChip("available", "Available"),
              _buildFilterChip("occupied", "Occupied"),
              _buildFilterChip("cleaning", "Cleaning"),
              _buildFilterChip("dirty", "Dirty"),
              _buildFilterChip("maintenance", "Maintenance"),
            ],
          ),

          // Rooms List
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
                                    color: _getStatusColor(room["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${room["status"]}".toUpperCase(),
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
                  if (room["guest"] != null) ...[
                    SizedBox(height: spSm),
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
                              "${room["guest"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "${room["checkIn"]} - ${room["checkOut"]}",
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
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Capacity: ${room["capacity"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Text(
                          (room["amenities"] as List).take(3).join(", "),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: _getRoomActionLabel(room["status"]),
                          size: bs.sm,
                          onPressed: () {
                            ss("Room ${room["number"]} action completed");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("Room ${room["number"]} options");
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

  Widget _buildFilterChip(String value, String label) {
    bool isSelected = selectedFilter == value;
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {
          selectedFilter = value;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spMd,
            vertical: spSm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: isSelected ? primaryColor : disabledOutlineBorderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : disabledBoldColor,
            ),
          ),
        ),
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
      case "maintenance":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getRoomActionLabel(String status) {
    switch (status) {
      case "available":
        return "Assign Guest";
      case "occupied":
        return "View Details";
      case "cleaning":
        return "Mark Clean";
      case "dirty":
        return "Start Cleaning";
      case "maintenance":
        return "Update Status";
      default:
        return "Update";
    }
  }

  Widget _buildRoomTypesTab() {
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
                  "Room Types",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Type",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("New room type form opened");
                },
              ),
            ],
          ),
          ...roomTypes.map((type) {
            double occupancyRate = ((type["count"] as int) - (type["available"] as int)) / (type["count"] as int) * 100;
            
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${type["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Max ${type["maxCapacity"]} guests",
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
                            "\$${((type["baseRate"] as double).toDouble()).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "base rate",
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
                        child: Column(
                          children: [
                            Text(
                              "${type["count"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Rooms",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${type["available"]}",
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
                        width: 1,
                        height: 40,
                        color: disabledOutlineBorderColor,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${type["occupied"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Occupancy: ${occupancyRate.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: occupancyRate / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                occupancyRate >= 80 ? successColor : occupancyRate >= 60 ? warningColor : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          si("Editing ${type["name"]} room type");
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

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildReportCard(
                "Occupancy Report",
                "Daily room occupancy statistics",
                Icons.hotel,
                primaryColor,
              ),
              _buildReportCard(
                "Revenue Analysis",
                "Room revenue by type and period",
                Icons.attach_money,
                Colors.green,
              ),
              _buildReportCard(
                "Maintenance Log",
                "Room maintenance history",
                Icons.build,
                Colors.red,
              ),
              _buildReportCard(
                "Housekeeping Report",
                "Cleaning schedules and status",
                Icons.cleaning_services,
                Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate",
              size: bs.sm,
              onPressed: () {
                ss("$title generated successfully");
              },
            ),
          ),
        ],
      ),
    );
  }
}
