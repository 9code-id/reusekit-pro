import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOverview7View extends StatefulWidget {
  @override
  State<GrlOverview7View> createState() => _GrlOverview7ViewState();
}

class _GrlOverview7ViewState extends State<GrlOverview7View> {
  List<Map<String, dynamic>> projectStats = [
    {
      "title": "Active Projects",
      "value": 24,
      "change": 12.5,
      "color": Colors.blue,
      "icon": Icons.work,
      "subtitle": "In Progress"
    },
    {
      "title": "Completed Tasks",
      "value": 156,
      "change": 8.3,
      "color": Colors.green,
      "icon": Icons.task_alt,
      "subtitle": "This Month"
    },
    {
      "title": "Team Members",
      "value": 32,
      "change": 3.2,
      "color": Colors.purple,
      "icon": Icons.people,
      "subtitle": "Active Users"
    },
    {
      "title": "Deadlines",
      "value": 7,
      "change": -2.1,
      "color": Colors.orange,
      "icon": Icons.schedule,
      "subtitle": "This Week"
    },
  ];

  List<Map<String, dynamic>> recentProjects = [
    {
      "name": "Mobile App Redesign",
      "progress": 75,
      "dueDate": "2024-02-15",
      "team": ["John", "Sarah", "Mike"],
      "priority": "High",
      "status": "In Progress",
      "tasks": 24,
      "completedTasks": 18
    },
    {
      "name": "Website Development",
      "progress": 45,
      "dueDate": "2024-03-01",
      "team": ["Alice", "Bob", "Carol"],
      "priority": "Medium",
      "status": "In Progress",
      "tasks": 32,
      "completedTasks": 14
    },
    {
      "name": "Marketing Campaign",
      "progress": 90,
      "dueDate": "2024-01-30",
      "team": ["David", "Emma"],
      "priority": "High",
      "status": "Review",
      "tasks": 18,
      "completedTasks": 16
    },
    {
      "name": "Database Migration",
      "progress": 20,
      "dueDate": "2024-03-15",
      "team": ["Frank", "Grace", "Henry", "Ivy"],
      "priority": "Low",
      "status": "Planning",
      "tasks": 28,
      "completedTasks": 6
    },
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "title": "Code Review Session",
      "project": "Mobile App Redesign",
      "assignee": "John Doe",
      "dueTime": "2:00 PM",
      "priority": "High"
    },
    {
      "title": "Client Meeting",
      "project": "Website Development",
      "assignee": "Sarah Johnson",
      "dueTime": "4:30 PM",
      "priority": "Medium"
    },
    {
      "title": "Testing Phase",
      "project": "Marketing Campaign",
      "assignee": "Mike Brown",
      "dueTime": "Tomorrow",
      "priority": "High"
    },
    {
      "title": "Documentation Update",
      "project": "Database Migration",
      "assignee": "Alice Wilson",
      "dueTime": "Friday",
      "priority": "Low"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Project Dashboard",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Track your team's progress and deliverables",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "15% increase in productivity",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Project Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: projectStats.map((stat) {
                return Container(
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(50),
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
                              color: (stat["change"] as double) >= 0 
                                  ? successColor.withAlpha(50)
                                  : dangerColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (stat["change"] as double) >= 0 
                                      ? Icons.trending_up 
                                      : Icons.trending_down,
                                  size: 12,
                                  color: (stat["change"] as double) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(stat["change"] as double) >= 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (stat["change"] as double) >= 0 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["subtitle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Recent Projects
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Active Projects",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
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
                      Color priorityColor = _getPriorityColor("${project["priority"]}");
                      Color statusColor = _getStatusColor("${project["status"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${project["name"]}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${project["priority"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: priorityColor,
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
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Container(
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: disabledColor.withAlpha(100),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (project["progress"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: statusColor,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Due: ${project["dueDate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${project["completedTasks"]}/${project["tasks"]} tasks",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: (project["team"] as List).take(3).map((member) {
                                    return Container(
                                      margin: EdgeInsets.only(right: spXs),
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: _getAvatarColor("$member"),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "$member".substring(0, 1).toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                if ((project["team"] as List).length > 3)
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+${(project["team"] as List).length - 3}",
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${project["status"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
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

            // Upcoming Tasks
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upcoming Tasks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: upcomingTasks.map((task) {
                      Color priorityColor = _getPriorityColor("${task["priority"]}");
                      
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: priorityColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.task,
                                color: priorityColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${task["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${task["project"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Assigned to: ${task["assignee"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${task["dueTime"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${task["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: priorityColor,
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

            // Action Buttons
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
                    label: "Team View",
                    icon: Icons.people,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return infoColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return infoColor;
      case 'review':
        return warningColor;
      case 'completed':
        return successColor;
      case 'planning':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Color _getAvatarColor(String name) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    return colors[name.hashCode % colors.length];
  }
}
