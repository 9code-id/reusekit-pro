import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaNotificationsView extends StatefulWidget {
  const SpaNotificationsView({super.key});

  @override
  State<SpaNotificationsView> createState() => _SpaNotificationsViewState();
}

class _SpaNotificationsViewState extends State<SpaNotificationsView> {
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Appointment Confirmed",
      "message": "Your Deep Tissue Massage appointment on Jan 20, 2:00 PM has been confirmed.",
      "type": "booking",
      "timestamp": "2024-01-19T10:30:00Z",
      "read": false,
      "priority": "high",
      "actionText": "View Details",
      "icon": Icons.event_available,
    },
    {
      "id": 2,
      "title": "Special Offer Available",
      "message": "20% off all facial treatments this weekend. Book now to secure your spot!",
      "type": "promotion",
      "timestamp": "2024-01-19T09:15:00Z",
      "read": false,
      "priority": "medium",
      "actionText": "Book Now",
      "icon": Icons.local_offer,
    },
    {
      "id": 3,
      "title": "Appointment Reminder",
      "message": "Don't forget your Hot Stone Massage tomorrow at 3:30 PM. Arrive 15 minutes early.",
      "type": "reminder",
      "timestamp": "2024-01-18T16:45:00Z",
      "read": true,
      "priority": "high",
      "actionText": "View Appointment",
      "icon": Icons.access_time,
    },
    {
      "id": 4,
      "title": "New Treatment Available",
      "message": "Try our new Himalayan Salt Stone Therapy. Perfect for muscle relaxation and detox.",
      "type": "announcement",
      "timestamp": "2024-01-18T14:20:00Z",
      "read": true,
      "priority": "low",
      "actionText": "Learn More",
      "icon": Icons.new_releases,
    },
    {
      "id": 5,
      "title": "Loyalty Points Earned",
      "message": "You've earned 150 points from your recent visit. You're 50 points away from a free facial!",
      "type": "reward",
      "timestamp": "2024-01-17T11:30:00Z",
      "read": false,
      "priority": "medium",
      "actionText": "View Points",
      "icon": Icons.star,
    },
    {
      "id": 6,
      "title": "Membership Renewal Due",
      "message": "Your premium spa membership expires in 7 days. Renew now to continue enjoying exclusive benefits.",
      "type": "subscription",
      "timestamp": "2024-01-17T09:00:00Z",
      "read": true,
      "priority": "high",
      "actionText": "Renew Now",
      "icon": Icons.card_membership,
    },
    {
      "id": 7,
      "title": "Treatment Cancelled",
      "message": "Your Aromatherapy Massage on Jan 16 has been cancelled due to therapist unavailability.",
      "type": "booking",
      "timestamp": "2024-01-15T13:45:00Z",
      "read": true,
      "priority": "high",
      "actionText": "Reschedule",
      "icon": Icons.event_busy,
    },
    {
      "id": 8,
      "title": "Feedback Request",
      "message": "How was your recent Swedish Massage experience? Your feedback helps us improve our services.",
      "type": "feedback",
      "timestamp": "2024-01-14T10:15:00Z",
      "read": false,
      "priority": "low",
      "actionText": "Leave Review",
      "icon": Icons.feedback,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all", "count": 8},
    {"label": "Bookings", "value": "booking", "count": 2},
    {"label": "Promotions", "value": "promotion", "count": 1},
    {"label": "Reminders", "value": "reminder", "count": 1},
    {"label": "Rewards", "value": "reward", "count": 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          QButton(
            icon: Icons.mark_email_read,
            size: bs.sm,
            onPressed: () {
              _markAllAsRead();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildNotificationHeader(),
          _buildFilterTabs(),
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationHeader() {
    final unreadCount = notifications.where((n) => !n["read"]).length;
    final todayCount = notifications.where((n) => 
      DateTime.parse(n["timestamp"]).isAfter(DateTime.now().subtract(Duration(days: 1)))
    ).length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stay Updated",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Never miss important spa updates and offers",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          Row(
            children: [
              _buildHeaderStat("$unreadCount", "Unread", Icons.markunread),
              SizedBox(width: spSm),
              _buildHeaderStat("$todayCount", "Today", Icons.today),
              SizedBox(width: spSm),
              _buildHeaderStat("${notifications.length}", "Total", Icons.inbox),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filterOptions.map((option) {
            bool isSelected = selectedFilter == option["value"];
            
            return GestureDetector(
              onTap: () {
                selectedFilter = option["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${option["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                    if (isSelected) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${option["count"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    final filteredNotifications = _getFilteredNotifications();
    
    if (filteredNotifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No notifications found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Check back later for updates",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification["read"] as bool;
    final priority = notification["priority"] as String;
    final timestamp = DateTime.parse(notification["timestamp"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isRead ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(spSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getNotificationColor(notification["type"]),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification["icon"] as IconData,
                    color: Colors.white,
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
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.only(right: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              "${notification["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isRead ? disabledBoldColor : Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(priority).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
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
                      SizedBox(height: spXs),
                      Text(
                        "${notification["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
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
                            "${timestamp.dMMMy} • ${timestamp.dMMMykkss.split(' ')[1]}",
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
                              fontWeight: FontWeight.w600,
                              color: _getNotificationColor(notification["type"]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "${notification["actionText"]}",
                    size: bs.sm,
                    onPressed: () {
                      _handleNotificationAction(notification);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: isRead ? Icons.mark_as_unread : Icons.mark_email_read,
                  size: bs.sm,
                  onPressed: () {
                    _toggleReadStatus(notification["id"]);
                  },
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () {
                    _deleteNotification(notification["id"]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    if (selectedFilter == "all") {
      return notifications;
    }
    return notifications.where((n) => n["type"] == selectedFilter).toList();
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case "booking":
        return primaryColor;
      case "promotion":
        return warningColor;
      case "reminder":
        return infoColor;
      case "announcement":
        return successColor;
      case "reward":
        return warningColor;
      case "subscription":
        return primaryColor;
      case "feedback":
        return infoColor;
      default:
        return disabledBoldColor;
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
        return disabledBoldColor;
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["read"] = true;
      }
    });
    ss("All notifications marked as read");
  }

  void _toggleReadStatus(int notificationId) {
    setState(() {
      final index = notifications.indexWhere((n) => n["id"] == notificationId);
      if (index != -1) {
        notifications[index]["read"] = !notifications[index]["read"];
      }
    });
    ss("Notification status updated");
  }

  void _deleteNotification(int notificationId) {
    setState(() {
      notifications.removeWhere((n) => n["id"] == notificationId);
    });
    ss("Notification deleted");
  }

  void _handleNotificationAction(Map<String, dynamic> notification) {
    final action = notification["actionText"] as String;
    ss("$action action performed");
    //navigateTo ( appropriate view based on action )
  }
}
