import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTaskAssignmentView extends StatefulWidget {
  const DmsTaskAssignmentView({super.key});

  @override
  State<DmsTaskAssignmentView> createState() => _DmsTaskAssignmentViewState();
}

class _DmsTaskAssignmentViewState extends State<DmsTaskAssignmentView> {
  String selectedProject = "all";
  String selectedAssignee = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Design user authentication flow",
      "description": "Create wireframes and mockups for the login, signup, and password reset flows",
      "project": "Mobile Banking App",
      "projectId": 2,
      "assignee": "Carol Smith",
      "assigneeId": 3,
      "assignedBy": "Alice Johnson",
      "status": "in_progress",
      "priority": "high",
      "dueDate": "2024-06-25",
      "createdDate": "2024-06-15",
      "estimatedHours": 16,
      "loggedHours": 8,
      "tags": ["Design", "UI/UX", "Authentication"],
      "comments": 5,
      "attachments": 3,
      "avatar": "https://picsum.photos/100/100?random=3&keyword=designer",
    },
    {
      "id": 2,
      "title": "Implement payment gateway integration",
      "description": "Integrate Stripe payment system with proper error handling and security measures",
      "project": "E-commerce Platform",
      "projectId": 1,
      "assignee": "Bob Wilson",
      "assigneeId": 2,
      "assignedBy": "Alice Johnson",
      "status": "pending",
      "priority": "high",
      "dueDate": "2024-06-28",
      "createdDate": "2024-06-18",
      "estimatedHours": 24,
      "loggedHours": 0,
      "tags": ["Development", "Payment", "Security"],
      "comments": 2,
      "attachments": 1,
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
    },
    {
      "id": 3,
      "title": "Write unit tests for API endpoints",
      "description": "Create comprehensive unit tests for all REST API endpoints with edge cases",
      "project": "E-commerce Platform",
      "projectId": 1,
      "assignee": "David Brown",
      "assigneeId": 4,
      "assignedBy": "Bob Wilson",
      "status": "completed",
      "priority": "medium",
      "dueDate": "2024-06-20",
      "createdDate": "2024-06-10",
      "estimatedHours": 12,
      "loggedHours": 14,
      "tags": ["Testing", "API", "Quality Assurance"],
      "comments": 8,
      "attachments": 0,
      "avatar": "https://picsum.photos/100/100?random=4&keyword=engineer",
    },
    {
      "id": 4,
      "title": "Update project documentation",
      "description": "Update technical documentation and user guides for the latest features",
      "project": "Marketing Dashboard",
      "projectId": 3,
      "assignee": "Alice Johnson",
      "assigneeId": 1,
      "assignedBy": "Carol Smith",
      "status": "review",
      "priority": "low",
      "dueDate": "2024-06-30",
      "createdDate": "2024-06-16",
      "estimatedHours": 8,
      "loggedHours": 6,
      "tags": ["Documentation", "Writing"],
      "comments": 3,
      "attachments": 2,
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
    },
  ];

  List<Map<String, dynamic>> teamMembers = [
    {"label": "All Members", "value": "all"},
    {"label": "Alice Johnson", "value": "1"},
    {"label": "Bob Wilson", "value": "2"},
    {"label": "Carol Smith", "value": "3"},
    {"label": "David Brown", "value": "4"},
  ];

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "1"},
    {"label": "Mobile Banking App", "value": "2"},
    {"label": "Marketing Dashboard", "value": "3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createNewTask(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTaskStats(),
                  SizedBox(height: spLg),
                  _buildFiltersAndSearch(),
                  SizedBox(height: spLg),
                  _buildTasksList(),
                  SizedBox(height: spLg),
                  _buildQuickAssignment(),
                ],
              ),
            ),
    );
  }

  Widget _buildTaskStats() {
    final totalTasks = tasks.length;
    final pendingTasks = tasks.where((t) => t["status"] == "pending").length;
    final inProgressTasks = tasks.where((t) => t["status"] == "in_progress").length;
    final completedTasks = tasks.where((t) => t["status"] == "completed").length;
    final overdueTasks = tasks.where((t) {
      final dueDate = DateTime.parse(t["dueDate"]);
      return dueDate.isBefore(DateTime.now()) && t["status"] != "completed";
    }).length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Task Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Tasks", "$totalTasks", Icons.task, primaryColor),
              _buildStatCard("Pending", "$pendingTasks", Icons.schedule, warningColor),
              _buildStatCard("In Progress", "$inProgressTasks", Icons.play_circle, infoColor),
              _buildStatCard("Completed", "$completedTasks", Icons.check_circle, successColor),
              _buildStatCard("Overdue", "$overdueTasks", Icons.warning, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
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
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Assignee",
                  items: teamMembers,
                  value: selectedAssignee,
                  onChanged: (value, label) {
                    selectedAssignee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "all"},
                    {"label": "Pending", "value": "pending"},
                    {"label": "In Progress", "value": "in_progress"},
                    {"label": "Review", "value": "review"},
                    {"label": "Completed", "value": "completed"},
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
          SizedBox(height: spSm),
          QCategoryPicker(
            items: [
              {"label": "All Priority", "value": "all"},
              {"label": "High", "value": "high"},
              {"label": "Medium", "value": "medium"},
              {"label": "Low", "value": "low"},
            ],
            value: selectedPriority,
            onChanged: (index, label, value, item) {
              selectedPriority = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    final filteredTasks = _getFilteredTasks();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tasks (${filteredTasks.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredTasks.map((task) => _buildTaskCard(task)).toList(),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final dueDate = DateTime.parse(task["dueDate"]);
    final isOverdue = dueDate.isBefore(DateTime.now()) && task["status"] != "completed";
    final progress = (task["loggedHours"] as num) / (task["estimatedHours"] as num);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isOverdue ? dangerColor : disabledOutlineBorderColor,
          width: isOverdue ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${task["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${task["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        _buildStatusBadge(task["status"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${task["assignee"]} • ${task["project"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildPriorityIndicator(task["priority"]),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${task["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress: ${task["loggedHours"]}h / ${task["estimatedHours"]}h",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: progress > 1 ? 1 : progress,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress > 1 ? warningColor : _getStatusColor(task["status"]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Due: ${task["dueDate"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: isOverdue ? dangerColor : disabledBoldColor,
                      fontWeight: isOverdue ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ((task["comments"] as int) > 0) ...[
                        Icon(Icons.comment, size: 10, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${task["comments"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                      ],
                      if ((task["attachments"] as int) > 0) ...[
                        Icon(Icons.attach_file, size: 10, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${task["attachments"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: spXs,
                  children: (task["tags"] as List).take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "$tag",
                        style: TextStyle(
                          fontSize: 8,
                          color: primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: spSm),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () => _editTask(task),
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.arrow_forward,
                    size: bs.sm,
                    onPressed: () => _viewTaskDetails(task),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        _getStatusLabel(status).toUpperCase(),
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: _getStatusColor(status),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    Color color;
    switch (priority) {
      case "high":
        color = dangerColor;
        break;
      case "medium":
        color = warningColor;
        break;
      default:
        color = successColor;
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildQuickAssignment() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Task Assignment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Task Title",
            value: "",
            hint: "Enter task title...",
            onChanged: (value) {},
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Assign to",
                  items: teamMembers.where((m) => m["value"] != "all").toList(),
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projects.where((p) => p["value"] != "all").toList(),
                  value: "",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Due Date",
                  value: DateTime.now().add(Duration(days: 7)),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Priority",
                  items: [
                    {"label": "High", "value": "high"},
                    {"label": "Medium", "value": "medium"},
                    {"label": "Low", "value": "low"},
                  ],
                  value: "medium",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Assign Task",
              size: bs.md,
              onPressed: () => _assignQuickTask(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "in_progress":
        return infoColor;
      case "review":
        return primaryColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "pending":
        return "Pending";
      case "in_progress":
        return "In Progress";
      case "review":
        return "Review";
      case "completed":
        return "Completed";
      default:
        return status;
    }
  }

  List<Map<String, dynamic>> _getFilteredTasks() {
    return tasks.where((task) {
      final matchesSearch = searchQuery.isEmpty ||
          task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["assignee"].toString().toLowerCase().contains(searchQuery.toLowerCase());

      final matchesProject = selectedProject == "all" ||
          task["projectId"].toString() == selectedProject;

      final matchesAssignee = selectedAssignee == "all" ||
          task["assigneeId"].toString() == selectedAssignee;

      final matchesStatus = selectedStatus == "all" ||
          task["status"] == selectedStatus;

      final matchesPriority = selectedPriority == "all" ||
          task["priority"] == selectedPriority;

      return matchesSearch && matchesProject && matchesAssignee && matchesStatus && matchesPriority;
    }).toList();
  }

  void _createNewTask() {
    // navigateTo('CreateTaskView')
  }

  void _editTask(Map<String, dynamic> task) {
    // navigateTo('EditTaskView')
  }

  void _viewTaskDetails(Map<String, dynamic> task) {
    // navigateTo('TaskDetailsView')
  }

  void _assignQuickTask() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));
    
    loading = false;
    setState(() {});
    
    ss("Task assigned successfully!");
  }
}
