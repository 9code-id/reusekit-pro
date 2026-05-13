import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus9View extends StatefulWidget {
  @override
  State<GrlStatus9View> createState() => _GrlStatus9ViewState();
}

class _GrlStatus9ViewState extends State<GrlStatus9View> {
  int selectedStatusFilter = 0;
  String searchQuery = "";
  bool showCompletedOnly = false;
  
  final List<String> statusFilters = [
    "All Status",
    "In Progress", 
    "Pending Review",
    "Completed",
    "Blocked"
  ];

  final List<Map<String, dynamic>> projectTasks = [
    {
      "id": "TSK-001",
      "title": "Mobile App UI Design",
      "description": "Design user interface mockups for the mobile application",
      "assignee": "Sarah Johnson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=1",
      "status": "In Progress",
      "priority": "High",
      "progress": 75,
      "dueDate": "2024-12-28",
      "category": "Design",
      "estimatedHours": 24,
      "actualHours": 18,
      "tags": ["UI/UX", "Mobile", "Design"],
      "comments": 8,
      "attachments": 3
    },
    {
      "id": "TSK-002", 
      "title": "API Integration Testing",
      "description": "Test all API endpoints and ensure proper error handling",
      "assignee": "Mike Chen",
      "assigneeAvatar": "https://picsum.photos/40/40?random=2",
      "status": "Pending Review",
      "priority": "Critical",
      "progress": 90,
      "dueDate": "2024-12-25",
      "category": "Development",
      "estimatedHours": 16,
      "actualHours": 14,
      "tags": ["API", "Testing", "Backend"],
      "comments": 12,
      "attachments": 5
    },
    {
      "id": "TSK-003",
      "title": "User Documentation",
      "description": "Create comprehensive user manual and help documentation",
      "assignee": "Emily Davis",
      "assigneeAvatar": "https://picsum.photos/40/40?random=3",
      "status": "Completed",
      "priority": "Medium",
      "progress": 100,
      "dueDate": "2024-12-20",
      "category": "Documentation",
      "estimatedHours": 20,
      "actualHours": 22,
      "tags": ["Documentation", "User Guide"],
      "comments": 6,
      "attachments": 8
    },
    {
      "id": "TSK-004",
      "title": "Database Optimization",
      "description": "Optimize database queries and improve performance",
      "assignee": "Alex Wilson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=4",
      "status": "Blocked",
      "priority": "High",
      "progress": 45,
      "dueDate": "2024-12-30",
      "category": "Backend",
      "estimatedHours": 32,
      "actualHours": 15,
      "tags": ["Database", "Performance", "Optimization"],
      "comments": 15,
      "attachments": 2
    },
    {
      "id": "TSK-005",
      "title": "Security Audit",
      "description": "Conduct thorough security assessment and vulnerability testing",
      "assignee": "David Brown",
      "assigneeAvatar": "https://picsum.photos/40/40?random=5",
      "status": "In Progress",
      "priority": "Critical",
      "progress": 60,
      "dueDate": "2024-12-27",
      "category": "Security",
      "estimatedHours": 40,
      "actualHours": 24,
      "tags": ["Security", "Audit", "Testing"],
      "comments": 20,
      "attachments": 12
    },
    {
      "id": "TSK-006",
      "title": "Performance Testing",
      "description": "Load testing and performance benchmarking of the application",
      "assignee": "Lisa Anderson",
      "assigneeAvatar": "https://picsum.photos/40/40?random=6",
      "status": "Pending Review",
      "priority": "Medium",
      "progress": 85,
      "dueDate": "2024-12-26",
      "category": "Testing",
      "estimatedHours": 28,
      "actualHours": 25,
      "tags": ["Performance", "Load Testing"],
      "comments": 9,
      "attachments": 4
    }
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return projectTasks.where((task) {
      bool matchesSearch = task["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          task["assignee"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          task["id"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatusFilter == 0 || task["status"] == statusFilters[selectedStatusFilter];
      
      bool matchesCompleted = !showCompletedOnly || task["status"] == "Completed";
      
      return matchesSearch && matchesStatus && matchesCompleted;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      default:
        return successColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Pending Review":
        return warningColor;
      case "Blocked":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${task["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${task["priority"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${task["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${task["status"]}"),
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${task["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${task["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
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
              SizedBox(width: spXs),
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
                      "${task["category"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Due: ${task["dueDate"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "${(task["progress"] as int)}% Complete",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor("${task["status"]}"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (task["progress"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: _getStatusColor("${task["status"]}"),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (task["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 9,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.schedule, size: 12, color: infoColor),
                    SizedBox(width: 4),
                    Text(
                      "${task["actualHours"]}h / ${task["estimatedHours"]}h",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.comment, size: 12, color: warningColor),
                    SizedBox(width: 4),
                    Text(
                      "${task["comments"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.attach_file, size: 12, color: successColor),
                    SizedBox(width: 4),
                    Text(
                      "${task["attachments"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  si("Edit task ${task["title"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSummary() {
    final inProgress = projectTasks.where((task) => task["status"] == "In Progress").length;
    final pending = projectTasks.where((task) => task["status"] == "Pending Review").length;
    final completed = projectTasks.where((task) => task["status"] == "Completed").length;
    final blocked = projectTasks.where((task) => task["status"] == "Blocked").length;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$inProgress",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "In Progress",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$pending",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$completed",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$blocked",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Blocked",
                        style: TextStyle(
                          fontSize: 10,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Tasks"),
        actions: [
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () {
              si("Open filter options");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusSummary(),
            
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search tasks",
                    value: searchQuery,
                    hint: "Search by task name, assignee, or ID",
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
                    si("Search tasks for: $searchQuery");
                  },
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Status Filter",
                    items: statusFilters.asMap().entries.map((entry) {
                      return {
                        "label": entry.value,
                        "value": entry.key,
                      };
                    }).toList(),
                    value: selectedStatusFilter,
                    onChanged: (value, label) {
                      selectedStatusFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    label: "Show Completed Only",
                    items: [
                      {
                        "label": "Completed Only",
                        "value": true,
                        "checked": showCompletedOnly,
                      }
                    ],
                    value: [
                      if (showCompletedOnly)
                        {
                          "label": "Completed Only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showCompletedOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            Row(
              children: [
                Text(
                  "Tasks (${filteredTasks.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Task",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Add new task");
                  },
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            if (filteredTasks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
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
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No tasks found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or search criteria",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredTasks.map((task) => _buildTaskCard(task)).toList(),
          ],
        ),
      ),
    );
  }
}
