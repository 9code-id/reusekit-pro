import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaNotificationsView extends StatefulWidget {
  const BfaNotificationsView({super.key});

  @override
  State<BfaNotificationsView> createState() => _BfaNotificationsViewState();
}

class _BfaNotificationsViewState extends State<BfaNotificationsView> {
  String selectedFilter = "All";
  bool showReadNotifications = true;
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Account Alerts", "value": "Account Alerts"},
    {"label": "Transactions", "value": "Transactions"},
    {"label": "Security", "value": "Security"},
    {"label": "Promotions", "value": "Promotions"},
    {"label": "System Updates", "value": "System Updates"},
  ];

  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Large Transaction Alert",
      "message": "A transaction of \$1,250.00 was made at Amazon.com using your credit card ending in 4567",
      "category": "Account Alerts",
      "type": "alert",
      "timestamp": "2025-06-15T10:30:00",
      "read": false,
      "icon": Icons.credit_card,
      "color": warningColor,
      "actionRequired": true,
      "priority": "High",
      "amount": 1250.0,
      "merchant": "Amazon.com",
    },
    {
      "id": 2,
      "title": "Password Changed Successfully",
      "message": "Your account password was successfully changed from your mobile device at 9:45 AM",
      "category": "Security",
      "type": "security",
      "timestamp": "2025-06-15T09:45:00",
      "read": false,
      "icon": Icons.security,
      "color": successColor,
      "actionRequired": false,
      "priority": "Medium",
      "amount": 0.0,
      "merchant": "",
    },
    {
      "id": 3,
      "title": "Monthly Statement Ready",
      "message": "Your credit card statement for May 2025 is now available. Total balance: \$2,847.56",
      "category": "Account Alerts",
      "type": "statement",
      "timestamp": "2025-06-14T08:00:00",
      "read": true,
      "icon": Icons.description,
      "color": primaryColor,
      "actionRequired": false,
      "priority": "Low",
      "amount": 2847.56,
      "merchant": "",
    },
    {
      "id": 4,
      "title": "New Device Login",
      "message": "A new device (iPhone 15) logged into your account from New York, NY. If this wasn't you, secure your account immediately",
      "category": "Security",
      "type": "login",
      "timestamp": "2025-06-14T15:22:00",
      "read": false,
      "icon": Icons.phone_iphone,
      "color": dangerColor,
      "actionRequired": true,
      "priority": "High",
      "amount": 0.0,
      "merchant": "",
    },
    {
      "id": 5,
      "title": "Cashback Reward Earned",
      "message": "You've earned \$15.75 in cashback rewards this week! Total available rewards: \$247.30",
      "category": "Account Alerts",
      "type": "reward",
      "timestamp": "2025-06-13T18:00:00",
      "read": true,
      "icon": Icons.card_giftcard,
      "color": successColor,
      "actionRequired": false,
      "priority": "Low",
      "amount": 15.75,
      "merchant": "",
    },
    {
      "id": 6,
      "title": "Budget Limit Reached",
      "message": "You've reached 90% of your dining budget for this month. Current spending: \$1,350 of \$1,500",
      "category": "Account Alerts",
      "type": "budget",
      "timestamp": "2025-06-13T12:30:00",
      "read": false,
      "icon": Icons.trending_up,
      "color": warningColor,
      "actionRequired": false,
      "priority": "Medium",
      "amount": 1350.0,
      "merchant": "",
    },
    {
      "id": 7,
      "title": "Payment Due Reminder",
      "message": "Your credit card payment of \$458.90 is due in 3 days (June 18, 2025). Set up autopay to avoid late fees",
      "category": "Account Alerts",
      "type": "payment",
      "timestamp": "2025-06-12T09:00:00",
      "read": true,
      "icon": Icons.schedule,
      "color": primaryColor,
      "actionRequired": true,
      "priority": "High",
      "amount": 458.90,
      "merchant": "",
    },
    {
      "id": 8,
      "title": "App Update Available",
      "message": "Version 2.4.1 is now available with improved security features and bug fixes",
      "category": "System Updates",
      "type": "update",
      "timestamp": "2025-06-11T16:00:00",
      "read": true,
      "icon": Icons.system_update,
      "color": infoColor,
      "actionRequired": false,
      "priority": "Low",
      "amount": 0.0,
      "merchant": "",
    },
    {
      "id": 9,
      "title": "Limited Time Offer",
      "message": "Earn 5% cashback on all purchases this weekend! No limits, no restrictions. Offer expires June 16th",
      "category": "Promotions",
      "type": "promotion",
      "timestamp": "2025-06-10T10:00:00",
      "read": false,
      "icon": Icons.local_offer,
      "color": successColor,
      "actionRequired": false,
      "priority": "Medium",
      "amount": 0.0,
      "merchant": "",
    },
    {
      "id": 10,
      "title": "Transaction Declined",
      "message": "A transaction for \$89.99 at Best Buy was declined due to insufficient funds. Account balance: \$45.23",
      "category": "Transactions",
      "type": "declined",
      "timestamp": "2025-06-09T14:15:00",
      "read": true,
      "icon": Icons.block,
      "color": dangerColor,
      "actionRequired": true,
      "priority": "High",
      "amount": 89.99,
      "merchant": "Best Buy",
    },
  ];

  List<Map<String, dynamic>> getFilteredNotifications() {
    List<Map<String, dynamic>> filtered = notifications;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((notif) => notif["category"] == selectedFilter).toList();
    }
    
    if (!showReadNotifications) {
      filtered = filtered.where((notif) => !(notif["read"] as bool)).toList();
    }
    
    // Sort by timestamp (newest first)
    filtered.sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));
    
    return filtered;
  }

  int getUnreadCount() {
    return notifications.where((notif) => !(notif["read"] as bool)).length;
  }

  int getActionRequiredCount() {
    return notifications.where((notif) => (notif["actionRequired"] as bool) && !(notif["read"] as bool)).length;
  }

  String getTimeAgo(String timestamp) {
    DateTime notifTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(notifTime);
    
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${(difference.inDays / 7).floor()}w ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications = getFilteredNotifications();
    int unreadCount = getUnreadCount();
    int actionCount = getActionRequiredCount();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          IconButton(
            onPressed: () {
              // Mark all as read
            },
            icon: Icon(Icons.done_all),
          ),
          IconButton(
            onPressed: () {
              // Notification settings
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Notification Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Unread",
                          "$unreadCount",
                          Icons.mark_email_unread,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Action Required",
                          "$actionCount",
                          Icons.priority_high,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                  _buildSummaryCard(
                    "Total Notifications",
                    "${notifications.length}",
                    Icons.notifications,
                    successColor,
                  ),
                ],
              ),
            ),

            // Filters
            QDropdownField(
              label: "Filter by Category",
              items: filterOptions,
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
              },
            ),

            QSwitch(
              items: [
                {
                  "label": "Show read notifications",
                  "value": true,
                  "checked": showReadNotifications,
                }
              ],
              value: [
                if (showReadNotifications)
                  {
                    "label": "Show read notifications",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                showReadNotifications = values.isNotEmpty;
                setState(() {});
              },
            ),

            // Quick Actions
            if (unreadCount > 0 || actionCount > 0) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        if (unreadCount > 0) ...[
                          Expanded(
                            child: QButton(
                              label: "Mark All Read",
                              icon: Icons.done_all,
                              size: bs.sm,
                              onPressed: () {
                                // Mark all as read
                              },
                            ),
                          ),
                        ],
                        if (unreadCount > 0 && actionCount > 0) ...[
                          SizedBox(width: spSm),
                        ],
                        if (actionCount > 0) ...[
                          Expanded(
                            child: QButton(
                              label: "Review Actions",
                              icon: Icons.priority_high,
                              size: bs.sm,
                              onPressed: () {
                                // Filter to action required
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Notifications List
            Text(
              "Notifications (${filteredNotifications.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (filteredNotifications.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Center(
                  child: Column(
                    spacing: spSm,
                    children: [
                      Icon(
                        Icons.notifications_off,
                        size: 48,
                        color: disabledBoldColor,
                      ),
                      Text(
                        "No notifications found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "You're all caught up! Check back later for updates.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Column(
                spacing: spSm,
                children: filteredNotifications.map((notification) {
                  bool isRead = notification["read"] as bool;
                  bool actionRequired = notification["actionRequired"] as bool;
                  String timeAgo = getTimeAgo(notification["timestamp"]);
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: !isRead ? Border(
                        left: BorderSide(
                          width: 4,
                          color: notification["color"] as Color,
                        ),
                      ) : null,
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (notification["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                notification["icon"] as IconData,
                                color: notification["color"] as Color,
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
                                            fontSize: 14,
                                            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (!isRead) ...[
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${notification["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        timeAgo,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      if (actionRequired) ...[
                                        Text(
                                          " • ",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 1,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Action Required",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w600,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(notification["priority"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${notification["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getPriorityColor(notification["priority"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "${notification["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isRead ? disabledBoldColor : primaryColor,
                          ),
                        ),

                        if ((notification["amount"] as double) > 0) ...[
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (notification["color"] as Color).withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 16,
                                  color: notification["color"] as Color,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Amount: \$${(notification["amount"] as double).currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: notification["color"] as Color,
                                  ),
                                ),
                                if ((notification["merchant"] as String).isNotEmpty) ...[
                                  Text(
                                    " at ${notification["merchant"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],

                        Row(
                          children: [
                            if (!isRead) ...[
                              Expanded(
                                child: QButton(
                                  label: "Mark as Read",
                                  icon: Icons.done,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Mark as read
                                  },
                                ),
                              ),
                            ],
                            if (actionRequired) ...[
                              if (!isRead) SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: _getActionButtonText(notification["type"]),
                                  icon: Icons.arrow_forward,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Handle specific action
                                  },
                                ),
                              ),
                            ],
                            if (!actionRequired && isRead) ...[
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  icon: Icons.visibility,
                                  size: bs.sm,
                                  onPressed: () {
                                    // View notification details
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],

            // Load More (if needed)
            if (filteredNotifications.length >= 10) ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Notifications",
                  icon: Icons.expand_more,
                  size: bs.sm,
                  onPressed: () {
                    // Load more notifications
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getActionButtonText(String type) {
    switch (type) {
      case "alert":
        return "Review Transaction";
      case "security":
        return "Secure Account";
      case "login":
        return "Verify Device";
      case "payment":
        return "Make Payment";
      case "declined":
        return "Add Funds";
      default:
        return "Take Action";
    }
  }
}
