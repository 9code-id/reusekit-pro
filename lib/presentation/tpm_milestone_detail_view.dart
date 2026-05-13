import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmMilestoneDetailView extends StatefulWidget {
  const TpmMilestoneDetailView({super.key});

  @override
  State<TpmMilestoneDetailView> createState() => _TpmMilestoneDetailViewState();
}

class _TpmMilestoneDetailViewState extends State<TpmMilestoneDetailView> {
  Map<String, dynamic> milestone = {
    "id": 1,
    "title": "Phase 1 Completion",
    "description": "Complete all core features for phase 1 including user authentication, data management, and basic UI components. This milestone represents the foundation of our application.",
    "status": "in_progress",
    "progress": 75,
    "dueDate": "2025-06-25",
    "startDate": "2025-05-01",
    "project": "Mobile App Development",
    "assignedTo": "Development Team",
    "priority": "high",
    "budget": 50000.0,
    "spent": 37500.0,
    "color": warningColor,
    "createdBy": "John Doe",
    "createdAt": "2025-04-15",
    "lastUpdated": "2025-06-15",
  };

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "User Authentication System",
      "description": "Implement login, registration, and password reset",
      "status": "completed",
      "progress": 100,
      "assignee": "Alice Johnson",
      "priority": "high",
      "dueDate": "2025-05-20",
      "timeSpent": 40,
      "estimatedTime": 40,
    },
    {
      "id": 2,
      "title": "Database Schema Design",
      "description": "Design and implement core database tables",
      "status": "completed",
      "progress": 100,
      "assignee": "Bob Smith",
      "priority": "high",
      "dueDate": "2025-05-15",
      "timeSpent": 32,
      "estimatedTime": 30,
    },
    {
      "id": 3,
      "title": "API Development",
      "description": "Create RESTful APIs for data operations",
      "status": "in_progress",
      "progress": 80,
      "assignee": "Charlie Brown",
      "priority": "medium",
      "dueDate": "2025-06-10",
      "timeSpent": 35,
      "estimatedTime": 45,
    },
    {
      "id": 4,
      "title": "UI Components Library",
      "description": "Build reusable UI components",
      "status": "in_progress",
      "progress": 60,
      "assignee": "Diana Wilson",
      "priority": "medium",
      "dueDate": "2025-06-20",
      "timeSpent": 28,
      "estimatedTime": 50,
    },
    {
      "id": 5,
      "title": "Testing Framework Setup",
      "description": "Setup unit and integration testing",
      "status": "pending",
      "progress": 0,
      "assignee": "Eve Davis",
      "priority": "low",
      "dueDate": "2025-06-25",
      "timeSpent": 0,
      "estimatedTime": 25,
    },
  ];

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "author": "John Doe",
      "content": "Great progress on the authentication system. The implementation looks solid.",
      "timestamp": "2025-06-10 14:30",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
    },
    {
      "id": 2,
      "author": "Alice Johnson",
      "content": "Authentication module is complete and tested. Moving on to API integration.",
      "timestamp": "2025-06-08 09:15",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=person",
    },
    {
      "id": 3,
      "author": "Project Manager",
      "content": "We might need to adjust the timeline for the UI components. The complexity is higher than expected.",
      "timestamp": "2025-06-05 16:45",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=person",
    },
  ];

  String newComment = "";
  int selectedTab = 0;

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
        return "Normal";
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
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewTab() {
    double budgetProgress = ((milestone["spent"] as double) / (milestone["budget"] as double)) * 100;
    int completedTasks = tasks.where((task) => task["status"] == "completed").length;
    int totalTasks = tasks.length;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Milestone Info
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
                        "${milestone["title"]}",
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
                        color: getStatusColor(milestone["status"]).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        getStatusText(milestone["status"]),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: getStatusColor(milestone["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${milestone["description"]}",
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
                            "Project",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${milestone["project"]}",
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
                            "Priority",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: getPriorityColor(milestone["priority"]).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              getPriorityText(milestone["priority"]),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: getPriorityColor(milestone["priority"]),
                              ),
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
                            "Start Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(milestone["startDate"]).dMMMy}",
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
                            "Due Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(milestone["dueDate"]).dMMMy}",
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

          // Progress Overview
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
                  "Progress Overview",
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
                        spacing: spXs,
                        children: [
                          Text(
                            "Overall Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${milestone["progress"]}%",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          LinearProgressIndicator(
                            value: (milestone["progress"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spLg),
                    Expanded(
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Tasks Completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "$completedTasks/$totalTasks",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          LinearProgressIndicator(
                            value: completedTasks / totalTasks,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(successColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                            "\$${(milestone["budget"] as double).currency}",
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
                            "Spent",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${(milestone["spent"] as double).currency}",
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
                            "\$${((milestone["budget"] as double) - (milestone["spent"] as double)).currency}",
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
                          "Budget Usage: ${budgetProgress.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: budgetProgress / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        budgetProgress > 80 ? dangerColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ...tasks.map((task) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getStatusColor(task["status"]),
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
                          "${task["title"]}",
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
                          color: getStatusColor(task["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          getStatusText(task["status"]),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(task["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${task["description"]}",
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: getPriorityColor(task["priority"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          getPriorityText(task["priority"]),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: getPriorityColor(task["priority"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Time: ${task["timeSpent"]}h / ${task["estimatedTime"]}h",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                            "Progress: ${task["progress"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: (task["progress"] as int) / 100,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getStatusColor(task["status"]),
                        ),
                      ),
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

  Widget _buildCommentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Comment Section
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
                QMemoField(
                  label: "Add a comment",
                  value: newComment,
                  hint: "Share your thoughts or updates...",
                  onChanged: (value) {
                    newComment = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Spacer(),
                    QButton(
                      label: "Post Comment",
                      size: bs.sm,
                      onPressed: () {
                        if (newComment.isNotEmpty) {
                          // Add comment logic here
                          newComment = "";
                          setState(() {});
                          ss("Comment posted successfully");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Comments List
          ...comments.map((comment) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "${comment["avatar"]}",
                      width: 40,
                      height: 40,
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
                            Text(
                              "${comment["author"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${DateTime.parse(comment["timestamp"]).dMMMykkss}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${comment["content"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Milestone Details",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Tasks", icon: Icon(Icons.task)),
        Tab(text: "Comments", icon: Icon(Icons.comment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTasksTab(),
        _buildCommentsTab(),
      ],
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            //navigateTo TpmCreateMilestoneView with edit mode
          },
        ),
      ],
    );
  }
}
