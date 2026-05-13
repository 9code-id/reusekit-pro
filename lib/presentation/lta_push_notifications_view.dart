import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPushNotificationsView extends StatefulWidget {
  const LtaPushNotificationsView({super.key});

  @override
  State<LtaPushNotificationsView> createState() => _LtaPushNotificationsViewState();
}

class _LtaPushNotificationsViewState extends State<LtaPushNotificationsView> {
  String searchQuery = "";
  String selectedType = "All";
  String selectedStatus = "All";
  
  // Notification Settings
  bool enableOrderUpdates = true;
  bool enableDeliveryAlerts = true;
  bool enableDriverNotifications = true;
  bool enableSystemAlerts = true;
  bool enablePromotions = false;
  bool enableMaintenanceReminders = true;
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All", "value": "All"},
    {"label": "Order Update", "value": "Order Update"},
    {"label": "Delivery Alert", "value": "Delivery Alert"},
    {"label": "Driver Notification", "value": "Driver Notification"},
    {"label": "System Alert", "value": "System Alert"},
    {"label": "Promotion", "value": "Promotion"},
    {"label": "Maintenance Reminder", "value": "Maintenance Reminder"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Sent", "value": "Sent"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Read", "value": "Read"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Pending", "value": "Pending"}
  ];

  List<Map<String, dynamic>> notifications = [
    {
      "notificationId": "NOT001",
      "type": "Order Update",
      "title": "Order ORD001 - In Transit",
      "message": "Your order is now in transit. Driver Budi Santoso (B 1234 XYZ) is on the way to deliver your package.",
      "recipient": "Ahmad Wijaya",
      "recipientType": "Customer",
      "deviceToken": "abc123def456",
      "sentTime": "2024-12-15 14:30",
      "deliveredTime": "2024-12-15 14:30",
      "readTime": "2024-12-15 14:35",
      "status": "Read",
      "orderId": "ORD001",
      "driverId": "DRV001",
      "priority": "Normal",
      "clickAction": "order_tracking",
      "imageUrl": "https://picsum.photos/300/200?random=1&keyword=delivery"
    },
    {
      "notificationId": "NOT002",
      "type": "Delivery Alert",
      "title": "Package Delivered Successfully",
      "message": "Your package has been delivered to the specified address. Thank you for using our service!",
      "recipient": "Siti Nurhaliza",
      "recipientType": "Customer",
      "deviceToken": "def456ghi789",
      "sentTime": "2024-12-15 16:45",
      "deliveredTime": "2024-12-15 16:45",
      "readTime": null,
      "status": "Delivered",
      "orderId": "ORD002",
      "driverId": "DRV002",
      "priority": "High",
      "clickAction": "delivery_confirmation",
      "imageUrl": null
    },
    {
      "notificationId": "NOT003",
      "type": "Driver Notification",
      "title": "New Delivery Assignment",
      "message": "You have been assigned a new delivery: ORD003. Please check your driver app for details.",
      "recipient": "Eko Prasetyo",
      "recipientType": "Driver",
      "deviceToken": "ghi789jkl012",
      "sentTime": "2024-12-15 09:15",
      "deliveredTime": "2024-12-15 09:15",
      "readTime": "2024-12-15 09:20",
      "status": "Read",
      "orderId": "ORD003",
      "driverId": "DRV003",
      "priority": "High",
      "clickAction": "driver_assignment",
      "imageUrl": null
    },
    {
      "notificationId": "NOT004",
      "type": "System Alert",
      "title": "System Maintenance Notice",
      "message": "Our system will undergo maintenance on Dec 16, 2024 from 2:00 AM to 4:00 AM. Service may be temporarily unavailable.",
      "recipient": "All Users",
      "recipientType": "Broadcast",
      "deviceToken": "broadcast",
      "sentTime": "2024-12-15 18:00",
      "deliveredTime": "2024-12-15 18:00",
      "readTime": null,
      "status": "Sent",
      "orderId": null,
      "driverId": null,
      "priority": "Normal",
      "clickAction": "system_notice",
      "imageUrl": null
    },
    {
      "notificationId": "NOT005",
      "type": "Promotion",
      "title": "Special Discount - 20% Off",
      "message": "Get 20% off your next delivery! Use code SAVE20. Valid until December 31, 2024.",
      "recipient": "Muhammad Rizki",
      "recipientType": "Customer",
      "deviceToken": "jkl012mno345",
      "sentTime": "2024-12-15 12:00",
      "deliveredTime": "2024-12-15 12:00",
      "readTime": "2024-12-15 13:15",
      "status": "Read",
      "orderId": null,
      "driverId": null,
      "priority": "Low",
      "clickAction": "promotion_details",
      "imageUrl": "https://picsum.photos/300/200?random=2&keyword=discount"
    },
    {
      "notificationId": "NOT006",
      "type": "Maintenance Reminder",
      "title": "Vehicle Maintenance Due",
      "message": "Vehicle B 5678 ABC is due for scheduled maintenance. Please contact maintenance team to schedule service.",
      "recipient": "Agus Wijaya",
      "recipientType": "Driver",
      "deviceToken": "mno345pqr678",
      "sentTime": "2024-12-15 08:00",
      "deliveredTime": null,
      "readTime": null,
      "status": "Failed",
      "orderId": null,
      "driverId": "DRV004",
      "priority": "High",
      "clickAction": "maintenance_schedule",
      "imageUrl": null
    },
    {
      "notificationId": "NOT007",
      "type": "Order Update",
      "title": "Order ORD004 - Pickup Completed",
      "message": "Your package has been picked up and is being prepared for delivery. Estimated delivery: Tomorrow 2:00 PM.",
      "recipient": "Diana Putri",
      "recipientType": "Customer",
      "deviceToken": "pqr678stu901",
      "sentTime": "2024-12-15 11:30",
      "deliveredTime": "2024-12-15 11:30",
      "readTime": null,
      "status": "Delivered",
      "orderId": "ORD004",
      "driverId": "DRV005",
      "priority": "Normal",
      "clickAction": "order_tracking",
      "imageUrl": null
    },
    {
      "notificationId": "NOT008",
      "type": "Driver Notification",
      "title": "Route Optimization Update",
      "message": "Your delivery route has been optimized. New route will save 15 minutes. Check updated route in driver app.",
      "recipient": "Indra Kusuma",
      "recipientType": "Driver",
      "deviceToken": "stu901vwx234",
      "sentTime": "2024-12-15 13:45",
      "deliveredTime": "2024-12-15 13:45",
      "readTime": "2024-12-15 14:00",
      "status": "Read",
      "orderId": null,
      "driverId": "DRV006",
      "priority": "Normal",
      "clickAction": "route_update",
      "imageUrl": null
    }
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    return notifications.where((notification) {
      bool matchesSearch = searchQuery.isEmpty || 
          (notification["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (notification["recipient"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (notification["notificationId"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "All" || notification["type"] == selectedType;
      bool matchesStatus = selectedStatus == "All" || notification["status"] == selectedStatus;
      
      return matchesSearch && matchesType && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Read":
        return successColor;
      case "Delivered":
        return infoColor;
      case "Sent":
        return primaryColor;
      case "Failed":
        return dangerColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Normal":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Order Update":
        return Icons.assignment;
      case "Delivery Alert":
        return Icons.local_shipping;
      case "Driver Notification":
        return Icons.person;
      case "System Alert":
        return Icons.warning;
      case "Promotion":
        return Icons.local_offer;
      case "Maintenance Reminder":
        return Icons.build;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create notification
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showNotificationSettings();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search notifications...",
                    value: searchQuery,
                    hint: "Search by title, recipient, or ID",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: typeOptions,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Notification Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.notifications, color: primaryColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${notifications.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Sent",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.mark_email_read, color: successColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${notifications.where((n) => n["status"] == "Read").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Read",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.error, color: dangerColor, size: 24),
                        SizedBox(height: spXs),
                        Text(
                          "${notifications.where((n) => n["status"] == "Failed").length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Failed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Notifications List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "Push Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredNotifications.length} notifications",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredNotifications.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final notification = filteredNotifications[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(notification["status"] as String).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    _getTypeIcon(notification["type"] as String),
                                    color: _getStatusColor(notification["status"] as String),
                                    size: 20,
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
                                              "${notification["title"]}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(notification["priority"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${notification["priority"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getPriorityColor(notification["priority"] as String),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spXs),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(notification["status"] as String).withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${notification["status"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: _getStatusColor(notification["status"] as String),
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
                                            "${notification["type"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            " • ${notification["recipientType"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      if (notification["imageUrl"] != null) ...[
                                        Container(
                                          width: 50,
                                          height: 40,
                                          margin: EdgeInsets.only(right: spSm),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusSm),
                                            image: DecorationImage(
                                              image: NetworkImage(notification["imageUrl"] as String),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                      Expanded(
                                        child: Text(
                                          "${notification["message"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(Icons.person, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "To: ${notification["recipient"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 12, color: disabledBoldColor),
                                      SizedBox(width: 2),
                                      Text(
                                        "Sent: ${notification["sentTime"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (notification["readTime"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.mark_email_read, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "Read: ${notification["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (notification["orderId"] != null) ...[
                                    Row(
                                      children: [
                                        Icon(Icons.assignment, size: 12, color: disabledBoldColor),
                                        SizedBox(width: 2),
                                        Text(
                                          "Order: ${notification["orderId"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Text(
                                  "${notification["notificationId"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (notification["status"] == "Failed") ...[
                                  QButton(
                                    label: "Resend",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Notification resent successfully");
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                ],
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to notification details
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
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
                    ),
                  ),
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Order Updates",
                        "value": "order_updates",
                        "checked": enableOrderUpdates,
                      }
                    ],
                    value: enableOrderUpdates ? [{"label": "Order Updates", "value": "order_updates", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableOrderUpdates = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Delivery Alerts",
                        "value": "delivery_alerts",
                        "checked": enableDeliveryAlerts,
                      }
                    ],
                    value: enableDeliveryAlerts ? [{"label": "Delivery Alerts", "value": "delivery_alerts", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableDeliveryAlerts = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Driver Notifications",
                        "value": "driver_notifications",
                        "checked": enableDriverNotifications,
                      }
                    ],
                    value: enableDriverNotifications ? [{"label": "Driver Notifications", "value": "driver_notifications", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableDriverNotifications = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "System Alerts",
                        "value": "system_alerts",
                        "checked": enableSystemAlerts,
                      }
                    ],
                    value: enableSystemAlerts ? [{"label": "System Alerts", "value": "system_alerts", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableSystemAlerts = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Promotions",
                        "value": "promotions",
                        "checked": enablePromotions,
                      }
                    ],
                    value: enablePromotions ? [{"label": "Promotions", "value": "promotions", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enablePromotions = values.isNotEmpty;
                      setModalState(() {});
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Maintenance Reminders",
                        "value": "maintenance_reminders",
                        "checked": enableMaintenanceReminders,
                      }
                    ],
                    value: enableMaintenanceReminders ? [{"label": "Maintenance Reminders", "value": "maintenance_reminders", "checked": true}] : [],
                    onChanged: (values, ids) {
                      enableMaintenanceReminders = values.isNotEmpty;
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
                        back();
                        ss("Notification settings saved successfully");
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
