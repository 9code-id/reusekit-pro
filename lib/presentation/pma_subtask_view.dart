import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaSubtaskView extends StatefulWidget {
  const PmaSubtaskView({super.key});

  @override
  State<PmaSubtaskView> createState() => _PmaSubtaskViewState();
}

class _PmaSubtaskViewState extends State<PmaSubtaskView> {
  String selectedProject = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool showCompleted = true;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
  ];

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Status", "value": "all"},
    {"label": "To Do", "value": "todo"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Review", "value": "review"},
    {"label": "Done", "value": "done"},
    {"label": "Blocked", "value": "blocked"},
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
      "estimatedHours": 24,
      "completedHours": 16,
      "subtasks": [
        {
          "id": "1-1",
          "title": "Create Login Screen Mockup",
          "description": "Design login screen with modern UI elements",
          "status": "done",
          "priority": "high",
          "assignee": "John Doe",
          "dueDate": "2024-12-20",
          "estimatedHours": 4,
          "actualHours": 5,
          "completedDate": "2024-12-19",
          "tags": ["UI", "Design"],
        },
        {
          "id": "1-2",
          "title": "Design Dashboard Layout",
          "description": "Create comprehensive dashboard with data visualization",
          "status": "in_progress",
          "priority": "high",
          "assignee": "John Doe",
          "dueDate": "2024-12-22",
          "estimatedHours": 8,
          "actualHours": 6,
          "tags": ["UI", "Dashboard"],
        },
        {
          "id": "1-3",
          "title": "Create Navigation Menu",
          "description": "Design responsive navigation for mobile app",
          "status": "todo",
          "priority": "medium",
          "assignee": "John Doe",
          "dueDate": "2024-12-24",
          "estimatedHours": 6,
          "actualHours": 0,
          "tags": ["UI", "Navigation"],
        },
        {
          "id": "1-4",
          "title": "Design User Profile Page",
          "description": "Create user profile management interface",
          "status": "todo",
          "priority": "medium",
          "assignee": "John Doe",
          "dueDate": "2024-12-26",
          "estimatedHours": 6,
          "actualHours": 0,
          "tags": ["UI", "Profile"],
        },
      ],
    },
    {
      "id": "2",
      "title": "Backend API Development",
      "project": "Website Development",
      "status": "in_progress",
      "priority": "critical",
      "assignee": "Mike Johnson",
      "dueDate": "2024-12-30",
      "progress": 45,
      "estimatedHours": 40,
      "completedHours": 18,
      "subtasks": [
        {
          "id": "2-1",
          "title": "Setup Database Schema",
          "description": "Create and configure PostgreSQL database",
          "status": "done",
          "priority": "critical",
          "assignee": "Mike Johnson",
          "dueDate": "2024-12-18",
          "estimatedHours": 8,
          "actualHours": 10,
          "completedDate": "2024-12-17",
          "tags": ["Database", "Setup"],
        },
        {
          "id": "2-2",
          "title": "Implement Authentication API",
          "description": "Build user authentication endpoints",
          "status": "done",
          "priority": "critical",
          "assignee": "Mike Johnson",
          "dueDate": "2024-12-20",
          "estimatedHours": 12,
          "actualHours": 8,
          "completedDate": "2024-12-19",
          "tags": ["API", "Auth"],
        },
        {
          "id": "2-3",
          "title": "Create User Management Endpoints",
          "description": "Build CRUD operations for user management",
          "status": "in_progress",
          "priority": "high",
          "assignee": "Mike Johnson",
          "dueDate": "2024-12-25",
          "estimatedHours": 10,
          "actualHours": 0,
          "tags": ["API", "CRUD"],
        },
        {
          "id": "2-4",
          "title": "Implement Data Analytics API",
          "description": "Create endpoints for analytics dashboard",
          "status": "blocked",
          "priority": "medium",
          "assignee": "Mike Johnson",
          "dueDate": "2024-12-28",
          "estimatedHours": 10,
          "actualHours": 0,
          "tags": ["API", "Analytics"],
        },
      ],
    },
    {
      "id": "3",
      "title": "Marketing Campaign Setup",
      "project": "Marketing Campaign",
      "status": "todo",
      "priority": "medium",
      "assignee": "Emma Davis",
      "dueDate": "2025-01-15",
      "progress": 15,
      "estimatedHours": 32,
      "completedHours": 5,
      "subtasks": [
        {
          "id": "3-1",
          "title": "Market Research Analysis",
          "description": "Conduct competitive analysis and market research",
          "status": "done",
          "priority": "high",
          "assignee": "Emma Davis",
          "dueDate": "2024-12-15",
          "estimatedHours": 8,
          "actualHours": 5,
          "completedDate": "2024-12-14",
          "tags": ["Research", "Analysis"],
        },
        {
          "id": "3-2",
          "title": "Create Marketing Content",
          "description": "Develop blog posts, social media content",
          "status": "todo",
          "priority": "medium",
          "assignee": "Emma Davis",
          "dueDate": "2024-12-30",
          "estimatedHours": 12,
          "actualHours": 0,
          "tags": ["Content", "Writing"],
        },
        {
          "id": "3-3",
          "title": "Design Marketing Materials",
          "description": "Create banners, infographics, and promotional materials",
          "status": "todo",
          "priority": "medium",
          "assignee": "Emma Davis",
          "dueDate": "2025-01-05",
          "estimatedHours": 12,
          "actualHours": 0,
          "tags": ["Design", "Graphics"],
        },
      ],
    },
  ];

  String newSubtaskTitle = "";
  String newSubtaskDescription = "";
  String newSubtaskPriority = "medium";
  DateTime? newSubtaskDueDate = DateTime.now().add(Duration(days: 3));
  String newSubtaskEstimatedHours = "4";

  List<Map<String, dynamic>> priorityItems = [
    {"label": "Low", "value": "low"},
    {"label": "Medium", "value": "medium"},
    {"label": "High", "value": "high"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          (task["title"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "all" || 
          (task["project"] as String).toLowerCase().contains(selectedProject.split('_').join(' ').toLowerCase());
          
      bool hasMatchingSubtask = selectedStatus == "all" || 
          (task["subtasks"] as List).any((subtask) => subtask["status"] == selectedStatus);
          
      bool matchesStatus = showCompleted || task["status"] != "done";
      
      return matchesSearch && matchesProject && hasMatchingSubtask && matchesStatus;
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

  void _toggleSubtaskStatus(String taskId, String subtaskId) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    setState(() {
      int taskIndex = tasks.indexWhere((task) => task["id"] == taskId);
      if (taskIndex != -1) {
        List<Map<String, dynamic>> subtasks = tasks[taskIndex]["subtasks"] as List<Map<String, dynamic>>;
        int subtaskIndex = subtasks.indexWhere((subtask) => subtask["id"] == subtaskId);
        if (subtaskIndex != -1) {
          String currentStatus = subtasks[subtaskIndex]["status"] as String;
          if (currentStatus == "done") {
            subtasks[subtaskIndex]["status"] = "todo";
            subtasks[subtaskIndex].remove("completedDate");
          } else {
            subtasks[subtaskIndex]["status"] = "done";
            subtasks[subtaskIndex]["completedDate"] = DateTime.now().toIso8601String().split('T')[0];
          }
          
          // Update parent task progress
          int completedSubtasks = subtasks.where((s) => s["status"] == "done").length;
          int totalSubtasks = subtasks.length;
          tasks[taskIndex]["progress"] = ((completedSubtasks / totalSubtasks) * 100).round();
        }
      }
    });
    
    ss("Subtask status updated");
  }

  void _updateSubtaskStatus(String taskId, String subtaskId, String newStatus) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    setState(() {
      int taskIndex = tasks.indexWhere((task) => task["id"] == taskId);
      if (taskIndex != -1) {
        List<Map<String, dynamic>> subtasks = tasks[taskIndex]["subtasks"] as List<Map<String, dynamic>>;
        int subtaskIndex = subtasks.indexWhere((subtask) => subtask["id"] == subtaskId);
        if (subtaskIndex != -1) {
          subtasks[subtaskIndex]["status"] = newStatus;
          if (newStatus == "done") {
            subtasks[subtaskIndex]["completedDate"] = DateTime.now().toIso8601String().split('T')[0];
          } else {
            subtasks[subtaskIndex].remove("completedDate");
          }
          
          // Update parent task progress
          int completedSubtasks = subtasks.where((s) => s["status"] == "done").length;
          int totalSubtasks = subtasks.length;
          tasks[taskIndex]["progress"] = ((completedSubtasks / totalSubtasks) * 100).round();
        }
      }
    });
    
    ss("Subtask status updated to $newStatus");
  }

  void _deleteSubtask(String taskId, String subtaskId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this subtask?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      
      setState(() {
        int taskIndex = tasks.indexWhere((task) => task["id"] == taskId);
        if (taskIndex != -1) {
          List<Map<String, dynamic>> subtasks = tasks[taskIndex]["subtasks"] as List<Map<String, dynamic>>;
          subtasks.removeWhere((subtask) => subtask["id"] == subtaskId);
          
          // Update parent task progress
          if (subtasks.isNotEmpty) {
            int completedSubtasks = subtasks.where((s) => s["status"] == "done").length;
            int totalSubtasks = subtasks.length;
            tasks[taskIndex]["progress"] = ((completedSubtasks / totalSubtasks) * 100).round();
          } else {
            tasks[taskIndex]["progress"] = 0;
          }
        }
      });
      
      ss("Subtask deleted successfully");
    }
  }

  void _showAddSubtaskDialog(String taskId) {
    newSubtaskTitle = "";
    newSubtaskDescription = "";
    newSubtaskPriority = "medium";
    newSubtaskDueDate = DateTime.now().add(Duration(days: 3));
    newSubtaskEstimatedHours = "4";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Subtask"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spMd,
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Subtask Title",
                value: newSubtaskTitle,
                validator: Validator.required,
                onChanged: (value) {
                  newSubtaskTitle = value;
                },
              ),
              QMemoField(
                label: "Description",
                value: newSubtaskDescription,
                onChanged: (value) {
                  newSubtaskDescription = value;
                },
              ),
              QDropdownField(
                label: "Priority",
                items: priorityItems,
                value: newSubtaskPriority,
                onChanged: (value, label) {
                  newSubtaskPriority = value;
                },
              ),
              QDatePicker(
                label: "Due Date",
                value: newSubtaskDueDate!,
                onChanged: (value) {
                  newSubtaskDueDate = value;
                },
              ),
              QNumberField(
                label: "Estimated Hours",
                value: newSubtaskEstimatedHours,
                onChanged: (value) {
                  newSubtaskEstimatedHours = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add Subtask",
            size: bs.sm,
            onPressed: () {
              if (newSubtaskTitle.isNotEmpty) {
                Navigator.pop(context);
                _addSubtask(taskId);
              }
            },
          ),
        ],
      ),
    );
  }

  void _addSubtask(String taskId) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    setState(() {
      int taskIndex = tasks.indexWhere((task) => task["id"] == taskId);
      if (taskIndex != -1) {
        List<Map<String, dynamic>> subtasks = tasks[taskIndex]["subtasks"] as List<Map<String, dynamic>>;
        String newId = "$taskId-${subtasks.length + 1}";
        
        subtasks.add({
          "id": newId,
          "title": newSubtaskTitle,
          "description": newSubtaskDescription,
          "status": "todo",
          "priority": newSubtaskPriority,
          "assignee": tasks[taskIndex]["assignee"],
          "dueDate": newSubtaskDueDate!.toIso8601String().split('T')[0],
          "estimatedHours": int.tryParse(newSubtaskEstimatedHours) ?? 4,
          "actualHours": 0,
          "tags": ["New"],
        });
      }
    });
    
    ss("Subtask added successfully");
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    List<Map<String, dynamic>> subtasks = task["subtasks"] as List<Map<String, dynamic>>;
    int completedSubtasks = subtasks.where((s) => s["status"] == "done").length;
    int totalSubtasks = subtasks.length;
    
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

          // Progress Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Progress: ${task["progress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
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
                ),
                SizedBox(width: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Subtasks: $completedSubtasks/$totalSubtasks",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Subtasks Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.checklist,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Subtasks (${subtasks.length})",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _showAddSubtaskDialog(task["id"] as String),
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
                if (subtasks.isNotEmpty) ...[
                  ...subtasks.map((subtask) => _buildSubtaskItem(task["id"] as String, subtask)).toList(),
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
                          Icons.checklist,
                          color: disabledBoldColor,
                          size: 24,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "No Subtasks",
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

  Widget _buildSubtaskItem(String taskId, Map<String, dynamic> subtask) {
    bool isCompleted = subtask["status"] == "done";
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _toggleSubtaskStatus(taskId, subtask["id"] as String),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isCompleted ? successColor : Colors.transparent,
                    border: Border.all(
                      color: isCompleted ? successColor : disabledBoldColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: isCompleted
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12,
                        )
                      : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${subtask["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isCompleted ? disabledBoldColor : primaryColor,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if ((subtask["description"] as String).isNotEmpty) ...[
                      SizedBox(height: spXs),
                      Text(
                        "${subtask["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledBoldColor,
                  size: 16,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      //navigateTo(PmaEditSubtaskView(subtaskId: subtask["id"]))
                      break;
                    case 'delete':
                      _deleteSubtask(taskId, subtask["id"] as String);
                      break;
                    case 'todo':
                    case 'in_progress':
                    case 'review':
                    case 'done':
                    case 'blocked':
                      _updateSubtaskStatus(taskId, subtask["id"] as String, value);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                  PopupMenuDivider(),
                  PopupMenuItem(value: 'todo', child: Text('To Do')),
                  PopupMenuItem(value: 'in_progress', child: Text('In Progress')),
                  PopupMenuItem(value: 'review', child: Text('Review')),
                  PopupMenuItem(value: 'done', child: Text('Done')),
                  PopupMenuItem(value: 'blocked', child: Text('Blocked')),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(subtask["status"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${subtask["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(subtask["status"] as String),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(subtask["priority"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${subtask["priority"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getPriorityColor(subtask["priority"] as String),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${subtask["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Due: ${DateTime.parse(subtask["dueDate"] as String).dMMMy}",
                style: TextStyle(
                  fontSize: 10,
                  color: warningColor,
                ),
              ),
            ],
          ),
          if ((subtask["tags"] as List).isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (subtask["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
          if (subtask["completedDate"] != null) ...[
            Text(
              "Completed: ${DateTime.parse(subtask["completedDate"] as String).dMMMy}",
              style: TextStyle(
                fontSize: 10,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, int count, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
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
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalSubtasks = filteredTasks.fold(0, (sum, task) => sum + (task["subtasks"] as List).length);
    int completedSubtasks = filteredTasks.fold(0, (sum, task) => 
        sum + (task["subtasks"] as List).where((s) => s["status"] == "done").length);
    int inProgressSubtasks = filteredTasks.fold(0, (sum, task) => 
        sum + (task["subtasks"] as List).where((s) => s["status"] == "in_progress").length);
    int blockedSubtasks = filteredTasks.fold(0, (sum, task) => 
        sum + (task["subtasks"] as List).where((s) => s["status"] == "blocked").length);

    return Scaffold(
      appBar: AppBar(
        title: Text("Subtask Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo(PmaSubtaskAnalyticsView())
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
                _buildSummaryCard("Total Subtasks", totalSubtasks, primaryColor, "All subtasks"),
                _buildSummaryCard("Completed", completedSubtasks, successColor, "Finished subtasks"),
                _buildSummaryCard("In Progress", inProgressSubtasks, infoColor, "Active subtasks"),
                _buildSummaryCard("Blocked", blockedSubtasks, dangerColor, "Blocked subtasks"),
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
                          label: "Subtask Status",
                          items: statusFilters,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
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

            // Tasks with Subtasks
            Text(
              "Tasks with Subtasks (${filteredTasks.length})",
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
                      Icons.checklist,
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
                      "Try adjusting your filters to see tasks with subtasks",
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
