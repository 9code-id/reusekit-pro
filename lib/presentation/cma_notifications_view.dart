import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaNotificationsView extends StatefulWidget {
  const CmaNotificationsView({super.key});

  @override
  State<CmaNotificationsView> createState() => _CmaNotificationsViewState();
}

class _CmaNotificationsViewState extends State<CmaNotificationsView> {
  String selectedFilter = "all";
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool criticalAlerts = true;
  bool maintenanceReminders = true;
  bool securityAlerts = true;
  bool tripSummaries = false;
  bool fuelAlerts = true;
  bool batteryAlerts = true;
  bool geofenceAlerts = true;
  bool speedingAlerts = true;
  String alertTiming = "immediate";
  String quietHoursStart = "22:00";
  String quietHoursEnd = "07:00";
  bool enableQuietHours = true;

  final List<Map<String, dynamic>> notifications = [
    {
      "id": "1",
      "title": "Vehicle Maintenance Due",
      "message": "Your Honda Civic is due for scheduled maintenance in 500 miles",
      "type": "maintenance",
      "priority": "medium",
      "timestamp": "2 hours ago",
      "read": false,
      "icon": Icons.build,
      "color": Colors.orange,
    },
    {
      "id": "2", 
      "title": "Security Alert",
      "message": "Unauthorized access attempt detected at 2:30 AM",
      "type": "security",
      "priority": "high",
      "timestamp": "5 hours ago",
      "read": false,
      "icon": Icons.security,
      "color": Colors.red,
    },
    {
      "id": "3",
      "title": "Trip Summary",
      "message": "Your trip to Downtown completed - 15.2 miles, 35 minutes",
      "type": "trip",
      "priority": "low",
      "timestamp": "1 day ago",
      "read": true,
      "icon": Icons.directions_car,
      "color": Colors.blue,
    },
    {
      "id": "4",
      "title": "Low Fuel Warning",
      "message": "Fuel level is at 15%. Nearest gas station is 2.1 miles away",
      "type": "fuel",
      "priority": "medium",
      "timestamp": "1 day ago",
      "read": true,
      "icon": Icons.local_gas_station,
      "color": Colors.orange,
    },
    {
      "id": "5",
      "title": "Geofence Alert",
      "message": "Vehicle has left the designated safe zone",
      "type": "geofence",
      "priority": "high",
      "timestamp": "2 days ago",
      "read": true,
      "icon": Icons.location_off,
      "color": Colors.red,
    },
    {
      "id": "6",
      "title": "Battery Health",
      "message": "Vehicle battery health is optimal - 98% capacity",
      "type": "battery",
      "priority": "low",
      "timestamp": "3 days ago",
      "read": true,
      "icon": Icons.battery_full,
      "color": Colors.green,
    },
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Notifications", "value": "all"},
    {"label": "Unread Only", "value": "unread"},
    {"label": "Security Alerts", "value": "security"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Trip Updates", "value": "trip"},
    {"label": "Fuel & Battery", "value": "fuel"},
  ];

  final List<Map<String, dynamic>> alertTimingOptions = [
    {"label": "Immediate", "value": "immediate"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Every hour", "value": "1hour"},
    {"label": "Daily summary", "value": "daily"},
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == "all") {
      return notifications;
    } else if (selectedFilter == "unread") {
      return notifications.where((n) => !(n["read"] as bool)).toList();
    } else {
      return notifications.where((n) => n["type"] == selectedFilter).toList();
    }
  }

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = notifications.firstWhere((n) => n["id"] == notificationId);
      notification["read"] = true;
    });
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      notifications.removeWhere((n) => n["id"] == notificationId);
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["read"] = true;
      }
    });
  }

  void _clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _markAllAsRead,
                child: Text("Mark All as Read"),
              ),
              PopupMenuItem(
                onTap: _clearAllNotifications,
                child: Text("Clear All"),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Notification Settings Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Notification Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  // Delivery Method Settings
                  Text(
                    "Delivery Methods",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Push Notifications",
                              "value": true,
                              "checked": pushNotifications,
                            }
                          ],
                          value: [
                            if (pushNotifications)
                              {
                                "label": "Push Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            pushNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Email Notifications",
                              "value": true,
                              "checked": emailNotifications,
                            }
                          ],
                          value: [
                            if (emailNotifications)
                              {
                                "label": "Email Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            emailNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "SMS Notifications",
                              "value": true,
                              "checked": smsNotifications,
                            }
                          ],
                          value: [
                            if (smsNotifications)
                              {
                                "label": "SMS Notifications",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            smsNotifications = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Alert Types Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Alert Types",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Critical Security Alerts",
                              "value": true,
                              "checked": criticalAlerts,
                            }
                          ],
                          value: [
                            if (criticalAlerts)
                              {
                                "label": "Critical Security Alerts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            criticalAlerts = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Maintenance Reminders",
                              "value": true,
                              "checked": maintenanceReminders,
                            }
                          ],
                          value: [
                            if (maintenanceReminders)
                              {
                                "label": "Maintenance Reminders",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            maintenanceReminders = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Trip Summaries",
                              "value": true,
                              "checked": tripSummaries,
                            }
                          ],
                          value: [
                            if (tripSummaries)
                              {
                                "label": "Trip Summaries",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            tripSummaries = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Fuel & Battery Alerts",
                              "value": true,
                              "checked": batteryAlerts,
                            }
                          ],
                          value: [
                            if (batteryAlerts)
                              {
                                "label": "Fuel & Battery Alerts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            batteryAlerts = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Geofence Alerts",
                              "value": true,
                              "checked": geofenceAlerts,
                            }
                          ],
                          value: [
                            if (geofenceAlerts)
                              {
                                "label": "Geofence Alerts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            geofenceAlerts = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Speeding Alerts",
                              "value": true,
                              "checked": speedingAlerts,
                            }
                          ],
                          value: [
                            if (speedingAlerts)
                              {
                                "label": "Speeding Alerts",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            speedingAlerts = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Timing & Schedule Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Timing & Schedule",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  
                  QDropdownField(
                    label: "Alert Timing",
                    items: alertTimingOptions,
                    value: alertTiming,
                    onChanged: (value, label) {
                      alertTiming = value;
                      setState(() {});
                    },
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable Quiet Hours",
                              "value": true,
                              "checked": enableQuietHours,
                            }
                          ],
                          value: [
                            if (enableQuietHours)
                              {
                                "label": "Enable Quiet Hours",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableQuietHours = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  if (enableQuietHours) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Quiet Hours Start",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursStart:00")),
                            onChanged: (value) {
                              quietHoursStart = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QTimePicker(
                            label: "Quiet Hours End",
                            value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 $quietHoursEnd:00")),
                            onChanged: (value) {
                              quietHoursEnd = value!.kkmm;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Filter Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: primaryColor),
                      SizedBox(width: spSm),
                      Text(
                        "Filter Notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredNotifications.length} notifications",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Filter by Type",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Notifications List
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Recent Notifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  if (filteredNotifications.isEmpty) ...[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(spLg),
                        child: Column(
                          children: [
                            Icon(
                              Icons.notifications_off,
                              size: 64,
                              color: disabledColor,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "No notifications found",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    ...filteredNotifications.map((notification) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (notification["read"] as bool) ? Colors.grey.withAlpha(20) : Colors.blue.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getPriorityColor(notification["priority"]),
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (notification["color"] as Color).withAlpha(40),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                notification["icon"] as IconData,
                                color: notification["color"] as Color,
                                size: 20,
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
                                            fontSize: 14,
                                            fontWeight: (notification["read"] as bool) ? FontWeight.normal : FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${notification["timestamp"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${notification["message"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor(notification["priority"]).withAlpha(40),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${notification["priority"].toString().toUpperCase()}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: _getPriorityColor(notification["priority"]),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      if (!(notification["read"] as bool)) ...[
                                        GestureDetector(
                                          onTap: () => _markAsRead(notification["id"]),
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            child: Icon(
                                              Icons.mark_email_read,
                                              color: primaryColor,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                      GestureDetector(
                                        onTap: () => _deleteNotification(notification["id"]),
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.delete,
                                            color: dangerColor,
                                            size: 16,
                                          ),
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
                    }).toList(),
                  ],
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Test Notifications",
                    size: bs.md,
                    onPressed: () {
                      ss("Test notification sent successfully");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Settings",
                    size: bs.md,
                    onPressed: () {
                      ss("Notification settings saved");
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
}
