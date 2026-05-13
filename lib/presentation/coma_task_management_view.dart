import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTaskManagementView extends StatefulWidget {
  const ComaTaskManagementView({super.key});

  @override
  State<ComaTaskManagementView> createState() => _ComaTaskManagementViewState();
}

class _ComaTaskManagementViewState extends State<ComaTaskManagementView> {
  String selectedProject = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedAssignee = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ001",
      "name": "Skyline Tower",
      "status": "active",
    },
    {
      "id": "PRJ002", 
      "name": "Harbor Bridge",
      "status": "active",
    },
    {
      "id": "PRJ003",
      "name": "Metro Station Complex",
      "status": "planning",
    },
  ];

  List<Map<String, dynamic>> priorities = [
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
    {"label": "Critical", "value": "critical"},
  ];

  List<Map<String, dynamic>> statuses = [
    {"label": "Not Started", "value": "not_started"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "On Hold", "value": "on_hold"},
    {"label": "Completed", "value": "completed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> assignees = [
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Lisa Wilson", "value": "lisa_wilson"},
    {"label": "Tom Brown", "value": "tom_brown"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "TSK001",
      "title": "Foundation Excavation",
      "description": "Complete excavation work for building foundation according to architectural plans",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "in_progress",
      "priority": "high",
      "assigneeId": "john_smith",
      "assigneeName": "John Smith",
      "startDate": "2024-01-15",
      "dueDate": "2024-02-15",
      "completionPercentage": 65,
      "estimatedHours": 120.0,
      "actualHours": 85.0,
      "dependencies": ["TSK010", "TSK011"],
      "tags": ["excavation", "foundation", "heavy_equipment"],
      "createdAt": "2024-01-10T08:30:00Z",
      "updatedAt": "2024-01-25T14:20:00Z",
    },
    {
      "id": "TSK002",
      "title": "Steel Frame Installation",
      "description": "Install structural steel framework for floors 1-5",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "not_started",
      "priority": "high",
      "assigneeId": "sarah_johnson",
      "assigneeName": "Sarah Johnson",
      "startDate": "2024-02-20",
      "dueDate": "2024-03-20",
      "completionPercentage": 0,
      "estimatedHours": 200.0,
      "actualHours": 0.0,
      "dependencies": ["TSK001"],
      "tags": ["steel", "structure", "welding"],
      "createdAt": "2024-01-12T10:15:00Z",
      "updatedAt": "2024-01-20T09:45:00Z",
    },
    {
      "id": "TSK003",
      "title": "Bridge Deck Pouring",
      "description": "Pour concrete for main bridge deck section",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "status": "completed",
      "priority": "critical",
      "assigneeId": "mike_davis",
      "assigneeName": "Mike Davis",
      "startDate": "2024-01-05",
      "dueDate": "2024-01-25",
      "completionPercentage": 100,
      "estimatedHours": 80.0,
      "actualHours": 85.0,
      "dependencies": [],
      "tags": ["concrete", "bridge", "deck"],
      "createdAt": "2024-01-02T07:30:00Z",
      "updatedAt": "2024-01-25T16:45:00Z",
    },
    {
      "id": "TSK004",
      "title": "Electrical Rough-In",
      "description": "Install electrical conduits and wiring for first phase",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "status": "in_progress",
      "priority": "medium",
      "assigneeId": "lisa_wilson",
      "assigneeName": "Lisa Wilson",
      "startDate": "2024-01-20",
      "dueDate": "2024-02-10",
      "completionPercentage": 40,
      "estimatedHours": 60.0,
      "actualHours": 25.0,
      "dependencies": ["TSK003"],
      "tags": ["electrical", "wiring", "conduit"],
      "createdAt": "2024-01-15T11:20:00Z",
      "updatedAt": "2024-01-28T13:30:00Z",
    },
    {
      "id": "TSK005",
      "title": "Platform Framework",
      "description": "Construct platform framework for metro station entrance",
      "projectId": "PRJ003",
      "projectName": "Metro Station Complex",
      "status": "on_hold",
      "priority": "medium",
      "assigneeId": "tom_brown",
      "assigneeName": "Tom Brown",
      "startDate": "2024-02-01",
      "dueDate": "2024-02-28",
      "completionPercentage": 15,
      "estimatedHours": 100.0,
      "actualHours": 18.0,
      "dependencies": ["TSK012"],
      "tags": ["platform", "framework", "metro"],
      "createdAt": "2024-01-18T09:15:00Z",
      "updatedAt": "2024-01-30T10:20:00Z",
    },
    {
      "id": "TSK006",
      "title": "Safety Inspection",
      "description": "Conduct comprehensive safety inspection of completed work areas",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "status": "completed",
      "priority": "critical",
      "assigneeId": "john_smith",
      "assigneeName": "John Smith",
      "startDate": "2024-01-22",
      "dueDate": "2024-01-24",
      "completionPercentage": 100,
      "estimatedHours": 16.0,
      "actualHours": 14.0,
      "dependencies": [],
      "tags": ["safety", "inspection", "compliance"],
      "createdAt": "2024-01-20T14:45:00Z",
      "updatedAt": "2024-01-24T17:30:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    List<Map<String, dynamic>> filtered = tasks;

    if (selectedProject != "all") {
      filtered = filtered.where((task) => task["projectId"] == selectedProject).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((task) => task["status"] == selectedStatus).toList();
    }

    if (selectedPriority != "all") {
      filtered = filtered.where((task) => task["priority"] == selectedPriority).toList();
    }

    if (selectedAssignee != "all") {
      filtered = filtered.where((task) => task["assigneeId"] == selectedAssignee).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((task) {
        return task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            task["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            task["projectName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            task["assigneeName"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  int get totalTasks => filteredTasks.length;

  int get completedTasks {
    return filteredTasks.where((task) => task["status"] == "completed").length;
  }

  int get inProgressTasks {
    return filteredTasks.where((task) => task["status"] == "in_progress").length;
  }

  int get overdueTasks {
    DateTime now = DateTime.now();
    return filteredTasks.where((task) {
      DateTime dueDate = DateTime.parse(task["dueDate"]);
      return dueDate.isBefore(now) && task["status"] != "completed";
    }).length;
  }

  double get averageProgress {
    if (filteredTasks.isEmpty) return 0.0;
    double totalProgress = filteredTasks.fold(0.0, (sum, task) => sum + (task["completionPercentage"] as int));
    return totalProgress / filteredTasks.length;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "on_hold":
        return warningColor;
      case "not_started":
        return disabledBoldColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "not_started":
        return "Not Started";
      case "in_progress":
        return "In Progress";
      case "on_hold":
        return "On Hold";
      case "completed":
        return "Completed";
      case "cancelled":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  String getPriorityText(String priority) {
    return priority.substring(0, 1).toUpperCase() + priority.substring(1);
  }

  bool isTaskOverdue(Map<String, dynamic> task) {
    DateTime now = DateTime.now();
    DateTime dueDate = DateTime.parse(task["dueDate"]);
    return dueDate.isBefore(now) && task["status"] != "completed";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              si("Task calendar view opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              si("Task analytics opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.task,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Tasks",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$totalTasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "across all projects",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$inProgressTasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "${averageProgress.toStringAsFixed(1)}% avg progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$completedTasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${totalTasks > 0 ? ((completedTasks / totalTasks) * 100).toStringAsFixed(0) : 0}% completion rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$overdueTasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "need immediate attention",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
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
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search tasks",
                          value: searchQuery,
                          hint: "Search by title, description, project, or assignee",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "all"},
                            ...projects.map((project) => {
                              "label": "${project["name"]}",
                              "value": "${project["id"]}",
                            }),
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            ...statuses,
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: [
                            {"label": "All Priorities", "value": "all"},
                            ...priorities,
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Assignee",
                          items: [
                            {"label": "All Assignees", "value": "all"},
                            ...assignees,
                          ],
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

            // Tasks List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Task Management",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Task",
                          size: bs.sm,
                          onPressed: () {
                            si("Add new task");
                          },
                        ),
                      ],
                    ),
                  ),
                  if (filteredTasks.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No tasks found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters or create new tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredTasks.map((task) {
                      bool isOverdue = isTaskOverdue(task);
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: getPriorityColor("${task["priority"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${task["title"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (isOverdue) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: dangerColor,
                                            ),
                                          ],
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getStatusColor("${task["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getStatusText("${task["status"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getStatusColor("${task["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${task["projectName"]} • ${task["assigneeName"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getPriorityColor("${task["priority"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getPriorityText("${task["priority"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getPriorityColor("${task["priority"]}"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isOverdue ? dangerColor : disabledBoldColor,
                                              fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                  children: [
                                    Text(
                                      "Progress",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${task["completionPercentage"]}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: disabledColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: (task["completionPercentage"] as int) / 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: getStatusColor("${task["status"]}"),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Task Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${task["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Estimated Hours",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${(task["estimatedHours"] as double).toStringAsFixed(0)}h",
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
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Actual Hours",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${(task["actualHours"] as double).toStringAsFixed(0)}h",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        spacing: 2,
                                        children: [
                                          Text(
                                            "Start Date",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${DateTime.parse(task["startDate"]).dMMMy}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if ((task["tags"] as List).isNotEmpty)
                                    Wrap(
                                      spacing: spXs,
                                      runSpacing: spXs,
                                      children: (task["tags"] as List).map((tag) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${tag}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: secondaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  Row(
                                    spacing: spSm,
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Viewing task details for ${task["id"]}");
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: QButton(
                                          label: "Edit Task",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Editing task ${task["id"]}");
                                          },
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
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
