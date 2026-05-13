import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTaskHistoryView extends StatefulWidget {
  const TpmTaskHistoryView({super.key});

  @override
  State<TpmTaskHistoryView> createState() => _TpmTaskHistoryViewState();
}

class _TpmTaskHistoryViewState extends State<TpmTaskHistoryView> {
  String searchQuery = "";
  String selectedTask = "";
  String selectedUser = "";
  String selectedAction = "";
  DateTime? startDate;
  DateTime? endDate;

  List<Map<String, dynamic>> historyEntries = [
    {
      "id": 1,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "created",
      "performedBy": "Sarah Johnson",
      "performedByAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "timestamp": "2024-12-19 10:30:00",
      "details": "Task created with initial requirements and specifications",
      "previousState": null,
      "newState": {
        "status": "Not Started",
        "priority": "High",
        "assignee": "Michael Chen"
      },
      "field": "task",
      "oldValue": null,
      "newValue": "Database Design",
      "attachments": []
    },
    {
      "id": 2,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "assigned",
      "performedBy": "Sarah Johnson",
      "performedByAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "timestamp": "2024-12-19 10:35:00",
      "details": "Task assigned to Michael Chen",
      "previousState": {"assignee": null},
      "newState": {"assignee": "Michael Chen"},
      "field": "assignee",
      "oldValue": null,
      "newValue": "Michael Chen",
      "attachments": []
    },
    {
      "id": 3,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "status_changed",
      "performedBy": "Michael Chen",
      "performedByAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "timestamp": "2024-12-19 14:20:00",
      "details": "Status changed from Not Started to In Progress",
      "previousState": {"status": "Not Started"},
      "newState": {"status": "In Progress"},
      "field": "status",
      "oldValue": "Not Started",
      "newValue": "In Progress",
      "attachments": []
    },
    {
      "id": 4,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "comment_added",
      "performedBy": "Michael Chen",
      "performedByAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "timestamp": "2024-12-19 16:45:00",
      "details": "Added comment: Initial schema design completed. Ready for review.",
      "previousState": null,
      "newState": null,
      "field": "comment",
      "oldValue": null,
      "newValue": "Initial schema design completed. Ready for review.",
      "attachments": []
    },
    {
      "id": 5,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "file_attached",
      "performedBy": "Michael Chen",
      "performedByAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "timestamp": "2024-12-19 16:50:00",
      "details": "Attached file: database_schema.sql",
      "previousState": null,
      "newState": null,
      "field": "attachment",
      "oldValue": null,
      "newValue": "database_schema.sql",
      "attachments": ["database_schema.sql"]
    },
    {
      "id": 6,
      "taskId": "DSN-001",
      "taskTitle": "UI Mockups",
      "action": "created",
      "performedBy": "Sarah Johnson",
      "performedByAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "timestamp": "2024-12-18 09:15:00",
      "details": "Task created for UI design requirements",
      "previousState": null,
      "newState": {
        "status": "Not Started",
        "priority": "Medium",
        "assignee": "Emma Wilson"
      },
      "field": "task",
      "oldValue": null,
      "newValue": "UI Mockups",
      "attachments": []
    },
    {
      "id": 7,
      "taskId": "DSN-001",
      "taskTitle": "UI Mockups",
      "action": "priority_changed",
      "performedBy": "Emma Wilson",
      "performedByAvatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "timestamp": "2024-12-18 11:30:00",
      "details": "Priority changed from Medium to High",
      "previousState": {"priority": "Medium"},
      "newState": {"priority": "High"},
      "field": "priority",
      "oldValue": "Medium",
      "newValue": "High",
      "attachments": []
    },
    {
      "id": 8,
      "taskId": "TSK-002",
      "taskTitle": "API Development",
      "action": "due_date_changed",
      "performedBy": "Sarah Johnson",
      "performedByAvatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "timestamp": "2024-12-17 15:20:00",
      "details": "Due date changed from 2024-12-30 to 2024-12-25",
      "previousState": {"dueDate": "2024-12-30"},
      "newState": {"dueDate": "2024-12-25"},
      "field": "dueDate",
      "oldValue": "2024-12-30",
      "newValue": "2024-12-25",
      "attachments": []
    },
    {
      "id": 9,
      "taskId": "TST-001",
      "taskTitle": "Integration Testing",
      "action": "dependency_added",
      "performedBy": "David Rodriguez",
      "performedByAvatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "timestamp": "2024-12-17 13:45:00",
      "details": "Added dependency: Task must wait for API Development completion",
      "previousState": null,
      "newState": {"dependency": "TSK-002"},
      "field": "dependency",
      "oldValue": null,
      "newValue": "API Development (TSK-002)",
      "attachments": []
    },
    {
      "id": 10,
      "taskId": "TSK-001",
      "taskTitle": "Database Design",
      "action": "completed",
      "performedBy": "Michael Chen",
      "performedByAvatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "timestamp": "2024-12-16 17:30:00",
      "details": "Task marked as completed",
      "previousState": {"status": "In Progress"},
      "newState": {"status": "Completed"},
      "field": "status",
      "oldValue": "In Progress",
      "newValue": "Completed",
      "attachments": []
    }
  ];

