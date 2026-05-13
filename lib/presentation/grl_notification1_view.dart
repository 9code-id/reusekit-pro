import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification1View extends StatefulWidget {
  @override
  State<GrlNotification1View> createState() => _GrlNotification1ViewState();
}

class _GrlNotification1ViewState extends State<GrlNotification1View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Order Confirmed",
      "message": "Your order #12345 has been confirmed and is being prepared",
      "time": "2 min ago",
      "type": "order",
      "isRead": false,
      "icon": Icons.shopping_cart,
      "color": Colors.green,
    },
    {
      "id": 2,
      "title": "New Message",
      "message": "You have received a new message from John Smith",
      "time": "5 min ago",
      "type": "message",
      "isRead": false,
      "icon": Icons.message,
      "color": Colors.blue,
    },
    {
      "id": 3,
      "title": "Payment Successful",
      "message": "Your payment of \$49.99 has been processed successfully",
      "time": "1 hour ago",
      "type": "payment",
      "isRead": true,
      "icon": Icons.payment,
      "color": Colors.orange,
    },
    {
      "id": 4,
      "title": "System Update",
      "message": "A new system update is available. Please update your app",
      "time": "3 hours ago",
      "type": "system",
      "isRead": true,
      "icon": Icons.system_update,
      "color": Colors.purple,
    },
    {
      "id": 5,
      "title": "Delivery Update",
      "message": "Your package is out for delivery and will arrive today",
      "time": "5 hours ago",
      "type": "delivery",
      "isRead": false,
      "icon": Icons.local_shipping,
      "color": Colors.teal,
    },
    {
      "id": 6,
      "title": "Security Alert",
      "message": "New device login detected from Windows PC",
      "time": "1 day ago",
      "type": "security",
      "isRead": true,
      "icon": Icons.security,
      "color": Colors.red,
    },
  ];

  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _calculateUnreadCount();
  }

  void _calculateUnreadCount() {
    unreadCount = notifications.where((n) => !(n["isRead"] as bool)).length;
  }

  void _markAsRead(int id) {
    setState(() {
      final notification = notifications.firstWhere((n) => n["id"] == id);
      notification["isRead"] = true;
      _calculateUnreadCount();
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["isRead"] = true;
      }
      _calculateUnreadCount();
    });
  }

  void _deleteNotification(int id) {
    setState(() {
      notifications.removeWhere((n) => n["id"] == id);
      _calculateUnreadCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                "Mark all read",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (unreadCount > 0)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              color: primaryColor.withAlpha(20),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "$unreadCount unread notifications",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No notifications",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "You're all caught up!",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      final isRead = notification["isRead"] as bool;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isRead ? Colors.white : primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isRead ? disabledOutlineBorderColor : primaryColor.withAlpha(30),
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Dismissible(
                          key: Key("${notification["id"]}"),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: spMd),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            _deleteNotification(notification["id"] as int);
                            ss("Notification deleted");
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.all(spMd),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: (notification["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                notification["icon"] as IconData,
                                color: notification["color"] as Color,
                              ),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${notification["title"]}",
                                    style: TextStyle(
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
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: spXs),
                                Text(
                                  "${notification["message"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${notification["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              if (!isRead) {
                                _markAsRead(notification["id"] as int);
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
