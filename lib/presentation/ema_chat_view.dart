import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaChatView extends StatefulWidget {
  const EmaChatView({super.key});

  @override
  State<EmaChatView> createState() => _EmaChatViewState();
}

class _EmaChatViewState extends State<EmaChatView> {
  String messageText = "";
  List<String> attachments = [];
  String selectedContact = "Dr. Sarah Wilson";
  
  List<Map<String, dynamic>> contacts = [
    {
      "id": 1,
      "name": "Dr. Sarah Wilson",
      "role": "Primary Therapist",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "status": "online",
      "lastSeen": "Now",
      "unreadCount": 2,
    },
    {
      "id": 2,
      "name": "Research Team",
      "role": "EMA Coordinators",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=team",
      "status": "offline",
      "lastSeen": "2 hours ago",
      "unreadCount": 0,
    },
    {
      "id": 3,
      "name": "Support Group",
      "role": "Peer Support",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=group",
      "status": "online",
      "lastSeen": "5 minutes ago",
      "unreadCount": 1,
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "sender": "Dr. Sarah Wilson",
      "message": "Hello! How are you feeling today? I noticed you completed your morning assessment.",
      "timestamp": "2025-06-18 09:15",
      "isMe": false,
      "type": "text",
      "status": "read",
    },
    {
      "id": 2,
      "sender": "You",
      "message": "Hi Dr. Wilson! I'm feeling much better today. The morning routine really helps.",
      "timestamp": "2025-06-18 09:18",
      "isMe": true,
      "type": "text",
      "status": "delivered",
    },
    {
      "id": 3,
      "sender": "Dr. Sarah Wilson",
      "message": "That's wonderful to hear! Your consistency with the assessments has been remarkable. Keep up the great work! 👏",
      "timestamp": "2025-06-18 09:22",
      "isMe": false,
      "type": "text",
      "status": "read",
    },
    {
      "id": 4,
      "sender": "You",
      "message": "Thank you! I have a question about the evening reflection assessment.",
      "timestamp": "2025-06-18 09:25",
      "isMe": true,
      "type": "text",
      "status": "delivered",
    },
    {
      "id": 5,
      "sender": "Dr. Sarah Wilson",
      "message": "Of course! What would you like to know about it?",
      "timestamp": "2025-06-18 09:27",
      "isMe": false,
      "type": "text",
      "status": "read",
    },
    {
      "id": 6,
      "sender": "You",
      "message": "Sometimes I feel like my responses might not be accurate. Is that normal?",
      "timestamp": "2025-06-18 09:30",
      "isMe": true,
      "type": "text",
      "status": "sending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                contacts.firstWhere((c) => c["name"] == selectedContact)["avatar"],
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedContact,
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    contacts.firstWhere((c) => c["name"] == selectedContact)["role"],
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
              // navigateTo('VideoCallView')
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // navigateTo('VoiceCallView')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // navigateTo('ChatSettingsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Contact Selector
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QHorizontalScroll(
              children: contacts.map((contact) {
                bool isSelected = contact["name"] == selectedContact;
                
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedContact = contact["name"];
                      setState(() {});
                    },
                    child: Container(
                      width: 240,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor.withAlpha(15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage("${contact["avatar"]}"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: contact["status"] == "online" 
                                        ? successColor 
                                        : disabledBoldColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${contact["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? primaryColor : Colors.black,
                                  ),
                                ),
                                Text(
                                  "${contact["role"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if ((contact["unreadCount"] as int) > 0)
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "${contact["unreadCount"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
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

          // Messages List
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> message = messages[index];
                  bool isMe = message["isMe"];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      mainAxisAlignment: isMe 
                          ? MainAxisAlignment.end 
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMe) ...[
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              contacts.firstWhere((c) => c["name"] == selectedContact)["avatar"],
                            ),
                          ),
                          SizedBox(width: spSm),
                        ],
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isMe ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                if (!isMe)
                                  Text(
                                    "${message["sender"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                Text(
                                  "${message["message"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isMe ? Colors.white : Colors.black,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${message["timestamp"].toString().split(' ')[1].substring(0, 5)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isMe 
                                            ? Colors.white.withAlpha(180) 
                                            : disabledBoldColor,
                                      ),
                                    ),
                                    if (isMe) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        _getStatusIcon(message["status"]),
                                        size: 12,
                                        color: Colors.white.withAlpha(180),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isMe) ...[
                          SizedBox(width: spSm),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: primaryColor,
                            child: Text(
                              "ME",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                if (attachments.isNotEmpty)
                  Container(
                    height: 60,
                    child: QHorizontalScroll(
                      children: attachments.map((attachment) {
                        return Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(attachment),
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
                                    attachments.remove(attachment);
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
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                QChatField(
                  label: "Message",
                  value: messageText,
                  hint: "Type your message...",
                  attachments: attachments,
                  showAttachmentButton: true,
                  showEmojiButton: true,
                  showVoiceButton: true,
                  onChanged: (value) {
                    messageText = value;
                    setState(() {});
                  },
                  onSend: () {
                    if (messageText.isNotEmpty || attachments.isNotEmpty) {
                      _sendMessage();
                    }
                  },
                  onAttachmentsChanged: (value) {
                    attachments = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageText.trim().isEmpty && attachments.isEmpty) return;

    Map<String, dynamic> newMessage = {
      "id": messages.length + 1,
      "sender": "You",
      "message": messageText.isNotEmpty ? messageText : "Sent an attachment",
      "timestamp": DateTime.now().toString(),
      "isMe": true,
      "type": attachments.isNotEmpty ? "attachment" : "text",
      "status": "sending",
      "attachments": List.from(attachments),
    };

    setState(() {
      messages.add(newMessage);
      messageText = "";
      attachments.clear();
    });

    // Simulate message delivery
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.last["status"] = "delivered";
      });
    });

    // Simulate read receipt
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "read";
      });
    });

    // Simulate response from therapist
    if (selectedContact == "Dr. Sarah Wilson") {
      Future.delayed(Duration(seconds: 5), () {
        Map<String, dynamic> responseMessage = {
          "id": messages.length + 1,
          "sender": "Dr. Sarah Wilson",
          "message": "Thank you for sharing that with me. That's completely normal and shows great self-awareness!",
          "timestamp": DateTime.now().toString(),
          "isMe": false,
          "type": "text",
          "status": "read",
        };

        setState(() {
          messages.add(responseMessage);
        });
      });
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "sending":
        return Icons.access_time;
      case "delivered":
        return Icons.check;
      case "read":
        return Icons.done_all;
      default:
        return Icons.check;
    }
  }
}
