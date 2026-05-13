import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline5View extends StatefulWidget {
  @override
  State<GrlTimeline5View> createState() => _GrlTimeline5ViewState();
}

class _GrlTimeline5ViewState extends State<GrlTimeline5View> {
  List<Map<String, dynamic>> projectMilestones = [
    {
      "id": "1",
      "title": "Project Kickoff",
      "description": "Initial project setup and team assignment",
      "date": "2024-01-01",
      "status": "completed",
      "progress": 100,
      "assignees": [
        {"name": "Alice", "avatar": "https://picsum.photos/30/30?random=1&keyword=person"},
        {"name": "Bob", "avatar": "https://picsum.photos/30/30?random=2&keyword=person"}
      ],
      "tasks": 5,
      "completedTasks": 5
    },
    {
      "id": "2", 
      "title": "Requirements Analysis",
      "description": "Gather and document all project requirements",
      "date": "2024-01-15",
      "status": "completed",
      "progress": 100,
      "assignees": [
        {"name": "Charlie", "avatar": "https://picsum.photos/30/30?random=3&keyword=person"},
        {"name": "Diana", "avatar": "https://picsum.photos/30/30?random=4&keyword=person"}
      ],
      "tasks": 8,
      "completedTasks": 8
    },
    {
      "id": "3",
      "title": "UI/UX Design",
      "description": "Create wireframes and design system",
      "date": "2024-02-01",
      "status": "in_progress",
      "progress": 75,
      "assignees": [
        {"name": "Eve", "avatar": "https://picsum.photos/30/30?random=5&keyword=person"},
        {"name": "Frank", "avatar": "https://picsum.photos/30/30?random=6&keyword=person"}
      ],
      "tasks": 12,
      "completedTasks": 9
    },
    {
      "id": "4",
      "title": "Backend Development",
      "description": "Develop APIs and database architecture",
      "date": "2024-02-15",
      "status": "in_progress",
      "progress": 40,
      "assignees": [
        {"name": "George", "avatar": "https://picsum.photos/30/30?random=7&keyword=person"},
        {"name": "Helen", "avatar": "https://picsum.photos/30/30?random=8&keyword=person"}
      ],
      "tasks": 15,
      "completedTasks": 6
    },
    {
      "id": "5",
      "title": "Frontend Development",
      "description": "Build user interface and integrate with APIs",
      "date": "2024-03-01",
      "status": "pending",
      "progress": 0,
      "assignees": [
        {"name": "Ian", "avatar": "https://picsum.photos/30/30?random=9&keyword=person"},
        {"name": "Jane", "avatar": "https://picsum.photos/30/30?random=10&keyword=person"}
      ],
      "tasks": 20,
      "completedTasks": 0
    },
    {
      "id": "6",
      "title": "Testing & QA",
      "description": "Comprehensive testing and quality assurance",
      "date": "2024-03-20",
      "status": "pending",
      "progress": 0,
      "assignees": [
        {"name": "Kevin", "avatar": "https://picsum.photos/30/30?random=11&keyword=person"}
      ],
      "tasks": 10,
      "completedTasks": 0
    },
    {
      "id": "7",
      "title": "Deployment",
      "description": "Deploy to production and monitor",
      "date": "2024-04-01",
      "status": "pending",
      "progress": 0,
      "assignees": [
        {"name": "Lisa", "avatar": "https://picsum.photos/30/30?random=12&keyword=person"}
      ],
      "tasks": 3,
      "completedTasks": 0
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
      default:
        return "Pending";
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "in_progress":
        return Icons.access_time;
      case "pending":
      default:
        return Icons.radio_button_unchecked;
    }
  }

  String _formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.timeline,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile App Development",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Q1 2024 Project Timeline",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overall Progress",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: 0.45,
                              backgroundColor: Colors.white.withAlpha(60),
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "45%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Project Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "2",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Timeline Milestones
            Text(
              "Project Milestones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...projectMilestones.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> milestone = entry.value;
              bool isLast = index == projectMilestones.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Indicator
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getStatusColor("${milestone["status"]}"),
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                          ),
                          child: Icon(
                            _getStatusIcon("${milestone["status"]}"),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 3,
                            height: 80,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: spXs),
                          ),
                      ],
                    ),

                    SizedBox(width: spMd),

                    // Milestone Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: _getStatusColor("${milestone["status"]}").withAlpha(60),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Milestone Header
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${milestone["title"]}",
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
                                    color: _getStatusColor("${milestone["status"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    _getStatusText("${milestone["status"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${milestone["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spXs),

                            // Date
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  _formatDate("${milestone["date"]}"),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Description
                            Text(
                              "${milestone["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Progress Bar
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Progress",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${milestone["progress"]}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: _getStatusColor("${milestone["status"]}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      LinearProgressIndicator(
                                        value: (milestone["progress"] as int) / 100,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          _getStatusColor("${milestone["status"]}"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spMd),

                            // Tasks and Assignees
                            Row(
                              children: [
                                // Task Count
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${milestone["completedTasks"]}/${milestone["tasks"]} tasks",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),

                                Spacer(),

                                // Assignees
                                Row(
                                  children: [
                                    ...(milestone["assignees"] as List).take(3).map((assignee) {
                                      return Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundImage: NetworkImage("${assignee["avatar"]}"),
                                        ),
                                      );
                                    }).toList(),
                                    if ((milestone["assignees"] as List).length > 3)
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.grey.shade300,
                                          child: Text(
                                            "+${(milestone["assignees"] as List).length - 3}",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
