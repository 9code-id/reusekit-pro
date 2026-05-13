import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification10View extends StatefulWidget {
  @override
  State<GrlNotification10View> createState() => _GrlNotification10ViewState();
}

class _GrlNotification10ViewState extends State<GrlNotification10View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Daily Achievement Unlocked!",
      "message": "Congratulations! You've completed your daily goal. Keep up the great work!",
      "time": DateTime.now().subtract(Duration(minutes: 5)),
      "type": "achievement",
      "isRead": false,
      "importance": "high",
      "image": "https://picsum.photos/100/100?random=1&keyword=trophy",
      "actionRequired": false,
      "tags": ["Achievement", "Daily Goal"],
    },
    {
      "id": 2,
      "title": "Meeting Reminder",
      "message": "Your team standup meeting starts in 15 minutes. Don't forget to join the video call.",
      "time": DateTime.now().subtract(Duration(minutes: 10)),
      "type": "reminder",
      "isRead": false,
      "importance": "urgent",
      "image": "https://picsum.photos/100/100?random=2&keyword=meeting",
      "actionRequired": true,
      "tags": ["Meeting", "Team", "Urgent"],
    },
    {
      "id": 3,
      "title": "New Feature Available",
      "message": "We've added dark mode support! You can now switch between light and dark themes in settings.",
      "time": DateTime.now().subtract(Duration(hours: 2)),
      "type": "feature",
      "isRead": true,
      "importance": "medium",
      "image": "https://picsum.photos/100/100?random=3&keyword=feature",
      "actionRequired": false,
      "tags": ["Feature", "Update", "Dark Mode"],
    },
    {
      "id": 4,
      "title": "Payment Processed",
      "message": "Your payment of \$49.99 for Premium Plan has been successfully processed. Thank you!",
      "time": DateTime.now().subtract(Duration(hours: 4)),
      "type": "payment",
      "isRead": true,
      "importance": "high",
      "image": "https://picsum.photos/100/100?random=4&keyword=payment",
      "actionRequired": false,
      "tags": ["Payment", "Premium", "Success"],
    },
    {
      "id": 5,
      "title": "Weekly Report Ready",
      "message": "Your weekly productivity report is now available. Check out your progress and insights.",
      "time": DateTime.now().subtract(Duration(days: 1)),
      "type": "report",
      "isRead": false,
      "importance": "low",
      "image": "https://picsum.photos/100/100?random=5&keyword=chart",
      "actionRequired": false,
      "tags": ["Report", "Weekly", "Analytics"],
    },
    {
      "id": 6,
      "title": "Security Update",
      "message": "We've enhanced our security measures. Your account is now more secure than ever.",
      "time": DateTime.now().subtract(Duration(days: 2)),
      "type": "security",
      "isRead": true,
      "importance": "high",
      "image": "https://picsum.photos/100/100?random=6&keyword=security",
      "actionRequired": false,
      "tags": ["Security", "Update", "Protection"],
    },
  ];

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "urgent":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "achievement":
        return Colors.amber;
      case "reminder":
        return Colors.purple;
      case "feature":
        return Colors.blue;
      case "payment":
        return Colors.green;
      case "report":
        return Colors.orange;
      case "security":
        return Colors.red;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "achievement":
        return Icons.emoji_events;
      case "reminder":
        return Icons.schedule;
      case "feature":
        return Icons.new_releases;
      case "payment":
        return Icons.payment;
      case "report":
        return Icons.analytics;
      case "security":
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  void _markAsRead(int id) {
    setState(() {
      final notification = notifications.firstWhere((n) => n["id"] == id);
      notification["isRead"] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["isRead"] = true;
      }
    });
    ss("All notifications marked as read");
  }

  void _deleteNotification(int id) {
    setState(() {
      notifications.removeWhere((n) => n["id"] == id);
    });
    ss("Notification deleted");
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !(n["isRead"] as bool)).length;
    final urgentCount = notifications.where((n) => 
        n["importance"] == "urgent" && !(n["isRead"] as bool)).length;

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
          // Summary header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  primaryColor.withAlpha(5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                // Total notifications
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: primaryColor.withAlpha(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${notifications.length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                
                // Unread notifications
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: unreadCount > 0 ? warningColor.withAlpha(10) : successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: unreadCount > 0 ? warningColor.withAlpha(30) : successColor.withAlpha(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          unreadCount > 0 ? Icons.mark_email_unread : Icons.mark_email_read,
                          color: unreadCount > 0 ? warningColor : successColor,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$unreadCount",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: unreadCount > 0 ? warningColor : successColor,
                          ),
                        ),
                        Text(
                          "Unread",
                          style: TextStyle(
                            fontSize: 12,
                            color: unreadCount > 0 ? warningColor : successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                
                // Urgent notifications
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: urgentCount > 0 ? dangerColor.withAlpha(10) : disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: urgentCount > 0 ? dangerColor.withAlpha(30) : disabledColor.withAlpha(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.priority_high,
                          color: urgentCount > 0 ? dangerColor : disabledColor,
                          size: 24,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$urgentCount",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: urgentCount > 0 ? dangerColor : disabledColor,
                          ),
                        ),
                        Text(
                          "Urgent",
                          style: TextStyle(
                            fontSize: 12,
                            color: urgentCount > 0 ? dangerColor : disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Notifications list
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
                      final importance = notification["importance"] as String;
                      final type = notification["type"] as String;
                      final actionRequired = notification["actionRequired"] as bool;
                      final tags = notification["tags"] as List<String>;
                      
                      return Dismissible(
                        key: Key("${notification["id"]}"),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: spMd),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mark_email_read,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Mark Read",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        secondaryBackground: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: spMd),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            // Mark as read
                            _markAsRead(notification["id"] as int);
                            ss("Notification marked as read");
                          } else {
                            // Delete
                            _deleteNotification(notification["id"] as int);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            boxShadow: [shadowMd],
                            border: Border(
                              left: BorderSide(
                                width: 4,
                                color: _getImportanceColor(importance),
                              ),
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusLg),
                            onTap: () {
                              if (!isRead) {
                                _markAsRead(notification["id"] as int);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image and type icon
                                  Stack(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          boxShadow: [shadowSm],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                          child: Image.network(
                                            "${notification["image"]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -2,
                                        right: -2,
                                        child: Container(
                                          width: 24,
                                          height: 24,
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
                                        // Title and indicators
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
                                            if (actionRequired)
                                              Container(
                                                margin: EdgeInsets.only(left: spSm),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spSm,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: dangerColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "ACTION",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            if (!isRead)
                                              Container(
                                                margin: EdgeInsets.only(left: spSm),
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: _getImportanceColor(importance),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        
                                        // Message
                                        Text(
                                          "${notification["message"]}",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            height: 1.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: spSm),
                                        
                                        // Tags
                                        Wrap(
                                          spacing: spXs,
                                          runSpacing: spXs,
                                          children: tags.map((tag) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getTypeColor(type).withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                tag,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: _getTypeColor(type),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        SizedBox(height: spSm),
                                        
                                        // Time and importance
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: disabledColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              _formatTime(notification["time"] as DateTime),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getImportanceColor(importance).withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                importance.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: _getImportanceColor(importance),
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
