import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification8View extends StatefulWidget {
  @override
  State<GrlNotification8View> createState() => _GrlNotification8ViewState();
}

class _GrlNotification8ViewState extends State<GrlNotification8View> {
  int selectedIndex = 0;
  
  Map<String, List<Map<String, dynamic>>> notificationsByCategory = {
    "All": [
      {
        "id": 1,
        "title": "Order Delivered Successfully",
        "message": "Your order #12345 has been delivered to your address. Thank you for shopping with us!",
        "time": "Just now",
        "category": "orders",
        "isRead": false,
        "priority": "high",
        "user": {
          "name": "Delivery Service",
          "avatar": "https://picsum.photos/50/50?random=1",
        }
      },
      {
        "id": 2,
        "title": "New Message from Alex",
        "message": "Hey! I saw your latest post about the vacation. The photos look amazing!",
        "time": "5 min ago",
        "category": "messages",
        "isRead": false,
        "priority": "medium",
        "user": {
          "name": "Alex Johnson",
          "avatar": "https://picsum.photos/50/50?random=2",
        }
      },
      {
        "id": 3,
        "title": "Weekly Summary Ready",
        "message": "Your weekly activity summary is now available. Check out your achievements!",
        "time": "2 hours ago",
        "category": "reports",
        "isRead": true,
        "priority": "low",
        "user": {
          "name": "System",
          "avatar": "https://picsum.photos/50/50?random=3",
        }
      },
      {
        "id": 4,
        "title": "Security Alert",
        "message": "We detected a new login from an unrecognized device. Please verify if this was you.",
        "time": "1 day ago",
        "category": "security",
        "isRead": false,
        "priority": "high",
        "user": {
          "name": "Security Team",
          "avatar": "https://picsum.photos/50/50?random=4",
        }
      },
      {
        "id": 5,
        "title": "App Update Available",
        "message": "Version 2.5.0 is now available with new features and improvements.",
        "time": "2 days ago",
        "category": "updates",
        "isRead": true,
        "priority": "medium",
        "user": {
          "name": "App Store",
          "avatar": "https://picsum.photos/50/50?random=5",
        }
      },
    ],
    "Messages": [],
    "Orders": [],
    "Security": [],
    "Updates": [],
  };

  List<String> get categories => notificationsByCategory.keys.toList();

  @override
  void initState() {
    super.initState();
    _categorizeNotifications();
  }

  void _categorizeNotifications() {
    final allNotifications = notificationsByCategory["All"]!;
    
    notificationsByCategory["Messages"] = allNotifications
        .where((n) => n["category"] == "messages")
        .toList();
    notificationsByCategory["Orders"] = allNotifications
        .where((n) => n["category"] == "orders")
        .toList();
    notificationsByCategory["Security"] = allNotifications
        .where((n) => n["category"] == "security")
        .toList();
    notificationsByCategory["Updates"] = allNotifications
        .where((n) => n["category"] == "updates")
        .toList();
  }

  List<Map<String, dynamic>> get currentNotifications {
    return notificationsByCategory[categories[selectedIndex]]!;
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case "messages":
        return Colors.blue;
      case "orders":
        return Colors.green;
      case "security":
        return Colors.red;
      case "updates":
        return Colors.purple;
      case "reports":
        return Colors.orange;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "messages":
        return Icons.message;
      case "orders":
        return Icons.shopping_bag;
      case "security":
        return Icons.security;
      case "updates":
        return Icons.system_update;
      case "reports":
        return Icons.analytics;
      default:
        return Icons.notifications;
    }
  }

  void _markAsRead(int id) {
    setState(() {
      for (var categoryNotifications in notificationsByCategory.values) {
        for (var notification in categoryNotifications) {
          if (notification["id"] == id) {
            notification["isRead"] = true;
            break;
          }
        }
      }
    });
  }

  int _getUnreadCount(String category) {
    return notificationsByCategory[category]!
        .where((n) => !(n["isRead"] as bool))
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final notifications = currentNotifications;
    final unreadCount = _getUnreadCount(categories[selectedIndex]);
    final totalUnread = _getUnreadCount("All");

    return QBottomBar(
      title: "Notifications",
      selectedIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.notifications),
              if (totalUnread > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Text(
                      "$totalUnread",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: "All",
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.message),
              if (_getUnreadCount("Messages") > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: "Messages",
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.shopping_bag),
              if (_getUnreadCount("Orders") > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: "Orders",
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.security),
              if (_getUnreadCount("Security") > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: "Security",
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.system_update),
              if (_getUnreadCount("Updates") > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          label: "Updates",
        ),
      ],
      children: categories.map((category) {
        final categoryNotifications = notificationsByCategory[category]!;
        final categoryUnreadCount = _getUnreadCount(category);
        
        return Column(
          children: [
            // Category header
            if (categoryUnreadCount > 0)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                color: primaryColor.withAlpha(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "$categoryUnreadCount unread notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Mark all read",
                      size: bs.sm,
                      onPressed: () {
                        setState(() {
                          for (var notification in categoryNotifications) {
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
              child: categoryNotifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category == "All" ? Icons.notifications_none : _getCategoryIcon(category.toLowerCase()),
                            size: 80,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No ${category.toLowerCase()} notifications",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            category == "All" 
                                ? "You're all caught up!"
                                : "No ${category.toLowerCase()} notifications yet",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(spMd),
                      itemCount: categoryNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = categoryNotifications[index];
                        final isRead = notification["isRead"] as bool;
                        final priority = notification["priority"] as String;
                        final categoryName = notification["category"] as String;
                        final user = notification["user"] as Map<String, dynamic>;
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: spMd),
                          decoration: BoxDecoration(
                            color: isRead ? Colors.white : primaryColor.withAlpha(5),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isRead ? disabledOutlineBorderColor : _getPriorityColor(priority).withAlpha(50),
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
                              child: Column(
                                children: [
                                  // Header row
                                  Row(
                                    children: [
                                      // User avatar
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
                                            "${user["avatar"]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spMd),
                                      
                                      // Title and user info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${notification["title"]}",
                                              style: TextStyle(
                                                fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                                color: primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Row(
                                              children: [
                                                Text(
                                                  "${user["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: _getCategoryColor(categoryName),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: spSm),
                                                Text(
                                                  "•",
                                                  style: TextStyle(
                                                    color: disabledColor,
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
                                          ],
                                        ),
                                      ),
                                      
                                      // Priority and category indicators
                                      Column(
                                        children: [
                                          if (!isRead)
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                color: _getPriorityColor(priority),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          SizedBox(height: spXs),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: _getCategoryColor(categoryName).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Icon(
                                              _getCategoryIcon(categoryName),
                                              size: 16,
                                              color: _getCategoryColor(categoryName),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spMd),
                                  
                                  // Message
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(5),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${notification["message"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                  
                                  // Action buttons
                                  Row(
                                    children: [
                                      if (!isRead)
                                        Expanded(
                                          child: QButton(
                                            label: "Mark as read",
                                            size: bs.sm,
                                            onPressed: () => _markAsRead(notification["id"] as int),
                                          ),
                                        ),
                                      if (!isRead) SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            if (!isRead) {
                                              _markAsRead(notification["id"] as int);
                                            }
                                            ss("Viewing notification details");
                                          },
                                        ),
                                      ),
                                    ],
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
        );
      }).toList(),
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
