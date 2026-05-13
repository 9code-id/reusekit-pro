import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus5View extends StatefulWidget {
  @override
  State<GrlStatus5View> createState() => _GrlStatus5ViewState();
}

class _GrlStatus5ViewState extends State<GrlStatus5View> {
  String selectedFilter = "All";
  String selectedPriority = "All";
  bool showCompletedTasks = false;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "In Progress", "value": "In Progress"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Completed", "value": "Completed"},
    {"label": "On Hold", "value": "On Hold"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Website Redesign Project",
      "description": "Complete redesign of company website with modern UI/UX principles",
      "status": "In Progress",
      "priority": "High",
      "progress": 65,
      "dueDate": "2024-08-30",
      "assignee": "Sarah Johnson",
      "assigneeImage": "https://picsum.photos/40/40?random=1&keyword=person",
      "department": "Design",
      "category": "Development",
      "timeSpent": 24.5,
      "estimatedHours": 40,
      "tags": ["UI/UX", "Frontend", "Responsive"],
      "lastUpdate": "2024-07-22 14:30",
      "comments": 8,
      "attachments": 5,
    },
    {
      "id": 2,
      "title": "Marketing Campaign Launch",
      "description": "Launch Q3 marketing campaign across all social media platforms",
      "status": "Pending",
      "priority": "Medium",
      "progress": 25,
      "dueDate": "2024-08-15",
      "assignee": "Mike Chen",
      "assigneeImage": "https://picsum.photos/40/40?random=2&keyword=person",
      "department": "Marketing",
      "category": "Campaign",
      "timeSpent": 8.0,
      "estimatedHours": 32,
      "tags": ["Social Media", "Content", "Analytics"],
      "lastUpdate": "2024-07-21 09:15",
      "comments": 3,
      "attachments": 12,
    },
    {
      "id": 3,
      "title": "Database Migration",
      "description": "Migrate legacy database to new cloud infrastructure",
      "status": "On Hold",
      "priority": "High",
      "progress": 45,
      "dueDate": "2024-09-10",
      "assignee": "Alex Rodriguez",
      "assigneeImage": "https://picsum.photos/40/40?random=3&keyword=person",
      "department": "IT",
      "category": "Infrastructure",
      "timeSpent": 18.0,
      "estimatedHours": 60,
      "tags": ["Database", "Cloud", "Migration"],
      "lastUpdate": "2024-07-20 16:45",
      "comments": 15,
      "attachments": 3,
    },
    {
      "id": 4,
      "title": "Customer Support Training",
      "description": "Training program for new customer support representatives",
      "status": "Completed",
      "priority": "Medium",
      "progress": 100,
      "dueDate": "2024-07-25",
      "assignee": "Emma Wilson",
      "assigneeImage": "https://picsum.photos/40/40?random=4&keyword=person",
      "department": "HR",
      "category": "Training",
      "timeSpent": 16.0,
      "estimatedHours": 16,
      "tags": ["Training", "Support", "Onboarding"],
      "lastUpdate": "2024-07-25 17:00",
      "comments": 6,
      "attachments": 8,
    },
    {
      "id": 5,
      "title": "Mobile App Testing",
      "description": "Comprehensive testing of new mobile application features",
      "status": "In Progress",
      "priority": "High",
      "progress": 80,
      "dueDate": "2024-08-05",
      "assignee": "David Kim",
      "assigneeImage": "https://picsum.photos/40/40?random=5&keyword=person",
      "department": "QA",
      "category": "Testing",
      "timeSpent": 28.0,
      "estimatedHours": 35,
      "tags": ["Mobile", "Testing", "QA"],
      "lastUpdate": "2024-07-22 11:20",
      "comments": 12,
      "attachments": 7,
    },
    {
      "id": 6,
      "title": "Financial Report Analysis",
      "description": "Analyze Q2 financial reports and prepare presentation for board meeting",
      "status": "Pending",
      "priority": "Low",
      "progress": 15,
      "dueDate": "2024-08-20",
      "assignee": "Lisa Thompson",
      "assigneeImage": "https://picsum.photos/40/40?random=6&keyword=person",
      "department": "Finance",
      "category": "Analysis",
      "timeSpent": 4.5,
      "estimatedHours": 20,
      "tags": ["Finance", "Analysis", "Reporting"],
      "lastUpdate": "2024-07-19 13:10",
      "comments": 2,
      "attachments": 4,
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesStatus = selectedFilter == "All" || task["status"] == selectedFilter;
      bool matchesPriority = selectedPriority == "All" || task["priority"] == selectedPriority;
      bool matchesCompletion = showCompletedTasks || task["status"] != "Completed";
      return matchesStatus && matchesPriority && matchesCompletion;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Completed":
        return successColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledBoldColor;
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
        return disabledBoldColor;
    }
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    double progressValue = (task["progress"] as int) / 100;
    Color statusColor = _getStatusColor(task["status"] as String);
    Color priorityColor = _getPriorityColor(task["priority"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: statusColor.withAlpha(50), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${task["title"]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${task["priority"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: spSm),
            
            // Progress Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: ${task["progress"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Time and Due Date
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${task["timeSpent"]}h / ${task["estimatedHours"]}h",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Due: ${task["dueDate"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Assignee and Department
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${task["assigneeImage"]}"),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${task["department"]} • ${task["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
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
                    SizedBox(width: spSm),
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
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Tags
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            
            SizedBox(height: spSm),
            
            // Last Update and Actions
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Updated: ${task["lastUpdate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    si("Task details opened");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSummary() {
    Map<String, int> statusCounts = {};
    for (var task in tasks) {
      String status = task["status"] as String;
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
                child: _buildSummaryCard("In Progress", statusCounts["In Progress"] ?? 0, infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Pending", statusCounts["Pending"] ?? 0, warningColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard("Completed", statusCounts["Completed"] ?? 0, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("On Hold", statusCounts["On Hold"] ?? 0, dangerColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String status, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Status"),
        actions: [
          Icon(Icons.search, color: disabledBoldColor),
          SizedBox(width: spSm),
          Icon(Icons.filter_list, color: disabledBoldColor),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Summary
            _buildStatusSummary(),
            
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
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
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show completed tasks",
                        "value": true,
                        "checked": showCompletedTasks,
                      }
                    ],
                    value: [if (showCompletedTasks) {"label": "Show completed tasks", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      showCompletedTasks = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Row(
              children: [
                Text(
                  "Tasks",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTasks.length} of ${tasks.length}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Tasks List
            if (filteredTasks.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Tasks Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredTasks.map((task) => _buildTaskCard(task)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
