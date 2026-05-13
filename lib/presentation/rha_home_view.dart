import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaHomeView extends StatefulWidget {
  const RhaHomeView({super.key});

  @override
  State<RhaHomeView> createState() => _RhaHomeViewState();
}

class _RhaHomeViewState extends State<RhaHomeView> {
  String searchQuery = "";
  int selectedNotificationFilter = 0;

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Post Job",
      "icon": Icons.work_outline,
      "color": Colors.blue,
      "description": "Create new job posting",
    },
    {
      "title": "Add Employee",
      "icon": Icons.person_add,
      "color": Colors.green,
      "description": "Onboard new team member",
    },
    {
      "title": "HR Analytics",
      "icon": Icons.analytics,
      "color": Colors.purple,
      "description": "View HR insights",
    },
    {
      "title": "Payroll",
      "icon": Icons.payments,
      "color": Colors.orange,
      "description": "Manage payroll",
    },
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "title": "New Application Received",
      "description": "John Smith applied for Senior Developer position",
      "time": "2 minutes ago",
      "type": "application",
      "icon": Icons.person_search,
    },
    {
      "title": "Interview Scheduled",
      "description": "Sarah Johnson - Marketing Manager interview at 2:00 PM",
      "time": "15 minutes ago",
      "type": "interview",
      "icon": Icons.schedule,
    },
    {
      "title": "Employee Onboarded",
      "description": "Mike Davis completed onboarding process",
      "time": "1 hour ago",
      "type": "onboard",
      "icon": Icons.check_circle,
    },
    {
      "title": "Performance Review Due",
      "description": "5 employees pending quarterly review",
      "time": "2 hours ago",
      "type": "review",
      "icon": Icons.rate_review,
    },
    {
      "title": "Job Posted",
      "description": "Frontend Developer position posted successfully",
      "time": "4 hours ago",
      "type": "job",
      "icon": Icons.work,
    },
  ];

  List<Map<String, dynamic>> hrMetrics = [
    {
      "title": "Active Employees",
      "value": 248,
      "change": "+12",
      "isPositive": true,
      "icon": Icons.people,
    },
    {
      "title": "Open Positions",
      "value": 15,
      "change": "+3",
      "isPositive": true,
      "icon": Icons.work_outline,
    },
    {
      "title": "Applications",
      "value": 156,
      "change": "+28",
      "isPositive": true,
      "icon": Icons.description,
    },
    {
      "title": "Interviews",
      "value": 23,
      "change": "+5",
      "isPositive": true,
      "icon": Icons.record_voice_over,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR Dashboard"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to notifications
            },
            icon: Stack(
              children: [
                Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to profile
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning! 👋",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Welcome back, Sarah. Here's your HR overview for today.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // HR Metrics
            Text(
              "Today's Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: hrMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"],
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["isPositive"] as bool)
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (metric["isPositive"] as bool)
                                    ? successColor
                                    : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${metric["title"]}",
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
              children: quickActions.map((action) {
                return GestureDetector(
                  onTap: () {
                    // Handle quick action
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: (action["color"] as Color).withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      spacing: spSm,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            action["icon"],
                            color: action["color"],
                            size: 24,
                          ),
                        ),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${action["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Recent Activities
            Row(
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // View all activities
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentActivities.take(5).map((activity) {
                  int index = recentActivities.indexOf(activity);
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index < 4
                              ? disabledOutlineBorderColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
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
                                "${activity["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${activity["description"]}",
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
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
