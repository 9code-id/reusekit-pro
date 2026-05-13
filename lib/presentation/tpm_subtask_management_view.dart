import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmSubtaskManagementView extends StatefulWidget {
  const TpmSubtaskManagementView({super.key});

  @override
  State<TpmSubtaskManagementView> createState() => _TpmSubtaskManagementViewState();
}

class _TpmSubtaskManagementViewState extends State<TpmSubtaskManagementView> {
  String selectedParentTask = "TSK-001";
  String searchQuery = "";
  String selectedStatus = "";
  String selectedAssignee = "";
  int currentTab = 0;

  List<Map<String, dynamic>> parentTasks = [
    {"label": "Database Design", "value": "TSK-001"},
    {"label": "UI Mockups", "value": "DSN-001"},
    {"label": "API Development", "value": "TSK-002"},
    {"label": "Integration Testing", "value": "TST-001"}
  ];

  List<Map<String, dynamic>> subtasks = [
    {
      "id": "SUB-001",
      "parentTaskId": "TSK-001",
      "parentTaskTitle": "Database Design",
      "title": "Design User Table Schema",
      "description": "Create detailed schema for user authentication and profile data",
      "status": "Completed",
      "priority": "High",
      "assignee": "Michael Chen",
      "assigneeAvatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-15",
      "dueDate": "2024-12-18",
      "completedDate": "2024-12-17",
      "estimatedHours": 8,
      "actualHours": 6,
      "progress": 100,
      "tags": ["Database", "Schema", "User Management"],
      "dependencies": []
    },
    {
      "id": "SUB-002",
      "parentTaskId": "TSK-001",
      "parentTaskTitle": "Database Design",
      "title": "Create Relationships",
      "description": "Define foreign key relationships between all tables",
      "status": "In Progress",
      "priority": "High",
      "assignee": "Michael Chen",
      "assigneeAvatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-16",
      "dueDate": "2024-12-20",
      "completedDate": null,
      "estimatedHours": 6,
      "actualHours": 3,
      "progress": 50,
      "tags": ["Database", "Relationships", "Foreign Keys"],
      "dependencies": ["SUB-001"]
    },
    {
      "id": "SUB-003",
      "parentTaskId": "TSK-001",
      "parentTaskTitle": "Database Design",
      "title": "Setup Indexes",
      "description": "Create optimized indexes for query performance",
      "status": "Not Started",
      "priority": "Medium",
      "assignee": "David Rodriguez",
      "assigneeAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "createdBy": "Michael Chen",
      "createdDate": "2024-12-17",
      "dueDate": "2024-12-22",
      "completedDate": null,
      "estimatedHours": 4,
      "actualHours": 0,
      "progress": 0,
      "tags": ["Database", "Performance", "Indexes"],
      "dependencies": ["SUB-002"]
    },
    {
      "id": "SUB-004",
      "parentTaskId": "DSN-001",
      "parentTaskTitle": "UI Mockups",
      "title": "Design Login Screen",
      "description": "Create wireframes and mockups for user login interface",
      "status": "Completed",
      "priority": "High",
      "assignee": "Emma Wilson",
      "assigneeAvatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-12",
      "dueDate": "2024-12-15",
      "completedDate": "2024-12-14",
      "estimatedHours": 5,
      "actualHours": 4,
      "progress": 100,
      "tags": ["UI Design", "Login", "Wireframes"],
      "dependencies": []
    },
    {
      "id": "SUB-005",
      "parentTaskId": "DSN-001",
      "parentTaskTitle": "UI Mockups",
      "title": "Design Dashboard Layout",
      "description": "Create responsive dashboard layout with navigation",
      "status": "In Progress",
      "priority": "High",
      "assignee": "Emma Wilson",
      "assigneeAvatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-14",
      "dueDate": "2024-12-19",
      "completedDate": null,
      "estimatedHours": 8,
      "actualHours": 5,
      "progress": 70,
      "tags": ["UI Design", "Dashboard", "Responsive"],
      "dependencies": ["SUB-004"]
    },
    {
      "id": "SUB-006",
      "parentTaskId": "TSK-002",
      "parentTaskTitle": "API Development",
      "title": "Implement User Authentication",
      "description": "Create login, logout, and token management endpoints",
      "status": "In Progress",
      "priority": "High",
      "assignee": "John Smith",
      "assigneeAvatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "createdBy": "Michael Chen",
      "createdDate": "2024-12-18",
      "dueDate": "2024-12-23",
      "completedDate": null,
      "estimatedHours": 12,
      "actualHours": 8,
      "progress": 60,
      "tags": ["API", "Authentication", "Security"],
      "dependencies": []
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Not Started", "value": "Not Started"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Completed", "value": "Completed"},
    {"label": "On Hold", "value": "On Hold"}
  ];

  List<Map<String, dynamic>> assigneeOptions = [
    {"label": "All Assignees", "value": ""},
    {"label": "Michael Chen", "value": "Michael Chen"},
    {"label": "Emma Wilson", "value": "Emma Wilson"},
    {"label": "David Rodriguez", "value": "David Rodriguez"},
    {"label": "John Smith", "value": "John Smith"}
  ];

