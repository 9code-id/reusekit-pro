import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard8View extends StatefulWidget {
  @override
  State<GrlDashboard8View> createState() => _GrlDashboard8ViewState();
}

class _GrlDashboard8ViewState extends State<GrlDashboard8View> {
  bool loading = false;
  String selectedProject = "All Projects";
  
  List<Map<String, dynamic>> projectMetrics = [
    {"metric": "Active Projects", "value": 24, "change": 8.3, "icon": Icons.work},
    {"metric": "Completed Tasks", "value": 1847, "change": 12.5, "icon": Icons.check_circle},
    {"metric": "Team Efficiency", "value": 87.3, "change": 5.7, "icon": Icons.trending_up, "unit": "%"},
    {"metric": "Budget Utilization", "value": 68.9, "change": -3.2, "icon": Icons.account_balance_wallet, "unit": "%"},
  ];

  List<Map<String, dynamic>> projectData = [
    {"name": "E-commerce Platform", "progress": 85, "budget": 150000.0, "spent": 127500.0, "team": 8, "deadline": "2024-02-15", "status": "On Track", "priority": "High"},
    {"name": "Mobile App Development", "progress": 65, "budget": 85000.0, "spent": 55250.0, "team": 5, "deadline": "2024-03-20", "status": "On Track", "priority": "Medium"},
    {"name": "Website Redesign", "progress": 92, "budget": 45000.0, "spent": 41400.0, "team": 4, "deadline": "2024-01-30", "status": "Ahead", "priority": "High"},
    {"name": "Data Analytics Tool", "progress": 45, "budget": 120000.0, "spent": 54000.0, "team": 6, "deadline": "2024-04-15", "status": "Behind", "priority": "Low"},
    {"name": "CRM Integration", "progress": 78, "budget": 75000.0, "spent": 58500.0, "team": 3, "deadline": "2024-02-28", "status": "On Track", "priority": "Medium"},
  ];

  List<Map<String, dynamic>> teamMembers = [
    {"name": "Alice Johnson", "role": "Project Manager", "projects": 3, "utilization": 95, "avatar": "https://picsum.photos/50/50?random=1&keyword=woman", "status": "Active"},
    {"name": "Bob Chen", "role": "Senior Developer", "projects": 2, "utilization": 88, "avatar": "https://picsum.photos/50/50?random=2&keyword=man", "status": "Active"},
    {"name": "Carol Smith", "role": "UI/UX Designer", "projects": 4, "utilization": 92, "avatar": "https://picsum.photos/50/50?random=3&keyword=woman", "status": "Active"},
    {"name": "David Wilson", "role": "Backend Developer", "projects": 2, "utilization": 78, "avatar": "https://picsum.photos/50/50?random=4&keyword=man", "status": "On Leave"},
    {"name": "Eva Martinez", "role": "QA Engineer", "projects": 3, "utilization": 85, "avatar": "https://picsum.photos/50/50?random=5&keyword=woman", "status": "Active"},
  ];

  List<Map<String, dynamic>> milestones = [
    {"project": "E-commerce Platform", "milestone": "Payment Integration", "dueDate": "2024-01-20", "status": "Completed", "assignee": "Bob Chen"},
    {"project": "Mobile App Development", "milestone": "UI Design Phase", "dueDate": "2024-01-25", "status": "In Progress", "assignee": "Carol Smith"},
    {"project": "Website Redesign", "milestone": "Content Migration", "dueDate": "2024-01-18", "status": "Completed", "assignee": "Alice Johnson"},
    {"project": "Data Analytics Tool", "milestone": "Database Schema", "dueDate": "2024-01-22", "status": "Pending", "assignee": "David Wilson"},
    {"project": "CRM Integration", "milestone": "API Development", "dueDate": "2024-01-28", "status": "In Progress", "assignee": "Bob Chen"},
  ];

