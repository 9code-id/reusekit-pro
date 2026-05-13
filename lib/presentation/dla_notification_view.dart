import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaNotificationView extends StatefulWidget {
  const DlaNotificationView({super.key});

  @override
  State<DlaNotificationView> createState() => _DlaNotificationViewState();
}

class _DlaNotificationViewState extends State<DlaNotificationView> {
  String selectedFilter = "all";
  String selectedCategory = "all";
  
  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All Notifications", "value": "all"},
    {"label": "Unread", "value": "unread"},
    {"label": "Read", "value": "read"},
    {"label": "Important", "value": "important"},
    {"label": "Today", "value": "today"},
  ];

  final List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Deliveries", "value": "deliveries"},
    {"label": "System Updates", "value": "system"},
    {"label": "Alerts", "value": "alerts"},
    {"label": "Reminders", "value": "reminders"},
    {"label": "Reports", "value": "reports"},
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      "id": "1",
      "title": "Delivery #DL-2024-001 Completed",
      "message": "Package delivered successfully to ABC Logistics warehouse. Customer satisfaction: 5/5",
      "type": "deliveries",
      "priority": "normal",
      "timestamp": "2024-06-17T14:30:00",
      "read": false,
      "icon": Icons.local_shipping,
      "color": successColor,
    },
    {
      "id": "2",
      "title": "Route Optimization Alert",
      "message": "New optimized route available for Jakarta-Surabaya corridor. Potential savings: 15% fuel cost.",
      "type": "alerts",
      "priority": "important",
      "timestamp": "2024-06-17T13:45:00",
      "read": false,
      "icon": Icons.route,
      "color": warningColor,
    },
    {
      "id": "3",
      "title": "Weekly Report Available",
      "message": "Your weekly efficiency report is ready for review. Performance increased by 8.5% this week.",
      "type": "reports",
      "priority": "normal",
      "timestamp": "2024-06-17T12:00:00",
      "read": true,
      "icon": Icons.assessment,
      "color": infoColor,
    },
    {
      "id": "4",
      "title": "System Maintenance Scheduled",
      "message": "Scheduled maintenance window: June 18, 2024 from 2:00 AM - 4:00 AM UTC. Services may be affected.",
      "type": "system",
      "priority": "important",
      "timestamp": "2024-06-17T11:15:00",
      "read": false,
      "icon": Icons.build,
      "color": primaryColor,
    },
    {
      "id": "5",
      "title": "Invoice Payment Reminder",
      "message": "Invoice INV-2024-089 is due in 3 days. Amount: \$2,450.00. Click to view details.",
      "type": "reminders",
      "priority": "important",
      "timestamp": "2024-06-17T10:30:00",
      "read": true,
      "icon": Icons.payment,
      "color": dangerColor,
    },
    {
      "id": "6",
      "title": "New Driver Registration",
      "message": "Driver John Smith has successfully completed registration and training. Ready for assignments.",
      "type": "system",
      "priority": "normal",
      "timestamp": "2024-06-17T09:45:00",
      "read": true,
      "icon": Icons.person_add,
      "color": successColor,
    },
    {
      "id": "7",
      "title": "Delivery Delay Alert",
      "message": "Delivery #DL-2024-045 delayed due to traffic congestion. New ETA: 16:30. Customer notified.",
      "type": "alerts",
      "priority": "normal",
      "timestamp": "2024-06-17T08:20:00",
      "read": false,
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "id": "8",
      "title": "Fuel Price Update",
      "message": "Fuel prices have increased by 3.2% effective immediately. Update your route calculations.",
      "type": "alerts",
      "priority": "important",
      "timestamp": "2024-06-16T18:30:00",
      "read": true,
      "icon": Icons.local_gas_station,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    return notifications.where((notification) {
      bool matchesFilter = true;
      bool matchesCategory = true;

      // Filter by read status
      switch (selectedFilter) {
        case "unread":
          matchesFilter = !(notification["read"] as bool);
          break;
        case "read":
          matchesFilter = notification["read"] as bool;
          break;
        case "important":
          matchesFilter = notification["priority"] == "important";
          break;
        case "today":
          DateTime notificationDate = DateTime.parse(notification["timestamp"] as String);
          DateTime today = DateTime.now();
          matchesFilter = notificationDate.year == today.year &&
                         notificationDate.month == today.month &&
                         notificationDate.day == today.day;
          break;
      }

      // Filter by category
      if (selectedCategory != "all") {
        matchesCategory = notification["type"] == selectedCategory;
      }

      return matchesFilter && matchesCategory;
    }).toList();
  }

  int get unreadCount => notifications.where((n) => !(n["read"] as bool)).length;

  Widget _buildNotificationFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "$unreadCount unread",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QButton(
              label: "Mark All Read",
              icon: Icons.done_all,
              size: bs.sm,
              onPressed: () {
                for (var notification in notifications) {
                  notification["read"] = true;
                }
                setState(() {});
                ss("All notifications marked as read");
              },
            ),
          ),
          Expanded(
            child: QButton(
              label: "Clear Read",
              icon: Icons.clear_all,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to clear all read notifications?");
                if (isConfirmed) {
                  notifications.removeWhere((n) => n["read"] as bool);
                  setState(() {});
                  ss("Read notifications cleared");
                }
              },
            ),
          ),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              si("Opening notification settings");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (filteredNotifications.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No notifications found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "No notifications match your current filters",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      spacing: spSm,
      children: filteredNotifications.map((notification) => _buildNotificationItem(notification)).toList(),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    bool isRead = notification["read"] as bool;
    bool isImportant = notification["priority"] == "important";
    DateTime timestamp = DateTime.parse(notification["timestamp"] as String);
    String timeAgo = _getTimeAgo(timestamp);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isImportant ? Border.all(color: (notification["color"] as Color), width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radiusMd),
          onTap: () {
            notification["read"] = true;
            setState(() {});
            si("Opening notification: ${notification["title"]}");
          },
          child: Container(
            padding: EdgeInsets.all(spSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (notification["color"] as Color).withAlpha(20),
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
                                fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (isImportant)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "IMPORTANT",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "${notification["message"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            timeAgo,
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                          Spacer(),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  color: disabledBoldColor,
                  onPressed: () {
                    _showNotificationActions(notification);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  void _showNotificationActions(Map<String, dynamic> notification) {
    // Handle notification actions
    si("Notification actions for: ${notification["title"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              si("Refreshing notifications");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildNotificationFilters(),
            _buildNotificationActions(),
            _buildNotificationsList(),
          ],
        ),
      ),
    );
  }
}
