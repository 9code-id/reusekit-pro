import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaActivityLogView extends StatefulWidget {
  const SmaActivityLogView({super.key});

  @override
  State<SmaActivityLogView> createState() => _SmaActivityLogViewState();
}

class _SmaActivityLogViewState extends State<SmaActivityLogView> {
  String selectedFilter = "all";
  String selectedTimeframe = "today";
  
  List<Map<String, dynamic>> activities = [
    {
      "id": 1,
      "action": "sent_message",
      "description": "Sent a message to Sarah Wilson",
      "timestamp": "2024-06-16T11:45:00Z",
      "details": {
        "recipient": "Sarah Wilson",
        "messageType": "text",
        "content": "Hey! How are you doing?"
      },
      "icon": Icons.send,
      "color": "blue",
    },
    {
      "id": 2,
      "action": "received_message",
      "description": "Received a message from Alex Johnson",
      "timestamp": "2024-06-16T11:30:00Z",
      "details": {
        "sender": "Alex Johnson",
        "messageType": "text",
        "content": "Looking forward to our meeting tomorrow"
      },
      "icon": Icons.message,
      "color": "green",
    },
    {
      "id": 3,
      "action": "photo_shared",
      "description": "Shared 3 photos in 'Family Trip' album",
      "timestamp": "2024-06-16T10:15:00Z",
      "details": {
        "album": "Family Trip",
        "photoCount": 3,
        "sharedWith": ["Sarah Wilson", "Mike Chen"]
      },
      "icon": Icons.photo,
      "color": "purple",
    },
    {
      "id": 4,
      "action": "friend_added",
      "description": "Added Emma Rodriguez as a friend",
      "timestamp": "2024-06-16T09:45:00Z",
      "details": {
        "friend": "Emma Rodriguez",
        "mutualFriends": 5
      },
      "icon": Icons.person_add,
      "color": "orange",
    },
    {
      "id": 5,
      "action": "profile_updated",
      "description": "Updated profile information",
      "timestamp": "2024-06-16T09:20:00Z",
      "details": {
        "changes": ["bio", "location", "interests"],
        "previousBio": "Love traveling and photography",
        "newBio": "Passionate about travel, photography, and hiking"
      },
      "icon": Icons.edit,
      "color": "teal",
    },
    {
      "id": 6,
      "action": "memory_created",
      "description": "Created a new memory from last week's photos",
      "timestamp": "2024-06-16T08:30:00Z",
      "details": {
        "memoryTitle": "Weekend Adventure",
        "photoCount": 12,
        "dateRange": "June 8-9, 2024"
      },
      "icon": Icons.auto_awesome,
      "color": "pink",
    },
    {
      "id": 7,
      "action": "login",
      "description": "Logged in from Chrome on Windows",
      "timestamp": "2024-06-16T08:00:00Z",
      "details": {
        "device": "Chrome on Windows",
        "location": "New York, NY",
        "ipAddress": "192.168.1.100"
      },
      "icon": Icons.login,
      "color": "indigo",
    },
    {
      "id": 8,
      "action": "backup_completed",
      "description": "Backup completed successfully",
      "timestamp": "2024-06-16T07:00:00Z",
      "details": {
        "dataTypes": ["messages", "photos", "contacts"],
        "size": "2.3 GB",
        "duration": "15 minutes"
      },
      "icon": Icons.backup,
      "color": "green",
    },
    {
      "id": 9,
      "action": "group_joined",
      "description": "Joined 'Hiking Enthusiasts' group",
      "timestamp": "2024-06-15T22:15:00Z",
      "details": {
        "group": "Hiking Enthusiasts",
        "memberCount": 247,
        "invitedBy": "Mike Chen"
      },
      "icon": Icons.group_add,
      "color": "cyan",
    },
    {
      "id": 10,
      "action": "photo_liked",
      "description": "Liked David Thompson's photo",
      "timestamp": "2024-06-15T21:30:00Z",
      "details": {
        "photoOwner": "David Thompson",
        "photoCaption": "Beautiful sunset at the beach",
        "album": "Beach Vacation"
      },
      "icon": Icons.favorite,
      "color": "red",
    },
    {
      "id": 11,
      "action": "settings_changed",
      "description": "Updated privacy settings",
      "timestamp": "2024-06-15T20:45:00Z",
      "details": {
        "changes": ["message_privacy", "photo_visibility"],
        "messagePrivacy": "friends_only",
        "photoVisibility": "private"
      },
      "icon": Icons.settings,
      "color": "grey",
    },
    {
      "id": 12,
      "action": "comment_posted",
      "description": "Commented on Lisa Park's photo",
      "timestamp": "2024-06-15T19:20:00Z",
      "details": {
        "photoOwner": "Lisa Park",
        "comment": "Amazing shot! Where was this taken?",
        "photoCaption": "Mountain hiking adventure"
      },
      "icon": Icons.comment,
      "color": "amber",
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    var filtered = activities;
    
    // Filter by type
    if (selectedFilter != "all") {
      filtered = filtered.where((activity) => activity["action"] == selectedFilter).toList();
    }
    
    // Filter by timeframe
    DateTime now = DateTime.now();
    DateTime filterDate;
    
    switch (selectedTimeframe) {
      case "today":
        filterDate = DateTime(now.year, now.month, now.day);
        break;
      case "week":
        filterDate = now.subtract(Duration(days: 7));
        break;
      case "month":
        filterDate = now.subtract(Duration(days: 30));
        break;
      default:
        filterDate = DateTime(2000); // Show all
    }
    
    filtered = filtered.where((activity) {
      DateTime activityDate = DateTime.parse("${activity["timestamp"]}");
      return activityDate.isAfter(filterDate);
    }).toList();
    
    return filtered;
  }

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Activities", "value": "all"},
    {"label": "Messages", "value": "sent_message"},
    {"label": "Photos", "value": "photo_shared"},
    {"label": "Friends", "value": "friend_added"},
    {"label": "Profile", "value": "profile_updated"},
    {"label": "Login", "value": "login"},
    {"label": "Groups", "value": "group_joined"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "All Time", "value": "all"},
  ];

