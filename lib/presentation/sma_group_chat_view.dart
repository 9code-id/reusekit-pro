import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaGroupChatView extends StatefulWidget {
  const SmaGroupChatView({super.key});

  @override
  State<SmaGroupChatView> createState() => _SmaGroupChatViewState();
}

class _SmaGroupChatViewState extends State<SmaGroupChatView> {
  String messageText = "";
  List<String> attachments = [];
  bool isTyping = false;

  Map<String, dynamic> groupInfo = {
    "id": "group_1",
    "name": "Weekend Warriors",
    "avatar": "https://picsum.photos/60/60?random=20&keyword=group",
    "description": "Planning our next adventure!",
    "memberCount": 8,
    "isOnline": true,
    "lastSeen": "Active now",
    "members": [
      {
        "id": "1",
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=21&keyword=woman",
        "isOnline": true,
        "role": "admin",
      },
      {
        "id": "2", 
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/40/40?random=22&keyword=man",
        "isOnline": true,
        "role": "member",
      },
      {
        "id": "3",
        "name": "Emma Wilson",
        "avatar": "https://picsum.photos/40/40?random=23&keyword=person",
        "isOnline": false,
        "role": "member",
      },
      {
        "id": "4",
        "name": "John Smith",
        "avatar": "https://picsum.photos/40/40?random=24&keyword=person",
        "isOnline": true,
        "role": "member",
      },
    ],
  };

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "senderId": "2",
      "senderName": "Mike Chen",
      "senderAvatar": "https://picsum.photos/40/40?random=22&keyword=man",
      "text": "Hey everyone! Who's up for hiking this weekend?",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "type": "text",
      "isMe": false,
      "reactions": [
        {"emoji": "👍", "count": 3, "users": ["1", "3", "4"]},
        {"emoji": "🔥", "count": 1, "users": ["1"]},
      ],
    },
    {
      "id": "2",
      "senderId": "1",
      "senderName": "Sarah Johnson",
      "senderAvatar": "https://picsum.photos/40/40?random=21&keyword=woman",
      "text": "Count me in! I found this amazing trail near the lake",
      "timestamp": DateTime.now().subtract(Duration(hours: 1, minutes: 45)),
      "type": "text",
      "isMe": false,
      "reactions": [],
    },
    {
      "id": "3",
      "senderId": "current_user",
      "senderName": "You",
      "senderAvatar": "https://picsum.photos/40/40?random=25&keyword=user",
      "text": "Sounds perfect! What time should we meet?",
      "timestamp": DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
      "type": "text",
      "isMe": true,
      "reactions": [],
    },
    {
      "id": "4",
      "senderId": "3",
      "senderName": "Emma Wilson",
      "senderAvatar": "https://picsum.photos/40/40?random=23&keyword=person",
      "text": "",
      "timestamp": DateTime.now().subtract(Duration(hours: 1, minutes: 15)),
      "type": "image",
      "imageUrl": "https://picsum.photos/400/300?random=30&keyword=hiking",
      "isMe": false,
      "reactions": [
        {"emoji": "😍", "count": 4, "users": ["1", "2", "4", "current_user"]},
      ],
    },
    {
      "id": "5",
      "senderId": "4",
      "senderName": "John Smith", 
      "senderAvatar": "https://picsum.photos/40/40?random=24&keyword=person",
      "text": "That view looks incredible! How about 8 AM at the parking lot?",
      "timestamp": DateTime.now().subtract(Duration(minutes: 45)),
      "type": "text",
      "isMe": false,
      "reactions": [],
    },
    {
      "id": "6",
      "senderId": "current_user",
      "senderName": "You",
      "senderAvatar": "https://picsum.photos/40/40?random=25&keyword=user",
      "text": "Perfect timing! I'll bring snacks for everyone 🥪",
      "timestamp": DateTime.now().subtract(Duration(minutes: 10)),
      "type": "text",
      "isMe": true,
      "reactions": [
        {"emoji": "🙏", "count": 2, "users": ["1", "2"]},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("${groupInfo["avatar"]}"),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${groupInfo["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${groupInfo["memberCount"]} members",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              //navigateTo(SmaVideoCallView(isGroup: true, groupInfo: groupInfo));
            },
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              //navigateTo(SmaVoiceCallView(isGroup: true, groupInfo: groupInfo));
            },
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showGroupInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessage(message, index);
              },
            ),
          ),
          
          // Typing Indicator
          if (isTyping)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage("https://picsum.photos/40/40?random=26&keyword=typing"),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Mike is typing...",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          
          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Attachments Preview
                if (attachments.isNotEmpty)
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(bottom: spSm),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: attachments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          margin: EdgeInsets.only(right: spXs),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXs),
                            image: DecorationImage(
                              image: NetworkImage(attachments[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    attachments.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
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
                
                // Input Row
                Row(
                  children: [
                    // Attachment Button
                    GestureDetector(
                      onTap: () {
                        _showAttachmentOptions();
                      },
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Text Input
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            messageText = value;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: disabledBoldColor),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    // Send Button
                    GestureDetector(
                      onTap: messageText.isNotEmpty || attachments.isNotEmpty
                          ? () {
                              _sendMessage();
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: messageText.isNotEmpty || attachments.isNotEmpty
                              ? primaryColor
                              : disabledColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
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

  Widget _buildMessage(Map<String, dynamic> message, int index) {
    final isMe = message["isMe"] as bool;
    final showAvatar = !isMe && (index == 0 || messages[index - 1]["senderId"] != message["senderId"]);
    final showName = !isMe && showAvatar;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar (for others)
          if (!isMe) ...[
            if (showAvatar)
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage("${message["senderAvatar"]}"),
              )
            else
              SizedBox(width: 32),
            SizedBox(width: spXs),
          ],
          
          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Sender Name
                if (showName)
                  Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Text(
                      "${message["senderName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                
                // Message Bubble
                GestureDetector(
                  onLongPress: () {
                    _showMessageOptions(message);
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isMe ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: !isMe ? Border.all(color: disabledOutlineBorderColor) : null,
                      boxShadow: [shadowXs],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message Content
                        if (message["type"] == "text")
                          Text(
                            "${message["text"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isMe ? Colors.white : primaryColor,
                            ),
                          )
                        else if (message["type"] == "image")
                          Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${message["imageUrl"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: Container(),
                            ),
                          ),
                        
                        SizedBox(height: spXs),
                        
                        // Timestamp
                        Text(
                          "${(message["timestamp"] as DateTime).kkmm}",
                          style: TextStyle(
                            fontSize: 10,
                            color: isMe ? Colors.white.withAlpha(180) : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Reactions
                if ((message["reactions"] as List).isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: spXs),
                    child: Wrap(
                      spacing: spXs,
                      children: (message["reactions"] as List).map<Widget>((reaction) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(color: primaryColor.withAlpha(40)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${reaction["emoji"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${reaction["count"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
          
          // Spacing for sent messages
          if (isMe) SizedBox(width: 32),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageText.isNotEmpty || attachments.isNotEmpty) {
      final newMessage = {
        "id": "${messages.length + 1}",
        "senderId": "current_user",
        "senderName": "You",
        "senderAvatar": "https://picsum.photos/40/40?random=25&keyword=user",
        "text": messageText,
        "timestamp": DateTime.now(),
        "type": attachments.isNotEmpty ? "image" : "text",
        "imageUrl": attachments.isNotEmpty ? attachments[0] : null,
        "isMe": true,
        "reactions": [],
      };
      
      messages.add(newMessage);
      messageText = "";
      attachments.clear();
      setState(() {});
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add to message",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(Icons.photo, "Photo", () {
                  attachments.add("https://picsum.photos/400/300?random=${attachments.length + 31}&keyword=photo");
                  Navigator.pop(context);
                  setState(() {});
                }),
                _buildAttachmentOption(Icons.videocam, "Video", () {
                  Navigator.pop(context);
                }),
                _buildAttachmentOption(Icons.file_present, "File", () {
                  Navigator.pop(context);
                }),
                _buildAttachmentOption(Icons.location_on, "Location", () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageOptions(Map<String, dynamic> message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add_reaction),
              title: Text("Add Reaction"),
              onTap: () {
                Navigator.pop(context);
                _showReactionPicker(message);
              },
            ),
            ListTile(
              leading: Icon(Icons.reply),
              title: Text("Reply"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Copy"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            if (message["isMe"] as bool)
              ListTile(
                leading: Icon(Icons.delete, color: dangerColor),
                title: Text("Delete", style: TextStyle(color: dangerColor)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showReactionPicker(Map<String, dynamic> message) {
    final reactions = ["👍", "❤️", "😂", "😮", "😢", "😡"];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("React to message"),
        content: Wrap(
          spacing: spSm,
          children: reactions.map((emoji) => GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Add reaction logic here
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                emoji,
                style: TextStyle(fontSize: 24),
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Group Header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${groupInfo["avatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${groupInfo["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${groupInfo["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Members List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Members (${groupInfo["memberCount"]})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (groupInfo["members"] as List).length,
                      itemBuilder: (context, index) {
                        final member = (groupInfo["members"] as List)[index];
                        return ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("${member["avatar"]}"),
                              ),
                              if (member["isOnline"] as bool)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          title: Text("${member["name"]}"),
                          subtitle: Text(
                            member["role"] == "admin" ? "Group Admin" : "Member",
                            style: TextStyle(
                              color: member["role"] == "admin" ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          trailing: member["role"] == "admin" 
                            ? Icon(Icons.admin_panel_settings, color: primaryColor)
                            : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
