import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskDependenciesView extends StatefulWidget {
  const PmaTaskDependenciesView({super.key});

  @override
  State<PmaTaskDependenciesView> createState() => _PmaTaskDependenciesViewState();
}

class _PmaTaskDependenciesViewState extends State<PmaTaskDependenciesView> {
  String selectedProject = "all";
  String selectedDependencyType = "all";
  String searchQuery = "";
  bool showCompleted = false;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
  ];

  List<Map<String, dynamic>> dependencyTypes = [
    {"label": "All Dependencies", "value": "all"},
    {"label": "Blocking", "value": "blocking"},
    {"label": "Blocked By", "value": "blocked_by"},
    {"label": "Related To", "value": "related"},
    {"label": "Waiting For", "value": "waiting"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "1",
      "title": "Design User Interface",
      "project": "Mobile App Redesign",
      "status": "in_progress",
      "priority": "high",
      "assignee": "John Doe",
      "dueDate": "2024-12-25",
      "progress": 65,
      "dependencies": [
        {
          "taskId": "2",
          "taskTitle": "Complete User Research",
          "type": "blocked_by",
          "status": "done",
          "priority": "high",
          "dueDate": "2024-12-20",
          "progress": 100,
        },
        {
          "taskId": "3",
          "taskTitle": "Create Wireframes",
          "type": "blocking",
          "status": "todo",
          "priority": "medium",
          "dueDate": "2024-12-28",
          "progress": 0,
        },
      ],
    },
    {
      "id": "2",
      "title": "Complete User Research",
      "project": "Mobile App Redesign",
      "status": "done",
      "priority": "high",
      "assignee": "Sarah Smith",
      "dueDate": "2024-12-20",
      "progress": 100,
      "dependencies": [
        {
          "taskId": "1",
          "taskTitle": "Design User Interface",
          "type": "blocking",
          "status": "in_progress",
          "priority": "high",
          "dueDate": "2024-12-25",
          "progress": 65,
        },
        {
          "taskId": "4",
          "taskTitle": "User Testing Session",
          "type": "blocking",
          "status": "todo",
          "priority": "medium",
          "dueDate": "2024-12-30",
          "progress": 0,
        },
      ],
    },
    {
      "id": "3",
      "title": "Create Wireframes",
      "project": "Mobile App Redesign",
      "status": "todo",
      "priority": "medium",
      "assignee": "John Doe",
      "dueDate": "2024-12-28",
      "progress": 0,
      "dependencies": [
        {
          "taskId": "1",
          "taskTitle": "Design User Interface",
          "type": "blocked_by",
          "status": "in_progress",
          "priority": "high",
          "dueDate": "2024-12-25",
          "progress": 65,
        },
        {
          "taskId": "5",
          "taskTitle": "Frontend Implementation",
          "type": "blocking",
          "status": "todo",
          "priority": "high",
          "dueDate": "2025-01-05",
          "progress": 0,
        },
      ],
    },
    {
      "id": "4",
      "title": "User Testing Session",
      "project": "Mobile App Redesign",
      "status": "todo",
      "priority": "medium",
      "assignee": "Lisa Brown",
      "dueDate": "2024-12-30",
      "progress": 0,
      "dependencies": [
        {
          "taskId": "2",
          "taskTitle": "Complete User Research",
          "type": "blocked_by",
          "status": "done",
          "priority": "high",
          "dueDate": "2024-12-20",
          "progress": 100,
        },
        {
          "taskId": "5",
          "taskTitle": "Frontend Implementation",
          "type": "related",
          "status": "todo",
          "priority": "high",
          "dueDate": "2025-01-05",
          "progress": 0,
        },
      ],
    },
    {
      "id": "5",
      "title": "Frontend Implementation",
      "project": "Website Development",
      "status": "todo",
      "priority": "high",
      "assignee": "Mike Johnson",
      "dueDate": "2025-01-05",
      "progress": 0,
      "dependencies": [
        {
          "taskId": "3",
          "taskTitle": "Create Wireframes",
          "type": "blocked_by",
          "status": "todo",
          "priority": "medium",
          "dueDate": "2024-12-28",
          "progress": 0,
        },
        {
          "taskId": "6",
          "taskTitle": "Backend API Development",
          "type": "waiting",
          "status": "in_progress",
          "priority": "critical",
          "dueDate": "2024-12-30",
          "progress": 40,
        },
      ],
    },
    {
      "id": "6",
      "title": "Backend API Development",
      "project": "Website Development",
      "status": "in_progress",
      "priority": "critical",
      "assignee": "David Wilson",
      "dueDate": "2024-12-30",
      "progress": 40,
      "dependencies": [
        {
          "taskId": "5",
          "taskTitle": "Frontend Implementation",
          "type": "blocking",
          "status": "todo",
          "priority": "high",
          "dueDate": "2025-01-05",
          "progress": 0,
        },
        {
          "taskId": "7",
          "taskTitle": "Database Schema Design",
          "type": "blocked_by",
          "status": "done",
          "priority": "high",
          "dueDate": "2024-12-18",
          "progress": 100,
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          (task["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "all" || 
          (task["project"] as String).toLowerCase().contains(selectedProject.split('_').join(' ').toLowerCase());
          
      bool hasMatchingDependency = selectedDependencyType == "all" || 
          (task["dependencies"] as List).any((dep) => dep["type"] == selectedDependencyType);
          
      bool matchesStatus = showCompleted || task["status"] != "done";
      
      return matchesSearch && matchesProject && hasMatchingDependency && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'todo':
        return disabledBoldColor;
      case 'in_progress':
        return infoColor;
      case 'review':
        return warningColor;
      case 'done':
        return successColor;
      case 'blocked':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getDependencyTypeColor(String type) {
    switch (type) {
      case 'blocking':
        return dangerColor;
      case 'blocked_by':
        return warningColor;
      case 'waiting':
        return infoColor;
      case 'related':
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getDependencyTypeLabel(String type) {
    switch (type) {
      case 'blocking':
        return 'Blocking';
      case 'blocked_by':
        return 'Blocked By';
      case 'waiting':
        return 'Waiting For';
      case 'related':
        return 'Related To';
      default:
        return 'Unknown';
    }
  }

  IconData _getDependencyTypeIcon(String type) {
    switch (type) {
      case 'blocking':
        return Icons.block;
      case 'blocked_by':
        return Icons.pause_circle;
      case 'waiting':
        return Icons.hourglass_empty;
      case 'related':
        return Icons.link;
      default:
        return Icons.help;
    }
  }

  void _addDependency(String taskId) {
    //navigateTo(PmaAddDependencyView(taskId: taskId))
    ss("Navigate to Add Dependency view");
  }

  void _removeDependency(String taskId, String dependencyId) async {
    bool isConfirmed = await confirm("Are you sure you want to remove this dependency?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      ss("Dependency removed successfully");
    }
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    List<Map<String, dynamic>> dependencies = task["dependencies"] as List<Map<String, dynamic>>;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(task["priority"] as String),
          ),
        ),
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task Header
          Row(
            children: [
              Text(
                "#${task["id"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(task["status"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(task["status"] as String),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task["priority"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getPriorityColor(task["priority"] as String),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Task Info
          Text(
            "${task["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Icon(
                Icons.folder,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["project"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
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
            ],
          ),

          // Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Progress: ${task["progress"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: FractionallySizedBox(
                  widthFactor: (task["progress"] as int) / 100,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _getStatusColor(task["status"] as String),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Dependencies Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.device_hub,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Dependencies (${dependencies.length})",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _addDependency(task["id"] as String),
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                if (dependencies.isNotEmpty) ...[
                  ...dependencies.map((dependency) => _buildDependencyItem(task["id"] as String, dependency)).toList(),
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: disabledColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.device_hub,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "No Dependencies",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDependencyItem(String taskId, Map<String, dynamic> dependency) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: _getDependencyTypeColor(dependency["type"] as String).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              _getDependencyTypeIcon(dependency["type"] as String),
              color: _getDependencyTypeColor(dependency["type"] as String),
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${dependency["taskTitle"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getDependencyTypeColor(dependency["type"] as String).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        _getDependencyTypeLabel(dependency["type"] as String),
                        style: TextStyle(
                          color: _getDependencyTypeColor(dependency["type"] as String),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(dependency["status"] as String).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${dependency["status"]}".toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(dependency["status"] as String),
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "#${dependency["taskId"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${dependency["progress"]}%",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(dependency["status"] as String),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _removeDependency(taskId, dependency["taskId"] as String),
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(
                Icons.close,
                color: dangerColor,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$count",
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalDependencies = filteredTasks.fold(0, (sum, task) => sum + (task["dependencies"] as List).length);
    int blockingCount = filteredTasks.fold(0, (sum, task) => 
        sum + (task["dependencies"] as List).where((dep) => dep["type"] == "blocking").length);
    int blockedCount = filteredTasks.fold(0, (sum, task) => 
        sum + (task["dependencies"] as List).where((dep) => dep["type"] == "blocked_by").length);
    int waitingCount = filteredTasks.fold(0, (sum, task) => 
        sum + (task["dependencies"] as List).where((dep) => dep["type"] == "waiting").length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Dependencies"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo(PmaDependencyAnalyticsView())
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Total Dependencies", totalDependencies, primaryColor, Icons.device_hub),
                _buildSummaryCard("Blocking Others", blockingCount, dangerColor, Icons.block),
                _buildSummaryCard("Being Blocked", blockedCount, warningColor, Icons.pause_circle),
                _buildSummaryCard("Waiting For", waitingCount, infoColor, Icons.hourglass_empty),
              ],
            ),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search Tasks",
                          value: searchQuery,
                          hint: "Search by task title...",
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
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projects,
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QDropdownField(
                          label: "Dependency Type",
                          items: dependencyTypes,
                          value: selectedDependencyType,
                          onChanged: (value, label) {
                            selectedDependencyType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show Completed Tasks",
                        "value": true,
                        "checked": showCompleted,
                      }
                    ],
                    value: [
                      if (showCompleted)
                        {"label": "Show Completed Tasks", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showCompleted = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Tasks List
            Text(
              "Tasks with Dependencies (${filteredTasks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredTasks.map((task) => _buildTaskCard(task)).toList(),

            if (filteredTasks.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.device_hub,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Tasks Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters to see tasks with dependencies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
