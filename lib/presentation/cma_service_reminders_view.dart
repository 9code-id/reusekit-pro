import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaServiceRemindersView extends StatefulWidget {
  const CmaServiceRemindersView({super.key});

  @override
  State<CmaServiceRemindersView> createState() => _CmaServiceRemindersViewState();
}

class _CmaServiceRemindersViewState extends State<CmaServiceRemindersView> {
  List<Map<String, dynamic>> activeReminders = [
    {
      "id": 1,
      "title": "Oil Change Due",
      "service_type": "Oil Change",
      "message": "Your oil change is overdue by 340 miles",
      "due_date": "2024-07-15",
      "due_mileage": 85000,
      "current_mileage": 85340,
      "priority": "High",
      "reminder_type": "Overdue",
      "notification_enabled": true,
      "advance_notice_days": 7,
      "created_date": "2024-07-20",
    },
    {
      "id": 2,
      "title": "Tire Rotation Upcoming",
      "service_type": "Tire Rotation",
      "message": "Tire rotation is due in 5 days",
      "due_date": "2024-08-20",
      "due_mileage": 88000,
      "current_mileage": 85340,
      "priority": "Medium",
      "reminder_type": "Due Soon",
      "notification_enabled": true,
      "advance_notice_days": 14,
      "created_date": "2024-08-06",
    },
    {
      "id": 3,
      "title": "Brake Inspection Scheduled",
      "service_type": "Brake Inspection",
      "message": "Don't forget your scheduled brake inspection",
      "due_date": "2024-09-10",
      "due_mileage": 90000,
      "current_mileage": 85340,
      "priority": "High",
      "reminder_type": "Scheduled",
      "notification_enabled": true,
      "advance_notice_days": 3,
      "created_date": "2024-08-27",
    },
    {
      "id": 4,
      "title": "Registration Renewal",
      "service_type": "Registration",
      "message": "Vehicle registration expires next month",
      "due_date": "2024-09-30",
      "due_mileage": 0,
      "current_mileage": 85340,
      "priority": "High",
      "reminder_type": "Upcoming",
      "notification_enabled": true,
      "advance_notice_days": 30,
      "created_date": "2024-08-30",
    },
  ];

  List<Map<String, dynamic>> reminderHistory = [
    {
      "id": 5,
      "title": "Air Filter Replacement",
      "service_type": "Air Filter",
      "completed_date": "2024-07-10",
      "reminder_date": "2024-07-05",
      "status": "Completed",
    },
    {
      "id": 6,
      "title": "Battery Check",
      "service_type": "Battery",
      "completed_date": "2024-06-25",
      "reminder_date": "2024-06-20",
      "status": "Completed",
    },
  ];

