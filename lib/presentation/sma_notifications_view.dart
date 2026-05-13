import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaNotificationsView extends StatefulWidget {
  const SmaNotificationsView({super.key});

  @override
  State<SmaNotificationsView> createState() => _SmaNotificationsViewState();
}

class _SmaNotificationsViewState extends State<SmaNotificationsView> {
  String selectedFilter = "all";
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "New Message from Sarah",
      "message": "Hey! How are you doing today? Would you like to grab lunch?",
      "type": "message",
      "timestamp": "2024-06-16T11:30:00Z",
      "isRead": false,
      "senderImage": "https://picsum.photos/50/50?random=1&keyword=profile",
      "senderName": "Sarah Wilson",
    },
    {
      "id": 2,
      "title": "Friend Request",
      "message": "Alex Johnson wants to connect with you",
      "type": "friend_request",
      "timestamp": "2024-06-16T10:15:00Z",
      "isRead": false,
      "senderImage": "https://picsum.photos/50/50?random=2&keyword=profile",
      "senderName": "Alex Johnson",
    },
    {
      "id": 3,
      "title": "Memory Created",
      "message": "A new memory has been created from your photos from last week",
      "type": "memory",
      "timestamp": "2024-06-16T09:45:00Z",
      "isRead": true,
      "icon": Icons.photo_library,
    },
    {
      "id": 4,
      "title": "Photo Tagged",
      "message": "Mike Chen tagged you in a photo",
      "type": "tag",
      "timestamp": "2024-06-16T08:20:00Z",
      "isRead": false,
      "senderImage": "https://picsum.photos/50/50?random=3&keyword=profile",
      "senderName": "Mike Chen",
    },
    {
      "id": 5,
      "title": "Backup Complete",
      "message": "Your photos and messages have been backed up successfully",
      "type": "system",
      "timestamp": "2024-06-16T07:00:00Z",
      "isRead": true,
      "icon": Icons.backup,
    },
    {
      "id": 6,
      "title": "New Group Invitation",
      "message": "Emma Rodriguez invited you to join 'Hiking Enthusiasts' group",
      "type": "group",
      "timestamp": "2024-06-15T22:30:00Z",
      "isRead": false,
      "senderImage": "https://picsum.photos/50/50?random=4&keyword=profile",
      "senderName": "Emma Rodriguez",
    },
    {
      "id": 7,
      "title": "Birthday Reminder",
      "message": "David Thompson's birthday is tomorrow. Send him a message!",
      "type": "reminder",
      "timestamp": "2024-06-15T20:00:00Z",
      "isRead": true,
      "icon": Icons.cake,
    },
    {
      "id": 8,
      "title": "Account Security",
      "message": "New login detected from Chrome on Windows. If this wasn't you, secure your account.",
      "type": "security",
      "timestamp": "2024-06-15T18:45:00Z",
      "isRead": false,
      "icon": Icons.security,
    },
    {
      "id": 9,
      "title": "Storage Almost Full",
      "message": "Your storage is 90% full. Consider upgrading or cleaning up old files.",
      "type": "warning",
      "timestamp": "2024-06-15T16:30:00Z",
      "isRead": true,
      "icon": Icons.storage,
    },
    {
      "id": 10,
      "title": "Weekly Summary",
      "message": "You received 25 messages and shared 12 photos this week",
      "type": "summary",
      "timestamp": "2024-06-15T12:00:00Z",
      "isRead": true,
      "icon": Icons.analytics,
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == "all") {
      return notifications;
    } else if (selectedFilter == "unread") {
      return notifications.where((n) => !(n["isRead"] as bool)).toList();
    } else {
      return notifications.where((n) => n["type"] == selectedFilter).toList();
    }
  }

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "all"},
    {"label": "Unread", "value": "unread"},
    {"label": "Messages", "value": "message"},
    {"label": "Friend Requests", "value": "friend_request"},
    {"label": "Groups", "value": "group"},
    {"label": "Memories", "value": "memory"},
    {"label": "System", "value": "system"},
  ];

  Color _getNotificationColor(String type) {
    switch (type) {
      case "message":
        return Colors.blue;
      case "friend_request":
        return Colors.green;
      case "memory":
        return Colors.purple;
      case "tag":
        return Colors.orange;
      case "group":
        return Colors.teal;
      case "reminder":
        return Colors.pink;
      case "security":
        return Colors.red;
      case "warning":
        return Colors.amber;
      case "summary":
        return Colors.indigo;
      case "system":
        return Colors.grey;
      default:
        return primaryColor;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case "message":
        return Icons.message;
      case "friend_request":
        return Icons.person_add;
      case "memory":
        return Icons.photo_library;
      case "tag":
        return Icons.local_offer;
      case "group":
        return Icons.group;
      case "reminder":
        return Icons.event;
      case "security":
        return Icons.security;
      case "warning":
        return Icons.warning;
      case "summary":
        return Icons.analytics;
      case "system":
        return Icons.settings;
      default:
        return Icons.notifications;
    }
  }

  void _markAsRead(Map<String, dynamic> notification) {
    setState(() {
      notification["isRead"] = true;
    });
  }

  void _markAllAsRead() async {
    bool isConfirmed = await confirm("Mark all notifications as read?");
    if (isConfirmed) {
      setState(() {
        for (var notification in notifications) {
          notification["isRead"] = true;
        }
      });
      ss("All notifications marked as read");
    }
  }

  void _deleteNotification(Map<String, dynamic> notification) async {
    bool isConfirmed = await confirm("Delete this notification?");
    if (isConfirmed) {
      setState(() {
        notifications.removeWhere((n) => n["id"] == notification["id"]);
      });
      ss("Notification deleted");
    }
  }

  void _clearAllNotifications() async {
    bool isConfirmed = await confirm("Delete all notifications? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        notifications.clear();
      });
      ss("All notifications cleared");
    }
  }

  void _handleNotificationAction(Map<String, dynamic> notification) {
    String type = "${notification["type"]}";
    
    switch (type) {
      case "message":
        si("Opening chat with ${notification["senderName"]}");
        break;
      case "friend_request":
        si("Opening friend request from ${notification["senderName"]}");
        break;
      case "memory":
        si("Opening memory album");
        break;
      case "tag":
        si("Opening tagged photo");
        break;
      case "group":
        si("Opening group invitation");
        break;
      case "reminder":
        si("Opening birthday reminder");
        break;
      case "security":
        si("Opening security settings");
        break;
      case "warning":
        si("Opening storage settings");
        break;
      case "summary":
        si("Opening weekly summary");
        break;
      default:
        si("Opening notification details");
    }
    
    _markAsRead(notification);
  }

  @override
  Widget build(BuildContext context) {
    int unreadCount = notifications.where((n) => !(n["isRead"] as bool)).length;
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notifications"),
            if (unreadCount > 0)
              Text(
                "$unreadCount unread",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
        actions: [
          if (unreadCount > 0)
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: _markAllAsRead,
            ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == "clear_all") {
                _clearAllNotifications();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "clear_all",
                child: Row(
                  children: [
                    Icon(Icons.clear_all, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Clear All"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filterOptions.map((option) {
                  bool isSelected = selectedFilter == option["value"];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: FilterChip(
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedFilter = "${option["value"]}";
                        });
                      },
                      label: Text("${option["label"]}"),
                      backgroundColor: Colors.grey.shade100,
                      selectedColor: primaryColor.withAlpha(20),
                      checkmarkColor: primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? primaryColor : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          Divider(height: 1),
          
          // Notifications List
          Expanded(
            child: filteredNotifications.isEmpty
                ? Center(
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
                          "No Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          selectedFilter == "unread"
                              ? "You have no unread notifications"
                              : "You have no notifications",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      final notification = filteredNotifications[index];
                      final isRead = notification["isRead"] as bool;
                      final type = "${notification["type"]}";
                      final typeColor = _getNotificationColor(type);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isRead ? Colors.white : primaryColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                          border: isRead ? null : Border.all(
                            color: primaryColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(radiusMd),
                            onTap: () => _handleNotificationAction(notification),
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  // Avatar or Icon
                                  if (notification["senderImage"] != null) ...[
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: NetworkImage("${notification["senderImage"]}"),
                                    ),
                                  ] else ...[
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: typeColor.withAlpha(20),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        notification["icon"] ?? _getNotificationIcon(type),
                                        color: typeColor,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                  
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
                                                  fontSize: 16,
                                                  fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (!isRead)
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  shape: BoxShape.circle,
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
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: spXs),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spSm,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: typeColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                type.replaceAll('_', ' ').toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: typeColor,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              DateTime.parse("${notification["timestamp"]}").dMMMy,
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
                                  
                                  SizedBox(width: spSm),
                                  
                                  // Actions
                                  PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: disabledBoldColor,
                                      size: 20,
                                    ),
                                    onSelected: (value) {
                                      if (value == "mark_read" && !isRead) {
                                        _markAsRead(notification);
                                      } else if (value == "delete") {
                                        _deleteNotification(notification);
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      if (!isRead)
                                        PopupMenuItem(
                                          value: "mark_read",
                                          child: Row(
                                            children: [
                                              Icon(Icons.mark_email_read, size: 18),
                                              SizedBox(width: spSm),
                                              Text("Mark as read"),
                                            ],
                                          ),
                                        ),
                                      PopupMenuItem(
                                        value: "delete",
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, size: 18, color: dangerColor),
                                            SizedBox(width: spSm),
                                            Text("Delete", style: TextStyle(color: dangerColor)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
