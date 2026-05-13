import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamListView extends StatefulWidget {
  const PmaTeamListView({super.key});

  @override
  State<PmaTeamListView> createState() => _PmaTeamListViewState();
}

class _PmaTeamListViewState extends State<PmaTeamListView> {
  String searchQuery = "";
  String selectedDepartment = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Sales", "value": "sales"},
    {"label": "HR", "value": "hr"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "On Hold", "value": "hold"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> teams = [
    {
      "id": 1,
      "name": "Frontend Development",
      "description": "Responsible for user interface and user experience development",
      "department": "engineering",
      "status": "active",
      "lead": "Sarah Wilson",
      "leadAvatar": "https://i.pravatar.cc/50?img=1",
      "memberCount": 8,
      "projectCount": 5,
      "completionRate": 87,
      "members": [
        {"name": "John Smith", "avatar": "https://i.pravatar.cc/30?img=2"},
        {"name": "Mike Johnson", "avatar": "https://i.pravatar.cc/30?img=3"},
        {"name": "Emily Davis", "avatar": "https://i.pravatar.cc/30?img=4"},
      ],
      "tags": ["React", "Flutter", "JavaScript"],
      "createdAt": "2024-01-15",
      "color": primaryColor,
    },
    {
      "id": 2,
      "name": "UI/UX Design",
      "description": "Creating amazing user experiences and visual designs",
      "department": "design",
      "status": "active",
      "lead": "Alex Chen",
      "leadAvatar": "https://i.pravatar.cc/50?img=5",
      "memberCount": 6,
      "projectCount": 8,
      "completionRate": 92,
      "members": [
        {"name": "Lisa Wang", "avatar": "https://i.pravatar.cc/30?img=6"},
        {"name": "David Brown", "avatar": "https://i.pravatar.cc/30?img=7"},
        {"name": "Anna Taylor", "avatar": "https://i.pravatar.cc/30?img=8"},
      ],
      "tags": ["Figma", "Adobe XD", "Sketch"],
      "createdAt": "2024-02-01",
      "color": successColor,
    },
    {
      "id": 3,
      "name": "Backend Infrastructure",
      "description": "Managing servers, databases, and system architecture",
      "department": "engineering",
      "status": "active",
      "lead": "Robert Kim",
      "leadAvatar": "https://i.pravatar.cc/50?img=9",
      "memberCount": 10,
      "projectCount": 3,
      "completionRate": 78,
      "members": [
        {"name": "Maria Garcia", "avatar": "https://i.pravatar.cc/30?img=10"},
        {"name": "James Wilson", "avatar": "https://i.pravatar.cc/30?img=11"},
        {"name": "Kevin Lee", "avatar": "https://i.pravatar.cc/30?img=12"},
      ],
      "tags": ["Node.js", "Docker", "AWS"],
      "createdAt": "2024-01-10",
      "color": infoColor,
    },
    {
      "id": 4,
      "name": "Digital Marketing",
      "description": "Content creation, social media, and online campaigns",
      "department": "marketing",
      "status": "active",
      "lead": "Jennifer Lopez",
      "leadAvatar": "https://i.pravatar.cc/50?img=13",
      "memberCount": 5,
      "projectCount": 12,
      "completionRate": 95,
      "members": [
        {"name": "Chris Anderson", "avatar": "https://i.pravatar.cc/30?img=14"},
        {"name": "Sofia Martinez", "avatar": "https://i.pravatar.cc/30?img=15"},
        {"name": "Paul Johnson", "avatar": "https://i.pravatar.cc/30?img=16"},
      ],
      "tags": ["SEO", "Content", "Analytics"],
      "createdAt": "2024-03-05",
      "color": warningColor,
    },
    {
      "id": 5,
      "name": "Quality Assurance",
      "description": "Testing and ensuring product quality before release",
      "department": "engineering",
      "status": "hold",
      "lead": "Michael Zhang",
      "leadAvatar": "https://i.pravatar.cc/50?img=17",
      "memberCount": 4,
      "projectCount": 2,
      "completionRate": 65,
      "members": [
        {"name": "Linda Chen", "avatar": "https://i.pravatar.cc/30?img=18"},
        {"name": "Tony Stark", "avatar": "https://i.pravatar.cc/30?img=19"},
      ],
      "tags": ["Testing", "Automation", "QA"],
      "createdAt": "2024-02-20",
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> get filteredTeams {
    return teams.where((team) {
      bool matchesDepartment = selectedDepartment == "all" || team["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "all" || team["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
          team["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          team["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesDepartment && matchesStatus && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "hold":
        return warningColor;
      case "completed":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "hold":
        return "On Hold";
      case "completed":
        return "Completed";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team List"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create team
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search teams...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Teams Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Teams Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard("Total Teams", "${teams.length}", primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("Active", "${teams.where((t) => t["status"] == "active").length}", successColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("Members", "${teams.fold(0, (sum, team) => sum + (team["memberCount"] as int))}", infoColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Teams (${filteredTeams.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Teams Grid
            if (filteredTeams.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.groups,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No teams found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or create a new team",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredTeams.map((team) {
                  return Container(
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
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${team["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${team["department"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: team["color"] as Color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${team["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      _getStatusLabel("${team["status"]}"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${team["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spSm),

                              // Description
                              Text(
                                "${team["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: spMd),

                              // Team Lead
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage("${team["leadAvatar"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Team Lead",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${team["lead"]}",
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

                              SizedBox(height: spMd),

                              // Stats Row
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatItem("Members", "${team["memberCount"]}", Icons.people),
                                  ),
                                  Expanded(
                                    child: _buildStatItem("Projects", "${team["projectCount"]}", Icons.folder),
                                  ),
                                  Expanded(
                                    child: _buildStatItem("Rate", "${team["completionRate"]}%", Icons.trending_up),
                                  ),
                                ],
                              ),

                              SizedBox(height: spMd),

                              // Members Preview
                              Row(
                                children: [
                                  Text(
                                    "Members:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ...(team["members"] as List).take(3).map((member) {
                                          return Container(
                                            margin: EdgeInsets.only(right: spXs),
                                            child: CircleAvatar(
                                              radius: 12,
                                              backgroundImage: NetworkImage("${member["avatar"]}"),
                                            ),
                                          );
                                        }).toList(),
                                        if ((team["memberCount"] as int) > 3)
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: disabledColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "+${(team["memberCount"] as int) - 3}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spMd),

                              // Tags
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (team["tags"] as List).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: (team["color"] as Color).withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(color: (team["color"] as Color).withAlpha(30)),
                                    ),
                                    child: Text(
                                      "$tag",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: team["color"] as Color,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        // Action Button
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radiusMd),
                              bottomRight: Radius.circular(radiusMd),
                            ),
                          ),
                          child: QButton(
                            label: "View Team",
                            size: bs.sm,
                            onPressed: () {},
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
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
