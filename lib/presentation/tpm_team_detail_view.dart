import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamDetailView extends StatefulWidget {
  const TpmTeamDetailView({super.key});

  @override
  State<TpmTeamDetailView> createState() => _TpmTeamDetailViewState();
}

class _TpmTeamDetailViewState extends State<TpmTeamDetailView> {
  int selectedTab = 0;

  Map<String, dynamic> team = {
    "id": 1,
    "name": "Development Team Alpha",
    "description": "Core mobile application development team responsible for building cross-platform applications using Flutter and React Native. The team specializes in creating high-quality mobile experiences with a focus on performance and user satisfaction.",
    "department": "Engineering",
    "lead": "Alice Johnson",
    "leadEmail": "alice@company.com",
    "leadAvatar": "https://picsum.photos/50/50?random=1&keyword=person",
    "members": 12,
    "activeProjects": 3,
    "completedProjects": 8,
    "efficiency": 92,
    "status": "active",
    "budget": 150000.0,
    "utilized": 125000.0,
    "skills": ["Flutter", "React Native", "Firebase", "Node.js", "TypeScript", "GraphQL"],
    "color": successColor,
    "createdDate": "2024-01-15",
    "location": "New York Office",
    "workingHours": "9:00 AM - 6:00 PM EST",
    "timezone": "EST",
  };

