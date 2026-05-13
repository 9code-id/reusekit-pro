import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskBoardView extends StatefulWidget {
  const TpmTaskBoardView({super.key});

  @override
  State<TpmTaskBoardView> createState() => _TpmTaskBoardViewState();
}

class _TpmTaskBoardViewState extends State<TpmTaskBoardView> {
  String selectedFilter = "all";
  String selectedSort = "priority";
  String searchQuery = "";
  bool showMyTasks = false;
  String selectedTeamMember = "";
  
  List<Map<String, dynamic>> taskStats = [
    {"title": "Total Tasks", "count": 157, "color": primaryColor, "icon": Icons.task_alt},
    {"title": "In Progress", "count": 42, "color": infoColor, "icon": Icons.trending_up},
    {"title": "Completed", "count": 89, "color": successColor, "icon": Icons.check_circle},
    {"title": "Overdue", "count": 8, "color": dangerColor, "icon": Icons.warning},
    {"title": "High Priority", "count": 23, "color": warningColor, "icon": Icons.priority_high},
    {"title": "Due Today", "count": 12, "color": secondaryColor, "icon": Icons.today},
  ];
  
  List<Map<String, dynamic>> recentTasks = [
    {
      "id": "1",
      "title": "Implement user authentication system",
      "description": "Create secure login and registration functionality",
      "project": "Mobile App Development",
      "assignee": "John Smith",
      "priority": "high",
      "status": "in_progress",
      "progress": 75,
      "dueDate": "2024-12-15",
      "tags": ["Backend", "Security", "API"],
      "subtasks": 4,
      "completedSubtasks": 3,
      "comments": 8,
      "attachments": 2,
    },
    {
      "id": "2", 
      "title": "Design user dashboard layout",
      "description": "Create responsive dashboard with analytics widgets",
      "project": "Website Redesign",
      "assignee": "Sarah Johnson",
      "priority": "medium",
      "status": "review",
      "progress": 90,
      "dueDate": "2024-12-12",
      "tags": ["UI/UX", "Frontend", "Design"],
      "subtasks": 6,
      "completedSubtasks": 5,
      "comments": 12,
      "attachments": 5,
    },
    {
      "id": "3",
      "title": "Database performance optimization",
      "description": "Optimize slow queries and improve database performance",
      "project": "API Integration",
      "assignee": "Mike Chen",
      "priority": "critical",
      "status": "blocked",
      "progress": 30,
      "dueDate": "2024-12-10",
      "tags": ["Database", "Performance", "Backend"],
      "subtasks": 8,
      "completedSubtasks": 2,
      "comments": 15,
      "attachments": 3,
    },
    {
      "id": "4",
      "title": "Create API documentation",
      "description": "Document all REST API endpoints with examples",
      "project": "API Integration",
      "assignee": "Emily Davis",
      "priority": "medium",
      "status": "todo",
      "progress": 0,
      "dueDate": "2024-12-20",
      "tags": ["Documentation", "API"],
      "subtasks": 3,
      "completedSubtasks": 0,
      "comments": 3,
      "attachments": 1,
    },
    {
      "id": "5",
      "title": "Implement push notifications",
      "description": "Add push notification functionality for mobile app",
      "project": "Mobile App Development",
      "assignee": "Alex Rodriguez",
      "priority": "high",
      "status": "in_progress",
      "progress": 45,
      "dueDate": "2024-12-18",
      "tags": ["Mobile", "Notifications", "Feature"],
      "subtasks": 5,
      "completedSubtasks": 2,
      "comments": 7,
      "attachments": 4,
    },
    {
      "id": "6",
      "title": "Fix payment gateway integration",
      "description": "Resolve issues with payment processing and webhook handling",
      "project": "Website Redesign",
      "assignee": "John Smith",
      "priority": "critical",
      "status": "in_progress",
      "progress": 60,
      "dueDate": "2024-12-11",
      "tags": ["Payment", "Bug Fix", "Critical"],
      "subtasks": 3,
      "completedSubtasks": 2,
      "comments": 20,
      "attachments": 6,
    },
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tasks", "value": "all"},
    {"label": "My Tasks", "value": "my_tasks"},
    {"label": "High Priority", "value": "high_priority"},
    {"label": "Due Soon", "value": "due_soon"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Completed", "value": "completed"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Priority", "value": "priority"},
    {"label": "Due Date", "value": "due_date"},
    {"label": "Progress", "value": "progress"},
    {"label": "Project", "value": "project"},
    {"label": "Assignee", "value": "assignee"},
    {"label": "Status", "value": "status"},
  ];
  
