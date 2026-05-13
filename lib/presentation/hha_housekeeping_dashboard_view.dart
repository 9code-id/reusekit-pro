import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaHousekeepingDashboardView extends StatefulWidget {
  const HhaHousekeepingDashboardView({super.key});

  @override
  State<HhaHousekeepingDashboardView> createState() => _HhaHousekeepingDashboardViewState();
}

class _HhaHousekeepingDashboardViewState extends State<HhaHousekeepingDashboardView> {
  int currentTab = 0;

  // Housekeeping Stats
  List<Map<String, dynamic>> housekeepingStats = [
    {
      "title": "Rooms Cleaned",
      "value": "32",
      "total": "45",
      "percentage": 71,
      "icon": Icons.cleaning_services,
      "color": Colors.green,
    },
    {
      "title": "Rooms Pending",
      "value": "13",
      "total": "45",
      "percentage": 29,
      "icon": Icons.pending,
      "color": Colors.orange,
    },
    {
      "title": "Maintenance Issues",
      "value": "5",
      "total": null,
      "percentage": null,
      "icon": Icons.build,
      "color": Colors.red,
    },
    {
      "title": "Staff On Duty",
      "value": "12",
      "total": "15",
      "percentage": 80,
      "icon": Icons.people,
      "color": Colors.blue,
    },
  ];

  List<Map<String, dynamic>> roomTasks = [
    {
      "room": "201",
      "type": "Deluxe Suite",
      "status": "dirty",
      "priority": "high",
      "checkOut": "11:00 AM",
      "nextCheckIn": "3:00 PM",
      "estimatedTime": "45 min",
      "assignedTo": "Maria",
    },
    {
      "room": "305",
      "type": "Standard Room",
      "status": "cleaning",
      "priority": "medium",
      "checkOut": "10:30 AM", 
      "nextCheckIn": "4:00 PM",
      "estimatedTime": "30 min",
      "assignedTo": "Ana",
    },
    {
      "room": "412",
      "type": "Presidential Suite",
      "status": "dirty",
      "priority": "high",
      "checkOut": "12:00 PM",
      "nextCheckIn": "2:00 PM",
      "estimatedTime": "60 min",
      "assignedTo": "Rosa",
    },
    {
      "room": "158",
      "type": "Standard Room",
      "status": "maintenance",
      "priority": "urgent",
      "checkOut": "9:00 AM",
      "nextCheckIn": "5:00 PM",
      "estimatedTime": "120 min",
      "assignedTo": "Carlos",
    },
  ];

  List<Map<String, dynamic>> staffMembers = [
    {
      "name": "Maria Garcia",
      "shift": "Morning",
      "status": "active",
      "roomsAssigned": 8,
      "roomsCompleted": 6,
      "currentRoom": "201",
      "performance": 95,
    },
    {
      "name": "Ana Rodriguez",
      "shift": "Morning",
      "status": "active",
      "roomsAssigned": 7,
      "roomsCompleted": 5,
      "currentRoom": "305",
      "performance": 88,
    },
    {
      "name": "Rosa Martinez",
      "shift": "Afternoon",
      "status": "active",
      "roomsAssigned": 6,
      "roomsCompleted": 4,
      "currentRoom": "412",
      "performance": 92,
    },
    {
      "name": "Carlos Silva",
      "shift": "Full Day",
      "status": "break",
      "roomsAssigned": 5,
      "roomsCompleted": 3,
      "currentRoom": null,
      "performance": 85,
    },
  ];

