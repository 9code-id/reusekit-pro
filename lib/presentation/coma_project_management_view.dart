import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectManagementView extends StatefulWidget {
  const ComaProjectManagementView({super.key});

  @override
  State<ComaProjectManagementView> createState() => _ComaProjectManagementViewState();
}

class _ComaProjectManagementViewState extends State<ComaProjectManagementView> {
  int currentTab = 0;
  String selectedProjectFilter = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> projectFilters = [
    {"label": "All Projects", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Planning", "value": "planning"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Completed", "value": "completed"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Projects", icon: Icon(Icons.construction)),
        Tab(text: "Tasks", icon: Icon(Icons.task)),
        Tab(text: "Team", icon: Icon(Icons.people)),
        Tab(text: "Resources", icon: Icon(Icons.inventory)),
      ],
      tabChildren: [
        _buildProjectsTab(),
        _buildTasksTab(),
        _buildTeamTab(),
        _buildResourcesTab(),
      ],
    );
  }

  Widget _buildProjectsTab() {
    List<Map<String, dynamic>> projects = [
      {
        "name": "Downtown Office Complex",
        "status": "active",
        "progress": 65,
        "budget": 2500000,
        "spent": 1625000,
        "startDate": "Aug 15, 2024",
        "endDate": "Dec 15, 2024",
        "teamSize": 12,
        "location": "Seattle, WA",
        "client": "Metropolitan Holdings",
        "priority": "high",
      },
      {
        "name": "Residential Villa Project",
        "status": "planning",
        "progress": 25,
        "budget": 800000,
        "spent": 200000,
        "startDate": "Oct 1, 2024",
        "endDate": "Jan 30, 2025",
        "teamSize": 8,
        "location": "Bellevue, WA",
        "client": "Private Owner",
        "priority": "medium",
      },
      {
        "name": "Shopping Mall Renovation",
        "status": "active",
        "progress": 90,
        "budget": 1200000,
        "spent": 1080000,
        "startDate": "Jun 1, 2024",
        "endDate": "Nov 20, 2024",
        "teamSize": 15,
        "location": "Tacoma, WA",
        "client": "Retail Group Inc",
        "priority": "high",
      },
      {
        "name": "Warehouse Expansion",
        "status": "completed",
        "progress": 100,
        "budget": 600000,
        "spent": 580000,
        "startDate": "Mar 1, 2024",
        "endDate": "Aug 31, 2024",
        "teamSize": 6,
        "location": "Kent, WA",
        "client": "Logistics Corp",
        "priority": "low",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search Projects",
                  value: searchQuery,
                  hint: "Enter project name or client",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: projectFilters,
                  value: selectedProjectFilter,
                  onChanged: (value, label) {
                    selectedProjectFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Add Project Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Project",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // Navigate to create project
              },
            ),
          ),

          // Projects List
          Column(
            spacing: spSm,
            children: projects.map((project) {
              Color statusColor = _getProjectStatusColor(project["status"]);
              Color priorityColor = _getPriorityColor(project["priority"]);
              double budgetUsed = (project["spent"] as int) / (project["budget"] as int);

              return Container(
                padding: EdgeInsets.all(spSm),
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
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${project["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: priorityColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${project["client"]} • ${project["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${project["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress: ${project["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${project["startDate"]} - ${project["endDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        LinearProgressIndicator(
                          value: (project["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation(statusColor),
                        ),
                      ],
                    ),

                    // Budget and Team Info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Budget",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((project["budget"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(budgetUsed * 100).toInt()}% used",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: budgetUsed > 0.8 ? dangerColor : successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Team Size",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${project["teamSize"]} members",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                // Show project options
                              },
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
    );
  }

  Widget _buildTasksTab() {
    List<Map<String, dynamic>> tasks = [
      {
        "title": "Foundation Inspection",
        "project": "Downtown Office Complex",
        "assignee": "Mike Johnson",
        "dueDate": "Nov 25, 2024",
        "status": "completed",
        "priority": "high",
      },
      {
        "title": "Electrical Wiring - Floor 5",
        "project": "Downtown Office Complex",
        "assignee": "Sarah Chen",
        "dueDate": "Nov 30, 2024",
        "status": "in_progress",
        "priority": "medium",
      },
      {
        "title": "Site Preparation",
        "project": "Residential Villa",
        "assignee": "David Wilson",
        "dueDate": "Dec 5, 2024",
        "status": "pending",
        "priority": "high",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Task",
              icon: Icons.add_task,
              size: bs.md,
              onPressed: () {},
            ),
          ),
          Column(
            spacing: spSm,
            children: tasks.map((task) {
              Color statusColor = _getTaskStatusColor(task["status"]);
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
                          child: Text(
                            "${task["title"]}",
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
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${task["status"]}".replaceAll('_', ' ').toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${task["project"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["assignee"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${task["dueDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 64,
                  color: disabledColor,
                ),
                Text(
                  "Team Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Manage team members, roles, and assignments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Add Team Member",
                  icon: Icons.person_add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory,
                  size: 64,
                  color: disabledColor,
                ),
                Text(
                  "Resource Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Track equipment, materials, and inventory",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Add Resource",
                  icon: Icons.add_box,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectStatusColor(String status) {
    switch (status) {
      case "active":
        return primaryColor;
      case "planning":
        return warningColor;
      case "on_hold":
        return dangerColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTaskStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return primaryColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
