import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress5View extends StatefulWidget {
  @override
  State<GrlProgress5View> createState() => _GrlProgress5ViewState();
}

class _GrlProgress5ViewState extends State<GrlProgress5View> {
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Development", "value": "development"},
    {"label": "Design", "value": "design"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Testing", "value": "testing"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Implement User Authentication",
      "description": "Set up login and registration system with security measures",
      "progress": 85,
      "category": "development",
      "priority": "High",
      "assignee": "John Doe",
      "dueDate": "2024-02-15",
      "subtasks": [
        {"name": "Design login UI", "completed": true},
        {"name": "Backend API", "completed": true},
        {"name": "Password encryption", "completed": false},
        {"name": "Testing", "completed": false},
      ]
    },
    {
      "id": 2,
      "title": "Create Landing Page Design",
      "description": "Design responsive landing page with modern UI/UX principles",
      "progress": 60,
      "category": "design",
      "priority": "Medium",
      "assignee": "Sarah Smith",
      "dueDate": "2024-02-18",
      "subtasks": [
        {"name": "Wireframes", "completed": true},
        {"name": "Visual design", "completed": true},
        {"name": "Responsive layout", "completed": false},
        {"name": "Final review", "completed": false},
      ]
    },
    {
      "id": 3,
      "title": "API Integration Testing",
      "description": "Comprehensive testing of all API endpoints and error handling",
      "progress": 30,
      "category": "testing",
      "priority": "High",
      "assignee": "Mike Johnson",
      "dueDate": "2024-02-20",
      "subtasks": [
        {"name": "Unit tests", "completed": true},
        {"name": "Integration tests", "completed": false},
        {"name": "Performance tests", "completed": false},
        {"name": "Documentation", "completed": false},
      ]
    },
    {
      "id": 4,
      "title": "Social Media Campaign",
      "description": "Launch awareness campaign across multiple social platforms",
      "progress": 75,
      "category": "marketing",
      "priority": "Low",
      "assignee": "Emma Wilson",
      "dueDate": "2024-02-25",
      "subtasks": [
        {"name": "Content creation", "completed": true},
        {"name": "Platform setup", "completed": true},
        {"name": "Scheduling posts", "completed": true},
        {"name": "Analytics setup", "completed": false},
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      final matchesCategory = selectedCategory == "all" || task["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search tasks...",
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

            // Category Filter
            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Progress Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Overall Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildOverviewCard(
                          "Total Tasks",
                          "${filteredTasks.length}",
                          Icons.assignment,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "Completed",
                          "${_getCompletedCount()}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildOverviewCard(
                          "In Progress",
                          "${_getInProgressCount()}",
                          Icons.schedule,
                          warningColor,
                        ),
                      ),
                    ],
                  ),

                  // Overall Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Overall Completion",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${_getOverallProgress().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: _getOverallProgress() / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        minHeight: 8,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Task List
            Column(
              spacing: spSm,
              children: List.generate(
                filteredTasks.length,
                (index) => _buildTaskCard(filteredTasks[index]),
              ),
            ),

            if (filteredTasks.isEmpty)
              Container(
                padding: EdgeInsets.all(sp2xl),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "No tasks found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final completedSubtasks = (task["subtasks"] as List).where((sub) => sub["completed"] as bool).length;
    final totalSubtasks = (task["subtasks"] as List).length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Task Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${task["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${task["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task["priority"]),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${task["progress"]}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: (task["progress"] as num) / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                minHeight: 6,
              ),
            ],
          ),

          // Subtasks
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtasks",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "$completedSubtasks/$totalSubtasks completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                Column(
                  spacing: spXs,
                  children: List.generate(
                    (task["subtasks"] as List).length,
                    (index) {
                      final subtask = (task["subtasks"] as List)[index];
                      return Row(
                        children: [
                          Icon(
                            subtask["completed"] ? Icons.check_circle : Icons.radio_button_unchecked,
                            size: 16,
                            color: subtask["completed"] ? successColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${subtask["name"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: subtask["completed"] ? disabledBoldColor : primaryColor,
                                decoration: subtask["completed"] ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Task Footer
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
                "Due: ${DateTime.parse(task["dueDate"]).day}/${DateTime.parse(task["dueDate"]).month}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
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

  int _getCompletedCount() {
    return filteredTasks.where((task) => (task["progress"] as num) >= 100).length;
  }

  int _getInProgressCount() {
    return filteredTasks.where((task) => (task["progress"] as num) > 0 && (task["progress"] as num) < 100).length;
  }

  double _getOverallProgress() {
    if (filteredTasks.isEmpty) return 0.0;
    
    final totalProgress = filteredTasks
        .map((task) => task["progress"] as num)
        .fold(0.0, (sum, progress) => sum + progress.toDouble());
    
    return totalProgress / filteredTasks.length;
  }
}
