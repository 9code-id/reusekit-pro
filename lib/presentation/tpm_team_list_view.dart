import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamListView extends StatefulWidget {
  const TpmTeamListView({super.key});

  @override
  State<TpmTeamListView> createState() => _TpmTeamListViewState();
}

class _TpmTeamListViewState extends State<TpmTeamListView> {
  String searchQuery = "";
  String departmentFilter = "";
  String statusFilter = "";
  String sortBy = "name";

  List<Map<String, dynamic>> teams = [
    {
      "id": 1,
      "name": "Development Team Alpha",
      "description": "Core mobile application development team",
      "department": "Engineering",
      "lead": "Alice Johnson",
      "leadAvatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "members": 12,
      "activeProjects": 3,
      "completedProjects": 8,
      "efficiency": 92,
      "status": "active",
      "budget": 150000.0,
      "utilized": 125000.0,
      "skills": ["Flutter", "React Native", "Firebase", "Node.js"],
      "color": successColor,
      "createdDate": "2024-01-15",
      "location": "New York",
    },
    {
      "id": 2,
      "name": "UI/UX Design Team",
      "description": "User interface and experience design specialists",
      "department": "Design",
      "lead": "Bob Smith",
      "leadAvatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "members": 6,
      "activeProjects": 4,
      "completedProjects": 12,
      "efficiency": 88,
      "status": "active",
      "budget": 90000.0,
      "utilized": 76000.0,
      "skills": ["Figma", "Adobe XD", "Sketch", "Prototyping"],
      "color": infoColor,
      "createdDate": "2024-02-01",
      "location": "San Francisco",
    },
    {
      "id": 3,
      "name": "Quality Assurance Team",
      "description": "Software testing and quality control specialists",
      "department": "Engineering",
      "lead": "Charlie Brown",
      "leadAvatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "members": 8,
      "activeProjects": 2,
      "completedProjects": 15,
      "efficiency": 85,
      "status": "active",
      "budget": 120000.0,
      "utilized": 98000.0,
      "skills": ["Selenium", "Jest", "Cypress", "Manual Testing"],
      "color": warningColor,
      "createdDate": "2024-01-20",
      "location": "Austin",
    },
    {
      "id": 4,
      "name": "DevOps Infrastructure",
      "description": "Cloud infrastructure and deployment automation",
      "department": "Engineering",
      "lead": "Diana Wilson",
      "leadAvatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "members": 4,
      "activeProjects": 5,
      "completedProjects": 6,
      "efficiency": 95,
      "status": "active",
      "budget": 100000.0,
      "utilized": 85000.0,
      "skills": ["AWS", "Docker", "Kubernetes", "CI/CD"],
      "color": primaryColor,
      "createdDate": "2024-03-10",
      "location": "Seattle",
    },
    {
      "id": 5,
      "name": "Data Analytics Team",
      "description": "Business intelligence and data analysis",
      "department": "Analytics",
      "lead": "Eve Davis",
      "leadAvatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "members": 5,
      "activeProjects": 2,
      "completedProjects": 7,
      "efficiency": 90,
      "status": "active",
      "budget": 80000.0,
      "utilized": 65000.0,
      "skills": ["Python", "SQL", "Tableau", "Machine Learning"],
      "color": secondaryColor,
      "createdDate": "2024-04-01",
      "location": "Boston",
    },
    {
      "id": 6,
      "name": "Marketing Creative Team",
      "description": "Brand marketing and creative content development",
      "department": "Marketing",
      "lead": "Frank Miller",
      "leadAvatar": "https://picsum.photos/40/40?random=6&keyword=person",
      "members": 7,
      "activeProjects": 6,
      "completedProjects": 9,
      "efficiency": 83,
      "status": "active",
      "budget": 70000.0,
      "utilized": 58000.0,
      "skills": ["Content Creation", "Social Media", "Brand Design", "Video"],
      "color": dangerColor,
      "createdDate": "2024-02-15",
      "location": "Los Angeles",
    },
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": ""},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Design", "value": "Design"},
    {"label": "Analytics", "value": "Analytics"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Operations", "value": "Operations"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Hold", "value": "on_hold"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "name"},
    {"label": "Members", "value": "members"},
    {"label": "Efficiency", "value": "efficiency"},
    {"label": "Active Projects", "value": "activeProjects"},
    {"label": "Created Date", "value": "createdDate"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedTeams {
    List<Map<String, dynamic>> filtered = teams.where((team) {
      bool matchesSearch = "${team["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${team["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${team["lead"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = departmentFilter.isEmpty || team["department"] == departmentFilter;
      bool matchesStatus = statusFilter.isEmpty || team["status"] == statusFilter;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();

    // Sort teams
    filtered.sort((a, b) {
      switch (sortBy) {
        case "members":
          return (b["members"] as int).compareTo(a["members"] as int);
        case "efficiency":
          return (b["efficiency"] as int).compareTo(a["efficiency"] as int);
        case "activeProjects":
          return (b["activeProjects"] as int).compareTo(a["activeProjects"] as int);
        case "createdDate":
          return DateTime.parse(b["createdDate"]).compareTo(DateTime.parse(a["createdDate"]));
        default:
          return "${a["name"]}".compareTo("${b["name"]}");
      }
    });

    return filtered;
  }

  Map<String, dynamic> get teamStats {
    int totalTeams = teams.length;
    int activeTeams = teams.where((t) => t["status"] == "active").length;
    int totalMembers = teams.fold(0, (sum, t) => sum + (t["members"] as int));
    int totalProjects = teams.fold(0, (sum, t) => sum + (t["activeProjects"] as int));
    double avgEfficiency = teams.fold(0.0, (sum, t) => sum + (t["efficiency"] as int)) / totalTeams;
    double totalBudget = teams.fold(0.0, (sum, t) => sum + (t["budget"] as double));
    double totalUtilized = teams.fold(0.0, (sum, t) => sum + (t["utilized"] as double));

    return {
      "totalTeams": totalTeams,
      "activeTeams": activeTeams,
      "totalMembers": totalMembers,
      "totalProjects": totalProjects,
      "avgEfficiency": avgEfficiency.round(),
      "totalBudget": totalBudget,
      "totalUtilized": totalUtilized,
      "budgetUtilization": (totalUtilized / totalBudget * 100).round(),
    };
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(Map<String, dynamic> team) {
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
                  color: (team["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${team["department"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: team["color"] as Color,
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
              Expanded(
                child: Text(
                  "Team Lead: ${team["lead"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(
                Icons.location_on,
                size: 12,
                color: disabledBoldColor,
              ),
              SizedBox(width: 2),
              Text(
                "${team["location"]}",
                style: TextStyle(
                  fontSize: 11,
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
                      "Efficiency",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${team["efficiency"]}%",
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
                    "Budget Utilization",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${budgetUtilization.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: budgetUtilization > 80 ? dangerColor : warningColor,
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
              Row(
                children: [
                  Text(
                    "\$${(team["utilized"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    " / \$${(team["budget"] as double).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Key Skills",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
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
                "Created: ${DateTime.parse(team["createdDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Completed: ${team["completedProjects"]} projects",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo TpmCreateTeamView with edit mode
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> stats = teamStats;
    List<Map<String, dynamic>> filteredTeams = filteredAndSortedTeams;

    return Scaffold(
      appBar: AppBar(
        title: Text("Team Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo TpmCreateTeamView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    label: "Search teams...",
                    value: searchQuery,
                    hint: "Search by name, description, or lead",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Department",
                          items: departmentOptions,
                          value: departmentFilter,
                          onChanged: (value, label) {
                            departmentFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: statusFilter,
                          onChanged: (value, label) {
                            statusFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Team Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Total Teams",
                  "${stats["totalTeams"]}",
                  "${stats["activeTeams"]} active teams",
                  Icons.groups,
                  primaryColor,
                ),
                _buildStatCard(
                  "Total Members",
                  "${stats["totalMembers"]}",
                  "Across all teams",
                  Icons.people,
                  successColor,
                ),
                _buildStatCard(
                  "Active Projects",
                  "${stats["totalProjects"]}",
                  "Currently in progress",
                  Icons.work,
                  warningColor,
                ),
                _buildStatCard(
                  "Avg Efficiency",
                  "${stats["avgEfficiency"]}%",
                  "Team performance",
                  Icons.trending_up,
                  infoColor,
                ),
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
                              "\$${(stats["totalBudget"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
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
                              "\$${(stats["totalUtilized"] as double).currency}",
                              style: TextStyle(
                                fontSize: 18,
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
                              "Utilization",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${stats["budgetUtilization"]}%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: (stats["budgetUtilization"] as int) > 80 ? dangerColor : successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: (stats["budgetUtilization"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      (stats["budgetUtilization"] as int) > 80 ? dangerColor : warningColor,
                    ),
                  ),
                ],
              ),
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "Teams (${filteredTeams.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (filteredTeams.length != teams.length)
                  Text(
                    "Filtered from ${teams.length} total",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),

            // Teams List
            ...filteredTeams.map((team) {
              return _buildTeamCard(team);
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
                    Text(
                      "Try adjusting your search and filter criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
