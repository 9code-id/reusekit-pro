import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaManagerDashboardView extends StatefulWidget {
  const HhaManagerDashboardView({super.key});

  @override
  State<HhaManagerDashboardView> createState() => _HhaManagerDashboardViewState();
}

class _HhaManagerDashboardViewState extends State<HhaManagerDashboardView> {
  int currentTab = 0;

  // Manager Dashboard Stats
  List<Map<String, dynamic>> managerStats = [
    {
      "title": "Today's Revenue",
      "value": "\$8,450",
      "change": "+15.2%",
      "changeType": "positive",
      "icon": Icons.attach_money,
      "color": Colors.green,
    },
    {
      "title": "Rooms Occupied",
      "value": "78/90",
      "change": "+12 rooms",
      "changeType": "positive",
      "icon": Icons.hotel,
      "color": Colors.blue,
    },
    {
      "title": "Staff on Duty",
      "value": "42/48",
      "change": "6 on break",
      "changeType": "neutral",
      "icon": Icons.people,
      "color": Colors.orange,
    },
    {
      "title": "Maintenance Tasks",
      "value": "3 pending",
      "change": "2 completed",
      "changeType": "warning",
      "icon": Icons.build,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> todayTasks = [
    {
      "task": "Check-in VIP guests",
      "department": "Reception",
      "priority": "high",
      "time": "10:00 AM",
      "status": "pending",
    },
    {
      "task": "Housekeeping inspection",
      "department": "Housekeeping",
      "priority": "medium",
      "time": "11:30 AM",
      "status": "in_progress",
    },
    {
      "task": "Staff meeting",
      "department": "All Departments",
      "priority": "medium",
      "time": "2:00 PM",
      "status": "pending",
    },
    {
      "task": "Maintenance check - HVAC",
      "department": "Maintenance",
      "priority": "high",
      "time": "3:30 PM",
      "status": "pending",
    },
  ];

  List<Map<String, dynamic>> guestRequests = [
    {
      "room": "205",
      "guest": "Mr. Anderson",
      "request": "Extra towels and pillows",
      "time": "5 minutes ago",
      "priority": "low",
      "status": "pending",
    },
    {
      "room": "314",
      "guest": "Mrs. Johnson",
      "request": "Room service - dinner",
      "time": "12 minutes ago",
      "priority": "medium",
      "status": "in_progress",
    },
    {
      "room": "101",
      "guest": "Mr. Williams",
      "request": "Air conditioning repair",
      "time": "25 minutes ago",
      "priority": "high",
      "status": "assigned",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Manager Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Tasks", icon: Icon(Icons.task_alt)),
        Tab(text: "Requests", icon: Icon(Icons.support)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTasksTab(),
        _buildRequestsTab(),
        _buildReportsTab(),
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
                        "Good Morning, Manager!",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Here's what's happening at the hotel today",
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
                    Icons.wb_sunny,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Key Metrics
          Text(
            "Today's Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: managerStats.map((stat) {
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
                        if (stat["changeType"] != "neutral")
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: stat["changeType"] == "positive"
                                  ? successColor.withAlpha(20)
                                  : stat["changeType"] == "warning"
                                      ? warningColor.withAlpha(20)
                                      : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: stat["changeType"] == "positive"
                                    ? successColor
                                    : stat["changeType"] == "warning"
                                        ? warningColor
                                        : dangerColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
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
                "Room Status",
                "View all room statuses",
                Icons.hotel,
                primaryColor,
              ),
              _buildQuickActionCard(
                "Staff Schedule",
                "Manage staff schedules",
                Icons.schedule,
                Colors.blue,
              ),
              _buildQuickActionCard(
                "Guest Services",
                "Handle guest requests",
                Icons.room_service,
                Colors.green,
              ),
              _buildQuickActionCard(
                "Maintenance",
                "Check maintenance tasks",
                Icons.build,
                Colors.orange,
              ),
            ],
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
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
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
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Task",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("New task added successfully");
                },
              ),
            ],
          ),
          ...todayTasks.map((task) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: task["priority"] == "high"
                        ? dangerColor
                        : task["priority"] == "medium"
                            ? warningColor
                            : successColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${task["task"]}",
                          style: TextStyle(
                            fontSize: 16,
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
                          color: task["status"] == "completed"
                              ? successColor.withAlpha(20)
                              : task["status"] == "in_progress"
                                  ? warningColor.withAlpha(20)
                                  : primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${task["status"]}".replaceAll("_", " ").toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: task["status"] == "completed"
                                ? successColor
                                : task["status"] == "in_progress"
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
                      Icon(
                        Icons.business,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${task["department"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${task["time"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: task["status"] == "pending" ? "Start Task" : "Update Status",
                          size: bs.sm,
                          onPressed: () {
                            ss("Task status updated");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          si("Task options menu");
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

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Guest Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...guestRequests.map((request) {
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
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Room ${request["room"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${request["guest"]}",
                          style: TextStyle(
                            fontSize: 16,
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
                          color: request["priority"] == "high"
                              ? dangerColor.withAlpha(20)
                              : request["priority"] == "medium"
                                  ? warningColor.withAlpha(20)
                                  : successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${request["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: request["priority"] == "high"
                                ? dangerColor
                                : request["priority"] == "medium"
                                    ? warningColor
                                    : successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${request["request"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${request["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${request["status"]}".replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: request["status"] == "completed"
                              ? successColor
                              : request["status"] == "in_progress"
                                  ? warningColor
                                  : primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Assign Staff",
                          size: bs.sm,
                          onPressed: () {
                            ss("Staff assigned to request");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Complete",
                        size: bs.sm,
                        onPressed: () {
                          ss("Request marked as completed");
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
            "Manager Reports",
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
                "Daily Summary",
                "Today's operations overview",
                Icons.today,
                primaryColor,
              ),
              _buildReportCard(
                "Staff Performance",
                "Employee productivity metrics",
                Icons.people,
                Colors.blue,
              ),
              _buildReportCard(
                "Guest Feedback",
                "Customer satisfaction reports",
                Icons.feedback,
                Colors.green,
              ),
              _buildReportCard(
                "Revenue Analysis",
                "Financial performance data",
                Icons.analytics,
                Colors.orange,
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
                ss("$title report generated");
              },
            ),
          ),
        ],
      ),
    );
  }
}
