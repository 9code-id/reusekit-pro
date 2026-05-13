import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamManagementView extends StatefulWidget {
  const TpmTeamManagementView({super.key});

  @override
  State<TpmTeamManagementView> createState() => _TpmTeamManagementViewState();
}

class _TpmTeamManagementViewState extends State<TpmTeamManagementView> {
  int selectedTab = 0;
  String searchQuery = "";
  String statusFilter = "";
  String roleFilter = "";

  List<Map<String, dynamic>> teams = [
    {
      "id": 1,
      "name": "Development Team",
      "description": "Core development team responsible for building applications",
      "members": 12,
      "activeProjects": 3,
      "completedProjects": 8,
      "efficiency": 92,
      "lead": "Alice Johnson",
      "leadAvatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "status": "active",
      "color": successColor,
      "skills": ["Flutter", "React", "Node.js", "Python"],
      "budget": 150000.0,
      "utilized": 125000.0,
    },
    {
      "id": 2,
      "name": "Design Team",
      "description": "UI/UX design and creative team",
      "members": 6,
      "activeProjects": 4,
      "completedProjects": 12,
      "efficiency": 88,
      "lead": "Bob Smith",
      "leadAvatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "status": "active",
      "color": infoColor,
      "skills": ["Figma", "Adobe XD", "Photoshop", "Illustrator"],
      "budget": 90000.0,
      "utilized": 76000.0,
    },
    {
      "id": 3,
      "name": "QA Team",
      "description": "Quality assurance and testing specialists",
      "members": 8,
      "activeProjects": 2,
      "completedProjects": 15,
      "efficiency": 85,
      "lead": "Charlie Brown",
      "leadAvatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "status": "active",
      "color": warningColor,
      "skills": ["Selenium", "Jest", "Cypress", "Manual Testing"],
      "budget": 120000.0,
      "utilized": 98000.0,
    },
    {
      "id": 4,
      "name": "DevOps Team",
      "description": "Infrastructure and deployment specialists",
      "members": 4,
      "activeProjects": 5,
      "completedProjects": 6,
      "efficiency": 95,
      "lead": "Diana Wilson",
      "leadAvatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "status": "active",
      "color": primaryColor,
      "skills": ["AWS", "Docker", "Kubernetes", "CI/CD"],
      "budget": 100000.0,
      "utilized": 85000.0,
    },
  ];

