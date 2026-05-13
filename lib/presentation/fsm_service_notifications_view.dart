import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmServiceNotificationsView extends StatefulWidget {
  const FsmServiceNotificationsView({super.key});

  @override
  State<FsmServiceNotificationsView> createState() => _FsmServiceNotificationsViewState();
}

class _FsmServiceNotificationsViewState extends State<FsmServiceNotificationsView> {
  int selectedTab = 0;
  bool enableNotifications = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool ledEnabled = false;
  String selectedSound = "Default";
  int quietHoursStart = 22;
  int quietHoursEnd = 7;

  List<Map<String, dynamic>> activeNotifications = [
    {
      "id": "1",
      "type": "job_assigned",
      "title": "New Job Assigned",
      "message": "HVAC Maintenance at Johnson Residence - 2:30 PM",
      "timestamp": "2024-03-15 14:15",
      "priority": "High",
      "customerName": "Sarah Johnson",
      "jobId": "JOB-2024-001",
      "isRead": false,
      "actionRequired": true,
      "location": "1234 Oak Street, Downtown"
    },
    {
      "id": "2",
      "type": "route_updated",
      "title": "Route Updated",
      "message": "Your next appointment has been rescheduled to 4:30 PM",
      "timestamp": "2024-03-15 13:45",
      "priority": "Medium",
      "customerName": "Mike Rodriguez",
      "jobId": "JOB-2024-002",
      "isRead": false,
      "actionRequired": false,
      "location": "5678 Pine Avenue, Riverside"
    },
    {
      "id": "3",
      "type": "customer_message",
      "title": "Customer Message",
      "message": "Customer inquiry about additional services",
      "timestamp": "2024-03-15 13:20",
      "priority": "Low",
      "customerName": "Lisa Chen",
      "jobId": "JOB-2024-003",
      "isRead": true,
      "actionRequired": true,
      "location": "9012 Maple Drive, Northside"
    },
    {
      "id": "4",
      "type": "emergency",
      "title": "Emergency Call",
      "message": "Urgent plumbing repair requested - burst pipe",
      "timestamp": "2024-03-15 12:50",
      "priority": "Critical",
      "customerName": "Robert Wilson",
      "jobId": "JOB-2024-004",
      "isRead": false,
      "actionRequired": true,
      "location": "3456 Elm Street, Eastside"
    }
  ];

  List<Map<String, dynamic>> notificationHistory = [
    {
      "id": "1",
      "type": "job_completed",
      "title": "Job Completed",
      "message": "HVAC Installation completed successfully",
      "timestamp": "2024-03-14 16:30",
      "customerName": "David Smith",
      "status": "acknowledged",
      "response": "Marked as completed"
    },
    {
      "id": "2",
      "type": "payment_received",
      "title": "Payment Received",
      "message": "Payment of \$350.00 received for Job #JOB-2024-005",
      "timestamp": "2024-03-14 15:15",
      "customerName": "Emma Davis",
      "status": "acknowledged",
      "response": "Payment confirmed"
    },
    {
      "id": "3",
      "type": "schedule_reminder",
      "title": "Schedule Reminder",
      "message": "Tomorrow's schedule: 3 appointments starting at 9:00 AM",
      "timestamp": "2024-03-14 18:00",
      "customerName": "",
      "status": "read",
      "response": "Schedule reviewed"
    }
  ];