  List<Map<String, dynamic>> tasks = [
    {"label": "All Tasks", "value": ""},
    {"label": "Database Design", "value": "TSK-001"},
    {"label": "UI Mockups", "value": "DSN-001"},
    {"label": "API Development", "value": "TSK-002"},
    {"label": "Integration Testing", "value": "TST-001"}
  ];

  List<Map<String, dynamic>> users = [
    {"label": "All Users", "value": ""},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Michael Chen", "value": "Michael Chen"},
    {"label": "Emma Wilson", "value": "Emma Wilson"},
    {"label": "David Rodriguez", "value": "David Rodriguez"}
  ];

  List<Map<String, dynamic>> actions = [
    {"label": "All Actions", "value": ""},
    {"label": "Created", "value": "created"},
    {"label": "Assigned", "value": "assigned"},
    {"label": "Status Changed", "value": "status_changed"},
    {"label": "Priority Changed", "value": "priority_changed"},
    {"label": "Comment Added", "value": "comment_added"},
    {"label": "File Attached", "value": "file_attached"},
    {"label": "Due Date Changed", "value": "due_date_changed"},
    {"label": "Dependency Added", "value": "dependency_added"},
    {"label": "Completed", "value": "completed"}
  ];

  List<Map<String, dynamic>> get filteredHistoryEntries {
    return historyEntries.where((entry) {
      bool matchesSearch = searchQuery.isEmpty ||
          (entry["taskTitle"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (entry["details"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (entry["performedBy"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesTask = selectedTask.isEmpty || entry["taskId"] == selectedTask;
      bool matchesUser = selectedUser.isEmpty || entry["performedBy"] == selectedUser;
      bool matchesAction = selectedAction.isEmpty || entry["action"] == selectedAction;
      
      DateTime entryDate = DateTime.parse(entry["timestamp"] as String);
      bool matchesDateRange = true;
      
      if (startDate != null) {
        matchesDateRange = matchesDateRange && entryDate.isAfter(startDate!.subtract(Duration(days: 1)));
      }
      
      if (endDate != null) {
        matchesDateRange = matchesDateRange && entryDate.isBefore(endDate!.add(Duration(days: 1)));
      }
      
      return matchesSearch && matchesTask && matchesUser && matchesAction && matchesDateRange;
    }).toList()..sort((a, b) => (b["timestamp"] as String).compareTo(a["timestamp"] as String));
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "created":
        return primaryColor;
      case "assigned":
        return infoColor;
      case "status_changed":
        return warningColor;
      case "priority_changed":
        return secondaryColor;
      case "comment_added":
        return successColor;
      case "file_attached":
        return primaryColor;
      case "due_date_changed":
        return warningColor;
      case "dependency_added":
        return infoColor;
      case "completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case "created":
        return Icons.add_circle;
      case "assigned":
        return Icons.person_add;
      case "status_changed":
        return Icons.swap_horiz;
      case "priority_changed":
        return Icons.priority_high;
      case "comment_added":
        return Icons.comment;
      case "file_attached":
        return Icons.attach_file;
      case "due_date_changed":
        return Icons.schedule;
      case "dependency_added":
        return Icons.account_tree;
      case "completed":
        return Icons.check_circle;
      default:
        return Icons.history;
    }
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }

  String _getActionTitle(String action) {
    switch (action) {
      case "created":
        return "Task Created";
      case "assigned":
        return "Task Assigned";
      case "status_changed":
        return "Status Changed";
      case "priority_changed":
        return "Priority Changed";
      case "comment_added":
        return "Comment Added";
      case "file_attached":
        return "File Attached";
      case "due_date_changed":
        return "Due Date Changed";
      case "dependency_added":
        return "Dependency Added";
      case "completed":
        return "Task Completed";
      default:
        return "Unknown Action";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task History"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowXs],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search history...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Task",
                        items: tasks,
                        value: selectedTask,
                        onChanged: (value, label) {
                          selectedTask = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "User",
                        items: users,
                        value: selectedUser,
                        onChanged: (value, label) {
                          selectedUser = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Action",
                        items: actions,
                        value: selectedAction,
                        onChanged: (value, label) {
                          selectedAction = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_alt,
                      size: bs.sm,
                      onPressed: () => _showDateRangeFilter(),
                    ),
                  ],
                ),

                if (startDate != null || endDate != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.date_range, color: primaryColor, size: 16),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Filtered: ${startDate?.day}/${startDate?.month}/${startDate?.year} - ${endDate?.day}/${endDate?.month}/${endDate?.year}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            startDate = null;
                            endDate = null;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: primaryColor, size: 16),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Showing ${filteredHistoryEntries.length} history entries",
                    style: TextStyle(
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.file_download,
                  size: bs.sm,
                  onPressed: () => _exportHistory(),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredHistoryEntries.isEmpty
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_outlined,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No history entries found",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Try adjusting your search filters",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredHistoryEntries.length,
                    itemBuilder: (context, index) {
                      final entry = filteredHistoryEntries[index];
                      return _buildHistoryEntry(entry, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryEntry(Map<String, dynamic> entry, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getActionColor("${entry["action"]}").withAlpha(20),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getActionColor("${entry["action"]}"),
                    width: 2,
                  ),
                ),
                child: Icon(
                  _getActionIcon("${entry["action"]}"),
                  color: _getActionColor("${entry["action"]}"),
                  size: 20,
                ),
              ),
              if (index < filteredHistoryEntries.length - 1)
                Container(
                  width: 2,
                  height: 30,
                  color: disabledColor.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: spXs),
                ),
            ],
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getActionTitle("${entry["action"]}"),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _getActionColor("${entry["action"]}"),
                              ),
                            ),
                            Text(
                              "${entry["taskTitle"]} (${entry["taskId"]})",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _formatTimestamp("${entry["timestamp"]}"),
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage("${entry["performedByAvatar"]}"),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${entry["performedBy"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${entry["details"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),

                  if (entry["oldValue"] != null && entry["newValue"] != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: warningColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Changes:",
                            style: TextStyle(
                              fontSize: 11,
                              color: warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "- ${entry["oldValue"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: spXs),
                              Icon(Icons.arrow_forward, size: 12, color: disabledColor),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "+ ${entry["newValue"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  if ((entry["attachments"] as List).isNotEmpty)
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (entry["attachments"] as List).map((attachment) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.attach_file, size: 12, color: primaryColor),
                              SizedBox(width: 4),
                              Text(
                                "$attachment",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
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
          ),
        ],
      ),
    );
  }

  void _showDateRangeFilter() {
    // Implementation for showing date range filter dialog
  }

  void _exportHistory() {
    // Implementation for exporting history
    ss("History exported successfully");
  }
}
