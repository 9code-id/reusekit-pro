import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification4View extends StatefulWidget {
  @override
  State<GrlNotification4View> createState() => _GrlNotification4ViewState();
}

class _GrlNotification4ViewState extends State<GrlNotification4View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "type": "promotion",
      "title": "50% Off Weekend Sale",
      "message": "Don't miss out on our biggest sale of the year! Get 50% off on all premium items.",
      "time": "2 min ago",
      "image": "https://picsum.photos/300/150?random=1&keyword=sale",
      "isRead": false,
      "actionLabel": "Shop Now",
      "badge": "LIMITED TIME",
      "backgroundColor": Colors.orange,
    },
    {
      "id": 2,
      "type": "update",
      "title": "App Update Available",
      "message": "Version 2.1.0 includes new features, performance improvements, and bug fixes.",
      "time": "1 hour ago",
      "image": "https://picsum.photos/300/150?random=2&keyword=technology",
      "isRead": false,
      "actionLabel": "Update Now",
      "badge": "NEW VERSION",
      "backgroundColor": Colors.blue,
    },
    {
      "id": 3,
      "type": "achievement",
      "title": "Congratulations!",
      "message": "You've completed your 30-day streak! Keep up the great work and maintain your momentum.",
      "time": "3 hours ago",
      "image": "https://picsum.photos/300/150?random=3&keyword=trophy",
      "isRead": true,
      "actionLabel": "View Progress",
      "badge": "ACHIEVEMENT",
      "backgroundColor": Colors.green,
    },
    {
      "id": 4,
      "type": "reminder",
      "title": "Meeting Reminder",
      "message": "Your team meeting 'Project Review' starts in 30 minutes. Join the video call now.",
      "time": "5 hours ago",
      "image": "https://picsum.photos/300/150?random=4&keyword=meeting",
      "isRead": true,
      "actionLabel": "Join Meeting",
      "badge": "URGENT",
      "backgroundColor": Colors.red,
    },
    {
      "id": 5,
      "type": "social",
      "title": "New Follower",
      "message": "Alex Johnson and 5 others started following you. Check out their profiles!",
      "time": "1 day ago",
      "image": "https://picsum.photos/300/150?random=5&keyword=people",
      "isRead": false,
      "actionLabel": "View Profile",
      "badge": "SOCIAL",
      "backgroundColor": Colors.purple,
    },
    {
      "id": 6,
      "type": "news",
      "title": "Industry News Update",
      "message": "Stay informed with the latest trends and developments in your industry.",
      "time": "2 days ago",
      "image": "https://picsum.photos/300/150?random=6&keyword=news",
      "isRead": true,
      "actionLabel": "Read Article",
      "badge": "TRENDING",
      "backgroundColor": Colors.teal,
    },
  ];

  void _markAsRead(int id) {
    setState(() {
      final notification = notifications.firstWhere((n) => n["id"] == id);
      notification["isRead"] = true;
    });
  }

  void _deleteNotification(int id) {
    setState(() {
      notifications.removeWhere((n) => n["id"] == id);
    });
    ss("Notification removed");
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification["isRead"] as bool;
    final backgroundColor = notification["backgroundColor"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with badge
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                  child: Image.network(
                    "${notification["image"]}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Badge
              Positioned(
                top: spMd,
                left: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                    boxShadow: [shadowSm],
                  ),
                  child: Text(
                    "${notification["badge"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // Unread indicator
              if (!isRead)
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [shadowSm],
                    ),
                  ),
                ),
            ],
          ),
          
          // Content section
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with title and time
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${notification["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${notification["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Message
                Text(
                  "${notification["message"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spMd),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "${notification["actionLabel"]}",
                        size: bs.sm,
                        onPressed: () {
                          if (!isRead) {
                            _markAsRead(notification["id"] as int);
                          }
                          ss("Action performed: ${notification["actionLabel"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: IconButton(
                        onPressed: () => _deleteNotification(notification["id"] as int),
                        icon: Icon(
                          Icons.close,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
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
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !(n["isRead"] as bool)).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "$unreadCount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: notifications.isEmpty
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
                    "We'll notify you when something happens",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Summary header
                if (unreadCount > 0)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withAlpha(10),
                          primaryColor.withAlpha(5),
                        ],
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: primaryColor.withAlpha(20),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.notifications_active,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You have $unreadCount unread notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Tap to view and take action",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Mark all read",
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
                      ],
                    ),
                  ),
                
                // Notifications list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationCard(notifications[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
