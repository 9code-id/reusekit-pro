import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist6View extends StatefulWidget {
  @override
  State<GrlWishlist6View> createState() => _GrlWishlist6ViewState();
}

class _GrlWishlist6ViewState extends State<GrlWishlist6View> {
  bool loading = false;
  int selectedTab = 0;
  String selectedNotificationType = "all";
  
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "type": "price_drop",
      "title": "Price Drop Alert!",
      "message": "Wireless Headphones Pro is now 25% off",
      "productName": "Wireless Headphones Pro",
      "oldPrice": 329.99,
      "newPrice": 249.99,
      "image": "https://picsum.photos/100/100?random=40&keyword=headphones",
      "timestamp": "2024-12-20T10:30:00",
      "isRead": false,
      "actionType": "price_drop",
    },
    {
      "id": 2,
      "type": "back_in_stock",
      "title": "Back in Stock!",
      "message": "Designer Handbag is now available",
      "productName": "Designer Handbag",
      "image": "https://picsum.photos/100/100?random=41&keyword=handbag",
      "timestamp": "2024-12-20T09:15:00",
      "isRead": false,
      "actionType": "restock",
    },
    {
      "id": 3,
      "type": "price_increase",
      "title": "Price Alert",
      "message": "Smart Coffee Maker price increased",
      "productName": "Smart Coffee Maker",
      "oldPrice": 189.99,
      "newPrice": 219.99,
      "image": "https://picsum.photos/100/100?random=42&keyword=coffee",
      "timestamp": "2024-12-19T16:45:00",
      "isRead": true,
      "actionType": "price_increase",
    },
    {
      "id": 4,
      "type": "sale_ending",
      "title": "Sale Ending Soon!",
      "message": "Programming Guide sale ends in 2 days",
      "productName": "Programming Guide",
      "saleEndDate": "2024-12-22",
      "currentPrice": 45.99,
      "image": "https://picsum.photos/100/100?random=43&keyword=book",
      "timestamp": "2024-12-19T14:20:00",
      "isRead": true,
      "actionType": "sale_ending",
    },
    {
      "id": 5,
      "type": "new_review",
      "title": "New Review",
      "message": "Smartwatch Pro received 5-star review",
      "productName": "Smartwatch Pro",
      "reviewRating": 5.0,
      "reviewText": "Amazing battery life and features!",
      "image": "https://picsum.photos/100/100?random=44&keyword=smartwatch",
      "timestamp": "2024-12-19T11:30:00",
      "isRead": true,
      "actionType": "review",
    },
  ];

  List<Map<String, dynamic>> priceAlerts = [
    {
      "id": 1,
      "productName": "Gaming Laptop",
      "currentPrice": 1299.99,
      "targetPrice": 999.00,
      "image": "https://picsum.photos/100/100?random=45&keyword=laptop",
      "isActive": true,
      "createdDate": "2024-12-15",
    },
    {
      "id": 2,
      "productName": "Professional Camera",
      "currentPrice": 2499.99,
      "targetPrice": 2000.00,
      "image": "https://picsum.photos/100/100?random=46&keyword=camera",
      "isActive": true,
      "createdDate": "2024-12-10",
    },
    {
      "id": 3,
      "productName": "Designer Watch",
      "currentPrice": 899.99,
      "targetPrice": 700.00,
      "image": "https://picsum.photos/100/100?random=47&keyword=watch",
      "isActive": false,
      "createdDate": "2024-12-05",
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedNotificationType == "all") {
      return notifications;
    }
    return notifications.where((notification) => 
        notification["type"] == selectedNotificationType).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Wishlist Alerts",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Notifications", icon: Icon(Icons.notifications)),
        Tab(text: "Price Alerts", icon: Icon(Icons.trending_down)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildNotificationsTab(),
        _buildPriceAlertsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter Notifications",
                    items: [
                      {"label": "All Notifications", "value": "all"},
                      {"label": "Price Drops", "value": "price_drop"},
                      {"label": "Back in Stock", "value": "back_in_stock"},
                      {"label": "Price Increases", "value": "price_increase"},
                      {"label": "Sale Ending", "value": "sale_ending"},
                      {"label": "New Reviews", "value": "new_review"},
                    ],
                    value: selectedNotificationType,
                    onChanged: (value, label) {
                      selectedNotificationType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.mark_email_read,
                  size: bs.sm,
                  onPressed: () {
                    for (var notification in notifications) {
                      notification["isRead"] = true;
                    }
                    setState(() {});
                    ss("All notifications marked as read");
                  },
                ),
              ],
            ),
          ),

          // Stats Card
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, infoColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Active Alerts",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${priceAlerts.where((alert) => alert["isActive"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withAlpha(50),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Unread",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${notifications.where((n) => !(n["isRead"] as bool)).length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withAlpha(50),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${notifications.where((n) => DateTime.parse("${n["timestamp"]}").day == DateTime.now().day).length}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Notifications List
          if (filteredNotifications.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No notifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...filteredNotifications.map((notification) {
              return _buildNotificationItem(notification);
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    Color typeColor = _getNotificationTypeColor(notification["type"] as String);
    IconData typeIcon = _getNotificationTypeIcon(notification["type"] as String);
    bool isRead = notification["isRead"] as bool;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: typeColor,
          ),
        ),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${notification["image"]}",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(width: spSm),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: typeColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        typeIcon,
                        size: 16,
                        color: typeColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${notification["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isRead ? disabledBoldColor : primaryColor,
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${notification["message"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                // Type-specific content
                if (notification["type"] == "price_drop")
                  Row(
                    children: [
                      Text(
                        "\$${(notification["oldPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "\$${(notification["newPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${(((notification["oldPrice"] as double) - (notification["newPrice"] as double)) / (notification["oldPrice"] as double) * 100).toStringAsFixed(0)}% off)",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                
                if (notification["type"] == "new_review")
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 12,
                          color: index < (notification["reviewRating"] as double).floor() 
                              ? warningColor 
                              : disabledColor,
                        );
                      }),
                      SizedBox(width: spXs),
                      Text(
                        "${notification["reviewRating"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${DateTime.parse("${notification["timestamp"]}").dMMMy}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Column(
            children: [
              QButton(
                icon: Icons.shopping_cart,
                size: bs.sm,
                onPressed: () {
                  ss("Added ${notification["productName"]} to cart");
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: isRead ? Icons.mark_email_unread : Icons.mark_email_read,
                size: bs.sm,
                onPressed: () {
                  notification["isRead"] = !isRead;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAlertsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Add Alert Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Price Alert",
              icon: Icons.add_alert,
              size: bs.md,
              onPressed: () {
                _showCreatePriceAlertDialog();
              },
            ),
          ),

          // Active Alerts Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${priceAlerts.where((alert) => alert["isActive"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active Alerts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${priceAlerts.where((alert) => !(alert["isActive"] as bool)).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Inactive",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${priceAlerts.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Price Alerts List
          ...priceAlerts.map((alert) {
            bool isActive = alert["isActive"] as bool;
            double currentPrice = alert["currentPrice"] as double;
            double targetPrice = alert["targetPrice"] as double;
            double percentageToTarget = ((currentPrice - targetPrice) / currentPrice * 100);

            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: isActive ? successColor : disabledColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${alert["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
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
                                "${alert["productName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isActive 
                                    ? successColor.withAlpha(20) 
                                    : disabledColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                isActive ? "ACTIVE" : "INACTIVE",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isActive ? successColor : disabledColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Text(
                              "Current: \$${currentPrice.currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Target: \$${targetPrice.currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spXs),
                        
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: percentageToTarget > 0 
                                    ? (100 - percentageToTarget) / 100 
                                    : 1.0,
                                backgroundColor: disabledOutlineBorderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  percentageToTarget <= 0 ? successColor : warningColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              percentageToTarget > 0 
                                  ? "${percentageToTarget.toStringAsFixed(0)}% to go"
                                  : "Target reached!",
                              style: TextStyle(
                                fontSize: 10,
                                color: percentageToTarget <= 0 ? successColor : warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Column(
                    children: [
                      QButton(
                        icon: isActive ? Icons.pause : Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () {
                          alert["isActive"] = !isActive;
                          setState(() {});
                          ss(isActive ? "Alert paused" : "Alert activated");
                        },
                      ),
                      SizedBox(height: spXs),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Delete this price alert?");
                          if (isConfirmed) {
                            priceAlerts.remove(alert);
                            setState(() {});
                            ss("Price alert deleted");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Notification Preferences
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                QSwitch(
                  items: [
                    {
                      "label": "Price drop notifications",
                      "value": "price_drop",
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Price drop notifications",
                      "value": "price_drop",
                      "checked": true,
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Back in stock alerts",
                      "value": "restock",
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Back in stock alerts",
                      "value": "restock",
                      "checked": true,
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "Sale ending reminders",
                      "value": "sale_ending",
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {},
                ),
                
                QSwitch(
                  items: [
                    {
                      "label": "New review notifications",
                      "value": "reviews",
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {},
                ),
              ],
            ),
          ),

          // Alert Frequency
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alert Frequency",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                QDropdownField(
                  label: "Price check frequency",
                  items: [
                    {"label": "Real-time", "value": "realtime"},
                    {"label": "Every hour", "value": "hourly"},
                    {"label": "Twice daily", "value": "twice_daily"},
                    {"label": "Daily", "value": "daily"},
                  ],
                  value: "hourly",
                  onChanged: (value, label) {},
                ),
              ],
            ),
          ),

          // Email Notifications
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                
                QSwitch(
                  items: [
                    {
                      "label": "Send email notifications",
                      "value": "email_enabled",
                      "checked": true,
                    }
                  ],
                  value: [
                    {
                      "label": "Send email notifications",
                      "value": "email_enabled",
                      "checked": true,
                    }
                  ],
                  onChanged: (values, ids) {},
                ),
                
                QTextField(
                  label: "Email Address",
                  value: "user@example.com",
                  onChanged: (value) {},
                ),
              ],
            ),
          ),

          // Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Clear All Notifications",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Clear all notifications?");
                      if (isConfirmed) {
                        notifications.clear();
                        setState(() {});
                        ss("All notifications cleared");
                      }
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Test Notification",
                    size: bs.md,
                    onPressed: () {
                      ss("Test notification sent!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getNotificationTypeColor(String type) {
    switch (type) {
      case "price_drop":
        return successColor;
      case "back_in_stock":
        return infoColor;
      case "price_increase":
        return warningColor;
      case "sale_ending":
        return dangerColor;
      case "new_review":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getNotificationTypeIcon(String type) {
    switch (type) {
      case "price_drop":
        return Icons.trending_down;
      case "back_in_stock":
        return Icons.inventory;
      case "price_increase":
        return Icons.trending_up;
      case "sale_ending":
        return Icons.timer;
      case "new_review":
        return Icons.star;
      default:
        return Icons.notifications;
    }
  }

  void _showCreatePriceAlertDialog() {
    String productName = "";
    String targetPriceStr = "";
    String currentPriceStr = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Price Alert"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Product Name",
                  value: productName,
                  hint: "Enter product name",
                  onChanged: (value) {
                    productName = value;
                  },
                ),
                QNumberField(
                  label: "Current Price (\$)",
                  value: currentPriceStr,
                  onChanged: (value) {
                    currentPriceStr = value;
                  },
                ),
                QNumberField(
                  label: "Target Price (\$)",
                  value: targetPriceStr,
                  onChanged: (value) {
                    targetPriceStr = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create Alert",
              size: bs.sm,
              onPressed: () {
                if (productName.isNotEmpty && targetPriceStr.isNotEmpty && currentPriceStr.isNotEmpty) {
                  Navigator.pop(context);
                  ss("Price alert created for $productName");
                } else {
                  se("Please fill in all fields");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
