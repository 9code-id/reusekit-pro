import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskPriorityView extends StatefulWidget {
  const PmaTaskPriorityView({super.key});

  @override
  State<PmaTaskPriorityView> createState() => _PmaTaskPriorityViewState();
}

class _PmaTaskPriorityViewState extends State<PmaTaskPriorityView> {
  String selectedProject = "all";
  String selectedPriority = "all";
  String searchQuery = "";
  String selectedTimeframe = "all";

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Redesign", "value": "mobile_app"},
    {"label": "Website Development", "value": "website_dev"},
    {"label": "Marketing Campaign", "value": "marketing"},
    {"label": "Product Launch", "value": "product_launch"},
  ];

  List<Map<String, dynamic>> priorityFilters = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> timeframeFilters = [
    {"label": "All Time", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "1",
      "title": "Fix Critical Security Bug",
      "project": "Website Development",
      "assignee": "Sarah Smith",
      "priority": "critical",
      "currentPriority": "critical",
      "status": "in_progress",
      "dueDate": "2024-12-20",
      "createdDate": "2024-12-15",
      "estimatedHours": 8,
      "urgencyScore": 95,
      "impactScore": 98,
      "riskLevel": "high",
      "tags": ["Security", "Bug Fix"],
      "description": "Critical security vulnerability found in user authentication system",
      "lastUpdated": "2 hours ago",
    },
    {
      "id": "2",
      "title": "Design User Dashboard",
      "project": "Mobile App Redesign",
      "assignee": "John Doe",
      "priority": "high",
      "currentPriority": "high",
      "status": "todo",
      "dueDate": "2024-12-25",
      "createdDate": "2024-12-18",
      "estimatedHours": 12,
      "urgencyScore": 85,
      "impactScore": 75,
      "riskLevel": "medium",
      "tags": ["Design", "UI/UX"],
      "description": "Create comprehensive dashboard design with data visualization",
      "lastUpdated": "1 day ago",
    },
    {
      "id": "3",
      "title": "Database Performance Optimization",
      "project": "Website Development",
      "assignee": "Mike Johnson",
      "priority": "medium",
      "currentPriority": "high",
      "status": "review",
      "dueDate": "2024-12-28",
      "createdDate": "2024-12-10",
      "estimatedHours": 16,
      "urgencyScore": 60,
      "impactScore": 85,
      "riskLevel": "medium",
      "tags": ["Performance", "Database"],
      "description": "Optimize database queries and improve overall system performance",
      "lastUpdated": "3 hours ago",
    },
    {
      "id": "4",
      "title": "Marketing Content Creation",
      "project": "Marketing Campaign",
      "assignee": "Emma Davis",
      "priority": "low",
      "currentPriority": "medium",
      "status": "todo",
      "dueDate": "2024-12-30",
      "createdDate": "2024-12-16",
      "estimatedHours": 20,
      "urgencyScore": 40,
      "impactScore": 60,
      "riskLevel": "low",
      "tags": ["Content", "Marketing"],
      "description": "Create marketing materials for upcoming product launch",
      "lastUpdated": "2 days ago",
    },
    {
      "id": "5",
      "title": "Mobile App Testing",
      "project": "Mobile App Redesign",
      "assignee": "David Wilson",
      "priority": "medium",
      "currentPriority": "medium",
      "status": "blocked",
      "dueDate": "2024-12-22",
      "createdDate": "2024-12-14",
      "estimatedHours": 24,
      "urgencyScore": 70,
      "impactScore": 80,
      "riskLevel": "high",
      "tags": ["Testing", "QA"],
      "description": "Comprehensive testing of mobile application features",
      "lastUpdated": "6 hours ago",
    },
    {
      "id": "6",
      "title": "API Documentation Update",
      "project": "Product Launch",
      "assignee": "Lisa Brown",
      "priority": "low",
      "currentPriority": "low",
      "status": "done",
      "dueDate": "2024-12-19",
      "createdDate": "2024-12-12",
      "estimatedHours": 6,
      "urgencyScore": 30,
      "impactScore": 50,
      "riskLevel": "low",
      "tags": ["Documentation", "API"],
      "description": "Update API documentation for external developers",
      "lastUpdated": "1 week ago",
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          (task["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (task["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "all" || 
          (task["project"] as String).toLowerCase().contains(selectedProject.split('_').join(' ').toLowerCase());
      bool matchesPriority = selectedPriority == "all" || task["priority"] == selectedPriority;
      
      bool matchesTimeframe = true;
      if (selectedTimeframe != "all") {
        DateTime dueDate = DateTime.parse(task["dueDate"] as String);
        DateTime now = DateTime.now();
        
        switch (selectedTimeframe) {
          case "today":
            matchesTimeframe = dueDate.year == now.year && 
                               dueDate.month == now.month && 
                               dueDate.day == now.day;
            break;
          case "week":
            matchesTimeframe = dueDate.isAfter(now) && 
                               dueDate.isBefore(now.add(Duration(days: 7)));
            break;
          case "month":
            matchesTimeframe = dueDate.month == now.month && dueDate.year == now.year;
            break;
          case "overdue":
            matchesTimeframe = dueDate.isBefore(now) && task["status"] != "done";
            break;
        }
      }
      
      return matchesSearch && matchesProject && matchesPriority && matchesTimeframe;
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

  String _getPriorityLabel(String priority) {
    return priority.substring(0, 1).toUpperCase() + priority.substring(1);
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

  Color _getRiskColor(String risk) {
    switch (risk) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _updateTaskPriority(String taskId, String newPriority) async {
    bool isConfirmed = await confirm("Are you sure you want to change the task priority to ${_getPriorityLabel(newPriority)}?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      hideLoading();
      
      setState(() {
        int index = tasks.indexWhere((task) => task["id"] == taskId);
        if (index != -1) {
          tasks[index]["priority"] = newPriority;
          tasks[index]["lastUpdated"] = "Just now";
        }
      });
      
      ss("Task priority updated successfully");
    }
  }

  void _bulkUpdatePriority(List<String> taskIds, String newPriority) async {
    bool isConfirmed = await confirm("Are you sure you want to update priority for ${taskIds.length} selected tasks?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      setState(() {
        for (String taskId in taskIds) {
          int index = tasks.indexWhere((task) => task["id"] == taskId);
          if (index != -1) {
            tasks[index]["priority"] = newPriority;
            tasks[index]["lastUpdated"] = "Just now";
          }
        }
      });
      
      ss("Priority updated for ${taskIds.length} tasks");
    }
  }

  Widget _buildPriorityCard(Map<String, dynamic> task) {
    bool hasPriorityChanged = task["priority"] != task["currentPriority"];
    
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
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "#${task["id"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(task["status"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${task["status"]}".toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(task["status"] as String),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              if (hasPriorityChanged) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "PRIORITY CHANGED",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task["priority"] as String).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getPriorityLabel(task["priority"] as String),
                  style: TextStyle(
                    color: _getPriorityColor(task["priority"] as String),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          // Task Info
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

          // Project & Assignee
          Row(
            children: [
              Icon(
                Icons.folder,
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
                Icons.person,
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

          // Priority Metrics
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Urgency Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${task["urgencyScore"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "/100",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Impact Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${task["impactScore"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "/100",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Risk Level",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getRiskColor(task["riskLevel"] as String).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${task["riskLevel"]}".toUpperCase(),
                            style: TextStyle(
                              color: _getRiskColor(task["riskLevel"] as String),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Timeline & Actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Updated: ${task["lastUpdated"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Change Priority",
                size: bs.sm,
                onPressed: () {
                  _showPriorityDialog(task["id"] as String, task["priority"] as String);
                },
              ),
            ],
          ),

          // Tags
          if ((task["tags"] as List).isNotEmpty) ...[
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
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
        ],
      ),
    );
  }

  void _showPriorityDialog(String taskId, String currentPriority) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change Task Priority"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: priorityFilters.where((p) => p["value"] != "all").map((priority) {
            bool isSelected = priority["value"] == currentPriority;
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _updateTaskPriority(taskId, priority["value"] as String);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? _getPriorityColor(priority["value"] as String).withAlpha(30) : Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? _getPriorityColor(priority["value"] as String) : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getPriorityColor(priority["value"] as String),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${priority["label"]}",
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? _getPriorityColor(priority["value"] as String) : primaryColor,
                        ),
                      ),
                      if (isSelected) ...[
                        Spacer(),
                        Icon(
                          Icons.check,
                          color: _getPriorityColor(priority["value"] as String),
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, String subtitle) {
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> criticalTasks = filteredTasks.where((task) => task["priority"] == "critical").toList();
    List<Map<String, dynamic>> highTasks = filteredTasks.where((task) => task["priority"] == "high").toList();
    List<Map<String, dynamic>> mediumTasks = filteredTasks.where((task) => task["priority"] == "medium").toList();
    List<Map<String, dynamic>> lowTasks = filteredTasks.where((task) => task["priority"] == "low").toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Priority Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo(PmaPriorityAnalyticsView())
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
            // Priority Summary
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Critical", "${criticalTasks.length}", dangerColor, "Urgent attention required"),
                _buildSummaryCard("High", "${highTasks.length}", warningColor, "Important tasks"),
                _buildSummaryCard("Medium", "${mediumTasks.length}", infoColor, "Standard priority"),
                _buildSummaryCard("Low", "${lowTasks.length}", successColor, "When time permits"),
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
                    "Filters & Search",
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
                          label: "Priority",
                          items: priorityFilters,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Timeframe",
                    items: timeframeFilters,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Tasks by Priority
            if (criticalTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "CRITICAL PRIORITY (${criticalTasks.length})",
                      style: TextStyle(
                        color: dangerColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...criticalTasks.map((task) => _buildPriorityCard(task)).toList(),
            ],

            if (highTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "HIGH PRIORITY (${highTasks.length})",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...highTasks.map((task) => _buildPriorityCard(task)).toList(),
            ],

            if (mediumTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "MEDIUM PRIORITY (${mediumTasks.length})",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...mediumTasks.map((task) => _buildPriorityCard(task)).toList(),
            ],

            if (lowTasks.isNotEmpty) ...[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "LOW PRIORITY (${lowTasks.length})",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ...lowTasks.map((task) => _buildPriorityCard(task)).toList(),
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
                      Icons.priority_high,
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
                      "Try adjusting your filters to see more tasks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
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
