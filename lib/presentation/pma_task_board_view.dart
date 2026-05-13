import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskBoardView extends StatefulWidget {
  const PmaTaskBoardView({super.key});

  @override
  State<PmaTaskBoardView> createState() => _PmaTaskBoardViewState();
}

class _PmaTaskBoardViewState extends State<PmaTaskBoardView> {
  String selectedProject = "all";
  String selectedAssignee = "all";
  String searchQuery = "";
  bool showCompletedTasks = true;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
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
      "description": "Create wireframes and mockups for the login interface",
      "project": "mobile_app",
      "assignee": "john_doe",
      "assigneeName": "John Doe",
      "priority": "high",
      "status": "todo",
      "dueDate": "2024-12-25",
      "estimatedHours": 8,
      "tags": ["design", "mobile"],
      "attachments": 3,
      "comments": 5,
    },
    {
      "id": "2",
      "title": "API Integration",
      "description": "Integrate authentication APIs with frontend",
      "project": "mobile_app",
      "assignee": "sarah_smith",
      "assigneeName": "Sarah Smith",
      "priority": "critical",
      "status": "in_progress",
      "dueDate": "2024-12-22",
      "estimatedHours": 16,
      "tags": ["development", "api"],
      "attachments": 1,
      "comments": 12,
    },
    {
      "id": "3",
      "title": "Database Schema",
      "description": "Design and implement user database schema",
      "project": "website_dev",
      "assignee": "mike_johnson",
      "assigneeName": "Mike Johnson",
      "priority": "medium",
      "status": "review",
      "dueDate": "2024-12-20",
      "estimatedHours": 12,
      "tags": ["backend", "database"],
      "attachments": 2,
      "comments": 8,
    },
    {
      "id": "4",
      "title": "User Testing",
      "description": "Conduct usability testing for new features",
      "project": "mobile_app",
      "assignee": "lisa_brown",
      "assigneeName": "Lisa Brown",
      "priority": "high",
      "status": "done",
      "dueDate": "2024-12-18",
      "estimatedHours": 20,
      "tags": ["testing", "ux"],
      "attachments": 5,
      "comments": 15,
    },
    {
      "id": "5",
      "title": "Performance Optimization",
      "description": "Optimize app loading speed and performance",
      "project": "mobile_app",
      "assignee": "sarah_smith",
      "assigneeName": "Sarah Smith",
      "priority": "medium",
      "status": "blocked",
      "dueDate": "2024-12-30",
      "estimatedHours": 24,
      "tags": ["performance", "optimization"],
      "attachments": 0,
      "comments": 3,
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          (task["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (task["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "all" || task["project"] == selectedProject;
      bool matchesAssignee = selectedAssignee == "all" || task["assignee"] == selectedAssignee;
      bool showCompleted = showCompletedTasks || task["status"] != "done";
      
      return matchesSearch && matchesProject && matchesAssignee && showCompleted;
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

  String _getStatusLabel(String status) {
    switch (status) {
      case 'todo':
        return 'To Do';
      case 'in_progress':
        return 'In Progress';
      case 'review':
        return 'Review';
      case 'done':
        return 'Done';
      case 'blocked':
        return 'Blocked';
      default:
        return 'Unknown';
    }
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
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
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(task["status"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(task["status"] as String),
                  style: TextStyle(
                    color: _getStatusColor(task["status"] as String),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "#${task["id"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            "${task["title"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
                "${task["assigneeName"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if ((task["attachments"] as int) > 0) ...[
                Icon(
                  Icons.attach_file,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${task["attachments"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Icon(
                Icons.comment,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["comments"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo(PmaTaskDetailView())
                  },
                ),
              ),
              SizedBox(width: spSm),
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

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
    List<Map<String, dynamic>> todoTasks = filteredTasks.where((task) => task["status"] == "todo").toList();
    List<Map<String, dynamic>> inProgressTasks = filteredTasks.where((task) => task["status"] == "in_progress").toList();
    List<Map<String, dynamic>> reviewTasks = filteredTasks.where((task) => task["status"] == "review").toList();
    List<Map<String, dynamic>> doneTasks = filteredTasks.where((task) => task["status"] == "done").toList();
    List<Map<String, dynamic>> blockedTasks = filteredTasks.where((task) => task["status"] == "blocked").toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Board"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo(PmaCreateTaskView())
            },
          ),
          IconButton(
            icon: Icon(Icons.view_kanban),
            onPressed: () {
              //navigateTo(PmaKanbanView())
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
                _buildSummaryCard("Total Tasks", "${filteredTasks.length}", Icons.assignment, primaryColor),
                _buildSummaryCard("In Progress", "${inProgressTasks.length}", Icons.pending, infoColor),
                _buildSummaryCard("Completed", "${doneTasks.length}", Icons.check_circle, successColor),
                _buildSummaryCard("Blocked", "${blockedTasks.length}", Icons.block, dangerColor),
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
                    "Filters",
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
                          hint: "Search by title or description...",
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
                  QSwitch(
                    items: [
                      {
                        "label": "Show Completed Tasks",
                        "value": true,
                        "checked": showCompletedTasks,
                      }
                    ],
                    value: [
                      if (showCompletedTasks)
                        {"label": "Show Completed Tasks", "value": true, "checked": true}
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        showCompletedTasks = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Tasks by Status
            if (todoTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("todo").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "TO DO (${todoTasks.length})",
                      style: TextStyle(
                        color: _getStatusColor("todo"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...todoTasks.map((task) => _buildTaskCard(task)).toList(),
            ],

            if (inProgressTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("in_progress").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "IN PROGRESS (${inProgressTasks.length})",
                      style: TextStyle(
                        color: _getStatusColor("in_progress"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...inProgressTasks.map((task) => _buildTaskCard(task)).toList(),
            ],

            if (reviewTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("review").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "REVIEW (${reviewTasks.length})",
                      style: TextStyle(
                        color: _getStatusColor("review"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...reviewTasks.map((task) => _buildTaskCard(task)).toList(),
            ],

            if (blockedTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("blocked").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "BLOCKED (${blockedTasks.length})",
                      style: TextStyle(
                        color: _getStatusColor("blocked"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...blockedTasks.map((task) => _buildTaskCard(task)).toList(),
            ],

            if (showCompletedTasks && doneTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("done").withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "COMPLETED (${doneTasks.length})",
                      style: TextStyle(
                        color: _getStatusColor("done"),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...doneTasks.map((task) => _buildTaskCard(task)).toList(),
            ],

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
                      Icons.assignment,
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
                      "Try adjusting your filters or create a new task",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Create New Task",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo(PmaCreateTaskView())
                      },
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
