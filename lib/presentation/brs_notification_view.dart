import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsNotificationView extends StatefulWidget {
  const BrsNotificationView({super.key});

  @override
  State<BrsNotificationView> createState() => _BrsNotificationViewState();
}

class _BrsNotificationViewState extends State<BrsNotificationView> {
  int selectedTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> allNotifications = [
    {
      "id": "1",
      "type": "booking_confirmed",
      "title": "Booking Confirmed",
      "message": "Your appointment with Mike Johnson has been confirmed for Dec 15, 2024 at 2:00 PM",
      "time": "2024-12-14T10:30:00Z",
      "read": false,
      "icon": Icons.check_circle,
      "color": Colors.green,
    },
    {
      "id": "2",
      "type": "reminder",
      "title": "Appointment Reminder",
      "message": "Don't forget your haircut appointment tomorrow at 2:00 PM with Mike Johnson",
      "time": "2024-12-14T09:00:00Z",
      "read": false,
      "icon": Icons.access_time,
      "color": Colors.orange,
    },
    {
      "id": "3",
      "type": "promotion",
      "title": "Special Offer",
      "message": "Get 20% off on your next premium service. Valid until Dec 31, 2024",
      "time": "2024-12-13T14:15:00Z",
      "read": true,
      "icon": Icons.local_offer,
      "color": Colors.purple,
    },
    {
      "id": "4",
      "type": "booking_cancelled",
      "title": "Booking Cancelled",
      "message": "Your appointment on Dec 12, 2024 has been cancelled by the barber due to emergency",
      "time": "2024-12-12T11:20:00Z",
      "read": true,
      "icon": Icons.cancel,
      "color": Colors.red,
    },
    {
      "id": "5",
      "type": "review_request",
      "title": "Rate Your Experience",
      "message": "How was your service with Alex Brown? Share your feedback to help others",
      "time": "2024-12-11T16:45:00Z",
      "read": true,
      "icon": Icons.star_rate,
      "color": Colors.blue,
    },
    {
      "id": "6",
      "type": "loyalty_points",
      "title": "Loyalty Points Earned",
      "message": "You've earned 25 loyalty points from your recent visit. Total: 450 points",
      "time": "2024-12-11T15:30:00Z",
      "read": true,
      "icon": Icons.stars,
      "color": Colors.amber,
    },
    {
      "id": "7",
      "type": "new_barber",
      "title": "New Barber Available",
      "message": "David Wilson has joined Elite Barber Shop. Check out his services and book now!",
      "time": "2024-12-10T13:00:00Z",
      "read": true,
      "icon": Icons.person_add,
      "color": Colors.teal,
    },
    {
      "id": "8",
      "type": "payment_success",
      "title": "Payment Successful",
      "message": "Your payment of \$35.00 for haircut service has been processed successfully",
      "time": "2024-12-09T17:20:00Z",
      "read": true,
      "icon": Icons.payment,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read),
            onPressed: _markAllAsRead,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => si("Navigate to Notification Settings"),
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: _buildNotificationList(),
              ),
            ],
          ),
    );
  }

  Widget _buildTabBar() {
    List<String> tabs = ["All", "Unread", "Bookings", "Promotions"];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        spacing: spSm,
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationList() {
    List<Map<String, dynamic>> filteredNotifications = _getFilteredNotifications();
    
    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> notification = filteredNotifications[index];
        return _buildNotificationItem(notification, index);
      },
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    bool isRead = notification["read"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: !isRead ? Border(
          left: BorderSide(
            width: 4,
            color: primaryColor,
          ),
        ) : null,
      ),
      child: GestureDetector(
        onTap: () => _markAsRead(notification["id"]),
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (notification["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  notification["icon"] as IconData,
                  color: notification["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(notification["time"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _deleteNotification(notification["id"]),
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    String message = "";
    IconData icon = Icons.notifications;
    
    switch (selectedTab) {
      case 0:
        message = "No notifications yet";
        break;
      case 1:
        message = "No unread notifications";
        break;
      case 2:
        message = "No booking notifications";
        break;
      case 3:
        message = "No promotional notifications";
        break;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spMd,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: disabledBoldColor,
              size: 40,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "When you have notifications, they'll appear here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    switch (selectedTab) {
      case 0: // All
        return allNotifications;
      case 1: // Unread
        return allNotifications.where((n) => !(n["read"] as bool)).toList();
      case 2: // Bookings
        return allNotifications.where((n) => 
          ["booking_confirmed", "booking_cancelled", "reminder"].contains(n["type"])
        ).toList();
      case 3: // Promotions
        return allNotifications.where((n) => 
          ["promotion", "loyalty_points"].contains(n["type"])
        ).toList();
      default:
        return allNotifications;
    }
  }

  void _markAsRead(String notificationId) {
    setState(() {
      allNotifications = allNotifications.map((notification) {
        if (notification["id"] == notificationId) {
          notification["read"] = true;
        }
        return notification;
      }).toList();
    });
  }

  void _markAllAsRead() async {
    bool isConfirmed = await confirm("Mark all notifications as read?");
    if (!isConfirmed) return;

    setState(() {
      allNotifications = allNotifications.map((notification) {
        notification["read"] = true;
        return notification;
      }).toList();
    });

    ss("All notifications marked as read");
  }

  void _deleteNotification(String notificationId) async {
    bool isConfirmed = await confirm("Delete this notification?");
    if (!isConfirmed) return;

    setState(() {
      allNotifications.removeWhere((notification) => notification["id"] == notificationId);
    });

    ss("Notification deleted");
  }
}
