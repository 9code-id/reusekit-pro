import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNotification7View extends StatefulWidget {
  @override
  State<GrlNotification7View> createState() => _GrlNotification7ViewState();
}

class _GrlNotification7ViewState extends State<GrlNotification7View> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "type": "order",
      "title": "Order Confirmation",
      "description": "Your order #ORD-2024-001 has been confirmed",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "isRead": false,
      "details": {
        "orderId": "ORD-2024-001",
        "amount": 299.99,
        "items": 3,
        "status": "Confirmed",
      },
      "icon": Icons.shopping_bag,
      "iconColor": Colors.green,
    },
    {
      "id": 2,
      "type": "message",
      "title": "New Message",
      "description": "You have received a message from customer support",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
      "isRead": false,
      "details": {
        "from": "Customer Support",
        "subject": "Regarding your recent inquiry",
        "preview": "Thank you for contacting us. We have reviewed your request...",
      },
      "icon": Icons.message,
      "iconColor": Colors.blue,
    },
    {
      "id": 3,
      "type": "promotion",
      "title": "Limited Time Offer",
      "description": "Get 30% off on all premium plans this week",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "isRead": true,
      "details": {
        "discount": "30%",
        "validUntil": "Dec 31, 2024",
        "couponCode": "PREMIUM30",
      },
      "icon": Icons.local_offer,
      "iconColor": Colors.orange,
    },
    {
      "id": 4,
      "type": "security",
      "title": "Security Alert",
      "description": "New login detected from Windows device",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
      "isRead": true,
      "details": {
        "device": "Windows PC",
        "location": "New York, USA",
        "ip": "192.168.1.100",
        "time": "Dec 15, 2024 at 3:45 PM",
      },
      "icon": Icons.security,
      "iconColor": Colors.red,
    },
    {
      "id": 5,
      "type": "reminder",
      "title": "Subscription Renewal",
      "description": "Your premium subscription expires in 3 days",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "isRead": false,
      "details": {
        "plan": "Premium Plan",
        "expiryDate": "Dec 18, 2024",
        "autoRenewal": true,
        "amount": 19.99,
      },
      "icon": Icons.schedule,
      "iconColor": Colors.amber,
    },
  ];

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return timestamp.dMMMy;
    }
  }

  void _markAsRead(int id) {
    setState(() {
      final notification = notifications.firstWhere((n) => n["id"] == id);
      notification["isRead"] = true;
    });
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowLg],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: (notification["iconColor"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: notification["iconColor"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        notification["icon"] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            _formatTimestamp(notification["timestamp"] as DateTime),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => back(),
                      icon: Icon(Icons.close),
                      color: disabledBoldColor,
                    ),
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${notification["description"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Details section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontSize: fsH6,
                            ),
                          ),
                          SizedBox(height: spSm),
                          ..._buildDetailItems(notification["details"] as Map<String, dynamic>),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),
                    
                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Dismiss",
                            size: bs.md,
                            onPressed: () {
                              back();
                              _markAsRead(notification["id"] as int);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: _getActionLabel(notification["type"] as String),
                            size: bs.md,
                            onPressed: () {
                              back();
                              _markAsRead(notification["id"] as int);
                              ss("${_getActionLabel(notification["type"] as String)} performed");
                            },
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

  List<Widget> _buildDetailItems(Map<String, dynamic> details) {
    return details.entries.map((entry) {
      String key = entry.key;
      dynamic value = entry.value;
      
      // Format key for display
      String displayKey = key.replaceAllMapped(
        RegExp(r'([A-Z])'),
        (match) => ' ${match.group(0)}',
      ).trim();
      displayKey = displayKey.split(' ').map((word) => 
        word[0].toUpperCase() + word.substring(1).toLowerCase()
      ).join(' ');
      
      // Format value for display
      String displayValue = value.toString();
      if (value is double && key.toLowerCase().contains('amount')) {
        displayValue = "\$${value.toString()}";
      } else if (value is bool) {
        displayValue = value ? "Yes" : "No";
      }
      
      return Padding(
        padding: EdgeInsets.only(bottom: spSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: Text(
                "$displayKey:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: Text(
                displayValue,
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  String _getActionLabel(String type) {
    switch (type) {
      case "order":
        return "View Order";
      case "message":
        return "Reply";
      case "promotion":
        return "Use Offer";
      case "security":
        return "Review";
      case "reminder":
        return "Renew Now";
      default:
        return "Take Action";
    }
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = notifications.where((n) => !(n["isRead"] as bool)).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          if (unreadCount > 0)
            Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
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
                    "You're all caught up!",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Quick actions bar
                if (unreadCount > 0)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    color: primaryColor.withAlpha(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "$unreadCount unread notifications",
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
                      final notification = notifications[index];
                      final isRead = notification["isRead"] as bool;
                      final iconColor = notification["iconColor"] as Color;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: Border.all(
                            color: isRead ? disabledOutlineBorderColor : iconColor.withAlpha(30),
                            width: isRead ? 1 : 2,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(radiusLg),
                          onTap: () => _showNotificationDetails(notification),
                          child: Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
                                // Icon
                                Container(
                                  padding: EdgeInsets.all(spMd),
                                  decoration: BoxDecoration(
                                    color: iconColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    notification["icon"] as IconData,
                                    color: iconColor,
                                    size: 24,
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
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: iconColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${notification["description"]}",
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
                                            Icons.access_time,
                                            size: 14,
                                            color: disabledColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            _formatTimestamp(notification["timestamp"] as DateTime),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "${notification["type"]}".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: iconColor,
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
