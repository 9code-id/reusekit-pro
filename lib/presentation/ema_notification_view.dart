import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaNotificationView extends StatefulWidget {
  const EmaNotificationView({super.key});

  @override
  State<EmaNotificationView> createState() => _EmaNotificationViewState();
}

class _EmaNotificationViewState extends State<EmaNotificationView> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Morning Assessment Ready",
      "message": "Time for your daily mood and energy check-in",
      "type": "assessment",
      "timestamp": "2025-06-18 08:00",
      "isRead": false,
      "priority": "high",
      "actionRequired": true,
    },
    {
      "id": 2,
      "title": "Weekly Report Available",
      "message": "Your weekly EMA report is now ready for review",
      "type": "report",
      "timestamp": "2025-06-18 07:30",
      "isRead": false,
      "priority": "medium",
      "actionRequired": false,
    },
    {
      "id": 3,
      "title": "Streak Achievement",
      "message": "Congratulations! You've completed 7 days in a row",
      "type": "achievement",
      "timestamp": "2025-06-17 20:15",
      "isRead": true,
      "priority": "low",
      "actionRequired": false,
    },
    {
      "id": 4,
      "title": "Missed Assessment",
      "message": "You missed your lunch check-in yesterday",
      "type": "reminder",
      "timestamp": "2025-06-17 18:30",
      "isRead": false,
      "priority": "medium",
      "actionRequired": true,
    },
    {
      "id": 5,
      "title": "Data Sync Complete",
      "message": "Your assessment data has been successfully synchronized",
      "type": "system",
      "timestamp": "2025-06-17 16:45",
      "isRead": true,
      "priority": "low",
      "actionRequired": false,
    },
    {
      "id": 6,
      "title": "Evening Reflection Due",
      "message": "Don't forget to complete your evening reflection",
      "type": "assessment",
      "timestamp": "2025-06-17 19:00",
      "isRead": true,
      "priority": "high",
      "actionRequired": false,
    },
  ];

  String selectedFilter = "All";
  List<String> filterOptions = ["All", "Unread", "Assessment", "Report", "Achievement"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications = notifications.where((notification) {
      if (selectedFilter == "Unread") return notification["isRead"] == false;
      if (selectedFilter == "Assessment") return notification["type"] == "assessment";
      if (selectedFilter == "Report") return notification["type"] == "report";
      if (selectedFilter == "Achievement") return notification["type"] == "achievement";
      return true;
    }).toList();

    int unreadCount = notifications.where((n) => n["isRead"] == false).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read),
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification["isRead"] = true;
                }
              });
              ss("All notifications marked as read");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // navigateTo('NotificationSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Notification Center",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${notifications.length} total notifications",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: unreadCount > 0 ? dangerColor : successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${unreadCount} unread",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Filter Options
            QCategoryPicker(
              items: filterOptions.map((filter) => {
                "label": filter,
                "value": filter,
              }).toList(),
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            // Notifications List
            Column(
              spacing: spSm,
              children: filteredNotifications.map((notification) {
                Color typeColor = _getTypeColor(notification["type"]);
                Color priorityColor = _getPriorityColor(notification["priority"]);
                IconData typeIcon = _getTypeIcon(notification["type"]);

                return Container(
                  decoration: BoxDecoration(
                    color: notification["isRead"] ? Colors.white : primaryColor.withAlpha(8),
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: notification["isRead"] ? disabledOutlineBorderColor : typeColor,
                      ),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radiusMd),
                      onTap: () {
                        setState(() {
                          notification["isRead"] = true;
                        });
                        
                        if (notification["actionRequired"]) {
                          // navigateTo('AssessmentView')
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(15),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    typeIcon,
                                    size: 20,
                                    color: typeColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${notification["title"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: notification["isRead"] 
                                                    ? FontWeight.w600 
                                                    : FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (!notification["isRead"])
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
                                      Text(
                                        "${notification["message"]}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${notification["timestamp"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: priorityColor.withAlpha(15),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${notification["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (notification["actionRequired"])
                              Row(
                                children: [
                                  Icon(
                                    Icons.touch_app,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Action required - Tap to continue",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            if (filteredNotifications.isEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No notifications found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filter settings",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Mark All Read",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              for (var notification in notifications) {
                                notification["isRead"] = true;
                              }
                            });
                            ss("All notifications marked as read");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('NotificationSettingsView')
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
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "assessment":
        return primaryColor;
      case "report":
        return infoColor;
      case "achievement":
        return successColor;
      case "reminder":
        return warningColor;
      case "system":
        return disabledBoldColor;
      default:
        return primaryColor;
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
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "assessment":
        return Icons.assignment;
      case "report":
        return Icons.analytics;
      case "achievement":
        return Icons.emoji_events;
      case "reminder":
        return Icons.alarm;
      case "system":
        return Icons.settings;
      default:
        return Icons.notifications;
    }
  }
}
