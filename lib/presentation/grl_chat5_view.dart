import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat5View extends StatefulWidget {
  @override
  State<GrlChat5View> createState() => _GrlChat5ViewState();
}

class _GrlChat5ViewState extends State<GrlChat5View> {
  String message = "";
  List<String> messageAttachments = [];
  bool isRecording = false;
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Good morning! Ready for today's standup?",
      "timestamp": "2024-01-15 09:00:00",
      "isMe": false,
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
        "role": "Team Lead"
      },
      "type": "text",
      "reactions": [
        {"emoji": "👍", "count": 3, "users": ["Mike", "Emma", "David"]},
        {"emoji": "😊", "count": 1, "users": ["Alex"]}
      ]
    },
    {
      "id": "2",
      "message": "Absolutely! I've got some exciting updates to share.",
      "timestamp": "2024-01-15 09:02:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text",
      "reactions": []
    },
    {
      "id": "3",
      "message": "",
      "timestamp": "2024-01-15 09:05:00",
      "isMe": false,
      "user": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=man",
        "role": "Developer"
      },
      "type": "voice",
      "voiceDuration": "0:45",
      "voiceUrl": "voice_message_1.mp3",
      "reactions": [
        {"emoji": "🎵", "count": 2, "users": ["Sarah", "Emma"]}
      ]
    },
    {
      "id": "4",
      "message": "Here's the design mockup we discussed yesterday",
      "timestamp": "2024-01-15 09:10:00",
      "isMe": false,
      "user": {
        "name": "Emma Davis",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=designer",
        "role": "UI Designer"
      },
      "type": "image",
      "imageUrl": "https://picsum.photos/300/200?random=10&keyword=mockup",
      "reactions": [
        {"emoji": "🔥", "count": 4, "users": ["Sarah", "Mike", "David", "Alex"]},
        {"emoji": "👏", "count": 2, "users": ["Sarah", "You"]}
      ]
    },
    {
      "id": "5",
      "message": "This looks amazing! The color scheme is perfect 🎨",
      "timestamp": "2024-01-15 09:12:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text",
      "reactions": [
        {"emoji": "❤️", "count": 1, "users": ["Emma"]}
      ]
    },
    {
      "id": "6",
      "message": "Team meeting agenda and notes",
      "timestamp": "2024-01-15 09:15:00",
      "isMe": false,
      "user": {
        "name": "David Wilson",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=manager",
        "role": "Project Manager"
      },
      "type": "file",
      "fileName": "Meeting_Agenda_Jan15.pdf",
      "fileSize": "1.2 MB",
      "fileUrl": "meeting_agenda.pdf",
      "reactions": [
        {"emoji": "📝", "count": 3, "users": ["Sarah", "Mike", "Emma"]}
      ]
    }
  ];

  List<String> quickReplies = [
    "👍 Great!",
    "✅ Done",
    "❓ Question",
    "⏰ Later",
    "📞 Call me",
    "💡 Idea"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.groups,
                color: primaryColor,
                size: 18,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Development Team",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "5 members, 4 online",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              si("Search messages");
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showChatOptions();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Quick Replies Bar
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: quickReplies.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _sendQuickReply(quickReplies[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        quickReplies[index],
                        style: TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Messages Area
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageData = messages[index];
                final isMe = messageData["isMe"] as bool;
                final messageType = messageData["type"] as String;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: _buildMessage(messageData, isMe, messageType, index),
                );
              },
            ),
          ),
          
          // Message Input Area
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
            child: Row(
              children: [
                // Attachment Button
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    _showAttachmentOptions();
                  },
                ),
                SizedBox(width: spSm),
                
                // Text Input
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (value) {
                              message = value;
                              setState(() {});
                            },
                            maxLines: null,
                          ),
                        ),
                        QButton(
                          icon: Icons.emoji_emotions,
                          size: bs.sm,
                          onPressed: () {
                            si("Show emoji picker");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(width: spSm),
                
                // Voice/Send Button
                QButton(
                  icon: message.isEmpty ? Icons.mic : Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    if (message.isEmpty) {
                      _toggleVoiceRecording();
                    } else {
                      _sendMessage(message);
                      message = "";
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> messageData, bool isMe, String messageType, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
          SizedBox(width: spSm),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsets.only(bottom: spXs, left: spXs),
                  child: Row(
                    children: [
                      Text(
                        "${messageData["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      if (messageData["user"]["role"] != null) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${messageData["user"]["role"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              
              // Message Content
              _buildMessageContent(messageData, isMe, messageType),
              
              // Reactions
              if (messageData["reactions"] != null && (messageData["reactions"] as List).isNotEmpty)
                _buildReactions(messageData["reactions"] as List, index),
              
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (isMe) ...[
          SizedBox(width: spSm),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
        ],
      ],
    );
  }

  Widget _buildMessageContent(Map<String, dynamic> messageData, bool isMe, String messageType) {
    switch (messageType) {
      case "text":
        return Container(
          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
          decoration: BoxDecoration(
            color: isMe ? primaryColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Text(
            "${messageData["message"]}",
            style: TextStyle(
              fontSize: 14,
              color: isMe ? Colors.white : Colors.black87,
            ),
          ),
        );
      
      case "voice":
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: isMe ? primaryColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              QButton(
                icon: Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  si("Playing voice message");
                },
              ),
              SizedBox(width: spSm),
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: isMe ? Colors.white.withAlpha(50) : primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Center(
                  child: Container(
                    height: 2,
                    width: 80,
                    decoration: BoxDecoration(
                      color: isMe ? Colors.white : primaryColor,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${messageData["voiceDuration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        );
      
      case "image":
        return Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: isMe ? primaryColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            children: [
              if (messageData["message"] != null && messageData["message"].toString().isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(bottom: spXs),
                  child: Text(
                    "${messageData["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: Image.network(
                  "${messageData["imageUrl"]}",
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      
      case "file":
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: isMe ? primaryColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.description,
                color: isMe ? Colors.white : primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${messageData["fileName"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    "${messageData["fileSize"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isMe ? Colors.white.withAlpha(180) : disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  si("Downloading ${messageData["fileName"]}");
                },
              ),
            ],
          ),
        );
      
      default:
        return Container();
    }
  }

  Widget _buildReactions(List reactions, int messageIndex) {
    return Container(
      margin: EdgeInsets.only(top: spXs),
      child: Wrap(
        spacing: spXs,
        children: reactions.map<Widget>((reaction) {
          return GestureDetector(
            onTap: () {
              _showReactionUsers(reaction["users"] as List<String>);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    reaction["emoji"],
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: 2),
                  Text(
                    "${reaction["count"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _sendMessage(String text) {
    final newMessage = {
      "id": "${messages.length + 1}",
      "message": text,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text",
      "reactions": []
    };
    
    messages.add(newMessage);
    setState(() {});
  }

  void _sendQuickReply(String reply) {
    _sendMessage(reply);
  }

  void _toggleVoiceRecording() {
    isRecording = !isRecording;
    setState(() {});
    
    if (isRecording) {
      si("Recording voice message...");
      // Simulate recording for 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        isRecording = false;
        setState(() {});
        
        final voiceMessage = {
          "id": "${messages.length + 1}",
          "message": "",
          "timestamp": DateTime.now().toIso8601String(),
          "isMe": true,
          "user": {
            "name": "You",
            "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
          },
          "type": "voice",
          "voiceDuration": "0:03",
          "voiceUrl": "voice_message_new.mp3",
          "reactions": []
        };
        
        messages.add(voiceMessage);
        setState(() {});
        ss("Voice message sent!");
      });
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Share",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(Icons.photo, "Photo", () {
                  Navigator.pop(context);
                  si("Select photo");
                }),
                _buildAttachmentOption(Icons.videocam, "Video", () {
                  Navigator.pop(context);
                  si("Select video");
                }),
                _buildAttachmentOption(Icons.insert_drive_file, "Document", () {
                  Navigator.pop(context);
                  si("Select document");
                }),
                _buildAttachmentOption(Icons.location_on, "Location", () {
                  Navigator.pop(context);
                  si("Share location");
                }),
              ],
            ),
            SizedBox(height: spLg),
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
            width: 50,
            height: 50,
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

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Chat Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people, color: primaryColor),
              title: Text("View Members"),
              onTap: () {
                Navigator.pop(context);
                si("View chat members");
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: primaryColor),
              title: Text("Search Messages"),
              onTap: () {
                Navigator.pop(context);
                si("Search in chat");
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: primaryColor),
              title: Text("Notifications"),
              onTap: () {
                Navigator.pop(context);
                si("Chat notifications settings");
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: dangerColor),
              title: Text("Block Chat"),
              onTap: () {
                Navigator.pop(context);
                sw("Chat blocked");
              },
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showReactionUsers(List<String> users) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reactions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: users.map((user) => Text(user)).toList(),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
