import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPushNotificationsView extends StatefulWidget {
  const EcmPushNotificationsView({super.key});

  @override
  State<EcmPushNotificationsView> createState() => _EcmPushNotificationsViewState();
}

class _EcmPushNotificationsViewState extends State<EcmPushNotificationsView> {
  bool pushNotificationsEnabled = true;
  bool orderUpdates = true;
  bool promotionalOffers = false;
  bool newProductAlerts = true;
  bool paymentReminders = true;
  bool deliveryUpdates = true;
  bool stockAlerts = false;
  bool reviewRequests = true;
  String notificationSound = "Default";
  String quietHoursStart = "22:00";
  String quietHoursEnd = "08:00";
  bool quietHoursEnabled = true;
  bool vibrationEnabled = true;
  String selectedTimezone = "UTC";

  List<Map<String, dynamic>> notificationHistory = [
    {
      "title": "Order Confirmed",
      "message": "Your order #12345 has been confirmed and is being processed",
      "time": "2 hours ago",
      "type": "order",
      "read": true,
      "icon": Icons.check_circle,
      "color": "#4CAF50",
    },
    {
      "title": "Flash Sale Alert",
      "message": "50% off on electronics! Limited time offer",
      "time": "4 hours ago",
      "type": "promotion",
      "read": false,
      "icon": Icons.local_offer,
      "color": "#FF9800",
    },
    {
      "title": "Payment Reminder",
      "message": "Your payment for order #12344 is due tomorrow",
      "time": "1 day ago",
      "type": "payment",
      "read": true,
      "icon": Icons.payment,
      "color": "#F44336",
    },
    {
      "title": "New Product Launch",
      "message": "iPhone 15 Pro Max is now available in our store",
      "time": "2 days ago",
      "type": "product",
      "read": true,
      "icon": Icons.new_releases,
      "color": "#2196F3",
    },
    {
      "title": "Delivery Update",
      "message": "Your order is out for delivery and will arrive today",
      "time": "3 days ago",
      "type": "delivery",
      "read": true,
      "icon": Icons.local_shipping,
      "color": "#9C27B0",
    },
  ];

  List<Map<String, dynamic>> notificationSounds = [
    {"label": "Default", "value": "Default"},
    {"label": "Chime", "value": "Chime"},
    {"label": "Bell", "value": "Bell"},
    {"label": "Notification", "value": "Notification"},
    {"label": "Alert", "value": "Alert"},
    {"label": "Silent", "value": "Silent"},
  ];

  List<Map<String, dynamic>> timezones = [
    {"label": "UTC (Coordinated Universal Time)", "value": "UTC"},
    {"label": "EST (Eastern Standard Time)", "value": "EST"},
    {"label": "PST (Pacific Standard Time)", "value": "PST"},
    {"label": "GMT (Greenwich Mean Time)", "value": "GMT"},
    {"label": "CET (Central European Time)", "value": "CET"},
    {"label": "JST (Japan Standard Time)", "value": "JST"},
  ];

