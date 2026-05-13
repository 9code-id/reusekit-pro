import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline10View extends StatefulWidget {
  @override
  State<GrlTimeline10View> createState() => _GrlTimeline10ViewState();
}

class _GrlTimeline10ViewState extends State<GrlTimeline10View> {
  List<Map<String, dynamic>> communicationHistory = [
    {
      "id": "1",
      "type": "email",
      "subject": "Welcome to Our Platform",
      "sender": {
        "name": "Support Team",
        "email": "support@company.com",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=support"
      },
      "recipient": {
        "name": "John Doe",
        "email": "john@example.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=user"
      },
      "content": "Thank you for joining our platform! Here's everything you need to get started.",
      "timestamp": "2024-01-20T09:30:00Z",
      "status": "delivered",
      "priority": "normal",
      "read": true,
      "attachments": 0
    },
    {
      "id": "2",
      "type": "call",
      "subject": "Product Demo Call",
      "sender": {
        "name": "Sales Representative",
        "email": "sales@company.com",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=sales"
      },
      "recipient": {
        "name": "John Doe",
        "email": "john@example.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=user"
      },
      "content": "30-minute product demonstration and Q&A session",
      "timestamp": "2024-01-20T14:00:00Z",
      "status": "completed",
      "priority": "high",
      "duration": "32 minutes",
      "recording": true
    },
    {
      "id": "3",
      "type": "sms",
      "subject": "Verification Code",
      "sender": {
        "name": "System",
        "email": "noreply@company.com",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=system"
      },
      "recipient": {
        "name": "John Doe",
        "email": "john@example.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=user"
      },
      "content": "Your verification code is: 123456. Valid for 10 minutes.",
      "timestamp": "2024-01-20T16:45:00Z",
      "status": "delivered",
      "priority": "high",
      "read": true,
      "characters": 58
    },
    {
      "id": "4",
      "type": "email",
      "subject": "Invoice #INV-2024-001",
      "sender": {
        "name": "Billing Department",
        "email": "billing@company.com",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=billing"
      },
      "recipient": {
        "name": "John Doe",
        "email": "john@example.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=user"
      },
      "content": "Your monthly invoice is ready. Payment due in 14 days.",
      "timestamp": "2024-01-19T10:15:00Z",
      "status": "delivered",
      "priority": "normal",
      "read": false,
      "attachments": 1
    },
    {
      "id": "5",
      "type": "meeting",
      "subject": "Team Standup Meeting",
      "sender": {
        "name": "Project Manager",
        "email": "pm@company.com",
        "avatar": "https://picsum.photos/40/40?random=6&keyword=manager"
      },
      "recipient": {
        "name": "Development Team",
        "email": "dev-team@company.com",
        "avatar": "https://picsum.photos/40/40?random=7&keyword=team"
      },
      "content": "Daily standup meeting to discuss progress and blockers",
      "timestamp": "2024-01-19T09:00:00Z",
      "status": "completed",
      "priority": "normal",
      "duration": "15 minutes",
      "attendees": 8
    },
    {
      "id": "6",
      "type": "chat",
      "subject": "Quick Question",
      "sender": {
        "name": "Alice Johnson",
        "email": "alice@company.com",
        "avatar": "https://picsum.photos/40/40?random=8&keyword=colleague"
      },
      "recipient": {
        "name": "John Doe",
        "email": "john@example.com",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=user"
      },
      "content": "Hey! Can you review the latest design mockups when you get a chance?",
      "timestamp": "2024-01-18T15:30:00Z",
      "status": "read",
      "priority": "low",
      "read": true,
      "thread": true
    }
  ];

  String selectedFilter = "all";
  List<String> filterOptions = ["all", "email", "call", "sms", "meeting", "chat"];