  List<Map<String, dynamic>> resourceAllocation = [
    {"resource": "Development", "allocated": 12, "available": 15, "utilization": 80.0},
    {"resource": "Design", "allocated": 4, "available": 5, "utilization": 80.0},
    {"resource": "QA Testing", "allocated": 3, "available": 4, "utilization": 75.0},
    {"resource": "Project Management", "allocated": 2, "available": 3, "utilization": 66.7},
    {"resource": "DevOps", "allocated": 1, "available": 2, "utilization": 50.0},
  ];

  List<Map<String, dynamic>> projectItems = [
    {"label": "All Projects", "value": "All Projects"},
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "Mobile App Development", "value": "Mobile App Development"},
    {"label": "Website Redesign", "value": "Website Redesign"},
    {"label": "Data Analytics Tool", "value": "Data Analytics Tool"},
  ];

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Management"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.add_box,
              size: bs.sm,
              onPressed: () {
                si("Creating new project");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Filter
            Row(
              children: [
                Text(
                  "Project:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Project",
                    items: projectItems,
                    value: selectedProject,
                    onChanged: (value, label) {
                      selectedProject = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Project Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: projectMetrics.map((metric) {
                String displayValue;
                if (metric.containsKey("unit")) {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(1)}${metric["unit"]}";
                } else {
                  displayValue = "${(metric["value"] as num).toStringAsFixed(0)}";
                }
                
                return _buildMetricCard(
                  metric["metric"],
                  displayValue,
                  metric["icon"],
                  primaryColor,
                  "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                );
              }).toList(),
            ),

            // Active Projects
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Projects",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening project portfolio view");
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
                    children: projectData.map((project) {
                      double budgetUsed = (project["spent"] as double) / (project["budget"] as double);
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getProjectStatusColor(project["status"]),
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${project["name"]}",
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
                                    color: _getPriorityColor(project["priority"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${project["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getPriorityColor(project["priority"]),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getProjectStatusColor(project["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${project["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getProjectStatusColor(project["status"]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Progress:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: (project["progress"] as int) / 100,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _getProgressColor(project["progress"] as int),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Budget: \$${((project["budget"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Team: ${project["team"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Due: ${project["deadline"]}",
                                  style: TextStyle(
                                    fontSize: 11,
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
            ),

            // Team Utilization
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team Utilization",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: teamMembers.map((member) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${member["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${member["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getMemberStatusColor(member["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${member["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getMemberStatusColor(member["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${member["role"]} • ${member["projects"]} projects",
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
                                  "${member["utilization"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getUtilizationColor(member["utilization"] as int),
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: (member["utilization"] as int) / 100,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _getUtilizationColor(member["utilization"] as int),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
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
            ),

            // Upcoming Milestones
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcoming Milestones",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: milestones.map((milestone) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _getMilestoneStatusColor(milestone["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getMilestoneIcon(milestone["status"]),
                                color: _getMilestoneStatusColor(milestone["status"]),
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${milestone["milestone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${milestone["project"]} • ${milestone["assignee"]}",
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
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getMilestoneStatusColor(milestone["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${milestone["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: _getMilestoneStatusColor(milestone["status"]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${milestone["dueDate"]}",
                                  style: TextStyle(
                                    fontSize: 11,
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
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "New Project",
                    icon: Icons.add_circle,
                    size: bs.md,
                    onPressed: () {
                      si("Creating new project");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Team Schedule",
                    icon: Icons.schedule,
                    size: bs.md,
                    onPressed: () {
                      si("Opening team schedule view");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: change.startsWith('+') ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProjectStatusColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Ahead":
        return primaryColor;
      case "Behind":
        return dangerColor;
      case "At Risk":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getProgressColor(int progress) {
    if (progress >= 80) return successColor;
    if (progress >= 50) return warningColor;
    return dangerColor;
  }

  Color _getMemberStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUtilizationColor(int utilization) {
    if (utilization >= 90) return warningColor;
    if (utilization >= 70) return successColor;
    return infoColor;
  }

  Color _getMilestoneStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMilestoneIcon(String status) {
    switch (status) {
      case "Completed":
        return Icons.check_circle;
      case "In Progress":
        return Icons.schedule;
      case "Pending":
        return Icons.pending;
      default:
        return Icons.help;
    }
  }
}
