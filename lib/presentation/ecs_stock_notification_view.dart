import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsStockNotificationView extends StatefulWidget {
  const EcsStockNotificationView({super.key});

  @override
  State<EcsStockNotificationView> createState() => _EcsStockNotificationViewState();
}

class _EcsStockNotificationViewState extends State<EcsStockNotificationView> {
  String selectedCategory = "All";
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool smsNotifications = false;

  List<Map<String, dynamic>> stockNotifications = [
    {
      "id": 1,
      "productName": "iPhone 15 Pro Max",
      "productImage": "https://picsum.photos/200/200?random=1&keyword=iphone",
      "category": "Electronics",
      "requestedDate": "2025-06-10",
      "expectedDate": "2025-06-20",
      "notificationType": ["email", "push"],
      "status": "waiting",
      "originalPrice": 1199.0,
      "currentPrice": 1199.0,
      "stockLevel": "out_of_stock",
      "priority": "high",
    },
    {
      "id": 2,
      "productName": "Nike Air Max 270",
      "productImage": "https://picsum.photos/200/200?random=2&keyword=nike",
      "category": "Fashion",
      "requestedDate": "2025-06-08",
      "expectedDate": "2025-06-15",
      "notificationType": ["email"],
      "status": "notified",
      "originalPrice": 150.0,
      "currentPrice": 129.99,
      "stockLevel": "in_stock",
      "priority": "medium",
      "notifiedDate": "2025-06-14",
    },
    {
      "id": 3,
      "productName": "Samsung 55\" QLED TV",
      "productImage": "https://picsum.photos/200/200?random=3&keyword=samsung-tv",
      "category": "Electronics",
      "requestedDate": "2025-06-12",
      "expectedDate": "2025-06-25",
      "notificationType": ["email", "push", "sms"],
      "status": "waiting",
      "originalPrice": 899.0,
      "currentPrice": 799.0,
      "stockLevel": "low_stock",
      "priority": "high",
    },
    {
      "id": 4,
      "productName": "Dyson V15 Vacuum",
      "productImage": "https://picsum.photos/200/200?random=4&keyword=dyson",
      "category": "Home",
      "requestedDate": "2025-06-05",
      "expectedDate": "2025-06-18",
      "notificationType": ["email", "push"],
      "status": "expired",
      "originalPrice": 749.0,
      "currentPrice": 749.0,
      "stockLevel": "out_of_stock",
      "priority": "low",
    },
    {
      "id": 5,
      "productName": "MacBook Pro 14-inch",
      "productImage": "https://picsum.photos/200/200?random=5&keyword=macbook",
      "category": "Electronics",
      "requestedDate": "2025-06-11",
      "expectedDate": "2025-06-22",
      "notificationType": ["email", "push"],
      "status": "waiting",
      "originalPrice": 1999.0,
      "currentPrice": 1899.0,
      "stockLevel": "out_of_stock",
      "priority": "high",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home", "value": "Home"},
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    return stockNotifications.where((notification) {
      return selectedCategory == "All" || notification["category"] == selectedCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "waiting":
        return warningColor;
      case "notified":
        return successColor;
      case "expired":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "waiting":
        return "Waiting";
      case "notified":
        return "In Stock";
      case "expired":
        return "Expired";
      default:
        return "Unknown";
    }
  }

  Color _getStockLevelColor(String stockLevel) {
    switch (stockLevel) {
      case "in_stock":
        return successColor;
      case "low_stock":
        return warningColor;
      case "out_of_stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStockLevelText(String stockLevel) {
    switch (stockLevel) {
      case "in_stock":
        return "In Stock";
      case "low_stock":
        return "Low Stock";
      case "out_of_stock":
        return "Out of Stock";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showNotificationSettings();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Active",
                    "${stockNotifications.where((n) => n["status"] == "waiting").length}",
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Notified",
                    "${stockNotifications.where((n) => n["status"] == "notified").length}",
                    successColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Expired",
                    "${stockNotifications.where((n) => n["status"] == "expired").length}",
                    disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Filter
          Container(
            padding: EdgeInsets.all(spMd),
            child: QDropdownField(
              label: "Filter by Category",
              items: categories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notification = filteredNotifications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${notification["productImage"]}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${notification["productName"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (notification["priority"] == "high")
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(50),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "HIGH",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  
                                  // Status and Stock Level
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(notification["status"]).withAlpha(50),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStatusText(notification["status"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(notification["status"]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: _getStockLevelColor(notification["stockLevel"]).withAlpha(50),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          _getStockLevelText(notification["stockLevel"]),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getStockLevelColor(notification["stockLevel"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  
                                  // Price Info
                                  Row(
                                    children: [
                                      Text(
                                        "\$${(notification["currentPrice"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if ((notification["currentPrice"] as double) < (notification["originalPrice"] as double)) ...[
                                        SizedBox(width: spSm),
                                        Text(
                                          "\$${(notification["originalPrice"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            decoration: TextDecoration.lineThrough,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(50),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "SALE",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
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

                      // Notification Details
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(25),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Requested: ${DateTime.parse("${notification["requestedDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (notification["status"] == "waiting") ...[
                                  Icon(Icons.schedule, size: 16, color: warningColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Expected: ${DateTime.parse("${notification["expectedDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ] else if (notification["status"] == "notified") ...[
                                  Icon(Icons.check_circle, size: 16, color: successColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Notified: ${DateTime.parse("${notification["notifiedDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            
                            // Notification Methods
                            Row(
                              children: [
                                Icon(Icons.notifications, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Notifications: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                ...((notification["notificationType"] as List).map((type) {
                                  IconData icon;
                                  switch (type) {
                                    case "email":
                                      icon = Icons.email;
                                      break;
                                    case "push":
                                      icon = Icons.notifications;
                                      break;
                                    case "sms":
                                      icon = Icons.sms;
                                      break;
                                    default:
                                      icon = Icons.notification_add;
                                  }
                                  
                                  return Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    child: Icon(icon, size: 14, color: primaryColor),
                                  );
                                }).toList()),
                                Spacer(),
                                
                                // Action Buttons
                                if (notification["status"] == "waiting")
                                  GestureDetector(
                                    onTap: () {
                                      _cancelNotification(notification);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                else if (notification["status"] == "notified")
                                  GestureDetector(
                                    onTap: () {
                                      ss("Redirecting to product page...");
                                    },
                                    child: Text(
                                      "View Product",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                else if (notification["status"] == "expired")
                                  GestureDetector(
                                    onTap: () {
                                      _reactivateNotification(notification);
                                    },
                                    child: Text(
                                      "Reactivate",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNotificationDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _cancelNotification(Map<String, dynamic> notification) {
    stockNotifications.removeWhere((n) => n["id"] == notification["id"]);
    setState(() {});
    si("Stock notification cancelled for ${notification["productName"]}");
  }

  void _reactivateNotification(Map<String, dynamic> notification) {
    int index = stockNotifications.indexWhere((n) => n["id"] == notification["id"]);
    if (index != -1) {
      stockNotifications[index]["status"] = "waiting";
      stockNotifications[index]["expectedDate"] = DateTime.now().add(Duration(days: 7)).toIso8601String().split('T')[0];
      setState(() {});
      ss("Stock notification reactivated for ${notification["productName"]}");
    }
  }

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              QSwitch(
                items: [
                  {
                    "label": "Email Notifications",
                    "value": true,
                    "checked": emailNotifications,
                  }
                ],
                value: [if (emailNotifications) {"label": "Email Notifications", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  emailNotifications = values.isNotEmpty;
                  setModalState(() {});
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "Push Notifications",
                    "value": true,
                    "checked": pushNotifications,
                  }
                ],
                value: [if (pushNotifications) {"label": "Push Notifications", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  pushNotifications = values.isNotEmpty;
                  setModalState(() {});
                  setState(() {});
                },
              ),
              
              SizedBox(height: spSm),
              
              QSwitch(
                items: [
                  {
                    "label": "SMS Notifications",
                    "value": true,
                    "checked": smsNotifications,
                  }
                ],
                value: [if (smsNotifications) {"label": "SMS Notifications", "value": true, "checked": true}],
                onChanged: (values, ids) {
                  smsNotifications = values.isNotEmpty;
                  setModalState(() {});
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Settings",
                  size: bs.md,
                  onPressed: () {
                    Navigator.pop(context);
                    ss("Notification settings saved");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddNotificationDialog() {
    String productName = "";
    String selectedNotificationType = "email";
    
    List<Map<String, dynamic>> notificationTypes = [
      {"label": "Email", "value": "email"},
      {"label": "Push", "value": "push"},
      {"label": "SMS", "value": "sms"},
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Stock Notification"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Product Name",
              value: productName,
              onChanged: (value) {
                productName = value;
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Notification Type",
              items: notificationTypes,
              value: selectedNotificationType,
              onChanged: (value, label) {
                selectedNotificationType = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (productName.isNotEmpty) {
                Navigator.pop(context);
                ss("Stock notification added for $productName");
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
