import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaNotificationsView extends StatefulWidget {
  const GeaNotificationsView({Key? key}) : super(key: key);

  @override
  State<GeaNotificationsView> createState() => _GeaNotificationsViewState();
}

class _GeaNotificationsViewState extends State<GeaNotificationsView> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool smsNotifications = true;
  bool inAppNotifications = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;
  bool badgeCount = true;
  bool doNotDisturbEnabled = false;

  String selectedTone = "Default";
  String doNotDisturbStart = "22:00";
  String doNotDisturbEnd = "07:00";

  List<Map<String, dynamic>> notificationCategories = [
    {
      "category": "Account Activity",
      "description": "Login attempts, password changes, security alerts",
      "icon": Icons.security,
      "enabled": true,
      "priority": "High"
    },
    {
      "category": "System Updates",
      "description": "App updates, maintenance notifications",
      "icon": Icons.system_update,
      "enabled": true,
      "priority": "Medium"
    },
    {
      "category": "Promotional",
      "description": "Special offers, new features, tips",
      "icon": Icons.local_offer,
      "enabled": false,
      "priority": "Low"
    },
    {
      "category": "Social",
      "description": "Comments, mentions, friend requests",
      "icon": Icons.people,
      "enabled": true,
      "priority": "Medium"
    },
    {
      "category": "Reminders",
      "description": "Task reminders, appointments, deadlines",
      "icon": Icons.alarm,
      "enabled": true,
      "priority": "High"
    },
  ];

  List<Map<String, dynamic>> recentNotifications = [
    {
      "title": "Security Alert",
      "message": "New login from Windows device",
      "time": "2 minutes ago",
      "category": "Account Activity",
      "read": false,
      "icon": Icons.security
    },
    {
      "title": "System Update",
      "message": "App version 2.1.0 is now available",
      "time": "1 hour ago",
      "category": "System Updates",
      "read": true,
      "icon": Icons.system_update
    },
    {
      "title": "Task Reminder",
      "message": "Team meeting in 30 minutes",
      "time": "30 minutes ago",
      "category": "Reminders",
      "read": false,
      "icon": Icons.alarm
    },
    {
      "title": "Special Offer",
      "message": "50% off premium features this week",
      "time": "2 hours ago",
      "category": "Promotional",
      "read": true,
      "icon": Icons.local_offer
    },
  ];

  List<String> notificationTones = [
    "Default",
    "Chime",
    "Bell",
    "Whistle",
    "Alert",
    "Silent"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings"),
        actions: [
          QButton(
            icon: Icons.notifications_off,
            size: bs.sm,
            onPressed: () {
              _toggleAllNotifications();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildNotificationOverview(),
            _buildGeneralSettings(),
            _buildNotificationChannels(),
            _buildCategorySettings(),
            _buildDoNotDisturb(),
            _buildRecentNotifications(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Notification Center",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Customize how and when you receive notifications to stay informed without being overwhelmed.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              _buildStatusIndicator("Push", pushNotifications),
              SizedBox(width: spMd),
              _buildStatusIndicator("Email", emailNotifications),
              SizedBox(width: spMd),
              _buildStatusIndicator("SMS", smsNotifications),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool enabled) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: enabled ? successColor : disabledColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: enabled ? successColor : disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
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
            child: Text(
              "General Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildGeneralSwitch(
            "In-App Notifications",
            "Show notifications within the app",
            Icons.notifications,
            inAppNotifications,
            (value) => setState(() => inAppNotifications = value),
          ),
          _buildGeneralSwitch(
            "Sound",
            "Play notification sounds",
            Icons.volume_up,
            soundEnabled,
            (value) => setState(() => soundEnabled = value),
          ),
          _buildGeneralSwitch(
            "Vibration",
            "Vibrate for notifications",
            Icons.vibration,
            vibrationEnabled,
            (value) => setState(() => vibrationEnabled = value),
          ),
          _buildGeneralSwitch(
            "Badge Count",
            "Show notification count on app icon",
            Icons.circle_notifications,
            badgeCount,
            (value) => setState(() => badgeCount = value),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralSwitch(
    String title,
    String description,
    IconData icon,
    bool value,
    Function(bool) onChanged, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? primaryColor : disabledBoldColor,
            size: 20,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildNotificationChannels() {
    return Container(
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
            child: Text(
              "Notification Channels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildChannelOption(
            "Push Notifications",
            "Instant notifications on your device",
            Icons.phone_android,
            pushNotifications,
            (value) => setState(() => pushNotifications = value),
          ),
          _buildChannelOption(
            "Email Notifications",
            "Receive notifications via email",
            Icons.email,
            emailNotifications,
            (value) => setState(() => emailNotifications = value),
          ),
          _buildChannelOption(
            "SMS Notifications",
            "Get important alerts via text message",
            Icons.sms,
            smsNotifications,
            (value) => setState(() => smsNotifications = value),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildChannelOption(
    String title,
    String description,
    IconData icon,
    bool value,
    Function(bool) onChanged, {
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: isLast ? null : Border(
          bottom: BorderSide(
            color: disabledColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: value ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: value ? primaryColor : disabledBoldColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
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

  Widget _buildCategorySettings() {
    return Container(
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
            child: Text(
              "Notification Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...notificationCategories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            final isLast = index == notificationCategories.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (category["enabled"] as bool) ? primaryColor.withAlpha(20) : disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      category["icon"] as IconData,
                      color: (category["enabled"] as bool) ? primaryColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${category["priority"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${category["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getPriorityColor("${category["priority"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${category["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: category["enabled"] as bool,
                    onChanged: (value) {
                      setState(() {
                        notificationCategories[index]["enabled"] = value;
                      });
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

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

  Widget _buildDoNotDisturb() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Do Not Disturb",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Silence notifications during specific hours",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: doNotDisturbEnabled,
                  onChanged: (value) {
                    setState(() => doNotDisturbEnabled = value);
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          if (doNotDisturbEnabled) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                border: Border(
                  top: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Start Time",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          doNotDisturbStart,
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "End Time",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          doNotDisturbEnd,
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentNotifications() {
    return Container(
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
                  "Recent Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    si("Clearing all notifications");
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...recentNotifications.asMap().entries.map((entry) {
            final index = entry.key;
            final notification = entry.value;
            final isLast = index == recentNotifications.length - 1;
            final isRead = notification["read"] as bool;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isRead ? Colors.white : primaryColor.withAlpha(5),
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      notification["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            if (!isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                margin: EdgeInsets.only(right: spXs),
                              ),
                            Text(
                              "${notification["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${notification["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${notification["time"]}",
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
          }),
        ],
      ),
    );
  }

  void _toggleAllNotifications() {
    setState(() {
      bool newState = !pushNotifications;
      pushNotifications = newState;
      emailNotifications = newState;
      smsNotifications = newState;
      inAppNotifications = newState;
    });
    
    if (pushNotifications) {
      ss("All notifications enabled");
    } else {
      sw("All notifications disabled");
    }
  }
}
