import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings5View extends StatefulWidget {
  @override
  State<GrlSettings5View> createState() => _GrlSettings5ViewState();
}

class _GrlSettings5ViewState extends State<GrlSettings5View> {
  bool messagesNotifications = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool socialNotifications = false;
  bool marketingNotifications = false;
  bool systemNotifications = true;
  
  String notificationSound = "Default";
  bool vibrationEnabled = true;
  bool ledEnabled = false;
  String quietHoursStart = "22:00";
  String quietHoursEnd = "07:00";
  bool quietHoursEnabled = true;
  bool weekendQuietHours = false;
  
  List<Map<String, dynamic>> soundOptions = [
    {"label": "Default", "value": "Default"},
    {"label": "Bell", "value": "Bell"},
    {"label": "Chime", "value": "Chime"},
    {"label": "Ding", "value": "Ding"},
    {"label": "Notification", "value": "Notification"},
    {"label": "Silent", "value": "Silent"},
  ];

  List<Map<String, dynamic>> notificationCategories = [
    {
      "title": "Messages",
      "description": "Chat messages and direct communications",
      "icon": Icons.message,
      "enabled": true,
      "sound": true,
      "vibration": true,
      "priority": "High"
    },
    {
      "title": "Email",
      "description": "New email notifications",
      "icon": Icons.email,
      "enabled": true,
      "sound": false,
      "vibration": true,
      "priority": "Medium"
    },
    {
      "title": "Social",
      "description": "Likes, comments, and social interactions",
      "icon": Icons.favorite,
      "enabled": false,
      "sound": false,
      "vibration": false,
      "priority": "Low"
    },
    {
      "title": "System",
      "description": "App updates and system notifications",
      "icon": Icons.system_update,
      "enabled": true,
      "sound": false,
      "vibration": false,
      "priority": "Medium"
    },
    {
      "title": "Marketing",
      "description": "Promotional content and offers",
      "icon": Icons.campaign,
      "enabled": false,
      "sound": false,
      "vibration": false,
      "priority": "Low"
    },
  ];

