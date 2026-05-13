import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmDashboardView extends StatefulWidget {
  const TpmDashboardView({super.key});

  @override
  State<TpmDashboardView> createState() => _TpmDashboardViewState();
}

class _TpmDashboardViewState extends State<TpmDashboardView> {
  int currentBottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "TeamPro Manager",
      selectedIndex: currentBottomIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: "Workspaces",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: "Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildDashboardTab(),
        _buildWorkspacesTab(),
        _buildTasksTab(),
        _buildReportsTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentBottomIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildDashboardTab() {
    List<Map<String, dynamic>> quickStats = [
      {
        "title": "Active Projects",
        "value": "12",
        "icon": Icons.work,
        "color": primaryColor,
        "trend": "+2",
      },
      {
        "title": "Pending Tasks",
        "value": "34",
        "icon": Icons.pending,
        "color": warningColor,
        "trend": "-5",
      },
      {
        "title": "Team Members",
        "value": "8",
        "icon": Icons.group,
        "color": successColor,
        "trend": "+1",
      },
      {
        "title": "Completed",
        "value": "156",
        "icon": Icons.check_circle,
        "color": infoColor,
        "trend": "+12",
      },
    ];

    List<Map<String, dynamic>> recentActivities = [
      {
        "title": "New task assigned to Mobile App Project",
        "subtitle": "John Smith assigned UI Design task",
        "time": "2 hours ago",
        "icon": Icons.assignment,
        "color": primaryColor,
      },
      {
        "title": "Project milestone completed",
        "subtitle": "Website Redesign - Phase 1 completed",
        "time": "4 hours ago",
        "icon": Icons.flag,
        "color": successColor,
      },
      {
        "title": "Team meeting scheduled",
        "subtitle": "Weekly standup meeting tomorrow 9 AM",
        "time": "6 hours ago",
        "icon": Icons.event,
        "color": infoColor,
      },
      {
        "title": "New workspace created",
        "subtitle": "Marketing Campaign workspace added",
        "time": "1 day ago",
        "icon": Icons.add_circle,
        "color": warningColor,
      },
    ];

    List<Map<String, dynamic>> urgentTasks = [
      {
        "title": "Fix critical bug in payment system",
        "project": "E-commerce Platform",
        "priority": "High",
        "dueDate": "Today",
        "assignee": "Alex Johnson",
      },
      {
        "title": "Review and approve design mockups",
        "project": "Mobile App",
        "priority": "Medium",
        "dueDate": "Tomorrow",
        "assignee": "Sarah Wilson",
      },
      {
        "title": "Deploy latest version to staging",
        "project": "Web Platform",
        "priority": "High",
        "dueDate": "Today",
        "assignee": "Mike Chen",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Welcome Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back, John!",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "You have 5 tasks due today",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
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
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: "${stat["trend"]}".startsWith("+") 
                              ? successColor.withAlpha(20) 
                              : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stat["trend"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: "${stat["trend"]}".startsWith("+") 
                                ? successColor 
                                : dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: stat["color"] as Color,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "New Task",
                        size: bs.sm,
                        icon: Icons.add_task,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "New Project",
                        size: bs.sm,
                        icon: Icons.work,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Team Meeting",
                        size: bs.sm,
                        icon: Icons.video_call,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reports",
                        size: bs.sm,
                        icon: Icons.analytics,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Urgent Tasks
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Urgent Tasks",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: urgentTasks.map((task) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: dangerColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${task["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${task["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Project: ${task["project"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 12, color: disabledBoldColor),
                              SizedBox(width: 4),
                              Text(
                                "${task["assignee"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.schedule, size: 12, color: dangerColor),
                              SizedBox(width: 4),
                              Text(
                                "Due ${task["dueDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
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

          // Recent Activities
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
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
                      onTap: () {},
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: recentActivities.map((activity) {
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (activity["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            activity["icon"] as IconData,
                            color: activity["color"] as Color,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
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
                                "${activity["subtitle"]}",
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
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspacesTab() {
    return Center(
      child: Text(
        "Workspaces content will be here",
        style: TextStyle(
          fontSize: fsH6,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildTasksTab() {
    return Center(
      child: Text(
        "Tasks content will be here",
        style: TextStyle(
          fontSize: fsH6,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildReportsTab() {
    return Center(
      child: Text(
        "Reports content will be here",
        style: TextStyle(
          fontSize: fsH6,
          color: disabledBoldColor,
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text(
        "Profile content will be here",
        style: TextStyle(
          fontSize: fsH6,
          color: disabledBoldColor,
        ),
      ),
    );
  }
}
