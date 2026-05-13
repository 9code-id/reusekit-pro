import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamView extends StatefulWidget {
  const PmaTeamView({super.key});

  @override
  State<PmaTeamView> createState() => _PmaTeamViewState();
}

class _PmaTeamViewState extends State<PmaTeamView> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Team Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Teams", icon: Icon(Icons.groups)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMembersTab(),
        _buildTeamsTab(),
        _buildPerformanceTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> stats = [
      {
        "title": "Total Members",
        "value": 48,
        "change": "+5",
        "changeType": "positive",
        "icon": Icons.people,
        "color": primaryColor,
      },
      {
        "title": "Active Teams",
        "value": 12,
        "change": "+2",
        "changeType": "positive",
        "icon": Icons.groups,
        "color": successColor,
      },
      {
        "title": "Projects",
        "value": 28,
        "change": "+8",
        "changeType": "positive",
        "icon": Icons.folder,
        "color": infoColor,
      },
      {
        "title": "Completion Rate",
        "value": 87,
        "change": "+3%",
        "changeType": "positive",
        "icon": Icons.trending_up,
        "color": warningColor,
      },
    ];

    List<Map<String, dynamic>> recentActivities = [
      {
        "user": "Sarah Wilson",
        "action": "completed task",
        "target": "Homepage Design",
        "time": "2 minutes ago",
        "avatar": "https://i.pravatar.cc/50?img=1",
        "type": "completion",
      },
      {
        "user": "John Smith",
        "action": "joined team",
        "target": "Frontend Development",
        "time": "15 minutes ago",
        "avatar": "https://i.pravatar.cc/50?img=2",
        "type": "join",
      },
      {
        "user": "Mike Johnson",
        "action": "created project",
        "target": "Mobile App Redesign",
        "time": "1 hour ago",
        "avatar": "https://i.pravatar.cc/50?img=3",
        "type": "create",
      },
      {
        "user": "Emily Davis",
        "action": "submitted review",
        "target": "Database Schema",
        "time": "2 hours ago",
        "avatar": "https://i.pravatar.cc/50?img=4",
        "type": "review",
      },
    ];

    List<Map<String, dynamic>> topPerformers = [
      {
        "name": "Sarah Wilson",
        "role": "Senior Designer",
        "completedTasks": 24,
        "rating": 4.9,
        "avatar": "https://i.pravatar.cc/50?img=1",
      },
      {
        "name": "John Smith",
        "role": "Full Stack Developer",
        "completedTasks": 22,
        "rating": 4.8,
        "avatar": "https://i.pravatar.cc/50?img=2",
      },
      {
        "name": "Mike Johnson",
        "role": "DevOps Engineer",
        "completedTasks": 18,
        "rating": 4.7,
        "avatar": "https://i.pravatar.cc/50?img=3",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Statistics Cards
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
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: stat["changeType"] == "positive" 
                                ? successColor.withAlpha(20) 
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${stat["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: stat["changeType"] == "positive" 
                                  ? successColor 
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      stat["title"] == "Completion Rate" 
                          ? "${stat["value"]}%" 
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          SizedBox(height: spMd),

          // Top Performers Section
          Container(
            width: double.infinity,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Performers",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  children: topPerformers.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> performer = entry.value;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: index < topPerformers.length - 1 ? spSm : 0),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: index == 0 
                                  ? warningColor
                                  : index == 1 
                                      ? disabledBoldColor
                                      : successColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${performer["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${performer["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${performer["role"]}",
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
                                "${performer["completedTasks"]} tasks",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${performer["rating"]}",
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
          ),

          SizedBox(height: spMd),

          // Recent Activities Section
          Container(
            width: double.infinity,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Activities",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Column(
                  children: recentActivities.map((activity) {
                    Color typeColor = _getActivityTypeColor("${activity["type"]}");
                    IconData typeIcon = _getActivityTypeIcon("${activity["type"]}");
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: typeColor.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: typeColor.withAlpha(20),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              typeIcon,
                              size: 16,
                              color: typeColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage("${activity["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "${activity["user"]} ",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: "${activity["action"]} ",
                                        style: TextStyle(color: disabledBoldColor),
                                      ),
                                      TextSpan(
                                        text: "${activity["target"]}",
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${activity["time"]}",
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

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Team Members content will be loaded here",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Teams list content will be loaded here",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Performance analytics will be loaded here",
            style: TextStyle(
              fontSize: 16,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case "completion":
        return successColor;
      case "join":
        return infoColor;
      case "create":
        return primaryColor;
      case "review":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityTypeIcon(String type) {
    switch (type) {
      case "completion":
        return Icons.check_circle;
      case "join":
        return Icons.person_add;
      case "create":
        return Icons.add_circle;
      case "review":
        return Icons.rate_review;
      default:
        return Icons.info;
    }
  }
}