  List<Map<String, dynamic>> recentNotifications = [
    {
      "title": "New message from Sarah",
      "description": "Hey! Are we still meeting for lunch?",
      "time": "5 min ago",
      "icon": Icons.message,
      "category": "Messages",
      "read": false
    },
    {
      "title": "System Update Available",
      "description": "Version 2.1.0 is ready to install",
      "time": "2 hours ago",
      "icon": Icons.system_update,
      "category": "System",
      "read": true
    },
    {
      "title": "Email from work",
      "description": "Weekly team meeting reminder",
      "time": "4 hours ago",
      "icon": Icons.email,
      "category": "Email",
      "read": true
    },
    {
      "title": "Special Offer!",
      "description": "50% off premium features this week",
      "time": "1 day ago",
      "icon": Icons.campaign,
      "category": "Marketing",
      "read": true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          QButton(
            icon: Icons.quiz,
            size: bs.sm,
            onPressed: () {
              _sendTestNotification();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Toggle Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildQuickToggle(
                    Icons.notifications,
                    "All Notifications",
                    "Enable or disable all notifications",
                    pushNotifications,
                    (value) {
                      pushNotifications = value;
                      setState(() {});
                      if (value) {
                        ss("All notifications enabled");
                      } else {
                        sw("All notifications disabled");
                      }
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildQuickToggle(
                    Icons.vibration,
                    "Vibration",
                    "Vibrate for notifications",
                    vibrationEnabled,
                    (value) {
                      vibrationEnabled = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildQuickToggle(
                    Icons.lightbulb,
                    "LED Indicator",
                    "Flash LED for notifications",
                    ledEnabled,
                    (value) {
                      ledEnabled = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Sound Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.volume_up,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sound Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Notification Sound",
                    items: soundOptions,
                    value: notificationSound,
                    onChanged: (value, label) {
                      notificationSound = value;
                      setState(() {});
                      si("Sound changed to ${label}");
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Test Sound",
                          size: bs.sm,
                          onPressed: () {
                            si("Playing ${notificationSound} sound");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Custom Sound",
                          size: bs.sm,
                          onPressed: () {
                            si("Custom sound feature coming soon");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quiet Hours
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bedtime,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Quiet Hours",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Switch(
                        value: quietHoursEnabled,
                        onChanged: (value) {
                          quietHoursEnabled = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  
                  if (quietHoursEnabled) ...[
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Start Time",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2023-01-01 ${quietHoursStart}:00")),
                            onChanged: (value) {
                              if (value != null) {
                                quietHoursStart = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: QTimePicker(
                            label: "End Time",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2023-01-01 ${quietHoursEnd}:00")),
                            onChanged: (value) {
                              if (value != null) {
                                quietHoursEnd = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.weekend,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Apply to weekends",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Switch(
                          value: weekendQuietHours,
                          onChanged: (value) {
                            weekendQuietHours = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Notification Categories
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Notification Categories",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Customize",
                        size: bs.sm,
                        onPressed: () {
                          si("Advanced customization coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...notificationCategories.map((category) => _buildCategoryCard(category)),
                ],
              ),
            ),

            // Recent Notifications
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Recent Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "Clear All",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Clear all notification history?");
                          if (isConfirmed) {
                            ss("Notification history cleared");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...recentNotifications.take(4).map((notification) => _buildNotificationItem(notification)),
                ],
              ),
            ),

            // Advanced Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings_applications,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Advanced Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildAdvancedOption(
                    Icons.priority_high,
                    "Notification Priority",
                    "Manage notification importance levels",
                    () {
                      si("Priority settings coming soon");
                    },
                  ),
                  
                  _buildAdvancedOption(
                    Icons.schedule,
                    "Scheduled Notifications",
                    "Set up recurring notifications",
                    () {
                      si("Scheduled notifications coming soon");
                    },
                  ),
                  
                  _buildAdvancedOption(
                    Icons.group,
                    "Grouped Notifications",
                    "Bundle similar notifications together",
                    () {
                      si("Notification grouping coming soon");
                    },
                  ),
                  
                  _buildAdvancedOption(
                    Icons.backup,
                    "Backup Settings",
                    "Save notification preferences",
                    () {
                      si("Settings backup coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Send Test Notification",
                    size: bs.md,
                    onPressed: () {
                      _sendTestNotification();
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Reset to Defaults",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Reset all notification settings to default values?");
                      if (isConfirmed) {
                        _resetToDefaults();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
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
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    Color priorityColor = primaryColor;
    if (category["priority"] == "High") priorityColor = dangerColor;
    if (category["priority"] == "Medium") priorityColor = warningColor;
    if (category["priority"] == "Low") priorityColor = successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              category["icon"],
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${category["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${category["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${category["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.volume_up,
                      color: category["sound"] ? successColor : disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      Icons.vibration,
                      color: category["vibration"] ? successColor : disabledBoldColor,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Switch(
            value: category["enabled"],
            onChanged: (value) {
              category["enabled"] = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: notification["read"] ? Colors.transparent : primaryColor.withAlpha(10),
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              notification["icon"],
              color: primaryColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${notification["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: notification["read"] ? FontWeight.w500 : FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${notification["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${notification["time"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              if (!notification["read"])
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
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
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _sendTestNotification() {
    si("Test notification sent! Check your notification panel.");
  }

  void _resetToDefaults() {
    messagesNotifications = true;
    emailNotifications = true;
    pushNotifications = true;
    socialNotifications = false;
    marketingNotifications = false;
    systemNotifications = true;
    notificationSound = "Default";
    vibrationEnabled = true;
    ledEnabled = false;
    quietHoursStart = "22:00";
    quietHoursEnd = "07:00";
    quietHoursEnabled = true;
    weekendQuietHours = false;
    setState(() {});
    ss("Notification settings reset to defaults");
  }
}
