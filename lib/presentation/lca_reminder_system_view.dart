import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaReminderSystemView extends StatefulWidget {
  const LcaReminderSystemView({super.key});

  @override
  State<LcaReminderSystemView> createState() => _LcaReminderSystemViewState();
}

class _LcaReminderSystemViewState extends State<LcaReminderSystemView> {
  String searchQuery = "";
  String selectedType = "";
  String selectedPriority = "";
  String selectedStatus = "";
  int currentTab = 0;

  // Sample data
  List<Map<String, dynamic>> reminders = [
    {
      "id": "REM-2024-001",
      "title": "Johnson vs. Smith - Discovery Deadline",
      "description": "Submit discovery documents for Johnson vs. Smith case",
      "type": "Court Deadline",
      "priority": "High",
      "status": "Active",
      "dueDate": "2024-12-22",
      "dueTime": "5:00 PM",
      "caseId": "CASE-2024-045",
      "assignedTo": "James Mitchell",
      "reminderTimes": ["1 week before", "3 days before", "1 day before", "2 hours before"],
      "isRecurring": false,
      "completedDate": null,
      "notes": "Critical deadline - court will not grant extensions",
      "attachments": ["Discovery_Checklist.pdf", "Court_Order.pdf"],
      "category": "Legal Deadline",
      "createdBy": "Sarah Johnson",
      "createdDate": "2024-12-01",
    },
    {
      "id": "REM-2024-002",
      "title": "Client Meeting - Estate Planning Review",
      "description": "Annual review meeting with the Williams family for estate planning updates",
      "type": "Client Meeting",
      "priority": "Medium",
      "status": "Active",
      "dueDate": "2024-12-23",
      "dueTime": "2:00 PM",
      "caseId": "CASE-2024-032",
      "assignedTo": "Lisa Thompson",
      "reminderTimes": ["1 day before", "2 hours before"],
      "isRecurring": true,
      "recurringPattern": "Yearly",
      "completedDate": null,
      "notes": "Bring updated will templates and tax documents",
      "attachments": ["Estate_Plan_Draft.pdf"],
      "category": "Client Service",
      "createdBy": "Lisa Thompson",
      "createdDate": "2024-11-15",
    },
    {
      "id": "REM-2024-003",
      "title": "License Renewal - State Bar",
      "description": "Annual state bar license renewal deadline",
      "type": "Administrative",
      "priority": "High",
      "status": "Completed",
      "dueDate": "2024-12-20",
      "dueTime": "11:59 PM",
      "caseId": null,
      "assignedTo": "All Attorneys",
      "reminderTimes": ["1 month before", "1 week before", "1 day before"],
      "isRecurring": true,
      "recurringPattern": "Yearly",
      "completedDate": "2024-12-19",
      "notes": "Completed online renewal with CLE credits",
      "attachments": ["License_Certificate.pdf"],
      "category": "Professional",
      "createdBy": "Office Manager",
      "createdDate": "2024-11-01",
    },
    {
      "id": "REM-2024-004",
      "title": "Contract Review - ABC Corporation",
      "description": "Review and finalize service agreement for ABC Corporation",
      "type": "Document Review",
      "priority": "Medium",
      "status": "Snoozed",
      "dueDate": "2024-12-25",
      "dueTime": "10:00 AM",
      "caseId": "CASE-2024-078",
      "assignedTo": "Robert Wilson",
      "reminderTimes": ["3 days before", "1 day before"],
      "isRecurring": false,
      "completedDate": null,
      "notes": "Client requested additional clauses for intellectual property",
      "attachments": ["Contract_Draft.pdf", "IP_Addendum.pdf"],
      "category": "Contract Law",
      "createdBy": "Robert Wilson",
      "createdDate": "2024-12-10",
    },
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Court Deadline", "value": "Court Deadline"},
    {"label": "Client Meeting", "value": "Client Meeting"},
    {"label": "Administrative", "value": "Administrative"},
    {"label": "Document Review", "value": "Document Review"},
    {"label": "Payment Due", "value": "Payment Due"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priorities", "value": ""},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Snoozed", "value": "Snoozed"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> get filteredReminders {
    return reminders.where((reminder) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${reminder["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${reminder["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${reminder["assignedTo"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType.isEmpty || reminder["type"] == selectedType;
      bool matchesPriority = selectedPriority.isEmpty || reminder["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus.isEmpty || reminder["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesPriority && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return successColor;
      case 'Completed':
        return infoColor;
      case 'Snoozed':
        return warningColor;
      case 'Overdue':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return dangerColor;
      case 'Medium':
        return warningColor;
      case 'Low':
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Court Deadline':
        return dangerColor;
      case 'Client Meeting':
        return infoColor;
      case 'Administrative':
        return warningColor;
      case 'Document Review':
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    bool isOverdue = DateTime.parse("${reminder["dueDate"]}").isBefore(DateTime.now()) && reminder["status"] != "Completed";
    
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
            color: isOverdue ? dangerColor : _getPriorityColor("${reminder["priority"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTypeColor("${reminder["type"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["type"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getTypeColor("${reminder["type"]}"),
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${reminder["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["priority"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor("${reminder["priority"]}"),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor("${reminder["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${reminder["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${reminder["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${reminder["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: isOverdue ? dangerColor : disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${reminder["dueDate"]} at ${reminder["dueTime"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (isOverdue) ...[
                SizedBox(width: spXs),
                Icon(Icons.warning, size: 16, color: dangerColor),
                SizedBox(width: spXs),
                Text(
                  "OVERDUE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${reminder["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              if (reminder["isRecurring"] == true) ...[
                Icon(Icons.repeat, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Text(
                  "${reminder["recurringPattern"] ?? "Recurring"}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          if (reminder["caseId"] != null) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.gavel, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${reminder["caseId"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          if ((reminder["reminderTimes"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reminder Schedule:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (reminder["reminderTimes"] as List).map((time) => 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: infoColor.withAlpha(100)),
                        ),
                        child: Text(
                          "$time",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ],
              ),
            ),
          ],
          if ("${reminder["notes"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${reminder["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              if (reminder["status"] != "Completed") ...[
                Expanded(
                  child: QButton(
                    label: reminder["status"] == "Snoozed" ? "Reactivate" : "Mark Complete",
                    size: bs.sm,
                    onPressed: () => _toggleReminderStatus(reminder),
                  ),
                ),
                SizedBox(width: spSm),
              ] else ...[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 16, color: successColor),
                        SizedBox(width: spXs),
                        Text(
                          "Completed on ${reminder["completedDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
              ],
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _showEditReminder(reminder),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showReminderActions(reminder),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              Spacer(),
              Icon(
                Icons.notifications_active,
                size: 16,
                color: color,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleReminderStatus(Map<String, dynamic> reminder) {
    setState(() {
      if (reminder["status"] == "Completed") {
        reminder["status"] = "Active";
        reminder["completedDate"] = null;
      } else if (reminder["status"] == "Snoozed") {
        reminder["status"] = "Active";
      } else {
        reminder["status"] = "Completed";
        reminder["completedDate"] = DateTime.now().toString().split(' ')[0];
      }
    });
    
    if (reminder["status"] == "Completed") {
      ss("Reminder marked as completed");
    } else {
      si("Reminder reactivated");
    }
  }

  void _showEditReminder(Map<String, dynamic> reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Reminder"),
        content: Text("Edit reminder functionality would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Reminder updated successfully");
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showReminderActions(Map<String, dynamic> reminder) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reminder["status"] != "Snoozed") ...[
              ListTile(
                leading: Icon(Icons.snooze, color: warningColor),
                title: Text("Snooze Reminder"),
                onTap: () {
                  Navigator.pop(context);
                  _snoozeReminder(reminder);
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.copy, color: infoColor),
              title: Text("Duplicate Reminder"),
              onTap: () {
                Navigator.pop(context);
                si("Reminder duplicated");
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: primaryColor),
              title: Text("Share Reminder"),
              onTap: () {
                Navigator.pop(context);
                si("Reminder shared");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Reminder"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this reminder?");
                if (isConfirmed) {
                  setState(() {
                    reminders.remove(reminder);
                  });
                  se("Reminder deleted");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _snoozeReminder(Map<String, dynamic> reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Snooze Reminder"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text("Snooze for 1 hour"),
              onTap: () {
                Navigator.pop(context);
                _applySnooze(reminder, "1 hour");
              },
            ),
            ListTile(
              title: Text("Snooze for 1 day"),
              onTap: () {
                Navigator.pop(context);
                _applySnooze(reminder, "1 day");
              },
            ),
            ListTile(
              title: Text("Snooze for 1 week"),
              onTap: () {
                Navigator.pop(context);
                _applySnooze(reminder, "1 week");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _applySnooze(Map<String, dynamic> reminder, String duration) {
    setState(() {
      reminder["status"] = "Snoozed";
    });
    sw("Reminder snoozed for $duration");
  }

  void _showNewReminderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Reminder"),
        content: Text("New reminder creation form would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("New reminder created successfully");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> activeReminders = filteredReminders.where((r) => r["status"] == "Active").map((reminder) => _buildReminderCard(reminder)).toList();
    List<Widget> completedReminders = filteredReminders.where((r) => r["status"] == "Completed").map((reminder) => _buildReminderCard(reminder)).toList();
    List<Widget> snoozedReminders = filteredReminders.where((r) => r["status"] == "Snoozed").map((reminder) => _buildReminderCard(reminder)).toList();
    
    int overdueCount = reminders.where((r) => 
      DateTime.parse("${r["dueDate"]}").isBefore(DateTime.now()) && 
      r["status"] != "Completed"
    ).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reminder System"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alarm),
            onPressed: _showNewReminderDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Reminders", "${reminders.length}", Icons.notifications, primaryColor),
                _buildStatCard("Active Reminders", "${reminders.where((r) => r["status"] == "Active").length}", Icons.notification_important, successColor),
                _buildStatCard("Overdue Items", "$overdueCount", Icons.warning, dangerColor),
                _buildStatCard("Completed Today", "${reminders.where((r) => r["status"] == "Completed" && r["completedDate"] == DateTime.now().toString().split(' ')[0]).length}", Icons.check_circle, infoColor),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search reminders...",
                    value: searchQuery,
                    hint: "Search by title, description, or assignee",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
              ],
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
            
            SizedBox(height: spMd),
            
            // Active Reminders
            if (activeReminders.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.notification_important, color: successColor),
                  SizedBox(width: spXs),
                  Text(
                    "Active Reminders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${activeReminders.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...activeReminders,
              SizedBox(height: spMd),
            ],
            
            // Snoozed Reminders
            if (snoozedReminders.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.snooze, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "Snoozed Reminders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${snoozedReminders.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...snoozedReminders,
              SizedBox(height: spMd),
            ],
            
            // Completed Reminders
            if (completedReminders.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.check_circle, color: infoColor),
                  SizedBox(width: spXs),
                  Text(
                    "Completed Reminders",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${completedReminders.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              ...completedReminders,
            ],
            
            if (filteredReminders.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: disabledColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 48,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No reminders found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Create a new reminder to get started",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
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
