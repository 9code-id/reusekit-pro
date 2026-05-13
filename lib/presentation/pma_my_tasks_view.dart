import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMyTasksView extends StatefulWidget {
  const PmaMyTasksView({super.key});

  @override
  State<PmaMyTasksView> createState() => _PmaMyTasksViewState();
}

class _PmaMyTasksViewState extends State<PmaMyTasksView> {
  String selectedFilter = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tasks", "value": "all"},
    {"label": "To Do", "value": "todo"},
    {"label": "In Progress", "value": "progress"},
    {"label": "Review", "value": "review"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Design Homepage Layout",
      "description": "Create wireframes and mockups for the new homepage design",
      "status": "progress",
      "priority": "high",
      "dueDate": "2024-12-25",
      "project": "Website Redesign",
      "assignee": "Sarah Wilson",
      "progress": 65,
      "tags": ["Design", "UI/UX"],
      "avatar": "https://i.pravatar.cc/50?img=1",
    },
    {
      "id": 2,
      "title": "Implement User Authentication",
      "description": "Add login, register, and password reset functionality",
      "status": "todo",
      "priority": "high",
      "dueDate": "2024-12-28",
      "project": "Mobile App",
      "assignee": "John Smith",
      "progress": 0,
      "tags": ["Backend", "Security"],
      "avatar": "https://i.pravatar.cc/50?img=2",
    },
    {
      "id": 3,
      "title": "Database Optimization",
      "description": "Optimize database queries and improve performance",
      "status": "review",
      "priority": "medium",
      "dueDate": "2024-12-30",
      "project": "System Enhancement",
      "assignee": "Mike Johnson",
      "progress": 90,
      "tags": ["Database", "Performance"],
      "avatar": "https://i.pravatar.cc/50?img=3",
    },
    {
      "id": 4,
      "title": "Content Creation",
      "description": "Write blog posts and create marketing materials",
      "status": "completed",
      "priority": "low",
      "dueDate": "2024-12-20",
      "project": "Marketing Campaign",
      "assignee": "Emily Davis",
      "progress": 100,
      "tags": ["Content", "Marketing"],
      "avatar": "https://i.pravatar.cc/50?img=4",
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesStatus = selectedFilter == "all" || task["status"] == selectedFilter;
      bool matchesPriority = selectedPriority == "all" || task["priority"] == selectedPriority;
      bool matchesSearch = searchQuery.isEmpty || 
          task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesPriority && matchesSearch;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "todo":
        return disabledBoldColor;
      case "progress":
        return infoColor;
      case "review":
        return warningColor;
      case "completed":
        return successColor;
      default:
        return disabledBoldColor;
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

  String _getStatusLabel(String status) {
    switch (status) {
      case "todo":
        return "To Do";
      case "progress":
        return "In Progress";
      case "review":
        return "Review";
      case "completed":
        return "Completed";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create task
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            SizedBox(height: spMd),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status",
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
                    label: "Priority",
                    items: priorityOptions,
                    value: selectedPriority,
                    onChanged: (value, label) {
                      selectedPriority = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Task Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard("Total", "${tasks.length}", primaryColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("In Progress", "${tasks.where((t) => t["status"] == "progress").length}", infoColor),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard("Completed", "${tasks.where((t) => t["status"] == "completed").length}", successColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tasks (${filteredTasks.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Tasks List
            if (filteredTasks.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spXl),
                child: Column(
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No tasks found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
                  ],
                ),
              )
            else
              Column(
                children: filteredTasks.map((task) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor("${task["status"]}"),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${task["title"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${task["project"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${task["priority"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getPriorityColor("${task["priority"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spSm),

                              // Description
                              Text(
                                "${task["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                              ),

                              SizedBox(height: spSm),

                              // Progress
                              if ((task["progress"] as int) > 0) ...[
                                Row(
                                  children: [
                                    Text(
                                      "Progress: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${task["progress"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${task["status"]}"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: (task["progress"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation(_getStatusColor("${task["status"]}")),
                                ),
                                SizedBox(height: spSm),
                              ],

                              // Tags
                              Wrap(
                                spacing: spXs,
                                children: (task["tags"] as List).map((tag) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      border: Border.all(color: primaryColor.withAlpha(30)),
                                    ),
                                    child: Text(
                                      "$tag",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: spSm),

                              // Footer
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundImage: NetworkImage("${task["avatar"]}"),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${task["assignee"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Due: ${DateTime.parse("${task["dueDate"]}").dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor("${task["status"]}").withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      _getStatusLabel("${task["status"]}"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor("${task["status"]}"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Action buttons
                        Container(
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(50),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radiusMd),
                              bottomRight: Radius.circular(radiusMd),
                            ),
                          ),
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.edit,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
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
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