  List<Map<String, dynamic>> notificationSettings = [
    {
      "category": "Job Assignments",
      "description": "New jobs and schedule changes",
      "types": [
        {"name": "New Job Assigned", "enabled": true},
        {"name": "Job Rescheduled", "enabled": true},
        {"name": "Job Cancelled", "enabled": true},
        {"name": "Route Updated", "enabled": true}
      ]
    },
    {
      "category": "Customer Communications",
      "description": "Messages and feedback from customers",
      "types": [
        {"name": "Customer Messages", "enabled": true},
        {"name": "Customer Calls", "enabled": true},
        {"name": "Review Received", "enabled": false},
        {"name": "Complaint Filed", "enabled": true}
      ]
    },
    {
      "category": "Emergency Alerts",
      "description": "Urgent situations requiring immediate attention",
      "types": [
        {"name": "Emergency Calls", "enabled": true},
        {"name": "Safety Alerts", "enabled": true},
        {"name": "Equipment Malfunction", "enabled": true},
        {"name": "Weather Warnings", "enabled": false}
      ]
    },
    {
      "category": "System Updates",
      "description": "App and system related notifications",
      "types": [
        {"name": "App Updates", "enabled": false},
        {"name": "Maintenance Notices", "enabled": true},
        {"name": "Policy Changes", "enabled": false},
        {"name": "Training Reminders", "enabled": true}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Service Notifications",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.notifications_active)),
        Tab(text: "Settings", icon: Icon(Icons.tune)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildActiveTab(),
        _buildSettingsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildActiveTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Notification Status
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: enableNotifications ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: enableNotifications ? successColor : dangerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: enableNotifications ? successColor : dangerColor,
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    enableNotifications ? Icons.notifications_active : Icons.notifications_off,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enableNotifications ? "Notifications Enabled" : "Notifications Disabled",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        enableNotifications 
                          ? "You'll receive all service notifications"
                          : "You won't receive any notifications",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: enableNotifications ? "Disable" : "Enable",
                  size: bs.sm,
                  onPressed: () {
                    enableNotifications = !enableNotifications;
                    setState(() {});
                    ss(enableNotifications ? "Notifications enabled" : "Notifications disabled");
                  },
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Unread", "${activeNotifications.where((n) => !(n["isRead"] as bool)).length}", Icons.mark_email_unread, dangerColor),
              _buildStatCard("Action Required", "${activeNotifications.where((n) => n["actionRequired"] as bool).length}", Icons.priority_high, warningColor),
              _buildStatCard("Emergency", "${activeNotifications.where((n) => n["priority"] == "Critical").length}", Icons.emergency, dangerColor),
              _buildStatCard("Today's Total", "12", Icons.today, primaryColor),
            ],
          ),

          // Active Notifications List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_active, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Active Notifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Mark All Read",
                      size: bs.sm,
                      onPressed: () {
                        for (var notification in activeNotifications) {
                          notification["isRead"] = true;
                        }
                        setState(() {});
                        ss("All notifications marked as read");
                      },
                    ),
                  ],
                ),
                if (activeNotifications.isEmpty)
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(Icons.notifications_none, size: 48, color: disabledColor),
                        SizedBox(height: spSm),
                        Text(
                          "No active notifications",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ...activeNotifications.map((notification) => _buildNotificationCard(notification)),
              ],
            ),
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Test Notification",
                        icon: Icons.notifications,
                        size: bs.sm,
                        onPressed: () {
                          ss("Test notification sent");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Clear All",
                        icon: Icons.clear_all,
                        size: bs.sm,
                        onPressed: () {
                          activeNotifications.clear();
                          setState(() {});
                          ss("All notifications cleared");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
          // General Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "General Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSwitchItem("Enable Notifications", "Receive all service notifications", enableNotifications, (value) {
                  enableNotifications = value;
                  setState(() {});
                }),
                _buildSwitchItem("Sound", "Play notification sounds", soundEnabled, (value) {
                  soundEnabled = value;
                  setState(() {});
                }),
                _buildSwitchItem("Vibration", "Vibrate on notifications", vibrationEnabled, (value) {
                  vibrationEnabled = value;
                  setState(() {});
                }),
                _buildSwitchItem("LED Indicator", "Show LED notification light", ledEnabled, (value) {
                  ledEnabled = value;
                  setState(() {});
                }),
              ],
            ),
          ),

          // Sound Settings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Sound Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSoundOption("Default", "System default notification sound", selectedSound == "Default"),
                _buildSoundOption("Alert", "Alert tone for urgent notifications", selectedSound == "Alert"),
                _buildSoundOption("Chime", "Gentle chime for normal notifications", selectedSound == "Chime"),
                _buildSoundOption("Buzz", "Buzzer sound for emergency alerts", selectedSound == "Buzz"),
              ],
            ),
          ),

          // Quiet Hours
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Quiet Hours",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Suppress non-urgent notifications during these hours",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildTimeSelector("Start Time", quietHoursStart, (value) {
                        quietHoursStart = value;
                        setState(() {});
                      }),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: _buildTimeSelector("End Time", quietHoursEnd, (value) {
                        quietHoursEnd = value;
                        setState(() {});
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification Categories
          ...notificationSettings.map((category) => _buildCategorySettings(category)),
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
          // History Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "This Week's Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 140,
                  children: [
                    _buildSummaryCard("Total", "156", Icons.notifications, primaryColor),
                    _buildSummaryCard("Acknowledged", "142", Icons.check, successColor),
                    _buildSummaryCard("Missed", "8", Icons.notifications_off, warningColor),
                    _buildSummaryCard("Emergency", "6", Icons.emergency, dangerColor),
                  ],
                ),
              ],
            ),
          ),

          // Filter Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Filter History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "All Types",
                        size: bs.sm,
                        onPressed: () {
                          ss("Showing all notification types");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Job Related",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering job notifications");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Emergency",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering emergency alerts");
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Today",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering today's notifications");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "This Week",
                        size: bs.sm,
                        onPressed: () {
                          ss("Filtering this week");
                        },
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Custom",
                        size: bs.sm,
                        onPressed: () {
                          ss("Custom date range");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification History List
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Notification History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Export",
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Exporting notification history");
                      },
                    ),
                  ],
                ),
                ...notificationHistory.map((history) => _buildHistoryCard(history)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    Color priorityColor = _getPriorityColor(notification["priority"] as String);
    Color typeColor = _getTypeColor(notification["type"] as String);
    bool isRead = notification["isRead"] as bool;
    bool actionRequired = notification["actionRequired"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : priorityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: isRead ? disabledOutlineBorderColor : priorityColor.withAlpha(30),
          width: isRead ? 1 : 2,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: typeColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getTypeIcon(notification["type"] as String),
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    if ((notification["customerName"] as String).isNotEmpty)
                      Text(
                        "${notification["customerName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${notification["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Text(
              "${notification["message"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.schedule, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${DateTime.parse(notification["timestamp"] as String).dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse(notification["timestamp"] as String)).format(context)}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if ((notification["location"] as String).isNotEmpty) ...[
                SizedBox(width: spMd),
                Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${notification["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              if (!isRead)
                Expanded(
                  child: QButton(
                    label: "Mark Read",
                    size: bs.sm,
                    onPressed: () {
                      notification["isRead"] = true;
                      setState(() {});
                      ss("Notification marked as read");
                    },
                  ),
                ),
              if (actionRequired)
                Expanded(
                  child: QButton(
                    label: "Take Action",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      ss("Opening ${notification["title"]}");
                    },
                  ),
                ),
              QButton(
                icon: Icons.close,
                size: bs.sm,
                onPressed: () {
                  activeNotifications.removeWhere((n) => n["id"] == notification["id"]);
                  setState(() {});
                  ss("Notification dismissed");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSoundOption(String name, String description, bool isSelected) {
    return GestureDetector(
      onTap: () {
        selectedSound = name;
        setState(() {});
        ss("Sound changed to $name");
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.music_note,
              color: isSelected ? primaryColor : disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: primaryColor, size: 20)
            else
              Icon(Icons.play_arrow, color: disabledBoldColor, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(String title, int hour, Function(int) onChanged) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${hour.toString().padLeft(2, '0')}:00",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.schedule,
                size: bs.sm,
                onPressed: () {
                  // Time picker would go here
                  ss("Opening time picker for $title");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySettings(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(_getCategoryIcon(category["category"] as String), color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${category["description"]}",
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
          ...(category["types"] as List).map((type) => _buildTypeToggle(type)),
        ],
      ),
    );
  }

  Widget _buildTypeToggle(Map<String, dynamic> type) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${type["name"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
          Switch(
            value: type["enabled"] as bool,
            onChanged: (value) {
              type["enabled"] = value;
              setState(() {});
              ss("${type["name"]} ${value ? 'enabled' : 'disabled'}");
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> history) {
    Color statusColor = _getHistoryStatusColor(history["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  _getTypeIcon(history["type"] as String),
                  color: Colors.white,
                  size: 14,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${history["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((history["customerName"] as String).isNotEmpty)
                      Text(
                        "${history["customerName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                "${DateTime.parse(history["timestamp"] as String).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.reply, color: statusColor, size: 14),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${history["response"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical': return dangerColor;
      case 'high': return warningColor;
      case 'medium': return primaryColor;
      case 'low': return successColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'job_assigned': return primaryColor;
      case 'route_updated': return infoColor;
      case 'customer_message': return successColor;
      case 'emergency': return dangerColor;
      case 'job_completed': return successColor;
      case 'payment_received': return successColor;
      case 'schedule_reminder': return warningColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'job_assigned': return Icons.assignment;
      case 'route_updated': return Icons.route;
      case 'customer_message': return Icons.message;
      case 'emergency': return Icons.emergency;
      case 'job_completed': return Icons.check_circle;
      case 'payment_received': return Icons.payment;
      case 'schedule_reminder': return Icons.schedule;
      default: return Icons.info;
    }
  }

  Color _getHistoryStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'acknowledged': return successColor;
      case 'read': return primaryColor;
      case 'missed': return warningColor;
      case 'failed': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Job Assignments': return Icons.assignment;
      case 'Customer Communications': return Icons.message;
      case 'Emergency Alerts': return Icons.emergency;
      case 'System Updates': return Icons.system_update;
      default: return Icons.category;
    }
  }
}
