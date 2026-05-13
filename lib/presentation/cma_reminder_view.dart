import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaReminderView extends StatefulWidget {
  const CmaReminderView({super.key});

  @override
  State<CmaReminderView> createState() => _CmaReminderViewState();
}

class _CmaReminderViewState extends State<CmaReminderView> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  String selectedType = "";
  String selectedStatus = "";
  bool showOverdueOnly = false;
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Meeting", "value": "meeting"},
    {"label": "Task", "value": "task"},
    {"label": "Follow-up", "value": "follow_up"},
    {"label": "Appointment", "value": "appointment"},
    {"label": "Deadline", "value": "deadline"},
    {"label": "Call", "value": "call"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Snoozed", "value": "snoozed"},
    {"label": "Dismissed", "value": "dismissed"},
  ];

  List<Map<String, dynamic>> reminders = [
    {
      "id": "1",
      "title": "Follow up with Johnson Corp",
      "description": "Call to discuss contract renewal",
      "type": "follow_up",
      "dueDate": "2024-12-22",
      "dueTime": "10:00",
      "priority": "high",
      "status": "active",
      "client": "Johnson Corp",
      "createdDate": "2024-12-20",
      "reminderBefore": 30,
      "isOverdue": false,
      "notes": "Important client - needs immediate attention",
    },
    {
      "id": "2",
      "title": "Submit project proposal",
      "description": "Send detailed proposal to ABC Industries",
      "type": "deadline",
      "dueDate": "2024-12-21",
      "dueTime": "17:00",
      "priority": "urgent",
      "status": "active",
      "client": "ABC Industries",
      "createdDate": "2024-12-18",
      "reminderBefore": 60,
      "isOverdue": true,
      "notes": "Final deadline - cannot be extended",
    },
    {
      "id": "3",
      "title": "Team meeting preparation",
      "description": "Prepare agenda and materials for team meeting",
      "type": "task",
      "dueDate": "2024-12-23",
      "dueTime": "09:00",
      "priority": "medium",
      "status": "active",
      "client": "Internal",
      "createdDate": "2024-12-21",
      "reminderBefore": 15,
      "isOverdue": false,
      "notes": "Review last quarter performance",
    },
    {
      "id": "4",
      "title": "Client check-in call",
      "description": "Weekly check-in with TechStart LLC",
      "type": "call",
      "dueDate": "2024-12-24",
      "dueTime": "14:00",
      "priority": "medium",
      "status": "completed",
      "client": "TechStart LLC",
      "createdDate": "2024-12-17",
      "reminderBefore": 10,
      "isOverdue": false,
      "notes": "Completed successfully",
    },
    {
      "id": "5",
      "title": "Contract review meeting",
      "description": "Review terms with legal team",
      "type": "meeting",
      "dueDate": "2024-12-25",
      "dueTime": "11:00",
      "priority": "high",
      "status": "snoozed",
      "client": "Global Solutions",
      "createdDate": "2024-12-19",
      "reminderBefore": 120,
      "isOverdue": false,
      "notes": "Snoozed until tomorrow",
    },
    {
      "id": "6",
      "title": "Product demo for new client",
      "description": "Demonstrate features to potential client",
      "type": "appointment",
      "dueDate": "2024-12-26",
      "dueTime": "15:30",
      "priority": "high",
      "status": "active",
      "client": "Innovate Inc",
      "createdDate": "2024-12-22",
      "reminderBefore": 60,
      "isOverdue": false,
      "notes": "High-value prospect",
    },
  ];

  List<Map<String, dynamic>> get filteredReminders {
    return reminders.where((reminder) {
      bool matchesSearch = searchQuery.isEmpty ||
          (reminder["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (reminder["client"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType.isEmpty || reminder["type"] == selectedType;
      bool matchesStatus = selectedStatus.isEmpty || reminder["status"] == selectedStatus;
      bool matchesOverdue = !showOverdueOnly || (reminder["isOverdue"] as bool);
      
      return matchesSearch && matchesType && matchesStatus && matchesOverdue;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminders"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add reminder
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: _buildRemindersList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    int totalReminders = reminders.length;
    int activeReminders = reminders.where((r) => r["status"] == "active").length;
    int overdueReminders = reminders.where((r) => r["isOverdue"] == true).length;
    int completedReminders = reminders.where((r) => r["status"] == "completed").length;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Reminder Overview",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", totalReminders, Colors.white),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Active", activeReminders, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Overdue", overdueReminders, dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Done", completedReminders, successColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Reminders",
            value: searchQuery,
            hint: "Search by title or client name",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Show overdue only",
                "value": true,
                "checked": showOverdueOnly,
              }
            ],
            value: [
              if (showOverdueOnly)
                {
                  "label": "Show overdue only",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              setState(() {
                showOverdueOnly = values.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersList() {
    if (filteredReminders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spSm,
          children: [
            Icon(
              Icons.notification_important,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No reminders found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredReminders.length,
      itemBuilder: (context, index) {
        final reminder = filteredReminders[index];
        return _buildReminderCard(reminder, index);
      },
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder, int index) {
    Color priorityColor = _getPriorityColor(reminder["priority"]);
    Color statusColor = _getStatusColor(reminder["status"]);
    Color typeColor = _getTypeColor(reminder["type"]);
    bool isOverdue = reminder["isOverdue"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : priorityColor,
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
                  "${reminder["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: isOverdue ? dangerColor : primaryColor,
                  ),
                ),
              ),
              if (isOverdue)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "OVERDUE",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: dangerColor,
                    ),
                  ),
                ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${reminder["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${reminder["client"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["type"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: typeColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${reminder["dueDate"]} at ${reminder["dueTime"]}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(
                Icons.notification_important,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${(reminder["reminderBefore"] as int)} min before",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "Priority: ${reminder["priority"]}".toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: priorityColor,
              ),
            ),
          ),
          if (reminder["notes"] != null && (reminder["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Notes: ${reminder["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: infoColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Row(
            children: [
              if (reminder["status"] == "active")
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () {
                    _markAsCompleted(reminder["id"]);
                  },
                ),
              if (reminder["status"] == "active")
                SizedBox(width: spSm),
              if (reminder["status"] == "active")
                QButton(
                  icon: Icons.snooze,
                  size: bs.sm,
                  onPressed: () {
                    _snoozeReminder(reminder["id"]);
                  },
                ),
              if (reminder["status"] == "active")
                SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Navigate to edit reminder
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {
                  _deleteReminder(reminder["id"]);
                },
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showReminderActions(reminder);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "urgent":
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
      case "active":
        return warningColor;
      case "completed":
        return successColor;
      case "snoozed":
        return infoColor;
      case "dismissed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "meeting":
        return primaryColor;
      case "task":
        return infoColor;
      case "follow_up":
        return warningColor;
      case "appointment":
        return successColor;
      case "deadline":
        return dangerColor;
      case "call":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _markAsCompleted(String reminderId) {
    setState(() {
      int index = reminders.indexWhere((r) => r["id"] == reminderId);
      if (index != -1) {
        reminders[index]["status"] = "completed";
      }
    });
    ss("Reminder marked as completed");
  }

  void _snoozeReminder(String reminderId) {
    setState(() {
      int index = reminders.indexWhere((r) => r["id"] == reminderId);
      if (index != -1) {
        reminders[index]["status"] = "snoozed";
      }
    });
    ss("Reminder snoozed for 1 hour");
  }

  void _deleteReminder(String reminderId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this reminder?");
    if (isConfirmed) {
      setState(() {
        reminders.removeWhere((r) => r["id"] == reminderId);
      });
      ss("Reminder deleted successfully");
    }
  }

  void _showReminderActions(Map<String, dynamic> reminder) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Container(
              width: double.infinity,
              child: QButton(
                label: "Edit Reminder",
                size: bs.md,
                onPressed: () {
                  back();
                  // Navigate to edit
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Duplicate Reminder",
                size: bs.md,
                onPressed: () {
                  back();
                  _duplicateReminder(reminder);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Share Reminder",
                size: bs.md,
                onPressed: () {
                  back();
                  _shareReminder(reminder);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _duplicateReminder(Map<String, dynamic> reminder) {
    Map<String, dynamic> newReminder = Map.from(reminder);
    newReminder["id"] = DateTime.now().millisecondsSinceEpoch.toString();
    newReminder["title"] = "Copy of ${reminder["title"]}";
    newReminder["status"] = "active";
    
    setState(() {
      reminders.add(newReminder);
    });
    ss("Reminder duplicated successfully");
  }

  void _shareReminder(Map<String, dynamic> reminder) {
    // Simulate sharing
    ss("Reminder shared successfully");
  }
}
