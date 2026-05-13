import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsNotificationsView extends StatefulWidget {
  const EcsNotificationsView({super.key});

  @override
  State<EcsNotificationsView> createState() => _EcsNotificationsViewState();
}

class _EcsNotificationsViewState extends State<EcsNotificationsView> {
  bool loading = false;
  String selectedFilter = "all";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Orders", "value": "orders"},
    {"label": "Promotions", "value": "promotions"},
    {"label": "Updates", "value": "updates"},
  ];

  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Order Delivered Successfully",
      "message": "Your order #ORD-2024-001 has been delivered to your address.",
      "type": "orders",
      "time": "2 minutes ago",
      "is_read": false,
      "icon": Icons.local_shipping,
      "color": 0xFF4CAF50,
    },
    {
      "id": 2,
      "title": "Flash Sale Alert!",
      "message": "Up to 70% off on electronics. Limited time offer ending soon!",
      "type": "promotions",
      "time": "1 hour ago",
      "is_read": false,
      "icon": Icons.flash_on,
      "color": 0xFFFF9800,
    },
    {
      "id": 3,
      "title": "Payment Confirmed",
      "message": "Your payment of \$129.99 for order #ORD-2024-002 has been processed.",
      "type": "orders",
      "time": "3 hours ago",
      "is_read": true,
      "icon": Icons.payment,
      "color": 0xFF2196F3,
    },
    {
      "id": 4,
      "title": "App Update Available",
      "message": "New features and bug fixes are available. Update now for better experience.",
      "type": "updates",
      "time": "1 day ago",
      "is_read": true,
      "icon": Icons.system_update,
      "color": 0xFF9C27B0,
    },
    {
      "id": 5,
      "title": "Weekend Special Deals",
      "message": "Exclusive weekend deals just for you! Check out our latest collection.",
      "type": "promotions",
      "time": "2 days ago",
      "is_read": true,
      "icon": Icons.local_offer,
      "color": 0xFFE91E63,
    },
    {
      "id": 6,
      "title": "Order Processing",
      "message": "Your order #ORD-2024-003 is being prepared for shipment.",
      "type": "orders",
      "time": "3 days ago",
      "is_read": true,
      "icon": Icons.inventory,
      "color": 0xFF607D8B,
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == "all") return notifications;
    return notifications.where((n) => n["type"] == selectedFilter).toList();
  }

  int get unreadCount {
    return notifications.where((n) => !(n["is_read"] as bool)).length;
  }

  void _markAsRead(int index) async {
    var notification = notifications.firstWhere((n) => n["id"] == filteredNotifications[index]["id"]);
    notification["is_read"] = true;
    setState(() {});
  }

  void _markAllAsRead() async {
    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    for (var notification in notifications) {
      notification["is_read"] = true;
    }

    loading = false;
    setState(() {});

    ss("All notifications marked as read");
  }

  void _deleteNotification(int index) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this notification?");
    if (!isConfirmed) return;

    var notificationId = filteredNotifications[index]["id"];
    notifications.removeWhere((n) => n["id"] == notificationId);
    setState(() {});

    ss("Notification deleted");
  }

  void _clearAllNotifications() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all notifications?");
    if (!isConfirmed) return;

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    notifications.clear();

    loading = false;
    setState(() {});

    ss("All notifications cleared");
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    bool isRead = notification["is_read"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isRead ? disabledOutlineBorderColor : primaryColor.withAlpha(50),
        ),
        boxShadow: [shadowSm],
      ),
      child: GestureDetector(
        onTap: () => _markAsRead(index),
        child: Container(
          padding: EdgeInsets.all(spSm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(notification["color"] as int).withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  notification["icon"] as IconData,
                  color: Color(notification["color"] as int),
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
                        Expanded(
                          child: Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontSize: 16,
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
                              color: dangerColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${notification["time"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _deleteNotification(index),
                          child: Icon(
                            Icons.delete_outline,
                            color: dangerColor,
                            size: 18,
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

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Notifications"),
            if (unreadCount > 0) ...[
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$unreadCount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (unreadCount > 0)
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: _markAllAsRead,
            ),
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Options
            QCategoryPicker(
              label: "Filter Notifications",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Notifications List
            if (filteredNotifications.isEmpty)
              Center(
                child: Column(
                  children: [
                    SizedBox(height: spXl),
                    Icon(
                      Icons.notifications_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Notifications",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      selectedFilter == "all" 
                        ? "You have no notifications at the moment"
                        : "No ${filterOptions.firstWhere((f) => f["value"] == selectedFilter)["label"].toString().toLowerCase()} notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: [
                  // Summary Info
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: infoColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${filteredNotifications.length} notification${filteredNotifications.length == 1 ? '' : 's'}" +
                            (unreadCount > 0 ? " ($unreadCount unread)" : ""),
                            style: TextStyle(
                              color: infoColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Notifications
                  ...List.generate(filteredNotifications.length, (index) {
                    final notification = filteredNotifications[index];
                    return _buildNotificationItem(notification, index);
                  }),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
