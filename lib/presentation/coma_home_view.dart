import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaHomeView extends StatefulWidget {
  const ComaHomeView({super.key});

  @override
  State<ComaHomeView> createState() => _ComaHomeViewState();
}

class _ComaHomeViewState extends State<ComaHomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "ConstructFlow",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.construction),
          label: "Projects",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: "Team",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Profile",
        ),
      ],
      children: [
        // Dashboard Tab
        _buildDashboardTab(),
        // Projects Tab
        _buildProjectsTab(),
        // Team Tab
        _buildTeamTab(),
        // Profile Tab
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildDashboardTab() {
    List<Map<String, dynamic>> dashboardStats = [
      {"title": "Active Projects", "value": 12, "icon": Icons.construction, "color": primaryColor},
      {"title": "Team Members", "value": 28, "icon": Icons.people, "color": successColor},
      {"title": "Completed Tasks", "value": 156, "color": infoColor, "icon": Icons.task_alt},
      {"title": "Budget Used", "value": 75, "unit": "%", "color": warningColor, "icon": Icons.account_balance_wallet},
    ];

    List<Map<String, dynamic>> recentProjects = [
      {
        "name": "Downtown Office Complex",
        "status": "In Progress",
        "progress": 65,
        "deadline": "Dec 15, 2024",
        "budget": 2500000,
        "team": 12,
      },
      {
        "name": "Residential Villa Project",
        "status": "Planning",
        "progress": 25,
        "deadline": "Jan 30, 2025",
        "budget": 800000,
        "team": 8,
      },
      {
        "name": "Shopping Mall Renovation",
        "status": "Review",
        "progress": 90,
        "deadline": "Nov 20, 2024",
        "budget": 1200000,
        "team": 15,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
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
                            "Welcome back, John!",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "You have 3 projects requiring attention",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dashboard Stats
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 150,
            children: dashboardStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spXs,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          stat["icon"],
                          color: stat["color"],
                          size: 20,
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+12%",
                            style: TextStyle(
                              fontSize: 10,
                              color: stat["color"],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["value"]}${stat["unit"] ?? ""}",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
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

          // Recent Projects
          Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Recent Projects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      currentIndex = 1;
                      setState(() {});
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
              Column(
                spacing: spSm,
                children: recentProjects.map((project) {
                  Color statusColor = project["status"] == "In Progress" 
                      ? primaryColor 
                      : project["status"] == "Planning" 
                          ? warningColor 
                          : successColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${project["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Deadline: ${project["deadline"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${project["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Progress: ${project["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  LinearProgressIndicator(
                                    value: (project["progress"] as int) / 100,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation(statusColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((project["budget"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${project["team"]} members",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        label: "New Project",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Add Team Member",
                        icon: Icons.person_add,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Projects",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Project filters and list would go here
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              "Projects list implementation",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Management",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Team list would go here
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              "Team management implementation",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile Settings",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          // Profile settings would go here
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Text(
              "Profile settings implementation",
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