  Color _getActivityColor(String colorName) {
    switch (colorName) {
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "purple":
        return Colors.purple;
      case "orange":
        return Colors.orange;
      case "teal":
        return Colors.teal;
      case "pink":
        return Colors.pink;
      case "indigo":
        return Colors.indigo;
      case "cyan":
        return Colors.cyan;
      case "red":
        return Colors.red;
      case "grey":
        return Colors.grey;
      case "amber":
        return Colors.amber;
      default:
        return primaryColor;
    }
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getActivityColor("${activity["color"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    activity["icon"],
                    color: _getActivityColor("${activity["color"]}"),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity["description"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        DateTime.parse("${activity["timestamp"]}").dMMMykkss,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Divider(),
            SizedBox(height: spMd),
            Text(
              "Details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildActivityDetails(activity["details"]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActivityDetails(Map<String, dynamic> details) {
    List<Widget> widgets = [];
    
    details.forEach((key, value) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: spXs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  "${key.replaceAll('_', ' ').toUpperCase()}:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  value is List ? value.join(", ") : "$value",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    
    return widgets;
  }

  void _exportActivityLog() async {
    bool isConfirmed = await confirm("Export activity log? This will include all your activity data.");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Activity log exported successfully");
    }
  }

  void _clearActivityLog() async {
    bool isConfirmed = await confirm("Clear activity log? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        activities.clear();
      });
      ss("Activity log cleared");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity Log"),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == "export") {
                _exportActivityLog();
              } else if (value == "clear") {
                _clearActivityLog();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "export",
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: spSm),
                    Text("Export Log"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "clear",
                child: Row(
                  children: [
                    Icon(Icons.clear_all, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Clear Log", style: TextStyle(color: dangerColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Activity Type",
                        items: filterOptions,
                        value: selectedFilter,
                        onChanged: (value, label) {
                          selectedFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: timeframeOptions,
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Showing ${filteredActivities.length} activities",
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
          
          // Activities List
          Expanded(
            child: filteredActivities.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No Activities Found",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No activities match your current filters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredActivities.length,
                    itemBuilder: (context, index) {
                      final activity = filteredActivities[index];
                      final activityColor = _getActivityColor("${activity["color"]}");
                      final isFirst = index == 0;
                      final isLast = index == filteredActivities.length - 1;
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Timeline
                            Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: activityColor.withAlpha(20),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: activityColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    activity["icon"],
                                    color: activityColor,
                                    size: 20,
                                  ),
                                ),
                                if (!isLast) ...[
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: Colors.grey.shade300,
                                    margin: EdgeInsets.symmetric(vertical: spSm),
                                  ),
                                ],
                              ],
                            ),
                            
                            SizedBox(width: spMd),
                            
                            // Content
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusMd),
                                  boxShadow: [shadowSm],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    onTap: () => _showActivityDetails(activity),
                                    child: Padding(
                                      padding: EdgeInsets.all(spSm),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${activity["description"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                                                  color: activityColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${activity["action"]}".replaceAll('_', ' ').toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: activityColor,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                DateTime.parse("${activity["timestamp"]}").dMMMy,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spSm),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                size: 12,
                                                color: disabledColor,
                                              ),
                                              SizedBox(width: spXs),
                                              Text(
                                                "${DateTime.parse("${activity["timestamp"]}").hour.toString().padLeft(2, '0')}:${DateTime.parse("${activity["timestamp"]}").minute.toString().padLeft(2, '0')}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Tap for details",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: spXs),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 12,
                                                color: primaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
    );
  }
}
