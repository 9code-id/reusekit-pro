import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTaskManagementView extends StatefulWidget {
  const LcaTaskManagementView({super.key});

  @override
  State<LcaTaskManagementView> createState() => _LcaTaskManagementViewState();
}

class _LcaTaskManagementViewState extends State<LcaTaskManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedAssignee = "all";
  String sortBy = "due_date";
  
  List<Map<String, dynamic>> tasks = [
    {
      "id": "TSK001",
      "title": "Review Settlement Agreement",
      "description": "Review and finalize settlement terms for Johnson v. Smith case",
      "status": "in_progress",
      "priority": "high",
      "due_date": "2024-06-25",
      "assigned_to": "Sarah Mitchell",
      "assigned_to_id": "USR001",
      "case_number": "2024-0123",
      "client_name": "Johnson & Associates",
      "created_date": "2024-06-15",
      "estimated_hours": 4.5,
      "actual_hours": 2.0,
      "category": "document_review",
      "attachments": 3,
    },
    {
      "id": "TSK002",
      "title": "Prepare Discovery Documents",
      "description": "Compile and organize discovery materials for upcoming deposition",
      "status": "pending",
      "priority": "medium",
      "due_date": "2024-06-28",
      "assigned_to": "Michael Chen",
      "assigned_to_id": "USR002",
      "case_number": "2024-0124",
      "client_name": "Tech Solutions Inc",
      "created_date": "2024-06-16",
      "estimated_hours": 6.0,
      "actual_hours": 0.0,
      "category": "discovery",
      "attachments": 1,
    },
    {
      "id": "TSK003",
      "title": "File Motion to Dismiss",
      "description": "Draft and file motion to dismiss with supporting memorandum",
      "status": "completed",
      "priority": "high",
      "due_date": "2024-06-20",
      "assigned_to": "David Rodriguez",
      "assigned_to_id": "USR003",
      "case_number": "2024-0125",
      "client_name": "Green Valley Medical",
      "created_date": "2024-06-10",
      "estimated_hours": 8.0,
      "actual_hours": 7.5,
      "category": "motion_filing",
      "attachments": 5,
    },
    {
      "id": "TSK004",
      "title": "Client Meeting Preparation",
      "description": "Prepare materials and agenda for client strategy meeting",
      "status": "overdue",
      "priority": "medium",
      "due_date": "2024-06-18",
      "assigned_to": "Lisa Thompson",
      "assigned_to_id": "USR004",
      "case_number": "2024-0126",
      "client_name": "Metro Construction",
      "created_date": "2024-06-12",
      "estimated_hours": 2.0,
      "actual_hours": 0.0,
      "category": "client_communication",
      "attachments": 0,
    },
    {
      "id": "TSK005",
      "title": "Contract Review and Analysis",
      "description": "Review employment contracts and identify potential issues",
      "status": "in_progress",
      "priority": "low",
      "due_date": "2024-07-01",
      "assigned_to": "Robert Kim",
      "assigned_to_id": "USR005",
      "case_number": "2024-0127",
      "client_name": "Retail Plus Corp",
      "created_date": "2024-06-17",
      "estimated_hours": 5.0,
      "actual_hours": 1.5,
      "category": "contract_review",
      "attachments": 2,
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${task["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["case_number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || task["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || task["priority"] == selectedPriority;
      bool matchesAssignee = selectedAssignee == "all" || task["assigned_to_id"] == selectedAssignee;
      
      return matchesSearch && matchesStatus && matchesPriority && matchesAssignee;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledColor;
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
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      case "overdue":
        return "Overdue";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task["status"] == "completed").length;
    final inProgressTasks = tasks.where((task) => task["status"] == "in_progress").length;
    final overdueTasks = tasks.where((task) => task["status"] == "overdue").length;
    final totalHours = tasks.fold(0.0, (sum, task) => sum + (task["actual_hours"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_task),
            onPressed: () {
              // Navigate to create new task
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to task calendar view
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$completedTasks",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.schedule,
                              color: infoColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "In Progress",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$inProgressTasks",
                          style: TextStyle(
                            fontSize: fsH4,
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
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.warning,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$overdueTasks",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.timer,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Total Hours",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${totalHours.toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
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
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search tasks...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            {"label": "Pending", "value": "pending"},
                            {"label": "In Progress", "value": "in_progress"},
                            {"label": "Completed", "value": "completed"},
                            {"label": "Overdue", "value": "overdue"},
                          ],
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
                          label: "Priority",
                          items: [
                            {"label": "All Priorities", "value": "all"},
                            {"label": "High", "value": "high"},
                            {"label": "Medium", "value": "medium"},
                            {"label": "Low", "value": "low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Tasks List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
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
                          label: "Bulk Actions",
                          size: bs.sm,
                          onPressed: () {
                            si("Opening bulk actions menu...");
                          },
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 4,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${task["priority"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spMd),
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
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor("${task["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              _getStatusLabel("${task["status"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${task["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                          Icon(
                                            Icons.person,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${task["assigned_to"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Due: ${DateTime.parse("${task["due_date"]}").dMMMy}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: task["status"] == "overdue" ? dangerColor : disabledBoldColor,
                                              fontWeight: task["status"] == "overdue" ? FontWeight.w600 : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.folder,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${task["case_number"]} • ${task["client_name"]}",
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
                                          ],
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor("${task["priority"]}").withAlpha(10),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${task["priority"]}".toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getPriorityColor("${task["priority"]}"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${(task["actual_hours"] as double).toStringAsFixed(1)}h / ${(task["estimated_hours"] as double).toStringAsFixed(1)}h",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                          Spacer(),
                                          QButton(
                                            label: "View Details",
                                            size: bs.sm,
                                            onPressed: () {
                                              // Navigate to task details
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
