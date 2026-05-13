import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTeamMembersView extends StatefulWidget {
  const PmaTeamMembersView({super.key});

  @override
  State<PmaTeamMembersView> createState() => _PmaTeamMembersViewState();
}

class _PmaTeamMembersViewState extends State<PmaTeamMembersView> {
  String searchQuery = "";
  String selectedRole = "all";
  String selectedStatus = "all";
  String selectedTeam = "all";

  List<Map<String, dynamic>> roleOptions = [
    {"label": "All Roles", "value": "all"},
    {"label": "Team Lead", "value": "lead"},
    {"label": "Senior Developer", "value": "senior"},
    {"label": "Developer", "value": "developer"},
    {"label": "Junior Developer", "value": "junior"},
    {"label": "Designer", "value": "designer"},
    {"label": "QA Engineer", "value": "qa"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Leave", "value": "leave"},
  ];

  List<Map<String, dynamic>> teamOptions = [
    {"label": "All Teams", "value": "all"},
    {"label": "Frontend Development", "value": "frontend"},
    {"label": "Backend Development", "value": "backend"},
    {"label": "UI/UX Design", "value": "design"},
    {"label": "Quality Assurance", "value": "qa"},
    {"label": "DevOps", "value": "devops"},
  ];

  List<Map<String, dynamic>> members = [
    {
      "id": 1,
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "avatar": "https://i.pravatar.cc/100?img=1",
      "role": "lead",
      "roleTitle": "Team Lead",
      "team": "frontend",
      "teamName": "Frontend Development",
      "status": "active",
      "joinDate": "2023-01-15",
      "completedTasks": 24,
      "rating": 4.9,
      "phone": "+1 (555) 123-4567",
      "location": "New York, NY",
      "skills": ["React", "Flutter", "Leadership"],
      "projects": ["E-Commerce Platform", "Mobile App"],
      "performance": 95,
      "salary": 85000,
    },
    {
      "id": 2,
      "name": "John Smith",
      "email": "john.smith@company.com",
      "avatar": "https://i.pravatar.cc/100?img=2",
      "role": "senior",
      "roleTitle": "Senior Developer",
      "team": "frontend",
      "teamName": "Frontend Development",
      "status": "active",
      "joinDate": "2023-03-10",
      "completedTasks": 22,
      "rating": 4.8,
      "phone": "+1 (555) 234-5678",
      "location": "Los Angeles, CA",
      "skills": ["JavaScript", "TypeScript", "React"],
      "projects": ["Admin Dashboard", "Customer Portal"],
      "performance": 92,
      "salary": 75000,
    },
    {
      "id": 3,
      "name": "Mike Johnson",
      "email": "mike.johnson@company.com",
      "avatar": "https://i.pravatar.cc/100?img=3",
      "role": "developer",
      "roleTitle": "Frontend Developer",
      "team": "frontend",
      "teamName": "Frontend Development",
      "status": "active",
      "joinDate": "2023-06-20",
      "completedTasks": 18,
      "rating": 4.7,
      "phone": "+1 (555) 345-6789",
      "location": "Chicago, IL",
      "skills": ["Vue.js", "HTML", "CSS"],
      "projects": ["Mobile App Redesign"],
      "performance": 88,
      "salary": 65000,
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "email": "emily.davis@company.com",
      "avatar": "https://i.pravatar.cc/100?img=4",
      "role": "designer",
      "roleTitle": "UI/UX Designer",
      "team": "design",
      "teamName": "UI/UX Design",
      "status": "active",
      "joinDate": "2023-08-05",
      "completedTasks": 20,
      "rating": 4.9,
      "phone": "+1 (555) 456-7890",
      "location": "San Francisco, CA",
      "skills": ["Figma", "Adobe XD", "User Research"],
      "projects": ["E-Commerce Platform", "Customer Portal"],
      "performance": 96,
      "salary": 70000,
    },
    {
      "id": 5,
      "name": "Alex Chen",
      "email": "alex.chen@company.com",
      "avatar": "https://i.pravatar.cc/100?img=5",
      "role": "junior",
      "roleTitle": "Junior Developer",
      "team": "backend",
      "teamName": "Backend Development",
      "status": "inactive",
      "joinDate": "2024-01-12",
      "completedTasks": 8,
      "rating": 4.3,
      "phone": "+1 (555) 567-8901",
      "location": "Seattle, WA",
      "skills": ["Node.js", "Python", "MongoDB"],
      "projects": ["API Development"],
      "performance": 78,
      "salary": 55000,
    },
    {
      "id": 6,
      "name": "Lisa Wang",
      "email": "lisa.wang@company.com",
      "avatar": "https://i.pravatar.cc/100?img=6",
      "role": "qa",
      "roleTitle": "QA Engineer",
      "team": "qa",
      "teamName": "Quality Assurance",
      "status": "leave",
      "joinDate": "2023-04-18",
      "completedTasks": 15,
      "rating": 4.6,
      "phone": "+1 (555) 678-9012",
      "location": "Austin, TX",
      "skills": ["Test Automation", "Selenium", "Jest"],
      "projects": ["Mobile App Testing", "API Testing"],
      "performance": 85,
      "salary": 62000,
    },
  ];

  List<Map<String, dynamic>> get filteredMembers {
    return members.where((member) {
      bool matchesRole = selectedRole == "all" || member["role"] == selectedRole;
      bool matchesStatus = selectedStatus == "all" || member["status"] == selectedStatus;
      bool matchesTeam = selectedTeam == "all" || member["team"] == selectedTeam;
      bool matchesSearch = searchQuery.isEmpty || 
          member["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          member["roleTitle"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesRole && matchesStatus && matchesTeam && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return dangerColor;
      case "leave":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "inactive":
        return "Inactive";
      case "leave":
        return "On Leave";
      default:
        return status;
    }
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 90) return successColor;
    if (performance >= 80) return infoColor;
    if (performance >= 70) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Members"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add member
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
                    label: "Search members...",
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Role",
                        items: roleOptions,
                        value: selectedRole,
                        onChanged: (value, label) {
                          selectedRole = value;
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
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Team",
                  items: teamOptions,
                  value: selectedTeam,
                  onChanged: (value, label) {
                    selectedTeam = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Members Summary
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
                    "Members Overview",
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
                        child: _buildSummaryCard("Total", "${members.length}", primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("Active", "${members.where((m) => m["status"] == "active").length}", successColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("Avg Rating", "${(members.fold(0.0, (sum, m) => sum + (m["rating"] as double)) / members.length).toStringAsFixed(1)}", warningColor),
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
                  "Members (${filteredMembers.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Members List
            if (filteredMembers.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.people,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No members found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredMembers.map((member) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor("${member["status"]}"),
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
                                  CircleAvatar(
                                    radius: 30,
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
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                              decoration: BoxDecoration(
                                                color: _getStatusColor("${member["status"]}").withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                              child: Text(
                                                _getStatusLabel("${member["status"]}"),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: _getStatusColor("${member["status"]}"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${member["roleTitle"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${member["teamName"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spMd),

                              // Contact Info
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: disabledColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Text(
                                            "${member["email"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${member["phone"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${member["location"]}",
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

                              // Performance Stats
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard("Performance", "${member["performance"]}%", _getPerformanceColor(member["performance"] as int)),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: _buildStatCard("Tasks", "${member["completedTasks"]}", successColor),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: _buildStatCard("Rating", "${member["rating"]}", warningColor),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: _buildStatCard("Salary", "\$${((member["salary"] as int) / 1000).toInt()}K", infoColor),
                                  ),
                                ],
                              ),

                              SizedBox(height: spMd),

                              // Skills
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Skills:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Wrap(
                                    spacing: spXs,
                                    runSpacing: spXs,
                                    children: (member["skills"] as List).map((skill) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          border: Border.all(color: primaryColor.withAlpha(30)),
                                        ),
                                        child: Text(
                                          "$skill",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              SizedBox(height: spMd),

                              // Projects
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Projects:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Column(
                                    children: (member["projects"] as List).map((project) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: spXs),
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          border: Border.all(color: successColor.withAlpha(30)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.folder,
                                              size: 16,
                                              color: successColor,
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "$project",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: successColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              SizedBox(height: spSm),

                              // Join Date
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Joined: ${DateTime.parse("${member["joinDate"]}").dMMMy}",
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

                        // Action Buttons
                        Container(
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radiusMd),
                              bottomRight: Radius.circular(radiusMd),
                            ),
                          ),
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Profile",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.message,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
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
              fontSize: 18,
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

  Widget _buildStatCard(String title, String value, Color color) {
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