  Widget _buildNotificationSetting({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: pushNotificationsEnabled ? onChanged : null,
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Notifications",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                si("Mark all notifications as read");
              },
              child: Text(
                "Mark all read",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...notificationHistory.map((notification) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: notification["read"] ? Colors.white : primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: notification["read"] ? disabledOutlineBorderColor : primaryColor.withAlpha(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(int.parse("0xFF${notification["color"].substring(1)}")).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    notification["icon"],
                    color: Color(int.parse("0xFF${notification["color"].substring(1)}")),
                    size: 18,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notification["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${notification["message"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${notification["time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!notification["read"]) ...[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Advanced notification settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Master Toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: pushNotificationsEnabled ? primaryColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: pushNotificationsEnabled ? primaryColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    pushNotificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
                    color: pushNotificationsEnabled ? primaryColor : warningColor,
                    size: 30,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Push Notifications",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: pushNotificationsEnabled ? primaryColor : warningColor,
                          ),
                        ),
                        Text(
                          pushNotificationsEnabled 
                              ? "Stay updated with real-time notifications"
                              : "Notifications are currently disabled",
                          style: TextStyle(
                            fontSize: 12,
                            color: pushNotificationsEnabled ? primaryColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: pushNotificationsEnabled,
                    onChanged: (value) {
                      pushNotificationsEnabled = value;
                      setState(() {});
                      if (value) {
                        ss("Push notifications enabled");
                      } else {
                        sw("Push notifications disabled");
                      }
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Notification Categories
            Text(
              "Notification Categories",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            _buildNotificationSetting(
              title: "Order Updates",
              subtitle: "Get notified about order status changes",
              value: orderUpdates,
              onChanged: (value) {
                orderUpdates = value;
                setState(() {});
              },
              icon: Icons.shopping_bag,
              color: successColor,
            ),
            _buildNotificationSetting(
              title: "Delivery Updates",
              subtitle: "Track your delivery status in real-time",
              value: deliveryUpdates,
              onChanged: (value) {
                deliveryUpdates = value;
                setState(() {});
              },
              icon: Icons.local_shipping,
              color: infoColor,
            ),
            _buildNotificationSetting(
              title: "Payment Reminders",
              subtitle: "Reminders for pending payments",
              value: paymentReminders,
              onChanged: (value) {
                paymentReminders = value;
                setState(() {});
              },
              icon: Icons.payment,
              color: warningColor,
            ),
            _buildNotificationSetting(
              title: "New Product Alerts",
              subtitle: "Be first to know about new arrivals",
              value: newProductAlerts,
              onChanged: (value) {
                newProductAlerts = value;
                setState(() {});
              },
              icon: Icons.new_releases,
              color: primaryColor,
            ),
            _buildNotificationSetting(
              title: "Promotional Offers",
              subtitle: "Special discounts and sale alerts",
              value: promotionalOffers,
              onChanged: (value) {
                promotionalOffers = value;
                setState(() {});
              },
              icon: Icons.local_offer,
              color: dangerColor,
            ),
            _buildNotificationSetting(
              title: "Stock Alerts",
              subtitle: "Get notified when items are back in stock",
              value: stockAlerts,
              onChanged: (value) {
                stockAlerts = value;
                setState(() {});
              },
              icon: Icons.inventory,
              color: secondaryColor,
            ),
            _buildNotificationSetting(
              title: "Review Requests",
              subtitle: "Reminders to review your purchases",
              value: reviewRequests,
              onChanged: (value) {
                reviewRequests = value;
                setState(() {});
              },
              icon: Icons.star_rate,
              color: Color(0xFFFF9800),
            ),
            SizedBox(height: spLg),

            // Notification Settings
            Text(
              "Notification Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QDropdownField(
                    label: "Notification Sound",
                    items: notificationSounds,
                    value: notificationSound,
                    onChanged: (value, label) {
                      if (pushNotificationsEnabled) {
                        notificationSound = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Timezone",
                    items: timezones,
                    value: selectedTimezone,
                    onChanged: (value, label) {
                      selectedTimezone = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QTimePicker(
                          label: "Quiet Hours Start",
                          value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${quietHoursStart}:00")),
                          onChanged: (value) {
                            if (value != null) {
                              quietHoursStart = value.kkmm;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTimePicker(
                          label: "Quiet Hours End",
                          value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${quietHoursEnd}:00")),
                          onChanged: (value) {
                            if (value != null) {
                              quietHoursEnd = value.kkmm;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiet Hours",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Disable notifications during specified hours",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: quietHoursEnabled,
                        onChanged: pushNotificationsEnabled ? (value) {
                          quietHoursEnabled = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vibration",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Enable vibration for notifications",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: vibrationEnabled,
                        onChanged: pushNotificationsEnabled ? (value) {
                          vibrationEnabled = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Notification History
            _buildNotificationHistory(),
            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Test Notification",
                    size: bs.md,
                    onPressed: pushNotificationsEnabled ? () {
                      si("Test notification sent! Check your notification panel.");
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Clear History",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to clear all notification history?");
                      if (isConfirmed) {
                        notificationHistory.clear();
                        setState(() {});
                        ss("Notification history cleared");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
