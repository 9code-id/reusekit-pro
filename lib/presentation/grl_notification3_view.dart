import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification3View extends StatefulWidget {
  @override
  State<GrlNotification3View> createState() => _GrlNotification3ViewState();
}

class _GrlNotification3ViewState extends State<GrlNotification3View> {
  int selectedTab = 0;
  
  List<Map<String, dynamic>> todayNotifications = [
    {
      "id": 1,
      "title": "Order Delivered",
      "message": "Your order has been successfully delivered to your address",
      "time": "9:30 AM",
      "isRead": false,
      "type": "success",
      "avatar": "https://picsum.photos/40/40?random=1",
    },
    {
      "id": 2,
      "title": "Payment Reminder",
      "message": "Your monthly subscription payment is due in 3 days",
      "time": "8:15 AM",
      "isRead": false,
      "type": "warning",
      "avatar": "https://picsum.photos/40/40?random=2",
    },
    {
      "id": 3,
      "title": "New Feature Update",
      "message": "Check out the new dark mode feature in app settings",
      "time": "7:00 AM",
      "isRead": true,
      "type": "info",
      "avatar": "https://picsum.photos/40/40?random=3",
    },
  ];

  List<Map<String, dynamic>> earlierNotifications = [
    {
      "id": 4,
      "title": "Security Alert",
      "message": "New device login detected from unknown location",
      "time": "Yesterday, 6:30 PM",
      "isRead": true,
      "type": "error",
      "avatar": "https://picsum.photos/40/40?random=4",
    },
    {
      "id": 5,
      "title": "Weekly Report",
      "message": "Your weekly activity report is now available",
      "time": "Yesterday, 2:15 PM",
      "isRead": true,
      "type": "info",
      "avatar": "https://picsum.photos/40/40?random=5",
    },
    {
      "id": 6,
      "title": "Friend Request",
      "message": "John Doe sent you a friend request",
      "time": "2 days ago",
      "isRead": false,
      "type": "social",
      "avatar": "https://picsum.photos/40/40?random=6",
    },
    {
      "id": 7,
      "title": "Backup Complete",
      "message": "Your data backup has been completed successfully",
      "time": "3 days ago",
      "isRead": true,
      "type": "success",
      "avatar": "https://picsum.photos/40/40?random=7",
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "error":
        return dangerColor;
      case "info":
        return infoColor;
      case "social":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "success":
        return Icons.check_circle;
      case "warning":
        return Icons.warning;
      case "error":
        return Icons.error;
      case "info":
        return Icons.info;
      case "social":
        return Icons.person_add;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isRead = notification["isRead"] as bool;
    final type = notification["type"] as String;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isRead ? null : Border.all(
          color: _getTypeColor(type).withAlpha(50),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radiusLg),
        onTap: () {
          setState(() {
            notification["isRead"] = true;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(spMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with type indicator
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowXs],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${notification["avatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _getTypeColor(type),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        _getTypeIcon(type),
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
                              fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                              color: primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getTypeColor(type),
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
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${notification["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Action menu
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: disabledColor,
                  size: 20,
                ),
                onSelected: (value) {
                  switch (value) {
                    case "mark_read":
                      setState(() {
                        notification["isRead"] = true;
                      });
                      break;
                    case "delete":
                      setState(() {
                        todayNotifications.removeWhere((n) => n["id"] == notification["id"]);
                        earlierNotifications.removeWhere((n) => n["id"] == notification["id"]);
                      });
                      ss("Notification deleted");
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!isRead)
                    PopupMenuItem(
                      value: "mark_read",
                      child: Row(
                        children: [
                          Icon(Icons.mark_email_read, size: 16),
                          SizedBox(width: spSm),
                          Text("Mark as read"),
                        ],
                      ),
                    ),
                  PopupMenuItem(
                    value: "delete",
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16, color: dangerColor),
                        SizedBox(width: spSm),
                        Text(
                          "Delete",
                          style: TextStyle(color: dangerColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allNotifications = [...todayNotifications, ...earlierNotifications];
    final unreadCount = allNotifications.where((n) => !(n["isRead"] as bool)).length;

    return QTabBar(
      title: "Notifications",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Today (${todayNotifications.length})"),
        Tab(text: "Earlier (${earlierNotifications.length})"),
      ],
      tabChildren: [
        // Today Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (unreadCount > 0)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: primaryColor.withAlpha(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "$unreadCount new notifications",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Mark all read",
                        size: bs.sm,
                        onPressed: () {
                          setState(() {
                            for (var notification in allNotifications) {
                              notification["isRead"] = true;
                            }
                          });
                          ss("All notifications marked as read");
                        },
                      ),
                    ],
                  ),
                ),
              
              if (todayNotifications.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 60,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No notifications today",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Check back later for updates",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...todayNotifications.map((notification) => _buildNotificationItem(notification)),
            ],
          ),
        ),
        
        // Earlier Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (earlierNotifications.isEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spXl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        size: 60,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No earlier notifications",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Your notification history will appear here",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...earlierNotifications.map((notification) => _buildNotificationItem(notification)),
            ],
          ),
        ),
      ],
    );
  }
}
