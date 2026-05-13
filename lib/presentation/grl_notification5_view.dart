import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification5View extends StatefulWidget {
  @override
  State<GrlNotification5View> createState() => _GrlNotification5ViewState();
}

class _GrlNotification5ViewState extends State<GrlNotification5View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Order Shipped",
      "message": "Your order #12345 has been shipped and is on its way to you",
      "time": DateTime.now().subtract(Duration(minutes: 5)),
      "type": "shipping",
      "priority": "high",
      "isRead": false,
      "sender": "Shipping Department",
      "senderAvatar": "https://picsum.photos/50/50?random=1",
      "actions": ["Track Order", "Contact Support"],
    },
    {
      "id": 2,
      "title": "New Message from Sarah",
      "message": "Hey! I wanted to discuss the project details with you. When are you free?",
      "time": DateTime.now().subtract(Duration(minutes: 15)),
      "type": "message",
      "priority": "medium",
      "isRead": false,
      "sender": "Sarah Johnson",
      "senderAvatar": "https://picsum.photos/50/50?random=2",
      "actions": ["Reply", "Call"],
    },
    {
      "id": 3,
      "title": "Payment Received",
      "message": "We have received your payment of \$299.99 for your premium subscription",
      "time": DateTime.now().subtract(Duration(hours: 2)),
      "type": "payment",
      "priority": "low",
      "isRead": true,
      "sender": "Billing Team",
      "senderAvatar": "https://picsum.photos/50/50?random=3",
      "actions": ["View Receipt", "Manage Subscription"],
    },
    {
      "id": 4,
      "title": "Security Alert",
      "message": "We detected a login attempt from a new device. Please verify if this was you.",
      "time": DateTime.now().subtract(Duration(hours: 4)),
      "type": "security",
      "priority": "high",
      "isRead": false,
      "sender": "Security Team",
      "senderAvatar": "https://picsum.photos/50/50?random=4",
      "actions": ["Verify", "Secure Account"],
    },
    {
      "id": 5,
      "title": "Weekly Report Ready",
      "message": "Your weekly activity report is now available for download",
      "time": DateTime.now().subtract(Duration(days: 1)),
      "type": "report",
      "priority": "low",
      "isRead": true,
      "sender": "Analytics Team",
      "senderAvatar": "https://picsum.photos/50/50?random=5",
      "actions": ["Download", "View Online"],
    },
  ];

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

  Color _getTypeColor(String type) {
    switch (type) {
      case "shipping":
        return Colors.blue;
      case "message":
        return Colors.green;
      case "payment":
        return Colors.orange;
      case "security":
        return Colors.red;
      case "report":
        return Colors.purple;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "shipping":
        return Icons.local_shipping;
      case "message":
        return Icons.message;
      case "payment":
        return Icons.payment;
      case "security":
        return Icons.security;
      case "report":
        return Icons.analytics;
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

  void _performAction(String action, Map<String, dynamic> notification) {
    if (!(notification["isRead"] as bool)) {
      _markAsRead(notification["id"] as int);
    }
    ss("$action performed");
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(top: spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
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
                        "${notification["senderAvatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${notification["sender"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${notification["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          _formatTime(notification["time"] as DateTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(notification["type"] as String).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${notification["type"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getTypeColor(notification["type"] as String),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Divider(height: 1),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: fsH6,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        height: 1.6,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Priority indicator
                    Row(
                      children: [
                        Text(
                          "Priority: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(notification["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${notification["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(notification["priority"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Actions
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Row(
                    children: (notification["actions"] as List<String>).map((action) {
                      final isFirst = (notification["actions"] as List<String>).indexOf(action) == 0;
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: isFirst ? spSm : 0),
                          child: QButton(
                            label: action,
                            size: bs.md,
                            onPressed: () {
                              back();
                              _performAction(action, notification);
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Mark as Read",
                      size: bs.md,
                      onPressed: () {
                        back();
                        _markAsRead(notification["id"] as int);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          IconButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification["isRead"] = true;
                }
              });
              ss("All notifications marked as read");
            },
            icon: Icon(Icons.done_all),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "$unreadCount",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Unread",
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
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${notifications.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${notifications.where((n) => n["priority"] == "high").length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "High Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
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
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      final isRead = notification["isRead"] as bool;
                      final priority = notification["priority"] as String;
                      final type = notification["type"] as String;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getPriorityColor(priority),
                            ),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(radiusLg),
                          onTap: () => _showNotificationDetails(notification),
                          child: Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
                                // Avatar
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
                                      "${notification["senderAvatar"]}",
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
                                                color: _getPriorityColor(priority),
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
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spSm),
                                      Row(
                                        children: [
                                          Icon(
                                            _getTypeIcon(type),
                                            size: 14,
                                            color: _getTypeColor(type),
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
                                              color: _getPriorityColor(priority).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              priority.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: _getPriorityColor(priority),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: disabledColor,
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
