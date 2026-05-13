import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaTeamMessagingView extends StatefulWidget {
  const ComaTeamMessagingView({Key? key}) : super(key: key);

  @override
  State<ComaTeamMessagingView> createState() => _ComaTeamMessagingViewState();
}

class _ComaTeamMessagingViewState extends State<ComaTeamMessagingView> {
  String searchQuery = "";
  String selectedChannel = "All";
  String selectedProject = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> messagesData = [
    {
      "id": "MSG001",
      "channel": "General Discussion",
      "project": "Highway Bridge",
      "sender": "John Smith",
      "sender_role": "Project Manager",
      "sender_avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "message": "Good morning team! Please remember that today's safety briefing is at 8:00 AM sharp. All site personnel must attend.",
      "timestamp": "2024-06-15 07:30",
      "message_type": "Text",
      "attachments": [],
      "reactions": [
        {"emoji": "👍", "count": 8, "users": ["Mike", "Sarah", "David", "Lisa", "Tom", "Anna", "Chris", "Emma"]},
        {"emoji": "✅", "count": 12, "users": ["All Team"]},
      ],
      "replies": 3,
      "priority": "Normal",
      "status": "Delivered",
      "read_by": 25,
      "total_members": 28,
      "thread_id": "T001",
      "is_pinned": true,
      "mentions": ["@everyone"],
      "tags": ["safety", "briefing", "mandatory"]
    },
    {
      "id": "MSG002",
      "channel": "Engineering Team",
      "project": "City Mall",
      "sender": "Sarah Johnson",
      "sender_role": "Lead Engineer", 
      "sender_avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "message": "Updated electrical blueprints are ready for review. Please check the new panel locations in section B-3.",
      "timestamp": "2024-06-15 09:15",
      "message_type": "Text",
      "attachments": [
        {"name": "Electrical_Blueprint_v2.1.pdf", "size": "15.7 MB", "type": "PDF"},
        {"name": "Panel_Locations.dwg", "size": "8.3 MB", "type": "DWG"}
      ],
      "reactions": [
        {"emoji": "👀", "count": 5, "users": ["Mike", "David", "Tom", "Chris", "Emma"]},
        {"emoji": "🔧", "count": 3, "users": ["Mike", "David", "Tom"]},
      ],
      "replies": 7,
      "priority": "High",
      "status": "Read",
      "read_by": 8,
      "total_members": 12,
      "thread_id": "T002",
      "is_pinned": false,
      "mentions": ["@engineering"],
      "tags": ["blueprints", "electrical", "review"]
    },
    {
      "id": "MSG003",
      "channel": "Site Updates",
      "project": "Residential Complex",
      "sender": "Mike Wilson",
      "sender_role": "Site Supervisor",
      "sender_avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "message": "Foundation work in units 10-15 is progressing well. Weather looks good for concrete pour tomorrow.",
      "timestamp": "2024-06-15 11:30",
      "message_type": "Text",
      "attachments": [
        {"name": "Foundation_Progress.jpg", "size": "2.1 MB", "type": "Image"},
        {"name": "Weather_Report.pdf", "size": "1.8 MB", "type": "PDF"}
      ],
      "reactions": [
        {"emoji": "🏗️", "count": 6, "users": ["John", "Sarah", "David", "Lisa", "Anna", "Chris"]},
        {"emoji": "☀️", "count": 4, "users": ["John", "David", "Lisa", "Anna"]},
      ],
      "replies": 5,
      "priority": "Normal",
      "status": "Delivered",
      "read_by": 15,
      "total_members": 18,
      "thread_id": "T003",
      "is_pinned": false,
      "mentions": [],
      "tags": ["foundation", "progress", "weather"]
    },
    {
      "id": "MSG004", 
      "channel": "Safety Alerts",
      "project": "Highway Bridge",
      "sender": "David Brown",
      "sender_role": "Safety Officer",
      "sender_avatar": "https://picsum.photos/50/50?random=4&keyword=safety",
      "message": "🚨 SAFETY ALERT: Crane operation in progress in zone A. Hard hats and high-vis vests required. No unauthorized personnel in the area.",
      "timestamp": "2024-06-15 13:45",
      "message_type": "Alert",
      "attachments": [
        {"name": "Safety_Zone_Map.png", "size": "3.2 MB", "type": "Image"}
      ],
      "reactions": [
        {"emoji": "⚠️", "count": 15, "users": ["All Team"]},
        {"emoji": "✅", "count": 20, "users": ["All Team"]},
      ],
      "replies": 2,
      "priority": "Critical",
      "status": "Read",
      "read_by": 28,
      "total_members": 28,
      "thread_id": "T004",
      "is_pinned": true,
      "mentions": ["@everyone", "@safety-team"],
      "tags": ["safety", "alert", "crane", "zone-a"]
    },
    {
      "id": "MSG005",
      "channel": "Quality Control",
      "project": "City Mall",
      "sender": "Lisa Garcia",
      "sender_role": "QC Inspector",
      "sender_avatar": "https://picsum.photos/50/50?random=5&keyword=inspector",
      "message": "Inspection results for level 2 concrete work. Minor issues found in section C-2, requires attention before proceeding.",
      "timestamp": "2024-06-15 14:20",
      "message_type": "Report",
      "attachments": [
        {"name": "QC_Report_Level2.pdf", "size": "5.4 MB", "type": "PDF"},
        {"name": "Issue_Photos.zip", "size": "12.8 MB", "type": "Archive"}
      ],
      "reactions": [
        {"emoji": "📋", "count": 7, "users": ["John", "Sarah", "Mike", "David", "Tom", "Anna", "Chris"]},
        {"emoji": "⚠️", "count": 3, "users": ["John", "Sarah", "Mike"]},
      ],
      "replies": 9,
      "priority": "High",
      "status": "Delivered",
      "read_by": 10,
      "total_members": 15,
      "thread_id": "T005",
      "is_pinned": false,
      "mentions": ["@qc-team", "@construction-manager"],
      "tags": ["inspection", "quality", "concrete", "issues"]
    },
    {
      "id": "MSG006",
      "channel": "Procurement Updates",
      "project": "Residential Complex",
      "sender": "Robert Lee",
      "sender_role": "Procurement Manager",
      "sender_avatar": "https://picsum.photos/50/50?random=6&keyword=manager",
      "message": "Steel delivery confirmed for Monday 8:00 AM. Please ensure crane availability and clear access to storage area.",
      "timestamp": "2024-06-15 15:10",
      "message_type": "Notification",
      "attachments": [
        {"name": "Delivery_Schedule.xlsx", "size": "2.7 MB", "type": "Excel"}
      ],
      "reactions": [
        {"emoji": "🚛", "count": 8, "users": ["John", "Mike", "David", "Tom", "Anna", "Chris", "Emma", "Pete"]},
        {"emoji": "📅", "count": 5, "users": ["John", "Mike", "David", "Tom", "Anna"]},
      ],
      "replies": 4,
      "priority": "Normal",
      "status": "Delivered",
      "read_by": 12,
      "total_members": 16,
      "thread_id": "T006",
      "is_pinned": false,
      "mentions": ["@logistics", "@crane-operator"],
      "tags": ["delivery", "steel", "procurement", "schedule"]
    }
  ];

