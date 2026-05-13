import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmNotificationCenterView extends StatefulWidget {
  const TpmNotificationCenterView({super.key});

  @override
  State<TpmNotificationCenterView> createState() => _TpmNotificationCenterViewState();
}

class _TpmNotificationCenterViewState extends State<TpmNotificationCenterView> {
  List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "title": "Task Assigned",
      "message": "You have been assigned to 'Implement user authentication'",
      "type": "task",
      "priority": "high",
      "timestamp": "2024-06-19 10:30:00",
      "isRead": false,
      "sender": "John Smith",
      "projectName": "Mobile App Development",
      "icon": Icons.task,
      "color": Colors.blue
    },
    {
      "id": 2,
      "title": "Deadline Approaching",
      "message": "Task 'Database optimization' is due tomorrow",
      "type": "deadline",
      "priority": "high",
      "timestamp": "2024-06-19 09:15:00",
      "isRead": false,
      "sender": "System",
      "projectName": "Backend Upgrade",
      "icon": Icons.schedule,
      "color": Colors.red
    },
    {
      "id": 3,
      "title": "Comment Added",
      "message": "Sarah Wilson commented on your task",
      "type": "comment",
      "priority": "medium",
      "timestamp": "2024-06-19 08:45:00",
      "isRead": true,
      "sender": "Sarah Wilson",
      "projectName": "UI/UX Redesign",
      "icon": Icons.comment,
      "color": Colors.green
    },
    {
      "id": 4,
      "title": "Project Update",
      "message": "Project status changed to 'In Review'",
      "type": "status",
      "priority": "medium",
      "timestamp": "2024-06-18 16:20:00",
      "isRead": true,
      "sender": "Mike Johnson",
      "projectName": "Client Portal",
      "icon": Icons.update,
      "color": Colors.orange
    },
    {
      "id": 5,
      "title": "Meeting Reminder",
      "message": "Daily standup meeting in 30 minutes",
      "type": "meeting",
      "priority": "medium",
      "timestamp": "2024-06-19 07:30:00",
      "isRead": false,
      "sender": "Calendar",
      "projectName": "Team Meeting",
      "icon": Icons.event,
      "color": Colors.purple
    },
    {
      "id": 6,
      "title": "New Message",
      "message": "You have a new message from the client",
      "type": "message",
      "priority": "low",
      "timestamp": "2024-06-18 14:15:00",
      "isRead": true,
      "sender": "Client Portal",
      "projectName": "E-commerce Platform",
      "icon": Icons.message,
      "color": Colors.indigo
    },
    {
      "id": 7,
      "title": "Approval Required",
      "message": "Your timesheet needs approval",
      "type": "approval",
      "priority": "medium",
      "timestamp": "2024-06-18 11:30:00",
      "isRead": false,
      "sender": "HR System",
      "projectName": "Time Management",
      "icon": Icons.approval,
      "color": Colors.teal
    },
    {
      "id": 8,
      "title": "System Maintenance",
      "message": "Scheduled system maintenance tonight at 11 PM",
      "type": "system",
      "priority": "low",
      "timestamp": "2024-06-18 09:00:00",
      "isRead": true,
      "sender": "IT Team",
      "projectName": "System Maintenance",
      "icon": Icons.settings,
      "color": Colors.grey
    }
  ];

  String selectedFilter = "All";
  List<String> filters = ["All", "Unread", "High Priority", "Task", "Deadline", "Meeting", "Comment"];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Center"),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read),
            onPressed: _markAllAsRead,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openNotificationSettings,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsRow(),
                  SizedBox(height: spMd),
                  _buildFilterRow(),
                  SizedBox(height: spMd),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ..._getFilteredNotifications().map((notification) => 
                    _buildNotificationCard(notification)
                  ).toList(),
                  if (_getFilteredNotifications().isEmpty)
                    _buildEmptyState(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsRow() {
    int unreadCount = notifications.where((n) => n["isRead"] == false).length;
    int highPriorityCount = notifications.where((n) => n["priority"] == "high" && n["isRead"] == false).length;
    int todayCount = notifications.where((n) {
      DateTime notificationDate = DateTime.parse(n["timestamp"]);
      DateTime today = DateTime.now();
      return notificationDate.day == today.day && 
             notificationDate.month == today.month && 
             notificationDate.year == today.year;
    }).length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Unread",
            value: "$unreadCount",
            icon: Icons.mark_email_unread,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "High Priority",
            value: "$highPriorityCount",
            icon: Icons.priority_high,
            color: dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Today",
            value: "$todayCount",
            icon: Icons.today,
            color: successColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return QHorizontalScroll(
      children: filters.map((filter) => 
        Container(
          margin: EdgeInsets.only(right: spXs),
          child: GestureDetector(
            onTap: () {
              selectedFilter = filter;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: selectedFilter == filter ? primaryColor : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: selectedFilter == filter ? Colors.white : disabledBoldColor,
                  fontWeight: selectedFilter == filter ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    Color priorityColor = notification["priority"] == "high" 
        ? dangerColor 
        : notification["priority"] == "medium" 
            ? warningColor 
            : successColor;

    bool isUnread = notification["isRead"] == false;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isUnread ? primaryColor.withAlpha(5) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isUnread ? Border.all(color: primaryColor.withAlpha(30), width: 1) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            margin: EdgeInsets.only(right: spXs),
                          ),
                        Expanded(
                          child: Text(
                            "${notification["title"]}",
                            style: TextStyle(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${notification["priority"].toString().toUpperCase()}",
                            style: TextStyle(
                              color: priorityColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${notification["message"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                        fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
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
            child: Row(
              children: [
                Icon(Icons.person, size: 14, color: disabledColor),
                SizedBox(width: spXs),
                Text(
                  "${notification["sender"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
                SizedBox(width: spMd),
                Icon(Icons.folder, size: 14, color: disabledColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${notification["projectName"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "${DateTime.parse(notification["timestamp"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              if (isUnread)
                Expanded(
                  child: QButton(
                    label: "Mark as Read",
                    size: bs.sm,
                    onPressed: () => _markAsRead(notification),
                  ),
                ),
              if (isUnread) SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewNotificationDetails(notification),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                color: dangerColor,
                onPressed: () => _deleteNotification(notification),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(spLg),
        child: Column(
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No Notifications",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You're all caught up! No notifications match your current filter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    List<Map<String, dynamic>> filtered = List.from(notifications);

    switch (selectedFilter) {
      case "Unread":
        filtered = filtered.where((n) => n["isRead"] == false).toList();
        break;
      case "High Priority":
        filtered = filtered.where((n) => n["priority"] == "high").toList();
        break;
      case "Task":
        filtered = filtered.where((n) => n["type"] == "task").toList();
        break;
      case "Deadline":
        filtered = filtered.where((n) => n["type"] == "deadline").toList();
        break;
      case "Meeting":
        filtered = filtered.where((n) => n["type"] == "meeting").toList();
        break;
      case "Comment":
        filtered = filtered.where((n) => n["type"] == "comment").toList();
        break;
    }

    // Sort by timestamp (newest first)
    filtered.sort((a, b) => DateTime.parse(b["timestamp"]).compareTo(DateTime.parse(a["timestamp"])));

    return filtered;
  }

  void _markAsRead(Map<String, dynamic> notification) {
    int index = notifications.indexWhere((n) => n["id"] == notification["id"]);
    if (index != -1) {
      notifications[index]["isRead"] = true;
      setState(() {});
      ss("Notification marked as read");
    }
  }

  void _markAllAsRead() async {
    bool isConfirmed = await confirm("Mark all notifications as read?");
    if (isConfirmed) {
      for (int i = 0; i < notifications.length; i++) {
        notifications[i]["isRead"] = true;
      }
      setState(() {});
      ss("All notifications marked as read");
    }
  }

  void _deleteNotification(Map<String, dynamic> notification) async {
    bool isConfirmed = await confirm("Delete this notification?");
    if (isConfirmed) {
      notifications.removeWhere((n) => n["id"] == notification["id"]);
      setState(() {});
      ss("Notification deleted");
    }
  }

  void _viewNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${notification["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              "Message",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${notification["message"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            _buildDetailRow("Sender", "${notification["sender"]}"),
            _buildDetailRow("Project", "${notification["projectName"]}"),
            _buildDetailRow("Priority", "${notification["priority"].toString().toUpperCase()}"),
            _buildDetailRow("Type", "${notification["type"].toString().toUpperCase()}"),
            _buildDetailRow("Time", "${DateTime.parse(notification["timestamp"]).dMMMy}"),
            Spacer(),
            Row(
              children: [
                if (notification["isRead"] == false)
                  Expanded(
                    child: QButton(
                      label: "Mark as Read",
                      size: bs.md,
                      onPressed: () {
                        _markAsRead(notification);
                        back();
                      },
                    ),
                  ),
                if (notification["isRead"] == false) SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Close",
                    size: bs.md,
                    onPressed: () => back(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                color: disabledColor,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openNotificationSettings() {
    ss("Opening notification settings - coming soon");
  }
}
