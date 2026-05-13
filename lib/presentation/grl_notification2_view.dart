import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification2View extends StatefulWidget {
  @override
  State<GrlNotification2View> createState() => _GrlNotification2ViewState();
}

class _GrlNotification2ViewState extends State<GrlNotification2View> {
  int selectedFilter = 0;
  List<String> filterOptions = ["All", "Unread", "Messages", "System", "Orders"];
  
  List<Map<String, dynamic>> allNotifications = [
    {
      "id": 1,
      "title": "Welcome to our app!",
      "message": "Thank you for joining us. Explore all the amazing features we have to offer.",
      "time": DateTime.now().subtract(Duration(minutes: 5)),
      "category": "system",
      "isRead": false,
      "priority": "high",
      "image": "https://picsum.photos/60/60?random=1",
    },
    {
      "id": 2,
      "title": "New message from Sarah",
      "message": "Hey! Are we still meeting for lunch today?",
      "time": DateTime.now().subtract(Duration(minutes: 15)),
      "category": "messages",
      "isRead": false,
      "priority": "medium",
      "image": "https://picsum.photos/60/60?random=2",
    },
    {
      "id": 3,
      "title": "Order shipped",
      "message": "Your order #ORD-2024-001 has been shipped and is on the way",
      "time": DateTime.now().subtract(Duration(hours: 2)),
      "category": "orders",
      "isRead": true,
      "priority": "medium",
      "image": "https://picsum.photos/60/60?random=3",
    },
    {
      "id": 4,
      "title": "Security update available",
      "message": "A new security update is available. Please update your app to stay secure.",
      "time": DateTime.now().subtract(Duration(hours: 4)),
      "category": "system",
      "isRead": true,
      "priority": "high",
      "image": "https://picsum.photos/60/60?random=4",
    },
    {
      "id": 5,
      "title": "Mike commented on your post",
      "message": "Great photo! Where was this taken?",
      "time": DateTime.now().subtract(Duration(hours: 6)),
      "category": "messages",
      "isRead": false,
      "priority": "low",
      "image": "https://picsum.photos/60/60?random=5",
    },
    {
      "id": 6,
      "title": "Payment received",
      "message": "We have received your payment of \$299.99",
      "time": DateTime.now().subtract(Duration(days: 1)),
      "category": "orders",
      "isRead": true,
      "priority": "medium",
      "image": "https://picsum.photos/60/60?random=6",
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    switch (selectedFilter) {
      case 1: // Unread
        return allNotifications.where((n) => !(n["isRead"] as bool)).toList();
      case 2: // Messages
        return allNotifications.where((n) => n["category"] == "messages").toList();
      case 3: // System
        return allNotifications.where((n) => n["category"] == "system").toList();
      case 4: // Orders
        return allNotifications.where((n) => n["category"] == "orders").toList();
      default: // All
        return allNotifications;
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
        return disabledColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "messages":
        return Icons.message;
      case "system":
        return Icons.settings;
      case "orders":
        return Icons.shopping_bag;
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
      final notification = allNotifications.firstWhere((n) => n["id"] == id);
      notification["isRead"] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = filteredNotifications;
    final unreadCount = allNotifications.where((n) => !(n["isRead"] as bool)).length;

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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filterOptions.length,
              itemBuilder: (context, index) {
                final isSelected = selectedFilter == index;
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: FilterChip(
                    label: Text(filterOptions[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = index;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: primaryColor.withAlpha(20),
                    labelStyle: TextStyle(
                      color: isSelected ? primaryColor : disabledBoldColor,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    side: BorderSide(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                );
              },
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
                          "No notifications match your filter",
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
                      final priority = notification["priority"] as String;
                      final category = notification["category"] as String;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: isRead ? Colors.white : primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isRead ? disabledOutlineBorderColor : primaryColor.withAlpha(30),
                          ),
                          boxShadow: [shadowSm],
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
                                // Profile image
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
                                      "${notification["image"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                
                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title and priority
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${notification["title"]}",
                                              style: TextStyle(
                                                fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                                                color: primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(priority),
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
                                      
                                      // Time and category
                                      Row(
                                        children: [
                                          Icon(
                                            _getCategoryIcon(category),
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
                                          if (!isRead) ...[
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "NEW",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