  List<Map<String, dynamic>> get filteredSubtasks {
    return subtasks.where((subtask) {
      bool matchesParent = subtask["parentTaskId"] == selectedParentTask;
      bool matchesSearch = searchQuery.isEmpty ||
          (subtask["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (subtask["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus.isEmpty || subtask["status"] == selectedStatus;
      bool matchesAssignee = selectedAssignee.isEmpty || subtask["assignee"] == selectedAssignee;
      
      return matchesParent && matchesSearch && matchesStatus && matchesAssignee;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Not Started":
        return disabledColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledColor;
    }
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
        return disabledColor;
    }
  }

  int get completedSubtasks {
    return filteredSubtasks.where((s) => s["status"] == "Completed").length;
  }

  int get totalEstimatedHours {
    return filteredSubtasks.fold(0, (sum, s) => sum + (s["estimatedHours"] as int));
  }

  int get totalActualHours {
    return filteredSubtasks.fold(0, (sum, s) => sum + (s["actualHours"] as int));
  }

  double get avgProgress {
    if (filteredSubtasks.isEmpty) return 0.0;
    return filteredSubtasks.fold(0.0, (sum, s) => sum + (s["progress"] as int)) / filteredSubtasks.length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Subtask Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Subtasks", icon: Icon(Icons.list_alt)),
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
      ],
      tabChildren: [
        _buildSubtasksTab(),
        _buildOverviewTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildSubtasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          QDropdownField(
            label: "Parent Task",
            items: parentTasks,
            value: selectedParentTask,
            onChanged: (value, label) {
              selectedParentTask = value;
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search subtasks...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () => _addSubtask(),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Assignee",
                  items: assigneeOptions,
                  value: selectedAssignee,
                  onChanged: (value, label) {
                    selectedAssignee = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Found ${filteredSubtasks.length} subtasks • ${completedSubtasks} completed",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (filteredSubtasks.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.checklist,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No subtasks found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Add subtasks to break down the main task",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Add Subtask",
                    onPressed: () => _addSubtask(),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredSubtasks.length,
              itemBuilder: (context, index) {
                final subtask = filteredSubtasks[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        color: _getStatusColor("${subtask["status"]}"),
                        width: 4,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${subtask["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${subtask["id"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${subtask["status"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${subtask["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor("${subtask["status"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Text(
                        "${subtask["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage("${subtask["assigneeAvatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${subtask["assignee"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Due: ${subtask["dueDate"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${subtask["priority"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${subtask["priority"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getPriorityColor("${subtask["priority"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress: ${subtask["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${subtask["actualHours"]}h / ${subtask["estimatedHours"]}h",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: (subtask["progress"] as int) / 100,
                            backgroundColor: disabledColor.withAlpha(30),
                            valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor("${subtask["status"]}")),
                          ),
                        ],
                      ),

                      if ((subtask["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (subtask["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      if ((subtask["dependencies"] as List).isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.account_tree, size: 16, color: warningColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Depends on: ${(subtask["dependencies"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Update Progress",
                              size: bs.sm,
                              onPressed: () => _updateProgress(subtask),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _editSubtask(subtask),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () => _showSubtaskOptions(subtask),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    String selectedTaskTitle = parentTasks.firstWhere(
      (task) => task["value"] == selectedParentTask,
      orElse: () => {"label": "Unknown Task"}
    )["label"] as String;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedTaskTitle,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Subtask Overview",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.list_alt, color: primaryColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Total Subtasks",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${filteredSubtasks.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "$completedSubtasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.schedule, color: warningColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Est. Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${totalEstimatedHours}h",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.timer, color: infoColor, size: 24),
                      SizedBox(height: spXs),
                      Text(
                        "Actual Hours",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${totalActualHours}h",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
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
                  "Overall Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${avgProgress.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "$completedSubtasks of ${filteredSubtasks.length} completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: avgProgress / 100,
                  backgroundColor: disabledColor.withAlpha(30),
                  valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  minHeight: 8,
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
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
                  "Status Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildStatusBreakdown("Completed", completedSubtasks, successColor),
                _buildStatusBreakdown("In Progress", filteredSubtasks.where((s) => s["status"] == "In Progress").length, warningColor),
                _buildStatusBreakdown("Not Started", filteredSubtasks.where((s) => s["status"] == "Not Started").length, disabledColor),
                _buildStatusBreakdown("On Hold", filteredSubtasks.where((s) => s["status"] == "On Hold").length, dangerColor),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildActivityItem("SUB-005 progress updated to 70%", "2 hours ago", Icons.trending_up, successColor),
                _buildActivityItem("SUB-006 assigned to John Smith", "5 hours ago", Icons.person_add, infoColor),
                _buildActivityItem("SUB-001 marked as completed", "1 day ago", Icons.check_circle, successColor),
                _buildActivityItem("SUB-003 created", "2 days ago", Icons.add_circle, primaryColor),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Subtask",
                  icon: Icons.add,
                  onPressed: () => _addSubtask(),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () => _refreshData(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBreakdown(String status, int count, Color color) {
    double percentage = filteredSubtasks.isEmpty ? 0 : count / filteredSubtasks.length;
    
    return Row(
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
        Expanded(
          child: Text(
            status,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          flex: 2,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String activity, String time, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addSubtask() {
    // Implementation for adding new subtask
  }

  void _updateProgress(Map<String, dynamic> subtask) {
    // Implementation for updating subtask progress
  }

  void _editSubtask(Map<String, dynamic> subtask) {
    // Implementation for editing subtask
  }

  void _showSubtaskOptions(Map<String, dynamic> subtask) {
    // Implementation for showing subtask options
  }

  void _refreshData() {
    // Implementation for refreshing data
    ss("Data refreshed");
    setState(() {});
  }
}
