import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaKanbanView extends StatefulWidget {
  const PmaKanbanView({super.key});

  @override
  State<PmaKanbanView> createState() => _PmaKanbanViewState();
}

class _PmaKanbanViewState extends State<PmaKanbanView> {
  String selectedProject = "all";
  String selectedAssignee = "all";

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
  ];

  List<Map<String, dynamic>> assignees = [
    {"label": "All Team Members", "value": "all"},
    {"label": "John Doe", "value": "john_doe"},
    {"label": "Sarah Smith", "value": "sarah_smith"},
    {"label": "Mike Johnson", "value": "mike_johnson"},
    {"label": "Lisa Brown", "value": "lisa_brown"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "1",
      "title": "Design Login Screen",
      "project": "Mobile App",
      "assignee": "john_doe",
      "assigneeName": "John Doe",
      "assigneeAvatar": "https://picsum.photos/40/40?random=1",
      "priority": "high",
      "status": "todo",
      "dueDate": "2024-12-25",
      "estimatedHours": 8,
      "tags": ["Design", "Mobile"],
      "attachments": 3,
      "comments": 5,
    },
    {
      "id": "2",
      "title": "API Integration",
      "project": "Mobile App",
      "assignee": "sarah_smith",
      "assigneeName": "Sarah Smith",
      "assigneeAvatar": "https://picsum.photos/40/40?random=2",
      "priority": "critical",
      "status": "in_progress",
      "dueDate": "2024-12-22",
      "estimatedHours": 16,
      "tags": ["Development", "API"],
      "attachments": 1,
      "comments": 12,
    },
    {
      "id": "3",
      "title": "Database Schema",
      "project": "Website",
      "assignee": "mike_johnson",
      "assigneeName": "Mike Johnson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=3",
      "priority": "medium",
      "status": "review",
      "dueDate": "2024-12-20",
      "estimatedHours": 12,
      "tags": ["Backend", "Database"],
      "attachments": 2,
      "comments": 8,
    },
    {
      "id": "4",
      "title": "User Testing",
      "project": "Mobile App",
      "assignee": "lisa_brown",
      "assigneeName": "Lisa Brown",
      "assigneeAvatar": "https://picsum.photos/40/40?random=4",
      "priority": "high",
      "status": "done",
      "dueDate": "2024-12-18",
      "estimatedHours": 20,
      "tags": ["Testing", "UX"],
      "attachments": 5,
      "comments": 15,
    },
    {
      "id": "5",
      "title": "Performance Optimization",
      "project": "Mobile App",
      "assignee": "sarah_smith",
      "assigneeName": "Sarah Smith",
      "assigneeAvatar": "https://picsum.photos/40/40?random=2",
      "priority": "medium",
      "status": "blocked",
      "dueDate": "2024-12-30",
      "estimatedHours": 24,
      "tags": ["Performance"],
      "attachments": 0,
      "comments": 3,
    },
    {
      "id": "6",
      "title": "Code Review",
      "project": "Website",
      "assignee": "mike_johnson",
      "assigneeName": "Mike Johnson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=3",
      "priority": "low",
      "status": "todo",
      "dueDate": "2024-12-28",
      "estimatedHours": 4,
      "tags": ["Review"],
      "attachments": 0,
      "comments": 2,
    },
    {
      "id": "7",
      "title": "Bug Fixes",
      "project": "Mobile App",
      "assignee": "john_doe",
      "assigneeName": "John Doe",
      "assigneeAvatar": "https://picsum.photos/40/40?random=1",
      "priority": "high",
      "status": "in_progress",
      "dueDate": "2024-12-24",
      "estimatedHours": 6,
      "tags": ["Bug Fix"],
      "attachments": 1,
      "comments": 7,
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesProject = selectedProject == "all" || 
          (task["project"] as String).toLowerCase().contains(selectedProject.split('_').join(' ').toLowerCase());
      bool matchesAssignee = selectedAssignee == "all" || task["assignee"] == selectedAssignee;
      
      return matchesProject && matchesAssignee;
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

  List<Map<String, dynamic>> _getTasksByStatus(String status) {
    return filteredTasks.where((task) => task["status"] == status).toList();
  }

  Widget _buildKanbanColumn(String status, String title, Color color) {
    List<Map<String, dynamic>> columnTasks = _getTasksByStatus(status);
    
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: color.withAlpha(50)),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${columnTasks.length}",
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: color.withAlpha(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: spSm,
                  children: [
                    ...columnTasks.map((task) => _buildTaskCard(task)).toList(),
                    if (status != 'done') _buildAddTaskButton(status, color),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 3,
            color: _getPriorityColor(task["priority"] as String),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "#${task["id"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task["priority"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getPriorityColor(task["priority"] as String),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${task["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${task["project"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if ((task["tags"] as List).isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${task["assigneeAvatar"]}",
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${task["assigneeName"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if ((task["attachments"] as int) > 0) ...[
                Icon(
                  Icons.attach_file,
                  size: 14,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${task["attachments"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Icon(
                Icons.comment,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["comments"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
            style: TextStyle(
              fontSize: 11,
              color: warningColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo(PmaTaskDetailView())
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo(PmaEditTaskView())
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton(String status, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: color.withAlpha(30),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.add,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            "Add Task",
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
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
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> todoTasks = _getTasksByStatus("todo");
    List<Map<String, dynamic>> inProgressTasks = _getTasksByStatus("in_progress");
    List<Map<String, dynamic>> reviewTasks = _getTasksByStatus("review");
    List<Map<String, dynamic>> doneTasks = _getTasksByStatus("done");
    List<Map<String, dynamic>> blockedTasks = _getTasksByStatus("blocked");

    return Scaffold(
      appBar: AppBar(
        title: Text("Kanban Board"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo(PmaCreateTaskView())
            },
          ),
          IconButton(
            icon: Icon(Icons.view_list),
            onPressed: () {
              //navigateTo(PmaTaskBoardView())
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spMd,
              children: [
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildSummaryCard("To Do", "${todoTasks.length}", _getStatusColor("todo")),
                    _buildSummaryCard("In Progress", "${inProgressTasks.length}", _getStatusColor("in_progress")),
                    _buildSummaryCard("Review", "${reviewTasks.length}", _getStatusColor("review")),
                    _buildSummaryCard("Done", "${doneTasks.length}", _getStatusColor("done")),
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
                        label: "Assignee",
                        items: assignees,
                        value: selectedAssignee,
                        onChanged: (value, label) {
                          selectedAssignee = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Kanban Columns
          Expanded(
            child: Container(
              color: disabledColor.withAlpha(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKanbanColumn("todo", "To Do", _getStatusColor("todo")),
                    _buildKanbanColumn("in_progress", "In Progress", _getStatusColor("in_progress")),
                    _buildKanbanColumn("review", "Review", _getStatusColor("review")),
                    if (blockedTasks.isNotEmpty)
                      _buildKanbanColumn("blocked", "Blocked", _getStatusColor("blocked")),
                    _buildKanbanColumn("done", "Done", _getStatusColor("done")),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