  List<Map<String, dynamic>> get filteredCommunications {
    if (selectedFilter == "all") {
      return communicationHistory;
    }
    return communicationHistory.where((comm) => comm["type"] == selectedFilter).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "email":
        return infoColor;
      case "call":
        return successColor;
      case "sms":
        return warningColor;
      case "meeting":
        return primaryColor;
      case "chat":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "email":
        return Icons.email;
      case "call":
        return Icons.phone;
      case "sms":
        return Icons.sms;
      case "meeting":
        return Icons.video_call;
      case "chat":
        return Icons.chat;
      default:
        return Icons.circle;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "delivered":
      case "completed":
      case "read":
        return successColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "normal":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  String _getTypeDisplayName(String type) {
    switch (type) {
      case "email":
        return "Email";
      case "call":
        return "Phone Call";
      case "sms":
        return "SMS";
      case "meeting":
        return "Meeting";
      case "chat":
        return "Chat";
      default:
        return type.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Communication History"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Communication Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, infoColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Communication Log",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Track all your communications",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Communications",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${filteredCommunications.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
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
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unread Items",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${communicationHistory.where((c) => c["read"] == false).length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Communication Type Filter
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
                    "Filter by Type",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filterOptions.map((filter) {
                        bool isSelected = selectedFilter == filter;
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedFilter = filter;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (filter != "all")
                                    Icon(
                                      _getTypeIcon(filter),
                                      size: 14,
                                      color: isSelected ? Colors.white : disabledBoldColor,
                                    ),
                                  if (filter != "all") SizedBox(width: spXs),
                                  Text(
                                    filter == "all" ? "All" : _getTypeDisplayName(filter),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Communication Timeline
            Text(
              "Communication Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...filteredCommunications.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> comm = entry.value;
              bool isLast = index == filteredCommunications.length - 1;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Indicator
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: _getTypeColor("${comm["type"]}"),
                            shape: BoxShape.circle,
                            boxShadow: [shadowSm],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            _getTypeIcon("${comm["type"]}"),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 3,
                            height: 80,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: spSm),
                          ),
                      ],
                    ),

                    SizedBox(width: spMd),

                    // Communication Content
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: (comm["read"] == false || comm["status"] == "pending")
                              ? Border.all(
                                  color: warningColor.withAlpha(100),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Communication Header
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${comm["subject"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getTypeColor("${comm["type"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    _getTypeDisplayName("${comm["type"]}"),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getTypeColor("${comm["type"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spXs),

                            // Timestamp and Status
                            Row(
                              children: [
                                Text(
                                  _formatTimestamp("${comm["timestamp"]}"),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${comm["status"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${comm["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor("${comm["status"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${comm["priority"]}").withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${comm["priority"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor("${comm["priority"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: spSm),

                            // Participants
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundImage: NetworkImage("${(comm["sender"] as Map)["avatar"]}"),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "From: ${(comm["sender"] as Map)["name"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${(comm["sender"] as Map)["email"]}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundImage: NetworkImage("${(comm["recipient"] as Map)["avatar"]}"),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "To: ${(comm["recipient"] as Map)["name"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${(comm["recipient"] as Map)["email"]}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: spSm),

                            // Content
                            Text(
                              "${comm["content"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: spMd),

                            // Additional Details
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  if (comm["attachments"] != null && (comm["attachments"] as int) > 0) ...[
                                    Icon(
                                      Icons.attach_file,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comm["attachments"]} attachments",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  if (comm["duration"] != null) ...[
                                    Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comm["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  if (comm["characters"] != null) ...[
                                    Icon(
                                      Icons.text_fields,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comm["characters"]} chars",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  if (comm["attendees"] != null) ...[
                                    Icon(
                                      Icons.people,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${comm["attendees"]} attendees",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                  if (comm["recording"] == true) ...[
                                    Spacer(),
                                    Icon(
                                      Icons.videocam,
                                      size: 16,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Recorded",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                  if (comm["thread"] == true) ...[
                                    Spacer(),
                                    Icon(
                                      Icons.forum,
                                      size: 16,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Thread",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            // Action Buttons
                            if (comm["type"] == "email" || comm["type"] == "chat") ...[
                              SizedBox(height: spMd),
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "Reply",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.forward,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
