import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskListView extends StatefulWidget {
  const TpmTaskListView({super.key});

  @override
  State<TpmTaskListView> createState() => _TpmTaskListViewState();
}

class _TpmTaskListViewState extends State<TpmTaskListView> {
  String selectedFilter = "all";
  String selectedSort = "created_desc";
  bool showCompleted = true;
  
  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Create user authentication system",
      "description": "Implement secure login and registration with JWT tokens and password encryption",
      "status": "in_progress",
      "priority": "high",
      "assignee": "John Doe",
      "assigneeAvatar": "https://picsum.photos/40/40?random=1",
      "reporter": "Mike Johnson",
      "createdAt": DateTime.now().subtract(Duration(days: 5)),
      "updatedAt": DateTime.now().subtract(Duration(hours: 3)),
      "dueDate": DateTime.now().add(Duration(days: 2)),
      "progress": 65,
      "tags": ["Backend", "Security"],
      "comments": 8,
      "attachments": 3,
      "subtasks": 5,
      "completedSubtasks": 3,
      "estimatedHours": 16,
      "loggedHours": 12,
    },
    {
      "id": 2,
      "title": "Design dashboard wireframes",
      "description": "Create low-fidelity wireframes for the main dashboard interface",
      "status": "todo",
      "priority": "medium",
      "assignee": "Jane Smith",
      "assigneeAvatar": "https://picsum.photos/40/40?random=2",
      "reporter": "Sarah Wilson",
      "createdAt": DateTime.now().subtract(Duration(days: 3)),
      "updatedAt": DateTime.now().subtract(Duration(days: 1)),
      "dueDate": DateTime.now().add(Duration(days: 5)),
      "progress": 0,
      "tags": ["Design", "UI/UX"],
      "comments": 3,
      "attachments": 1,
      "subtasks": 3,
      "completedSubtasks": 0,
      "estimatedHours": 8,
      "loggedHours": 0,
    },
    {
      "id": 3,
      "title": "Implement REST API endpoints",
      "description": "Develop CRUD operations for user management and data handling",
      "status": "in_progress",
      "priority": "high",
      "assignee": "Mike Johnson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=3",
      "reporter": "John Doe",
      "createdAt": DateTime.now().subtract(Duration(days: 7)),
      "updatedAt": DateTime.now().subtract(Duration(hours: 6)),
      "dueDate": DateTime.now().add(Duration(days: 3)),
      "progress": 40,
      "tags": ["Backend", "API"],
      "comments": 12,
      "attachments": 2,
      "subtasks": 8,
      "completedSubtasks": 3,
      "estimatedHours": 24,
      "loggedHours": 18,
    },
    {
      "id": 4,
      "title": "Setup database schema",
      "description": "Design and implement the database structure with proper relationships",
      "status": "done",
      "priority": "high",
      "assignee": "Tom Brown",
      "assigneeAvatar": "https://picsum.photos/40/40?random=4",
      "reporter": "Mike Johnson",
      "createdAt": DateTime.now().subtract(Duration(days: 10)),
      "updatedAt": DateTime.now().subtract(Duration(days: 2)),
      "dueDate": DateTime.now().subtract(Duration(days: 1)),
      "progress": 100,
      "tags": ["Database", "Schema"],
      "comments": 6,
      "attachments": 4,
      "subtasks": 4,
      "completedSubtasks": 4,
      "estimatedHours": 12,
      "loggedHours": 14,
    },
    {
      "id": 5,
      "title": "Write unit tests",
      "description": "Create comprehensive unit tests for all API endpoints and core functionality",
      "status": "todo",
      "priority": "medium",
      "assignee": "Sarah Wilson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=5",
      "reporter": "John Doe",
      "createdAt": DateTime.now().subtract(Duration(days: 2)),
      "updatedAt": DateTime.now().subtract(Duration(hours: 8)),
      "dueDate": DateTime.now().add(Duration(days: 7)),
      "progress": 0,
      "tags": ["Testing", "Quality"],
      "comments": 2,
      "attachments": 0,
      "subtasks": 6,
      "completedSubtasks": 0,
      "estimatedHours": 20,
      "loggedHours": 0,
    },
    {
      "id": 6,
      "title": "Performance optimization",
      "description": "Optimize database queries and improve application performance",
      "status": "review",
      "priority": "low",
      "assignee": "Mike Johnson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=3",
      "reporter": "Tom Brown",
      "createdAt": DateTime.now().subtract(Duration(days: 1)),
      "updatedAt": DateTime.now().subtract(Duration(hours: 2)),
      "dueDate": DateTime.now().add(Duration(days: 10)),
      "progress": 85,
      "tags": ["Performance", "Optimization"],
      "comments": 4,
      "attachments": 1,
      "subtasks": 3,
      "completedSubtasks": 2,
      "estimatedHours": 10,
      "loggedHours": 8,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tasks", "value": "all"},
    {"label": "Assigned to Me", "value": "assigned_to_me"},
    {"label": "Created by Me", "value": "created_by_me"},
    {"label": "High Priority", "value": "high_priority"},
    {"label": "Due Soon", "value": "due_soon"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Created (Newest)", "value": "created_desc"},
    {"label": "Created (Oldest)", "value": "created_asc"},
    {"label": "Due Date", "value": "due_date"},
    {"label": "Priority", "value": "priority"},
    {"label": "Progress", "value": "progress"},
    {"label": "Updated", "value": "updated"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createNewTask(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter",
                        items: filterOptions,
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: selectedSort,
                        onChanged: (value, label) {
                          selectedSort = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show Completed Tasks",
                            "value": true,
                            "checked": showCompleted,
                          }
                        ],
                        value: [if (showCompleted) {"label": "Show Completed Tasks", "value": true, "checked": true}],
                        onChanged: (values, ids) {
                          setState(() {
                            showCompleted = values.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    _buildTaskStats(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getFilteredTasks().length,
              itemBuilder: (context, index) {
                return _buildTaskItem(_getFilteredTasks()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStats() {
    List<Map<String, dynamic>> filteredTasks = _getFilteredTasks();
    int totalTasks = filteredTasks.length;
    int completedTasks = filteredTasks.where((task) => task["status"] == "done").length;
    int inProgressTasks = filteredTasks.where((task) => task["status"] == "in_progress").length;
    
    return Row(
      children: [
        _buildStatChip("Total", "$totalTasks", primaryColor),
        SizedBox(width: spSm),
        _buildStatChip("Done", "$completedTasks", successColor),
        SizedBox(width: spSm),
        _buildStatChip("Active", "$inProgressTasks", warningColor),
      ],
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    bool isOverdue = (task["dueDate"] as DateTime).isBefore(DateTime.now()) && task["status"] != "done";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
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
                    decoration: task["status"] == "done" ? TextDecoration.lineThrough : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  _getStatusLabel(task["status"]),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showTaskActions(task),
              ),
            ],
          ),
          if (task["description"] != null && task["description"].isNotEmpty)
            Text(
              "${task["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          if ((task["tags"] as List).isNotEmpty)
            QHorizontalScroll(
              children: (task["tags"] as List).map((tag) => Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              )).toList(),
            ),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${task["assigneeAvatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["assignee"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Reporter: ${task["reporter"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          if ((task["progress"] as int) > 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${task["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${task["completedSubtasks"]}/${task["subtasks"]} subtasks",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (task["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 4,
                ),
              ],
            ),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, size: 14, color: isOverdue ? dangerColor : disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Due: ${(task["dueDate"] as DateTime).dMMMy}",
                    style: TextStyle(
                      fontSize: 11,
                      color: isOverdue ? dangerColor : disabledBoldColor,
                      fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Spacer(),
              if ((task["comments"] as int) > 0) ...[
                Icon(Icons.comment, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${task["comments"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spMd),
              ],
              if ((task["attachments"] as int) > 0) ...[
                Icon(Icons.attach_file, size: 14, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${task["attachments"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spMd),
              ],
              Icon(Icons.access_time, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${task["loggedHours"]}h/${task["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (isOverdue)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: dangerColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: dangerColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "This task is overdue",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredTasks() {
    List<Map<String, dynamic>> filtered = List.from(tasks);
    
    // Apply show completed filter
    if (!showCompleted) {
      filtered = filtered.where((task) => task["status"] != "done").toList();
    }
    
    // Apply selected filter
    switch (selectedFilter) {
      case "assigned_to_me":
        filtered = filtered.where((task) => task["assignee"] == "John Doe").toList();
        break;
      case "created_by_me":
        filtered = filtered.where((task) => task["reporter"] == "John Doe").toList();
        break;
      case "high_priority":
        filtered = filtered.where((task) => task["priority"] == "high").toList();
        break;
      case "due_soon":
        DateTime threeDaysFromNow = DateTime.now().add(Duration(days: 3));
        filtered = filtered.where((task) => 
          (task["dueDate"] as DateTime).isBefore(threeDaysFromNow) && 
          task["status"] != "done"
        ).toList();
        break;
      case "overdue":
        filtered = filtered.where((task) => 
          (task["dueDate"] as DateTime).isBefore(DateTime.now()) && 
          task["status"] != "done"
        ).toList();
        break;
    }
    
    // Apply sorting
    filtered.sort((a, b) {
      switch (selectedSort) {
        case "created_asc":
          return (a["createdAt"] as DateTime).compareTo(b["createdAt"] as DateTime);
        case "created_desc":
          return (b["createdAt"] as DateTime).compareTo(a["createdAt"] as DateTime);
        case "due_date":
          return (a["dueDate"] as DateTime).compareTo(b["dueDate"] as DateTime);
        case "priority":
          Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
          return (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
        case "progress":
          return (b["progress"] as int).compareTo(a["progress"] as int);
        case "updated":
          return (b["updatedAt"] as DateTime).compareTo(a["updatedAt"] as DateTime);
        default:
          return 0;
      }
    });
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "todo":
        return disabledBoldColor;
      case "in_progress":
        return primaryColor;
      case "review":
        return warningColor;
      case "done":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "todo":
        return "TO DO";
      case "in_progress":
        return "IN PROGRESS";
      case "review":
        return "REVIEW";
      case "done":
        return "DONE";
      default:
        return status.toUpperCase();
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    // Implementation for filter dialog
  }

  void _createNewTask() {
    // Implementation for create new task
  }

  void _showTaskActions(Map<String, dynamic> task) {
    // Implementation for task actions menu
  }
}
