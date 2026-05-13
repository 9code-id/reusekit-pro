import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus10View extends StatefulWidget {
  @override
  State<GrlStatus10View> createState() => _GrlStatus10ViewState();
}

class _GrlStatus10ViewState extends State<GrlStatus10View> {
  int currentTab = 0;
  List<Map<String, dynamic>> pendingTasks = [
    {
      "id": "T001",
      "title": "Complete Monthly Report",
      "description": "Submit the monthly sales report to management",
      "priority": "High",
      "dueDate": "2025-06-25",
      "status": "In Progress",
      "assignee": "John Smith",
      "department": "Sales",
      "progress": 65,
      "category": "Report"
    },
    {
      "id": "T002", 
      "title": "Review Budget Proposal",
      "description": "Analyze Q3 budget allocation and provide feedback",
      "priority": "Medium",
      "dueDate": "2025-06-28",
      "status": "Pending Review",
      "assignee": "Sarah Johnson",
      "department": "Finance",
      "progress": 30,
      "category": "Review"
    },
    {
      "id": "T003",
      "title": "System Maintenance",
      "description": "Perform scheduled server maintenance and updates",
      "priority": "High",
      "dueDate": "2025-06-26",
      "status": "Scheduled",
      "assignee": "Mike Wilson",
      "department": "IT",
      "progress": 0,
      "category": "Maintenance"
    }
  ];

  List<Map<String, dynamic>> completedTasks = [
    {
      "id": "T004",
      "title": "Employee Training Session",
      "description": "Conduct cybersecurity awareness training",
      "priority": "Medium",
      "completedDate": "2025-06-20",
      "status": "Completed",
      "assignee": "Lisa Chen",
      "department": "HR",
      "category": "Training"
    },
    {
      "id": "T005",
      "title": "Client Presentation",
      "description": "Present Q2 performance results to key clients",
      "priority": "High",
      "completedDate": "2025-06-19",
      "status": "Completed",
      "assignee": "David Brown",
      "department": "Business Development",
      "category": "Presentation"
    }
  ];

  String selectedPriority = "All";
  String selectedDepartment = "All";

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Finance", "value": "Finance"},
    {"label": "IT", "value": "IT"},
    {"label": "HR", "value": "HR"},
    {"label": "Business Development", "value": "Business Development"},
  ];

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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Pending Review":
        return warningColor;
      case "Scheduled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredTasks(List<Map<String, dynamic>> tasks) {
    return tasks.where((task) {
      bool priorityMatch = selectedPriority == "All" || task["priority"] == selectedPriority;
      bool departmentMatch = selectedDepartment == "All" || task["department"] == selectedDepartment;
      return priorityMatch && departmentMatch;
    }).toList();
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isCompleted = task["status"] == "Completed";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${task["priority"]}"),
          ),
        ),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${task["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${task["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${task["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${task["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor("${task["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${task["id"]}",
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
          ),
          SizedBox(height: spSm),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${task["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          if (!isCompleted && task.containsKey("progress"))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${task["progress"]}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (task["progress"] as int) / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
                SizedBox(height: spSm),
              ],
            ),
          Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.schedule,
                size: 16,
                color: isCompleted ? successColor : warningColor,
              ),
              SizedBox(width: spXs),
              Text(
                isCompleted 
                  ? "Completed: ${task["completedDate"]}"
                  : "Due: ${task["dueDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: isCompleted ? successColor : warningColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              QButton(
                label: isCompleted ? "View Details" : "Update",
                size: bs.sm,
                onPressed: () {
                  // Handle task action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
          SizedBox(height: spSm),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPendingTasks = _getFilteredTasks(pendingTasks);
    List<Map<String, dynamic>> filteredCompletedTasks = _getFilteredTasks(completedTasks);

    return QTabBar(
      title: "Task Status Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "Completed", icon: Icon(Icons.check_circle)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Cards
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildStatsCard(
                    "Total Tasks",
                    "${pendingTasks.length + completedTasks.length}",
                    Icons.assignment,
                    primaryColor,
                  ),
                  _buildStatsCard(
                    "Pending",
                    "${pendingTasks.length}",
                    Icons.pending_actions,
                    warningColor,
                  ),
                  _buildStatsCard(
                    "Completed",
                    "${completedTasks.length}",
                    Icons.check_circle,
                    successColor,
                  ),
                  _buildStatsCard(
                    "High Priority",
                    "${pendingTasks.where((t) => t["priority"] == "High").length}",
                    Icons.priority_high,
                    dangerColor,
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              // Recent Activities
              Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              ...pendingTasks.take(2).map((task) => _buildTaskCard(task)).toList(),
              ...completedTasks.take(1).map((task) => _buildTaskCard(task)).toList(),
            ],
          ),
        ),
        
        // Pending Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildFilterSection(),
              ...filteredPendingTasks.map((task) => _buildTaskCard(task)).toList(),
              if (filteredPendingTasks.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_turned_in,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No pending tasks found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        
        // Completed Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildFilterSection(),
              ...filteredCompletedTasks.map((task) => _buildTaskCard(task)).toList(),
              if (filteredCompletedTasks.isEmpty)
                Container(
                  padding: EdgeInsets.all(spLg),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No completed tasks found",
                        style: TextStyle(
                          fontSize: fsH6,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
