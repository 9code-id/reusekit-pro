import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmContactActivitiesView extends StatefulWidget {
  const CrmContactActivitiesView({super.key});

  @override
  State<CrmContactActivitiesView> createState() => _CrmContactActivitiesViewState();
}

class _CrmContactActivitiesViewState extends State<CrmContactActivitiesView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedPeriod = "today";
  bool loading = false;

  List<Map<String, dynamic>> activities = [
    {
      "id": "1",
      "type": "email",
      "title": "Email sent to John Doe",
      "description": "Welcome email campaign delivered successfully",
      "contact_name": "John Doe",
      "contact_email": "john.doe@example.com",
      "timestamp": "2024-06-19T10:30:00",
      "status": "completed",
      "duration": "2 minutes",
      "outcome": "opened"
    },
    {
      "id": "2",
      "type": "call",
      "title": "Phone call with Sarah Wilson",
      "description": "Discussed product demo and pricing options",
      "contact_name": "Sarah Wilson",
      "contact_phone": "+1 (555) 0123",
      "timestamp": "2024-06-19T09:15:00",
      "status": "completed",
      "duration": "25 minutes",
      "outcome": "positive"
    },
    {
      "id": "3",
      "type": "meeting",
      "title": "Sales meeting with Tech Corp",
      "description": "Quarterly business review and contract renewal",
      "contact_name": "Mike Johnson",
      "contact_company": "Tech Corp",
      "timestamp": "2024-06-19T14:00:00",
      "status": "scheduled",
      "duration": "1 hour",
      "outcome": "pending"
    },
    {
      "id": "4",
      "type": "sms",
      "title": "SMS reminder sent",
      "description": "Appointment reminder for tomorrow's meeting",
      "contact_name": "Emily Davis",
      "contact_phone": "+1 (555) 0456",
      "timestamp": "2024-06-18T16:45:00",
      "status": "delivered",
      "duration": "instant",
      "outcome": "read"
    },
    {
      "id": "5",
      "type": "email",
      "title": "Follow-up email to prospect",
      "description": "Product information and case studies attached",
      "contact_name": "Robert Chen",
      "contact_email": "robert.chen@company.com",
      "timestamp": "2024-06-18T11:20:00",
      "status": "bounced",
      "duration": "failed",
      "outcome": "failed"
    },
    {
      "id": "6",
      "type": "note",
      "title": "Contact note added",
      "description": "Customer expressed interest in enterprise package",
      "contact_name": "Lisa Anderson",
      "contact_email": "lisa.anderson@business.com",
      "timestamp": "2024-06-18T13:30:00",
      "status": "completed",
      "duration": "5 minutes",
      "outcome": "noted"
    }
  ];

  List<Map<String, dynamic>> get filteredActivities {
    return activities.where((activity) {
      final matchesSearch = "${activity["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           "${activity["contact_name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesType = selectedType == "all" || "${activity["type"]}" == selectedType;
      final matchesPeriod = _matchesPeriod(activity);
      return matchesSearch && matchesType && matchesPeriod;
    }).toList()..sort((a, b) => DateTime.parse("${b["timestamp"]}").compareTo(DateTime.parse("${a["timestamp"]}")));
  }

  bool _matchesPeriod(Map<String, dynamic> activity) {
    final activityDate = DateTime.parse("${activity["timestamp"]}");
    final now = DateTime.now();
    
    switch (selectedPeriod) {
      case "today":
        return activityDate.day == now.day && activityDate.month == now.month && activityDate.year == now.year;
      case "week":
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        return activityDate.isAfter(weekStart);
      case "month":
        return activityDate.month == now.month && activityDate.year == now.year;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Activities"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddActivityDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search activities...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            // Filter Chips
            QHorizontalScroll(
              children: [
                _buildFilterChip("All", "all", selectedType),
                _buildFilterChip("Emails", "email", selectedType),
                _buildFilterChip("Calls", "call", selectedType),
                _buildFilterChip("Meetings", "meeting", selectedType),
                _buildFilterChip("SMS", "sms", selectedType),
                _buildFilterChip("Notes", "note", selectedType),
              ],
            ),

            // Activity Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildStatCard("Today", "${activities.where((a) => _matchesPeriodForStat(a, "today")).length}", primaryColor, Icons.today),
                _buildStatCard("This Week", "${activities.where((a) => _matchesPeriodForStat(a, "week")).length}", successColor, Icons.date_range),
                _buildStatCard("Completed", "${activities.where((a) => a["status"] == "completed").length}", infoColor, Icons.check_circle),
                _buildStatCard("Pending", "${activities.where((a) => a["status"] == "scheduled").length}", warningColor, Icons.schedule),
              ],
            ),

            // Activities List
            if (loading)
              Center(child: CircularProgressIndicator())
            else if (filteredActivities.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.history, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No activities found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredActivities.map((activity) => _buildActivityCard(activity)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddActivityDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, String selectedValue) {
    final isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () {
        selectedType = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
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
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
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
            color: _getActivityColor("${activity["type"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getActivityIcon("${activity["type"]}"),
                color: _getActivityColor("${activity["type"]}"),
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${activity["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${activity["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${activity["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${activity["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${activity["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${activity["contact_name"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                _formatTimestamp("${activity["timestamp"]}"),
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (activity["duration"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.timer, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${activity["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          if (activity["outcome"] != null && activity["outcome"] != "pending") ...[
            SizedBox(height: spSm),
            Row(
              children: [
                Icon(
                  _getOutcomeIcon("${activity["outcome"]}"),
                  size: 16,
                  color: _getOutcomeColor("${activity["outcome"]}"),
                ),
                SizedBox(width: spXs),
                Text(
                  "Outcome: ${activity["outcome"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getOutcomeColor("${activity["outcome"]}"),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _showActivityDetails(activity);
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (activity["type"] == "email")
                QButton(
                  icon: Icons.reply,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CrmComposeEmailView');
                  },
                )
              else if (activity["type"] == "call")
                QButton(
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('CrmCallView');
                  },
                ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showActivityOptions(activity);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "call":
        return Icons.phone;
      case "meeting":
        return Icons.event;
      case "sms":
        return Icons.sms;
      case "note":
        return Icons.note;
      default:
        return Icons.history;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case "email":
        return primaryColor;
      case "call":
        return successColor;
      case "meeting":
        return infoColor;
      case "sms":
        return warningColor;
      case "note":
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "scheduled":
        return warningColor;
      case "delivered":
        return infoColor;
      case "bounced":
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getOutcomeIcon(String outcome) {
    switch (outcome) {
      case "positive":
      case "opened":
      case "read":
        return Icons.check_circle;
      case "negative":
      case "failed":
        return Icons.cancel;
      case "neutral":
      case "noted":
        return Icons.info;
      default:
        return Icons.help;
    }
  }

  Color _getOutcomeColor(String outcome) {
    switch (outcome) {
      case "positive":
      case "opened":
      case "read":
        return successColor;
      case "negative":
      case "failed":
        return dangerColor;
      case "neutral":
      case "noted":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _matchesPeriodForStat(Map<String, dynamic> activity, String period) {
    final activityDate = DateTime.parse("${activity["timestamp"]}");
    final now = DateTime.now();
    
    switch (period) {
      case "today":
        return activityDate.day == now.day && activityDate.month == now.month && activityDate.year == now.year;
      case "week":
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        return activityDate.isAfter(weekStart);
      default:
        return true;
    }
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else {
        return "${difference.inDays}d ago";
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Activities"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Time Period", style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile(
              title: Text("Today"),
              value: "today",
              groupValue: selectedPeriod,
              onChanged: (value) {
                selectedPeriod = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("This Week"),
              value: "week",
              groupValue: selectedPeriod,
              onChanged: (value) {
                selectedPeriod = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("This Month"),
              value: "month",
              groupValue: selectedPeriod,
              onChanged: (value) {
                selectedPeriod = value!;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddActivityDialog() {
    String activityType = "note";
    String title = "";
    String description = "";
    String contactName = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Activity"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Activity Type",
              items: [
                {"label": "Note", "value": "note"},
                {"label": "Email", "value": "email"},
                {"label": "Call", "value": "call"},
                {"label": "Meeting", "value": "meeting"},
                {"label": "SMS", "value": "sms"},
              ],
              value: activityType,
              onChanged: (value, label) => activityType = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Title",
              value: title,
              onChanged: (value) => title = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: description,
              onChanged: (value) => description = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Contact Name",
              value: contactName,
              onChanged: (value) => contactName = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () {
              if (title.isNotEmpty && contactName.isNotEmpty) {
                Navigator.pop(context);
                _addActivity(activityType, title, description, contactName);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Activity Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${activity["type"]}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: spXs),
            Text("Contact: ${activity["contact_name"]}"),
            SizedBox(height: spXs),
            Text("Status: ${activity["status"]}"),
            SizedBox(height: spXs),
            Text("Time: ${_formatTimestamp("${activity["timestamp"]}")}"),
            if (activity["duration"] != null) ...[
              SizedBox(height: spXs),
              Text("Duration: ${activity["duration"]}"),
            ],
            if (activity["outcome"] != null) ...[
              SizedBox(height: spXs),
              Text("Outcome: ${activity["outcome"]}"),
            ],
            SizedBox(height: spSm),
            Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${activity["description"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showActivityOptions(Map<String, dynamic> activity) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Activity"),
              onTap: () {
                Navigator.pop(context);
                _editActivity(activity);
              },
            ),
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text("Duplicate Activity"),
              onTap: () {
                Navigator.pop(context);
                _duplicateActivity(activity);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Activity", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this activity?");
                if (isConfirmed) {
                  _deleteActivity(activity);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addActivity(String type, String title, String description, String contactName) {
    final newActivity = {
      "id": "${activities.length + 1}",
      "type": type,
      "title": title,
      "description": description,
      "contact_name": contactName,
      "timestamp": DateTime.now().toString(),
      "status": "completed",
      "duration": "manual entry",
      "outcome": "noted"
    };
    
    activities.insert(0, newActivity);
    setState(() {});
    ss("Activity added successfully");
  }

  void _editActivity(Map<String, dynamic> activity) {
    // Implementation for editing activity
    ss("Edit functionality would be implemented here");
  }

  void _duplicateActivity(Map<String, dynamic> activity) {
    final duplicatedActivity = Map<String, dynamic>.from(activity);
    duplicatedActivity["id"] = "${activities.length + 1}";
    duplicatedActivity["title"] = "${activity["title"]} (Copy)";
    duplicatedActivity["timestamp"] = DateTime.now().toString();
    
    activities.insert(0, duplicatedActivity);
    setState(() {});
    ss("Activity duplicated successfully");
  }

  void _deleteActivity(Map<String, dynamic> activity) {
    activities.removeWhere((a) => a["id"] == activity["id"]);
    setState(() {});
    ss("Activity deleted successfully");
  }
}