  List<Map<String, dynamic>> teamMembers = [
    {"label": "All Members", "value": ""},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Chen", "value": "mike_chen"},
    {"label": "Emily Davis", "value": "emily_davis"},
    {"label": "Alex Rodriguez", "value": "alex_rodriguez"},
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Board"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // navigateTo(TpmCreateTaskView());
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showFilterOptions(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildSearchAndFilters(),
            _buildTaskStats(),
            _buildQuickActions(),
            _buildTasksList(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Tasks",
            value: searchQuery,
            hint: "Search by title, description, or tags...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
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
          QDropdownField(
            label: "Team Member",
            items: teamMembers,
            value: selectedTeamMember,
            onChanged: (value, label) {
              selectedTeamMember = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Task Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 150,
          children: taskStats.map((stat) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: (stat["color"] as Color).withAlpha(50),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (stat["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(
                          stat["icon"],
                          color: stat["color"],
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(stat["count"] as int)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: stat["color"],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${stat["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: [
              _buildQuickActionCard("Create Task", Icons.add_task, primaryColor),
              _buildQuickActionCard("My Tasks", Icons.person, infoColor),
              _buildQuickActionCard("Due Today", Icons.today, warningColor),
              _buildQuickActionCard("High Priority", Icons.priority_high, dangerColor),
              _buildQuickActionCard("Team Tasks", Icons.group, successColor),
              _buildQuickActionCard("Reports", Icons.analytics, secondaryColor),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _handleQuickAction(title),
      child: Container(
        width: 120,
        padding: EdgeInsets.all(spMd),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(50)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTasksList() {
    List<Map<String, dynamic>> filteredTasks = _getFilteredTasks();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Tasks (${filteredTasks.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {
                // navigateTo(TpmTaskListView());
              },
            ),
          ],
        ),
        if (filteredTasks.isEmpty)
          _buildEmptyState()
        else
          ...filteredTasks.map((task) => _buildTaskCard(task)).toList(),
      ],
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spLg * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: disabledBoldColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No tasks found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "Try adjusting your filters or create a new task",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          QButton(
            label: "Create Task",
            size: bs.md,
            onPressed: () {
              // navigateTo(TpmCreateTaskView());
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    Color statusColor = _getStatusColor(task["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  _getStatusLabel(task["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${task["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.folder_outlined,
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
                Icons.person_outline,
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Progress: ${(task["progress"] as int)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
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
                      backgroundColor: statusColor.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (task["tags"] as List<String>).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            children: [
              _buildTaskMetric(Icons.task_alt, "${task["completedSubtasks"]}/${task["subtasks"]}", infoColor),
              SizedBox(width: spMd),
              _buildTaskMetric(Icons.comment_outlined, "${task["comments"]}", secondaryColor),
              SizedBox(width: spMd),
              _buildTaskMetric(Icons.attach_file, "${task["attachments"]}", warningColor),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  // navigateTo(TpmTaskDetailView());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTaskMetric(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
  
  List<Map<String, dynamic>> _getFilteredTasks() {
    List<Map<String, dynamic>> filtered = List.from(recentTasks);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((task) {
        return task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               task["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               (task["tags"] as List<String>).any((tag) => 
                 tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }
    
    // Apply status/priority filters
    switch (selectedFilter) {
      case "high_priority":
        filtered = filtered.where((task) => task["priority"] == "high" || task["priority"] == "critical").toList();
        break;
      case "due_soon":
        filtered = filtered.where((task) {
          DateTime dueDate = DateTime.parse(task["dueDate"]);
          DateTime now = DateTime.now();
          return dueDate.difference(now).inDays <= 3 && dueDate.isAfter(now);
        }).toList();
        break;
      case "overdue":
        filtered = filtered.where((task) {
          DateTime dueDate = DateTime.parse(task["dueDate"]);
          return dueDate.isBefore(DateTime.now()) && task["status"] != "done";
        }).toList();
        break;
      case "in_progress":
        filtered = filtered.where((task) => task["status"] == "in_progress").toList();
        break;
      case "completed":
        filtered = filtered.where((task) => task["status"] == "done").toList();
        break;
    }
    
    // Apply team member filter
    if (selectedTeamMember.isNotEmpty) {
      filtered = filtered.where((task) => 
        task["assignee"].toString().toLowerCase().replaceAll(" ", "_") == selectedTeamMember).toList();
    }
    
    // Apply sorting
    switch (selectedSort) {
      case "priority":
        filtered.sort((a, b) => _getPriorityValue(b["priority"]).compareTo(_getPriorityValue(a["priority"])));
        break;
      case "due_date":
        filtered.sort((a, b) => DateTime.parse(a["dueDate"]).compareTo(DateTime.parse(b["dueDate"])));
        break;
      case "progress":
        filtered.sort((a, b) => (b["progress"] as int).compareTo(a["progress"] as int));
        break;
      case "project":
        filtered.sort((a, b) => a["project"].toString().compareTo(b["project"].toString()));
        break;
      case "assignee":
        filtered.sort((a, b) => a["assignee"].toString().compareTo(b["assignee"].toString()));
        break;
      case "status":
        filtered.sort((a, b) => a["status"].toString().compareTo(b["status"].toString()));
        break;
    }
    
    return filtered;
  }
  
  int _getPriorityValue(String priority) {
    switch (priority) {
      case "critical": return 4;
      case "high": return 3;
      case "medium": return 2;
      case "low": return 1;
      default: return 0;
    }
  }
  
  Color _getPriorityColor(String priority) {
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
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "todo":
        return disabledBoldColor;
      case "in_progress":
        return infoColor;
      case "review":
        return warningColor;
      case "testing":
        return secondaryColor;
      case "done":
        return successColor;
      case "blocked":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  String _getStatusLabel(String status) {
    switch (status) {
      case "todo":
        return "To Do";
      case "in_progress":
        return "In Progress";
      case "review":
        return "Review";
      case "testing":
        return "Testing";
      case "done":
        return "Done";
      case "blocked":
        return "Blocked";
      default:
        return "Unknown";
    }
  }
  
  void _handleQuickAction(String action) {
    switch (action) {
      case "Create Task":
        // navigateTo(TpmCreateTaskView());
        break;
      case "My Tasks":
        selectedFilter = "my_tasks";
        selectedTeamMember = "john_smith"; // Current user
        setState(() {});
        break;
      case "Due Today":
        selectedFilter = "due_soon";
        setState(() {});
        break;
      case "High Priority":
        selectedFilter = "high_priority";
        setState(() {});
        break;
      case "Team Tasks":
        selectedTeamMember = "";
        selectedFilter = "all";
        setState(() {});
        break;
      case "Reports":
        si("Reports feature coming soon");
        break;
    }
  }
  
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Filter & Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            QDropdownField(
              label: "Filter Tasks",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: selectedSort,
              onChanged: (value, label) {
                selectedSort = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            QDropdownField(
              label: "Team Member",
              items: teamMembers,
              value: selectedTeamMember,
              onChanged: (value, label) {
                selectedTeamMember = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