  List<Map<String, dynamic>> get filteredMessages {
    return messagesData.where((message) {
      bool matchesSearch = message["message"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          message["sender"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          message["channel"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesChannel = selectedChannel == "All" || message["channel"] == selectedChannel;
      bool matchesProject = selectedProject == "All" || message["project"] == selectedProject;
      bool matchesStatus = selectedStatus == "All" || message["status"] == selectedStatus;
      
      return matchesSearch && matchesChannel && matchesProject && matchesStatus;
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Normal":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Read":
        return infoColor;
      case "Sending":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMessageTypeColor(String type) {
    switch (type) {
      case "Alert":
        return dangerColor;
      case "Report":
        return warningColor;
      case "Notification":
        return infoColor;
      case "Text":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMessageTypeIcon(String type) {
    switch (type) {
      case "Alert":
        return Icons.warning;
      case "Report":
        return Icons.assessment;
      case "Notification":
        return Icons.notifications;
      case "Text":
        return Icons.message;
      default:
        return Icons.message;
    }
  }

  String _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case "pdf":
        return "📄";
      case "dwg":
        return "📐";
      case "image":
        return "🖼️";
      case "excel":
        return "📊";
      case "archive":
        return "📦";
      default:
        return "📎";
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalMessages = messagesData.length;
    int unreadMessages = messagesData.where((msg) => (msg["read_by"] as int) < (msg["total_members"] as int)).length;
    int pinnedMessages = messagesData.where((msg) => msg["is_pinned"] == true).length;
    int criticalMessages = messagesData.where((msg) => msg["priority"] == "Critical").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Team Messaging"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Messages", totalMessages.toString(), Icons.message, primaryColor),
                _buildStatCard("Unread", unreadMessages.toString(), Icons.mark_email_unread, warningColor),
                _buildStatCard("Pinned", pinnedMessages.toString(), Icons.push_pin, infoColor),
                _buildStatCard("Critical", criticalMessages.toString(), Icons.priority_high, dangerColor),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Messages",
                    value: searchQuery,
                    hint: "Search by message content, sender, or channel...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Channel",
                          items: [
                            {"label": "All Channels", "value": "All"},
                            {"label": "General Discussion", "value": "General Discussion"},
                            {"label": "Engineering Team", "value": "Engineering Team"},
                            {"label": "Site Updates", "value": "Site Updates"},
                            {"label": "Safety Alerts", "value": "Safety Alerts"},
                            {"label": "Quality Control", "value": "Quality Control"},
                            {"label": "Procurement Updates", "value": "Procurement Updates"},
                          ],
                          value: selectedChannel,
                          onChanged: (value, label) {
                            selectedChannel = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "All"},
                            {"label": "Highway Bridge", "value": "Highway Bridge"},
                            {"label": "City Mall", "value": "City Mall"},
                            {"label": "Residential Complex", "value": "Residential Complex"},
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "All"},
                            {"label": "Delivered", "value": "Delivered"},
                            {"label": "Read", "value": "Read"},
                            {"label": "Sending", "value": "Sending"},
                            {"label": "Failed", "value": "Failed"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Messages List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredMessages.map((message) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: message["is_pinned"] == true 
                        ? Border.all(color: primaryColor.withAlpha(50), width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header with Sender Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${message["sender_avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${message["sender"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    if (message["is_pinned"] == true)
                                      Icon(
                                        Icons.push_pin,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                  ],
                                ),
                                Text(
                                  "${message["sender_role"]} • ${message["channel"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getMessageTypeColor(message["message_type"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getMessageTypeIcon(message["message_type"]),
                                  size: 12,
                                  color: _getMessageTypeColor(message["message_type"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${message["message_type"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getMessageTypeColor(message["message_type"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Priority and Status
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(message["priority"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${message["priority"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getPriorityColor(message["priority"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(message["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${message["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(message["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Message Content
                      Text(
                        "${message["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),

                      // Attachments
                      if ((message["attachments"] as List).isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Attachments:",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              ...(message["attachments"] as List).map((attachment) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Text(
                                        _getFileIcon(attachment["type"]),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${attachment["name"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "${attachment["size"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                      // Reactions
                      if ((message["reactions"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          children: (message["reactions"] as List).map((reaction) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${reaction["emoji"]}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${reaction["count"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                      // Timestamp and Read Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${message["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Read by ${message["read_by"]}/${message["total_members"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Mentions and Tags
                      if ((message["mentions"] as List).isNotEmpty || (message["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          children: [
                            ...(message["mentions"] as List).map((mention) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$mention",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            ...(message["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "#$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),

                      // Replies Count
                      if ((message["replies"] as int) > 0)
                        Row(
                          children: [
                            Icon(Icons.reply, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "${message["replies"]} replies",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                      // Actions
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Reply",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "React",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Share",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
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
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
