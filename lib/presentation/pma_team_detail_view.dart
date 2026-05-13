import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamDetailView extends StatefulWidget {
  const PmaTeamDetailView({super.key});

  @override
  State<PmaTeamDetailView> createState() => _PmaTeamDetailViewState();
}

class _PmaTeamDetailViewState extends State<PmaTeamDetailView> {
  int currentTab = 0;

  Map<String, dynamic> team = {
    "id": 1,
    "name": "Frontend Development",
    "description": "Responsible for user interface and user experience development across all company products and platforms",
    "department": "Engineering",
    "status": "active",
    "lead": {
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "avatar": "https://i.pravatar.cc/100?img=1",
      "role": "Senior Frontend Developer",
      "joinDate": "2023-01-15",
    },
    "memberCount": 8,
    "projectCount": 5,
    "completionRate": 87,
    "createdAt": "2024-01-15",
    "color": primaryColor,
    "budget": 125000,
    "spent": 87500,
  };

  List<Map<String, dynamic>> members = [
    {
      "id": 1,
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "role": "Team Lead",
      "avatar": "https://i.pravatar.cc/50?img=1",
      "status": "active",
      "joinDate": "2023-01-15",
      "completedTasks": 24,
      "rating": 4.9,
    },
    {
      "id": 2,
      "name": "John Smith",
      "email": "john.smith@company.com",
      "role": "Senior Developer",
      "avatar": "https://i.pravatar.cc/50?img=2",
      "status": "active",
      "joinDate": "2023-03-10",
      "completedTasks": 22,
      "rating": 4.8,
    },
    {
      "id": 3,
      "name": "Mike Johnson",
      "email": "mike.johnson@company.com",
      "role": "Frontend Developer",
      "avatar": "https://i.pravatar.cc/50?img=3",
      "status": "active",
      "joinDate": "2023-06-20",
      "completedTasks": 18,
      "rating": 4.7,
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "email": "emily.davis@company.com",
      "role": "UI/UX Designer",
      "avatar": "https://i.pravatar.cc/50?img=4",
      "status": "active",
      "joinDate": "2023-08-05",
      "completedTasks": 20,
      "rating": 4.9,
    },
    {
      "id": 5,
      "name": "Alex Chen",
      "email": "alex.chen@company.com",
      "role": "Junior Developer",
      "avatar": "https://i.pravatar.cc/50?img=5",
      "status": "inactive",
      "joinDate": "2024-01-12",
      "completedTasks": 8,
      "rating": 4.3,
    },
  ];

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "E-Commerce Platform",
      "description": "Complete redesign of the online shopping experience",
      "status": "in_progress",
      "progress": 75,
      "dueDate": "2024-12-30",
      "priority": "high",
      "assignedMembers": 5,
    },
    {
      "id": 2,
      "name": "Mobile App Redesign",
      "description": "Modernizing the mobile application interface",
      "status": "in_progress",
      "progress": 60,
      "dueDate": "2025-01-15",
      "priority": "medium",
      "assignedMembers": 3,
    },
    {
      "id": 3,
      "name": "Admin Dashboard",
      "description": "Internal admin panel for content management",
      "status": "completed",
      "progress": 100,
      "dueDate": "2024-11-30",
      "priority": "low",
      "assignedMembers": 2,
    },
    {
      "id": 4,
      "name": "Customer Portal",
      "description": "Self-service portal for customer account management",
      "status": "planning",
      "progress": 15,
      "dueDate": "2025-02-28",
      "priority": "medium",
      "assignedMembers": 4,
    },
  ];

  List<Map<String, dynamic>> activities = [
    {
      "user": "Sarah Wilson",
      "action": "completed task",
      "target": "Homepage Design Review",
      "time": "2 hours ago",
      "avatar": "https://i.pravatar.cc/30?img=1",
      "type": "completion",
    },
    {
      "user": "John Smith",
      "action": "updated project",
      "target": "E-Commerce Platform",
      "time": "4 hours ago",
      "avatar": "https://i.pravatar.cc/30?img=2",
      "type": "update",
    },
    {
      "user": "Mike Johnson",
      "action": "submitted for review",
      "target": "Mobile Navigation Component",
      "time": "6 hours ago",
      "avatar": "https://i.pravatar.cc/30?img=3",
      "type": "review",
    },
    {
      "user": "Emily Davis",
      "action": "created wireframes",
      "target": "Customer Portal Design",
      "time": "1 day ago",
      "avatar": "https://i.pravatar.cc/30?img=4",
      "type": "create",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${team["name"]}",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Projects", icon: Icon(Icons.folder)),
        Tab(text: "Activity", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMembersTab(),
        _buildProjectsTab(),
        _buildActivityTab(),
      ],
      actions: [
        QButton(
          icon: Icons.edit,
          size: bs.sm,
          onPressed: () {
            // Navigate to edit team
          },
        ),
        QButton(
          icon: Icons.more_vert,
          size: bs.sm,
          onPressed: () {},
        ),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                top: BorderSide(
                  width: 4,
                  color: team["color"] as Color,
                ),
              ),
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
                            "${team["name"]}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${team["department"]} Department",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: team["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "ACTIVE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "${team["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Created: ${DateTime.parse("${team["createdAt"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Team Lead Card
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
                Text(
                  "Team Lead",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("${(team["lead"] as Map<String, dynamic>)["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(team["lead"] as Map<String, dynamic>)["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(team["lead"] as Map<String, dynamic>)["role"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(team["lead"] as Map<String, dynamic>)["email"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      icon: Icons.message,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Statistics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Members", "${team["memberCount"]}", Icons.people, primaryColor),
              _buildStatCard("Projects", "${team["projectCount"]}", Icons.folder, successColor),
              _buildStatCard("Completion", "${team["completionRate"]}%", Icons.trending_up, infoColor),
              _buildStatCard("Budget", "\$${((team["budget"] as int) / 1000).toInt()}K", Icons.account_balance_wallet, warningColor),
            ],
          ),

          SizedBox(height: spMd),

          // Budget Progress
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
                Text(
                  "Budget Usage",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${((team["spent"] as int) / 1000).toInt()}K spent",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "\$${((team["budget"] as int) / 1000).toInt()}K total",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                LinearProgressIndicator(
                  value: (team["spent"] as int) / (team["budget"] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation(warningColor),
                ),
                SizedBox(height: spSm),
                Text(
                  "${(((team["spent"] as int) / (team["budget"] as int)) * 100).toInt()}% of budget used",
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
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add Member Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team Members (${members.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Add Member",
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Members List
          Column(
            children: members.map((member) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: member["status"] == "active" ? successColor : warningColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("${member["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${member["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: member["status"] == "active" 
                                      ? successColor.withAlpha(20) 
                                      : warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${member["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: member["status"] == "active" ? successColor : warningColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${member["role"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${member["email"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: infoColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Joined: ${DateTime.parse("${member["joinDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.task_alt,
                                size: 14,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["completedTasks"]} tasks",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Icon(
                                Icons.star,
                                size: 14,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${member["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      children: [
                        QButton(
                          icon: Icons.message,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(height: spXs),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {},
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
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Team Projects (${projects.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "New Project",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),

          SizedBox(height: spMd),

          Column(
            children: projects.map((project) {
              Color statusColor = _getProjectStatusColor("${project["status"]}");
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
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
                            "${project["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            _getProjectStatusLabel("${project["status"]}"),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${project["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spMd),
                    if ((project["progress"] as int) > 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress: ${project["progress"]}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            "Due: ${DateTime.parse("${project["dueDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: (project["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation(statusColor),
                      ),
                      SizedBox(height: spSm),
                    ],
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${project["assignedMembers"]} members assigned",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor("${project["priority"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${project["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor("${project["priority"]}"),
                            ),
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
    );
  }

  Widget _buildActivityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: activities.map((activity) {
              Color typeColor = _getActivityTypeColor("${activity["type"]}");
              IconData typeIcon = _getActivityTypeIcon("${activity["type"]}");
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        typeIcon,
                        size: 20,
                        color: typeColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${activity["avatar"]}"),
                    ),
                    SizedBox(width: spMd),
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
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectStatusColor(String status) {
    switch (status) {
      case "planning":
        return disabledBoldColor;
      case "in_progress":
        return infoColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getProjectStatusLabel(String status) {
    switch (status) {
      case "planning":
        return "Planning";
      case "in_progress":
        return "In Progress";
      case "completed":
        return "Completed";
      default:
        return status;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityTypeColor(String type) {
    switch (type) {
      case "completion":
        return successColor;
      case "update":
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
      case "update":
        return Icons.update;
      case "create":
        return Icons.add_circle;
      case "review":
        return Icons.rate_review;
      default:
        return Icons.info;
    }
  }
}