  List<Map<String, dynamic>> supplies = [
    {
      "item": "Toilet Paper",
      "current": 25,
      "minimum": 20,
      "status": "ok",
    },
    {
      "item": "Towels (Clean)",
      "current": 45,
      "minimum": 50,
      "status": "low",
    },
    {
      "item": "Bed Sheets",
      "current": 35,
      "minimum": 30,
      "status": "ok",
    },
    {
      "item": "Cleaning Supplies",
      "current": 8,
      "minimum": 15,
      "status": "critical",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Housekeeping Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Room Tasks", icon: Icon(Icons.hotel)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
        Tab(text: "Supplies", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRoomTasksTab(),
        _buildStaffTab(),
        _buildSuppliesTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Housekeeping Department",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Maintaining comfort and cleanliness",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.cleaning_services,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Daily Stats
          Text(
            "Today's Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: housekeepingStats.map((stat) {
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"],
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        if (stat["percentage"] != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (stat["percentage"] as int) >= 80
                                  ? successColor.withAlpha(20)
                                  : (stat["percentage"] as int) >= 50
                                      ? warningColor.withAlpha(20)
                                      : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (stat["percentage"] as int) >= 80
                                    ? successColor
                                    : (stat["percentage"] as int) >= 50
                                        ? warningColor
                                        : dangerColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (stat["total"] != null)
                          Text(
                            "/${stat["total"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
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

          // Priority Rooms
          Text(
            "Priority Rooms",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...roomTasks.where((task) => task["priority"] == "high" || task["priority"] == "urgent").take(3).map((task) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: task["priority"] == "urgent"
                        ? dangerColor
                        : task["priority"] == "high"
                            ? warningColor
                            : primaryColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Room ${task["room"]}",
                              style: TextStyle(
                                fontSize: 18,
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
                                color: task["priority"] == "urgent"
                                    ? dangerColor.withAlpha(20)
                                    : warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${task["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: task["priority"] == "urgent"
                                      ? dangerColor
                                      : warningColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${task["type"]} • ${task["estimatedTime"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Assigned to: ${task["assignedTo"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: task["status"] == "cleaning" ? "Update" : "Start",
                    size: bs.sm,
                    onPressed: () {
                      ss("Room ${task["room"]} task updated");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRoomTasksTab() {
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
                  "Room Assignments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Assign Room",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("New room assignment created");
                },
              ),
            ],
          ),
          ...roomTasks.map((task) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: task["status"] == "clean"
                        ? successColor
                        : task["status"] == "cleaning"
                            ? warningColor
                            : task["status"] == "maintenance"
                                ? dangerColor
                                : primaryColor,
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
                                  "Room ${task["room"]}",
                                  style: TextStyle(
                                    fontSize: 20,
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
                                    color: task["status"] == "clean"
                                        ? successColor.withAlpha(20)
                                        : task["status"] == "cleaning"
                                            ? warningColor.withAlpha(20)
                                            : task["status"] == "maintenance"
                                                ? dangerColor.withAlpha(20)
                                                : primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${task["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: task["status"] == "clean"
                                          ? successColor
                                          : task["status"] == "cleaning"
                                              ? warningColor
                                              : task["status"] == "maintenance"
                                                  ? dangerColor
                                                  : primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${task["type"]}",
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
                          color: task["priority"] == "urgent"
                              ? dangerColor.withAlpha(20)
                              : task["priority"] == "high"
                                  ? warningColor.withAlpha(20)
                                  : primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${task["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: task["priority"] == "urgent"
                                ? dangerColor
                                : task["priority"] == "high"
                                    ? warningColor
                                    : primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Assigned to: ${task["assignedTo"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Est. ${task["estimatedTime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Next: ${task["nextCheckIn"]}",
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
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: task["status"] == "dirty" ? "Start Cleaning" : "Update Status",
                          size: bs.sm,
                          onPressed: () {
                            ss("Room ${task["room"]} status updated");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("Room ${task["room"]} options");
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

  Widget _buildStaffTab() {
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
                  "Staff Members",
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
                  "${staffMembers.where((s) => s["status"] == "active").length} active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          ...staffMembers.map((staff) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: staff["status"] == "active"
                        ? successColor
                        : staff["status"] == "break"
                            ? warningColor
                            : disabledColor,
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
                            Text(
                              "${staff["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${staff["shift"]} Shift",
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: staff["status"] == "active"
                                  ? successColor.withAlpha(20)
                                  : staff["status"] == "break"
                                      ? warningColor.withAlpha(20)
                                      : disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${staff["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: staff["status"] == "active"
                                    ? successColor
                                    : staff["status"] == "break"
                                        ? warningColor
                                        : disabledColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${staff["performance"]}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: (staff["performance"] as int) >= 90
                                  ? successColor
                                  : (staff["performance"] as int) >= 80
                                      ? warningColor
                                      : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Progress: ${staff["roomsCompleted"]}/${staff["roomsAssigned"]} rooms",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                            if (staff["currentRoom"] != null)
                              Text(
                                "Current: Room ${staff["currentRoom"]}",
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
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: staff["status"] == "active" ? "View Tasks" : "Assign Task",
                          size: bs.sm,
                          onPressed: () {
                            si("Viewing tasks for ${staff["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.message,
                        size: bs.sm,
                        onPressed: () {
                          si("Messaging ${staff["name"]}");
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

  Widget _buildSuppliesTab() {
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
                  "Supply Inventory",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Reorder",
                icon: Icons.shopping_cart,
                size: bs.sm,
                onPressed: () {
                  ss("Supply reorder initiated");
                },
              ),
            ],
          ),
          ...supplies.map((supply) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: supply["status"] == "critical"
                        ? dangerColor
                        : supply["status"] == "low"
                            ? warningColor
                            : successColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${supply["item"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Minimum: ${supply["minimum"]} units",
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
                        "${supply["current"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: supply["status"] == "critical"
                              ? dangerColor
                              : supply["status"] == "low"
                                  ? warningColor
                                  : successColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: supply["status"] == "critical"
                              ? dangerColor.withAlpha(20)
                              : supply["status"] == "low"
                                  ? warningColor.withAlpha(20)
                                  : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${supply["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: supply["status"] == "critical"
                                ? dangerColor
                                : supply["status"] == "low"
                                    ? warningColor
                                    : successColor,
                          ),
                        ),
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
}