  Map<String, dynamic> reminderSettings = {
    "email_notifications": true,
    "push_notifications": true,
    "sms_notifications": false,
    "default_advance_days": 7,
    "weekend_reminders": true,
    "quiet_hours_start": "22:00",
    "quiet_hours_end": "08:00",
  };

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Reminders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.notifications_active)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildActiveRemindersTab(),
        _buildHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildActiveRemindersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Active Reminders (${activeReminders.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Add Reminder",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showAddReminderDialog();
                },
              ),
            ],
          ),

          _buildReminderSummary(),

          ...activeReminders.map((reminder) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: _getReminderPriorityColor(reminder["priority"]),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getReminderIcon(reminder["reminder_type"]),
                      color: _getReminderPriorityColor(reminder["priority"]),
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${reminder["title"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getReminderTypeColor(reminder["reminder_type"]),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${reminder["reminder_type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                
                Text(
                  "${reminder["message"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Due Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${DateTime.parse(reminder["due_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (reminder["due_mileage"] > 0)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Due Mileage",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(reminder["due_mileage"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} mi",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Priority",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${reminder["priority"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getReminderPriorityColor(reminder["priority"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Icon(
                      reminder["notification_enabled"] 
                          ? Icons.notifications_active 
                          : Icons.notifications_off,
                      color: reminder["notification_enabled"] 
                          ? successColor 
                          : disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      reminder["notification_enabled"] 
                          ? "Notifications On" 
                          : "Notifications Off",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${reminder["advance_notice_days"]} days advance notice",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Mark Complete",
                        size: bs.sm,
                        onPressed: () {
                          _markReminderComplete(reminder);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Snooze",
                      size: bs.sm,
                      onPressed: () {
                        _snoozeReminder(reminder);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        _editReminder(reminder);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Reminder History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...reminderHistory.map((reminder) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${reminder["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Completed on ${DateTime.parse(reminder["completed_date"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${reminder["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Notification Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,	
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QSwitch(
                  items: [
                    {
                      "label": "Email Notifications",
                      "value": "email",
                      "checked": reminderSettings["email_notifications"],
                    }
                  ],
                  value: reminderSettings["email_notifications"] 
                      ? [{"label": "Email Notifications", "value": "email", "checked": true}]
                      : [],
                  onChanged: (values, ids) {
                    reminderSettings["email_notifications"] = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Push Notifications",
                      "value": "push",
                      "checked": reminderSettings["push_notifications"],
                    }
                  ],
                  value: reminderSettings["push_notifications"] 
                      ? [{"label": "Push Notifications", "value": "push", "checked": true}]
                      : [],
                  onChanged: (values, ids) {
                    reminderSettings["push_notifications"] = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "SMS Notifications",
                      "value": "sms",
                      "checked": reminderSettings["sms_notifications"],
                    }
                  ],
                  value: reminderSettings["sms_notifications"] 
                      ? [{"label": "SMS Notifications", "value": "sms", "checked": true}]
                      : [],
                  onChanged: (values, ids) {
                    reminderSettings["sms_notifications"] = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QNumberField(
                  label: "Default Advance Notice (Days)",
                  value: reminderSettings["default_advance_days"].toString(),
                  hint: "Number of days before due date",
                  onChanged: (value) {
                    reminderSettings["default_advance_days"] = int.tryParse(value) ?? 7;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Weekend Reminders",
                      "value": "weekend",
                      "checked": reminderSettings["weekend_reminders"],
                    }
                  ],
                  value: reminderSettings["weekend_reminders"] 
                      ? [{"label": "Weekend Reminders", "value": "weekend", "checked": true}]
                      : [],
                  onChanged: (values, ids) {
                    reminderSettings["weekend_reminders"] = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Quiet Hours",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Start Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${reminderSettings["quiet_hours_start"]}:00")),
                        onChanged: (value) {
                          reminderSettings["quiet_hours_start"] = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "End Time",
                        value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${reminderSettings["quiet_hours_end"]}:00")),
                        onChanged: (value) {
                          reminderSettings["quiet_hours_end"] = value!.kkmm;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: () {
                _saveSettings();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderSummary() {
    int overdueCount = activeReminders.where((r) => r["reminder_type"] == "Overdue").length;
    int dueSoonCount = activeReminders.where((r) => r["reminder_type"] == "Due Soon").length;
    int upcomingCount = activeReminders.where((r) => r["reminder_type"] == "Upcoming").length;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$overdueCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Overdue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$dueSoonCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Due Soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$upcomingCount",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Upcoming",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getReminderPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getReminderTypeColor(String type) {
    switch (type) {
      case "Overdue":
        return dangerColor;
      case "Due Soon":
        return warningColor;
      case "Upcoming":
        return infoColor;
      case "Scheduled":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getReminderIcon(String type) {
    switch (type) {
      case "Overdue":
        return Icons.warning;
      case "Due Soon":
        return Icons.schedule;
      case "Upcoming":
        return Icons.event;
      case "Scheduled":
        return Icons.event_available;
      default:
        return Icons.notifications;
    }
  }

  void _showAddReminderDialog() {
    si("Add custom reminder feature coming soon");
  }

  void _markReminderComplete(Map<String, dynamic> reminder) async {
    bool isConfirmed = await confirm("Mark this reminder as complete?");
    if (isConfirmed) {
      ss("Reminder marked as complete");
      // Add to history and remove from active
      setState(() {
        activeReminders.removeWhere((r) => r["id"] == reminder["id"]);
      });
    }
  }

  void _snoozeReminder(Map<String, dynamic> reminder) {
    si("Snooze reminder for ${reminder["title"]}");
  }

  void _editReminder(Map<String, dynamic> reminder) {
    si("Edit reminder: ${reminder["title"]}");
  }

  void _saveSettings() {
    showLoading();
    
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Reminder settings saved successfully!");
    });
  }
}
