import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAdminDashboardView extends StatefulWidget {
  const HhaAdminDashboardView({super.key});

  @override
  State<HhaAdminDashboardView> createState() => _HhaAdminDashboardViewState();
}

class _HhaAdminDashboardViewState extends State<HhaAdminDashboardView> {
  int currentTab = 0;

  // Dashboard Stats Data
  List<Map<String, dynamic>> stats = [
    {
      "title": "Total Revenue",
      "value": "\$125,430",
      "change": "+12.5%",
      "changeType": "positive",
      "icon": Icons.trending_up,
      "color": Colors.green,
    },
    {
      "title": "Occupancy Rate",
      "value": "87%",
      "change": "+5.2%",
      "changeType": "positive",
      "icon": Icons.hotel,
      "color": Colors.blue,
    },
    {
      "title": "Guest Satisfaction",
      "value": "4.8/5",
      "change": "+0.3",
      "changeType": "positive", 
      "icon": Icons.star,
      "color": Colors.orange,
    },
    {
      "title": "Staff Efficiency",
      "value": "94%",
      "change": "-1.2%",
      "changeType": "negative",
      "icon": Icons.people,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> departments = [
    {
      "name": "Reception",
      "manager": "Sarah Johnson",
      "staff": 8,
      "status": "active",
      "performance": 95,
    },
    {
      "name": "Housekeeping",
      "manager": "Maria Garcia",
      "staff": 15,
      "status": "active",
      "performance": 92,
    },
    {
      "name": "Food & Beverage",
      "manager": "Chef Marco",
      "staff": 22,
      "status": "active",
      "performance": 88,
    },
    {
      "name": "Maintenance",
      "manager": "John Smith",
      "staff": 6,
      "status": "warning",
      "performance": 85,
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "activity": "New booking received",
      "details": "Presidential Suite - 3 nights",
      "time": "2 minutes ago",
      "type": "booking",
      "icon": Icons.bookmark_add,
    },
    {
      "activity": "Guest complaint resolved",
      "details": "Room 305 - Air conditioning fixed",
      "time": "15 minutes ago",
      "type": "maintenance",
      "icon": Icons.build,
    },
    {
      "activity": "Staff shift updated",
      "details": "Housekeeping department",
      "time": "1 hour ago",
      "type": "staff",
      "icon": Icons.schedule,
    },
    {
      "activity": "Revenue milestone reached",
      "details": "Monthly target achieved",
      "time": "2 hours ago",
      "type": "finance",
      "icon": Icons.celebration,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Admin Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
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
          // Quick Stats
          Text(
            "Hotel Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: stats.map((stat) {
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: stat["changeType"] == "positive"
                                ? successColor.withAlpha(20)
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

          // Recent Activities
          Text(
            "Recent Activities",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: recentActivities.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> activity = entry.value;
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: index < recentActivities.length - 1
                        ? Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          activity["icon"],
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["activity"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${activity["details"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
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
                "Room Management",
                "Manage room status and assignments",
                Icons.hotel,
                primaryColor,
              ),
              _buildQuickActionCard(
                "Staff Schedule",
                "View and edit staff schedules",
                Icons.schedule,
                Colors.blue,
              ),
              _buildQuickActionCard(
                "Guest Services",
                "Handle guest requests and feedback",
                Icons.support_agent,
                Colors.green,
              ),
              _buildQuickActionCard(
                "Financial Reports",
                "Generate revenue and expense reports",
                Icons.receipt_long,
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
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Open",
              size: bs.sm,
              onPressed: () {
                si("$title module will open");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Department Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...departments.map((dept) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
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
                              "${dept["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Manager: ${dept["manager"]}",
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
                          color: dept["status"] == "active"
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${dept["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dept["status"] == "active"
                                ? successColor
                                : warningColor,
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
                              "Staff Count",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${dept["staff"]} employees",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Performance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${dept["performance"]}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: (dept["performance"] as int) >= 90
                                    ? successColor
                                    : (dept["performance"] as int) >= 80
                                        ? warningColor
                                        : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Manage",
                        size: bs.sm,
                        onPressed: () {
                          si("Managing ${dept["name"]} department");
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hotel Analytics",
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
                  "Advanced analytics features coming soon",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spLg),
                Icon(
                  Icons.analytics,
                  size: 80,
                  color: disabledColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "System Settings",
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
                  "Admin settings panel coming soon",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spLg),
                Icon(
                  Icons.settings,
                  size: 80,
                  color: disabledColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
