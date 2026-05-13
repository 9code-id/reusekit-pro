import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaNotificationsView extends StatefulWidget {
  const FdaNotificationsView({super.key});

  @override
  State<FdaNotificationsView> createState() => _FdaNotificationsViewState();
}

class _FdaNotificationsViewState extends State<FdaNotificationsView> {
  String selectedFilter = "all";
  List<String> selectedNotifications = [];
  bool selectMode = false;

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Orders", "value": "order"},
    {"label": "Promotions", "value": "promotion"},
    {"label": "System", "value": "system"},
    {"label": "Delivery", "value": "delivery"},
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      "id": "1",
      "type": "order",
      "title": "Order Delivered Successfully",
      "message": "Your order #OD123456 from Mario's Pizzeria has been delivered to your address.",
      "timestamp": "2024-01-15T14:30:00",
      "isRead": false,
      "priority": "high",
      "actionData": {
        "orderId": "OD123456",
        "restaurantName": "Mario's Pizzeria"
      },
    },
    {
      "id": "2",
      "type": "promotion",
      "title": "50% Off Your Next Order!",
      "message": "Use code SAVE50 and get 50% discount on orders above \$30. Valid until midnight!",
      "timestamp": "2024-01-15T12:00:00",
      "isRead": true,
      "priority": "medium",
      "actionData": {
        "promoCode": "SAVE50",
        "discount": 50,
        "minOrder": 30
      },
    },
    {
      "id": "3",
      "type": "delivery",
      "title": "Your Order is Out for Delivery",
      "message": "Your order from Dragon Palace is on its way! Expected delivery time: 15-20 minutes.",
      "timestamp": "2024-01-15T11:45:00",
      "isRead": false,
      "priority": "high",
      "actionData": {
        "orderId": "OD123457",
        "estimatedTime": "15-20 minutes",
        "driverName": "Mike Johnson"
      },
    },
    {
      "id": "4",
      "type": "system",
      "title": "App Update Available",
      "message": "Version 2.5.0 is now available with new features and bug fixes. Update now for the best experience!",
      "timestamp": "2024-01-14T16:20:00",
      "isRead": true,
      "priority": "low",
      "actionData": {
        "version": "2.5.0",
        "updateUrl": "https://app.store/update"
      },
    },
    {
      "id": "5",
      "type": "order",
      "title": "Order Confirmed",
      "message": "Your order #OD123458 has been confirmed by Burger Junction. Estimated preparation time: 25 minutes.",
      "timestamp": "2024-01-14T13:10:00",
      "isRead": false,
      "priority": "medium",
      "actionData": {
        "orderId": "OD123458",
        "restaurantName": "Burger Junction",
        "prepTime": "25 minutes"
      },
    },
    {
      "id": "6",
      "type": "promotion",
      "title": "Free Delivery Weekend",
      "message": "Enjoy free delivery on all orders this weekend! No minimum order required.",
      "timestamp": "2024-01-13T10:00:00",
      "isRead": true,
      "priority": "medium",
      "actionData": {
        "validFrom": "2024-01-13",
        "validUntil": "2024-01-14"
      },
    },
    {
      "id": "7",
      "type": "delivery",
      "title": "Delivery Address Updated",
      "message": "Your default delivery address has been successfully updated to 456 Oak Street.",
      "timestamp": "2024-01-13T09:30:00",
      "isRead": true,
      "priority": "low",
      "actionData": {
        "newAddress": "456 Oak Street"
      },
    },
    {
      "id": "8",
      "type": "system",
      "title": "Maintenance Notice",
      "message": "Scheduled maintenance on Jan 12, 2:00-4:00 AM. Some features may be temporarily unavailable.",
      "timestamp": "2024-01-11T18:00:00",
      "isRead": true,
      "priority": "medium",
      "actionData": {
        "maintenanceDate": "2024-01-12",
        "startTime": "2:00 AM",
        "endTime": "4:00 AM"
      },
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    List<Map<String, dynamic>> filtered = notifications;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((notification) => notification["type"] == selectedFilter).toList();
    }
    
    // Sort by timestamp (newest first)
    filtered.sort((a, b) => (b["timestamp"] as String).compareTo(a["timestamp"] as String));
    
    return filtered;
  }

  int get unreadCount {
    return notifications.where((notification) => !(notification["isRead"] as bool)).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications"),
            if (unreadCount > 0)
              Text(
                "$unreadCount unread",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          if (!selectMode) ...[
            IconButton(
              icon: Icon(Icons.checklist),
              onPressed: () {
                selectMode = true;
                setState(() {});
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "mark_all_read") {
                  _markAllAsRead();
                } else if (value == "clear_all") {
                  _clearAllNotifications();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "mark_all_read",
                  child: Row(
                    children: [
                      Icon(Icons.mark_email_read, size: 20),
                      SizedBox(width: spSm),
                      Text("Mark All as Read"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "clear_all",
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, size: 20),
                      SizedBox(width: spSm),
                      Text("Clear All"),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            TextButton(
              onPressed: () {
                if (selectedNotifications.length == filteredNotifications.length) {
                  selectedNotifications.clear();
                } else {
                  selectedNotifications = filteredNotifications.map((n) => n["id"] as String).toList();
                }
                setState(() {});
              },
              child: Text(
                selectedNotifications.length == filteredNotifications.length ? "Deselect All" : "Select All",
                style: TextStyle(color: primaryColor),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                selectMode = false;
                selectedNotifications.clear();
                setState(() {});
              },
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filterOptions.length,
              itemBuilder: (context, index) {
                final filter = filterOptions[index];
                final isSelected = selectedFilter == filter["value"];
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedFilter = filter["value"];
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        "${filter["label"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Notifications List
          Expanded(
            child: filteredNotifications.isEmpty 
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(spMd),
                  itemCount: filteredNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = filteredNotifications[index];
                    return _buildNotificationItem(notification);
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: selectMode && selectedNotifications.isNotEmpty
        ? Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Mark as Read (${selectedNotifications.length})",
                    icon: Icons.mark_email_read,
                    size: bs.sm,
                    onPressed: _markSelectedAsRead,
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: _deleteSelectedNotifications,
                ),
              ],
            ),
          )
        : null,
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isRead = notification["isRead"] as bool;
    final isSelected = selectedNotifications.contains(notification["id"]);
    final priorityColor = _getPriorityColor(notification["priority"]);
    final typeIcon = _getTypeIcon(notification["type"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isSelected ? primaryColor : (isRead ? disabledOutlineBorderColor : primaryColor.withAlpha(50)),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [shadowSm],
      ),
      child: InkWell(
        onTap: () {
          if (selectMode) {
            if (isSelected) {
              selectedNotifications.remove(notification["id"]);
            } else {
              selectedNotifications.add(notification["id"]);
            }
            setState(() {});
          } else {
            _openNotificationDetail(notification);
          }
        },
        onLongPress: () {
          if (!selectMode) {
            selectMode = true;
            selectedNotifications.add(notification["id"]);
            setState(() {});
          }
        },
        borderRadius: BorderRadius.circular(radiusSm),
        child: Padding(
          padding: EdgeInsets.all(spMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selection Checkbox (in select mode)
              if (selectMode) ...[
                Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    if (value == true) {
                      selectedNotifications.add(notification["id"]);
                    } else {
                      selectedNotifications.remove(notification["id"]);
                    }
                    setState(() {});
                  },
                ),
                SizedBox(width: spSm),
              ],

              // Type Icon
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  typeIcon,
                  color: priorityColor,
                  size: 20,
                ),
              ),
              
              SizedBox(width: spMd),
              
              // Content
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
                              fontSize: fsH6,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTimestamp(notification["timestamp"]),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${notification["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: priorityColor,
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
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Notifications",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              selectedFilter == "all" 
                ? "You're all caught up! No new notifications."
                : "No ${selectedFilter} notifications found.",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "order":
        return Icons.receipt;
      case "promotion":
        return Icons.local_offer;
      case "delivery":
        return Icons.delivery_dining;
      case "system":
        return Icons.system_update;
      default:
        return Icons.notifications;
    }
  }

  String _formatTimestamp(String timestamp) {
    DateTime date = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return date.dMMMy;
    }
  }

  void _openNotificationDetail(Map<String, dynamic> notification) {
    // Mark as read when opened
    notification["isRead"] = true;
    setState(() {});

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getTypeIcon(notification["type"]),
                    color: _getPriorityColor(notification["priority"]),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "${notification["title"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "${notification["message"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                _formatTimestamp(notification["timestamp"]),
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (notification["type"] == "order" || notification["type"] == "promotion") ...[
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: notification["type"] == "order" ? "View Order" : "Use Offer",
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      si("Opening ${notification["type"]} details...");
                    },
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _markAllAsRead() async {
    bool isConfirmed = await confirm("Mark all notifications as read?");
    if (isConfirmed) {
      for (var notification in notifications) {
        notification["isRead"] = true;
      }
      setState(() {});
      ss("All notifications marked as read");
    }
  }

  void _markSelectedAsRead() {
    for (var notification in notifications) {
      if (selectedNotifications.contains(notification["id"])) {
        notification["isRead"] = true;
      }
    }
    selectMode = false;
    selectedNotifications.clear();
    setState(() {});
    ss("Selected notifications marked as read");
  }

  void _clearAllNotifications() async {
    bool isConfirmed = await confirm("Delete all notifications? This action cannot be undone.");
    if (isConfirmed) {
      notifications.clear();
      setState(() {});
      ss("All notifications cleared");
    }
  }

  void _deleteSelectedNotifications() async {
    bool isConfirmed = await confirm("Delete ${selectedNotifications.length} notification(s)?");
    if (isConfirmed) {
      notifications.removeWhere((notification) => selectedNotifications.contains(notification["id"]));
      selectMode = false;
      selectedNotifications.clear();
      setState(() {});
      ss("Selected notifications deleted");
    }
  }
}