  List<Map<String, dynamic>> members = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@company.com",
      "role": "Team Lead",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "status": "active",
      "joinDate": "2024-01-15",
      "efficiency": 95,
      "tasksCompleted": 145,
      "activeProjects": 2,
      "skills": ["Flutter", "Team Management", "Architecture"],
      "workload": 85,
      "phone": "+1 555-0101",
    },
    {
      "id": 2,
      "name": "John Smith",
      "email": "john@company.com",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
      "status": "active",
      "joinDate": "2024-02-01",
      "efficiency": 90,
      "tasksCompleted": 128,
      "activeProjects": 2,
      "skills": ["React Native", "iOS", "Android"],
      "workload": 78,
      "phone": "+1 555-0102",
    },
    {
      "id": 3,
      "name": "Sarah Wilson",
      "email": "sarah@company.com",
      "role": "Flutter Developer",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "status": "active",
      "joinDate": "2024-02-15",
      "efficiency": 88,
      "tasksCompleted": 95,
      "activeProjects": 1,
      "skills": ["Flutter", "Dart", "Firebase"],
      "workload": 72,
      "phone": "+1 555-0103",
    },
  ];

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "E-commerce Mobile App",
      "description": "Cross-platform shopping application",
      "status": "in_progress",
      "progress": 75,
      "startDate": "2024-04-01",
      "dueDate": "2024-07-15",
      "priority": "high",
      "assignedMembers": ["Alice Johnson", "John Smith", "Sarah Wilson"],
      "budget": 80000.0,
      "spent": 55000.0,
    },
    {
      "id": 2,
      "name": "Banking App Redesign",
      "description": "UI/UX overhaul for mobile banking",
      "status": "in_progress",
      "progress": 45,
      "startDate": "2024-05-01",
      "dueDate": "2024-08-30",
      "priority": "medium",
      "assignedMembers": ["Alice Johnson", "Sarah Wilson"],
      "budget": 50000.0,
      "spent": 22000.0,
    },
    {
      "id": 3,
      "name": "Fitness Tracking App",
      "description": "Health and fitness monitoring platform",
      "status": "completed",
      "progress": 100,
      "startDate": "2024-01-15",
      "dueDate": "2024-04-30",
      "completedDate": "2024-04-25",
      "priority": "low",
      "assignedMembers": ["John Smith"],
      "budget": 35000.0,
      "spent": 32000.0,
    },
  ];

  List<Map<String, dynamic>> performanceData = [
    {"month": "Jan", "efficiency": 88, "tasks": 45, "projects": 1},
    {"month": "Feb", "efficiency": 90, "tasks": 52, "projects": 2},
    {"month": "Mar", "efficiency": 92, "tasks": 48, "projects": 2},
    {"month": "Apr", "efficiency": 94, "tasks": 58, "projects": 3},
    {"month": "May", "efficiency": 91, "tasks": 55, "projects": 3},
    {"month": "Jun", "efficiency": 92, "tasks": 60, "projects": 3},
  ];

  String getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getPriorityText(String priority) {
    switch (priority) {
      case "high":
        return "High";
      case "medium":
        return "Medium";
      case "low":
        return "Low";
      default:
        return "Medium";
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return warningColor;
    }
  }

  Widget _buildOverviewTab() {
    double budgetUtilization = ((team["utilized"] as double) / (team["budget"] as double)) * 100;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Team Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${team["name"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${team["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.5,
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Department",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${team["department"]}",
                            style: TextStyle(
                              fontSize: 14,
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
                        spacing: spXs,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${team["location"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Working Hours",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${team["workingHours"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Created",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(team["createdDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Team Lead Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Team Lead",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${team["leadAvatar"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${team["lead"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${team["leadEmail"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        QButton(
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            //send email
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Team Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Team Members", "${team["members"]}", Icons.people, primaryColor),
              _buildMetricCard("Active Projects", "${team["activeProjects"]}", Icons.work, warningColor),
              _buildMetricCard("Completed Projects", "${team["completedProjects"]}", Icons.check_circle, successColor),
              _buildMetricCard("Team Efficiency", "${team["efficiency"]}%", Icons.trending_up, infoColor),
            ],
          ),

          // Budget Overview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Budget Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Total Budget",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(team["budget"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Utilized",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(team["utilized"] as double).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Remaining",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((team["budget"] as double) - (team["utilized"] as double)).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Budget Utilization: ${budgetUtilization.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: budgetUtilization / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        budgetUtilization > 80 ? dangerColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Core Skills
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Core Skills & Technologies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (team["skills"] as List<String>).map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
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
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Team Members (${members.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Member",
                size: bs.sm,
                icon: Icons.add,
                onPressed: () {
                  //add member functionality
                },
              ),
            ],
          ),
          ...members.map((member) {
            Color workloadColor = (member["workload"] as int) > 80
                ? dangerColor
                : (member["workload"] as int) > 60
                    ? warningColor
                    : successColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${member["avatar"]}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${member["efficiency"]}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${member["role"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "${member["email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Tasks Done",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${member["tasksCompleted"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Projects",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${member["activeProjects"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "Workload",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${member["workload"]}%",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: workloadColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: LinearProgressIndicator(
                                          value: (member["workload"] as int) / 100,
                                          backgroundColor: disabledColor,
                                          valueColor: AlwaysStoppedAnimation<Color>(workloadColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        QHorizontalScroll(
                          children: (member["skills"] as List<String>).map((skill) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Joined: ${DateTime.parse(member["joinDate"]).dMMMy}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              icon: Icons.email,
                              size: bs.sm,
                              onPressed: () {
                                //send email
                              },
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: () {
                                //call phone
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildProjectsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Team Projects",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Assign Project",
                size: bs.sm,
                icon: Icons.add,
                onPressed: () {
                  //assign project functionality
                },
              ),
            ],
          ),
          ...projects.map((project) {
            double budgetUsage = ((project["spent"] as double) / (project["budget"] as double)) * 100;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getStatusColor(project["status"]),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${project["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: getStatusColor(project["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          getStatusText(project["status"]),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(project["status"]),
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: getPriorityColor(project["priority"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          getPriorityText(project["priority"]),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: getPriorityColor(project["priority"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${project["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (project["progress"] as int) / 100,
                                    backgroundColor: disabledColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      getStatusColor(project["status"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${project["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Budget",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(project["budget"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Spent",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(project["spent"] as double).currency} (${budgetUsage.toStringAsFixed(1)}%)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Assigned Members",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: (project["assignedMembers"] as List<String>).map((member) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              member,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Start: ${DateTime.parse(project["startDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${DateTime.parse(project["dueDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (project["status"] == "completed") ...[
                        SizedBox(width: spSm),
                        Icon(
                          Icons.check_circle,
                          size: 12,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Completed: ${DateTime.parse(project["completedDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                          ),
                        ),
                      ],
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

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "${team["name"]}",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Projects", icon: Icon(Icons.work)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMembersTab(),
        _buildProjectsTab(),
      ],
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            //navigateTo TpmCreateTeamView with edit mode
          },
        ),
        IconButton(
          icon: Icon(Icons.bar_chart),
          onPressed: () {
            //navigateTo TpmTeamWorkloadView
          },
        ),
      ],
    );
  }
}
