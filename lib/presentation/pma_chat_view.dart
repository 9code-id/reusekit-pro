import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaChatView extends StatefulWidget {
  const PmaChatView({super.key});

  @override
  State<PmaChatView> createState() => _PmaChatViewState();
}

class _PmaChatViewState extends State<PmaChatView> {
  String message = "";
  List<String> attachments = [];
  String selectedChannel = "general";
  bool isTyping = false;

  List<Map<String, dynamic>> channels = [
    {"label": "# general", "value": "general"},
    {"label": "# project-updates", "value": "project-updates"},
    {"label": "# design-team", "value": "design-team"},
    {"label": "# dev-team", "value": "dev-team"},
    {"label": "# random", "value": "random"},
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1",
        "role": "Project Manager",
        "status": "online"
      },
      "content": "Hey team! Just wanted to give you all an update on the mobile app project. We're making great progress and should be ready for the next milestone review by Friday.",
      "timestamp": "2024-01-15T10:30:00Z",
      "type": "text",
      "reactions": [
        {"emoji": "👍", "count": 3, "users": ["Alex Chen", "Mike Wilson", "Emma Davis"]},
        {"emoji": "🎉", "count": 2, "users": ["David Lee", "Lisa Wang"]},
      ],
      "thread_count": 0,
      "is_edited": false,
    },
    {
      "id": "2",
      "user": {
        "name": "Alex Chen",
        "avatar": "https://picsum.photos/40/40?random=2",
        "role": "UI Designer",
        "status": "online"
      },
      "content": "That's awesome! I've just finished the new wireframes for the user authentication flow. Would love to get feedback from everyone.",
      "timestamp": "2024-01-15T10:35:00Z",
      "type": "text",
      "attachments": [
        {
          "name": "auth_wireframes.fig",
          "type": "design",
          "size": "2.3 MB",
          "url": "https://example.com/file1"
        }
      ],
      "reactions": [
        {"emoji": "👏", "count": 4, "users": ["Sarah Johnson", "Mike Wilson", "Emma Davis", "David Lee"]},
      ],
      "thread_count": 2,
      "is_edited": false,
    },
    {
      "id": "3",
      "user": {
        "name": "Mike Wilson",
        "avatar": "https://picsum.photos/40/40?random=3",
        "role": "Developer",
        "status": "away"
      },
      "content": "Looking good! I'll start implementing the backend for the auth system this week. Should have the API endpoints ready by Wednesday.",
      "timestamp": "2024-01-15T10:42:00Z",
      "type": "text",
      "reactions": [],
      "thread_count": 0,
      "is_edited": true,
    },
    {
      "id": "4",
      "user": {
        "name": "Emma Davis",
        "avatar": "https://picsum.photos/40/40?random=4",
        "role": "QA Engineer",
        "status": "online"
      },
      "content": "Perfect timing! I've prepared the test cases for the authentication module. I'll share the document later today.",
      "timestamp": "2024-01-15T10:45:00Z",
      "type": "text",
      "reactions": [
        {"emoji": "✅", "count": 2, "users": ["Sarah Johnson", "Alex Chen"]},
      ],
      "thread_count": 1,
      "is_edited": false,
    },
    {
      "id": "5",
      "user": {
        "name": "David Lee",
        "avatar": "https://picsum.photos/40/40?random=5",
        "role": "Tech Lead",
        "status": "online"
      },
      "content": "Great collaboration everyone! Let's schedule a quick sync tomorrow to align on the implementation details.",
      "timestamp": "2024-01-15T10:50:00Z",
      "type": "text",
      "reactions": [
        {"emoji": "📅", "count": 5, "users": ["Sarah Johnson", "Alex Chen", "Mike Wilson", "Emma Davis", "Lisa Wang"]},
      ],
      "thread_count": 0,
      "is_edited": false,
    },
  ];

  List<Map<String, dynamic>> onlineUsers = [
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/30/30?random=1",
      "status": "online",
      "role": "Project Manager"
    },
    {
      "name": "Alex Chen",
      "avatar": "https://picsum.photos/30/30?random=2",
      "status": "online",
      "role": "UI Designer"
    },
    {
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/30/30?random=4",
      "status": "online",
      "role": "QA Engineer"
    },
    {
      "name": "David Lee",
      "avatar": "https://picsum.photos/30/30?random=5",
      "status": "online",
      "role": "Tech Lead"
    },
    {
      "name": "Mike Wilson",
      "avatar": "https://picsum.photos/30/30?random=3",
      "status": "away",
      "role": "Developer"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chat"),
            Text(
              "#${selectedChannel}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show channel info
            },
            icon: Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              // Chat settings
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildChannelSelector(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _buildChatArea(),
                ),
                Container(
                  width: 280,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: disabledColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: _buildSidebar(),
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChannelSelector() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.tag,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Channel",
              items: channels,
              value: selectedChannel,
              onChanged: (value, label) {
                selectedChannel = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spMd),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "${onlineUsers.where((user) => user["status"] == "online").length} online",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildDateDivider("Today"),
                  ...messages.map((msg) => _buildMessageItem(msg)),
                  if (isTyping) _buildTypingIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Team Members",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: onlineUsers.length,
              itemBuilder: (context, index) {
                final user = onlineUsers[index];
                return _buildUserItem(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserItem(Map<String, dynamic> user) {
    Color statusColor = user["status"] == "online" ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: disabledColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${user["avatar"]}",
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user["name"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${user["role"]}",
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
    );
  }

  Widget _buildDateDivider(String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spMd),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: disabledColor,
              thickness: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.symmetric(
              horizontal: spMd,
              vertical: spSm,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: disabledColor,
                width: 1,
              ),
            ),
            child: Text(
              date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: disabledColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> msg) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusLg),
            child: Image.network(
              "${msg["user"]["avatar"]}",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
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
                    Text(
                      "${msg["user"]["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${msg["user"]["role"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "10:30 AM",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (msg["is_edited"] as bool)
                      Container(
                        margin: EdgeInsets.only(left: spSm),
                        child: Text(
                          "(edited)",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
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
                        "${msg["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                      if ((msg["attachments"] as List?)?.isNotEmpty ?? false)
                        ...(msg["attachments"] as List).map((attachment) {
                          return _buildAttachment(attachment);
                        }),
                    ],
                  ),
                ),
                if ((msg["reactions"] as List).isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: spSm),
                    child: Wrap(
                      spacing: spSm,
                      children: (msg["reactions"] as List).map((reaction) {
                        return _buildReaction(reaction);
                      }).toList(),
                    ),
                  ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Add reaction
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        child: Text(
                          "😊",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    if ((msg["thread_count"] as int) > 0)
                      GestureDetector(
                        onTap: () {
                          // Open thread
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          child: Text(
                            "${msg["thread_count"]} replies",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // More options
                      },
                      child: Icon(
                        Icons.more_horiz,
                        size: 16,
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
    );
  }

  Widget _buildAttachment(Map<String, dynamic> attachment) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: primaryColor.withAlpha(76),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getAttachmentIcon(attachment["type"] as String),
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attachment["name"]}",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${attachment["size"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              // Download attachment
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReaction(Map<String, dynamic> reaction) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: primaryColor.withAlpha(76),
          width: 1,
        ),
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
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(top: spMd),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Someone is typing",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: spSm),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: QChatField(
        label: "Type a message...",
        value: message,
        attachments: attachments,
        showAttachmentButton: true,
        showEmojiButton: true,
        showVoiceButton: true,
        onChanged: (value) {
          message = value;
          setState(() {});
        },
        onSend: () {
          if (message.isNotEmpty || attachments.isNotEmpty) {
            // Send message
            message = "";
            attachments = [];
            setState(() {});
            ss("Message sent!");
          }
        },
        onAttachmentsChanged: (value) {
          attachments = value;
          setState(() {});
        },
      ),
    );
  }

  IconData _getAttachmentIcon(String type) {
    switch (type) {
      case 'design':
        return Icons.brush;
      case 'document':
        return Icons.description;
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.play_circle;
      default:
        return Icons.attach_file;
    }
  }
}