  List<Map<String, dynamic>> members = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "email": "alice@company.com",
      "role": "Team Lead",
      "team": "Development Team",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "status": "active",
      "joinDate": "2024-01-15",
      "efficiency": 95,
      "tasksCompleted": 145,
      "activeProjects": 2,
      "skills": ["Flutter", "Dart", "Firebase", "Team Management"],
      "workload": 85,
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "email": "bob@company.com",
      "role": "Senior Designer",
      "team": "Design Team",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=person",
      "status": "active",
      "joinDate": "2024-02-01",
      "efficiency": 90,
      "tasksCompleted": 98,
      "activeProjects": 3,
      "skills": ["UI/UX", "Figma", "Prototyping", "Design Systems"],
      "workload": 78,
    },
    {
      "id": 3,
      "name": "Charlie Brown",
      "email": "charlie@company.com",
      "role": "QA Engineer",
      "team": "QA Team",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "status": "active",
      "joinDate": "2024-01-20",
      "efficiency": 88,
      "tasksCompleted": 167,
      "activeProjects": 1,
      "skills": ["Testing", "Automation", "Bug Tracking", "Selenium"],
      "workload": 65,
    },
    {
      "id": 4,
      "name": "Diana Wilson",
      "email": "diana@company.com",
      "role": "DevOps Engineer",
      "team": "DevOps Team",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=person",
      "status": "active",
      "joinDate": "2024-03-10",
      "efficiency": 93,
      "tasksCompleted": 89,
      "activeProjects": 4,
      "skills": ["AWS", "Docker", "CI/CD", "Monitoring"],
      "workload": 92,
    },
    {
      "id": 5,
      "name": "Eve Davis",
      "email": "eve@company.com",
      "role": "Junior Developer",
      "team": "Development Team",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "status": "active",
      "joinDate": "2024-04-01",
      "efficiency": 82,
      "tasksCompleted": 67,
      "activeProjects": 1,
      "skills": ["React", "JavaScript", "HTML/CSS", "Git"],
      "workload": 70,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Leave", "value": "on_leave"},
  ];

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": ""},
    {"label": "Team Lead", "value": "Team Lead"},
    {"label": "Senior Developer", "value": "Senior Developer"},
    {"label": "Junior Developer", "value": "Junior Developer"},
    {"label": "Designer", "value": "Designer"},
    {"label": "QA Engineer", "value": "QA Engineer"},
  ];

  List<Map<String, dynamic>> get filteredTeams {
    return teams.where((team) {
      bool matchesSearch = "${team["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${team["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get filteredMembers {
    return members.where((member) {
      bool matchesSearch = "${member["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${member["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = statusFilter.isEmpty || member["status"] == statusFilter;
      bool matchesRole = roleFilter.isEmpty || member["role"] == roleFilter;
      return matchesSearch && matchesStatus && matchesRole;
    }).toList();
  }

  Map<String, dynamic> get overallStats {
    int totalMembers = members.length;
    int activeMembers = members.where((m) => m["status"] == "active").length;
    int totalTeams = teams.length;
    int activeTeams = teams.where((t) => t["status"] == "active").length;
    
    double averageEfficiency = members.fold(0.0, (sum, m) => sum + (m["efficiency"] as int)) / totalMembers;
    double averageWorkload = members.fold(0.0, (sum, m) => sum + (m["workload"] as int)) / totalMembers;
    
    int totalProjects = teams.fold(0, (sum, t) => sum + (t["activeProjects"] as int));
    
    return {
      "totalMembers": totalMembers,
      "activeMembers": activeMembers,
      "totalTeams": totalTeams,
      "activeTeams": activeTeams,
      "averageEfficiency": averageEfficiency.round(),
      "averageWorkload": averageWorkload.round(),
      "totalProjects": totalProjects,
    };
  }

  Widget _buildTeamsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: QTextField(
              label: "Search teams...",
              value: searchQuery,
              hint: "Search by team name or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),

          // Team Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Teams", "${teams.length}", Icons.groups, primaryColor),
              _buildStatCard("Active Teams", "${teams.where((t) => t["status"] == "active").length}", Icons.group, successColor),
              _buildStatCard("Total Members", "${members.length}", Icons.person, infoColor),
              _buildStatCard("Avg Efficiency", "${overallStats["averageEfficiency"]}%", Icons.trending_up, warningColor),
            ],
          ),

          // Teams List
          ...filteredTeams.map((team) {
            double budgetUtilization = ((team["utilized"] as double) / (team["budget"] as double)) * 100;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: team["color"] as Color,
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
                          "${team["name"]}",
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
                          "${team["efficiency"]}% Efficiency",
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
                    "${team["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${team["leadAvatar"]}",
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Lead: ${team["lead"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                              "Members",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${team["members"]}",
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
                              "Active Projects",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${team["activeProjects"]}",
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
                              "Completed",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${team["completedProjects"]}",
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
                          Spacer(),
                          Text(
                            "\$${(team["utilized"] as double).currency} / \$${(team["budget"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                  QHorizontalScroll(
                    children: (team["skills"] as List<String>).map((skill) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: (team["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: team["color"] as Color,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo TpmTeamDetailView
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.people,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo TpmTeamMembersView
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.bar_chart,
                        size: bs.sm,
                        onPressed: () {
                          //navigateTo TpmTeamWorkloadView
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          if (filteredTeams.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No teams found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
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
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search members...",
                  value: searchQuery,
                  hint: "Search by name or email",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status Filter",
                        items: statusOptions,
                        value: statusFilter,
                        onChanged: (value, label) {
                          statusFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Role Filter",
                        items: roleOptions,
                        value: roleFilter,
                        onChanged: (value, label) {
                          roleFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Members List
          ...filteredMembers.map((member) {
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
                                "${member["efficiency"]}% Efficiency",
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
                          "${member["role"]} • ${member["team"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                                    "Active Projects",
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
                                          fontSize: 14,
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          if (filteredMembers.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No members found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
      title: "Team Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Teams", icon: Icon(Icons.groups)),
        Tab(text: "Members", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildTeamsTab(),
        _buildMembersTab(),
      ],
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            //navigateTo TpmCreateTeamView
          },
        ),
      ],
    );
  }
}
