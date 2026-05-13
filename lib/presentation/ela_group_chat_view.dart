import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaGroupChatView extends StatefulWidget {
  const ElaGroupChatView({super.key});

  @override
  State<ElaGroupChatView> createState() => _ElaGroupChatViewState();
}

class _ElaGroupChatViewState extends State<ElaGroupChatView> {
  String message = "";
  List<String> messageAttachments = [];

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "sender": "Dr. Sarah Johnson",
      "message": "Welcome everyone to our Advanced Calculus study group! Let's start with today's discussion on integration techniques.",
      "timestamp": "2024-01-15 09:00:00",
      "isMe": false,
      "isModerator": true,
      "avatar": "https://picsum.photos/40/40?random=1&keyword=teacher",
      "attachments": [],
    },
    {
      "id": 2,
      "sender": "You",
      "message": "Thank you Dr. Johnson! I have a question about integration by parts.",
      "timestamp": "2024-01-15 09:02:00",
      "isMe": true,
      "isModerator": false,
      "avatar": "https://picsum.photos/40/40?random=me&keyword=student",
      "attachments": [],
    },
    {
      "id": 3,
      "sender": "Mike Chen",
      "message": "I was wondering about that too. Could you explain when to use substitution vs integration by parts?",
      "timestamp": "2024-01-15 09:03:00",
      "isMe": false,
      "isModerator": false,
      "avatar": "https://picsum.photos/40/40?random=2&keyword=student",
      "attachments": [],
    },
    {
      "id": 4,
      "sender": "Dr. Sarah Johnson",
      "message": "Great questions! Let me share a document that explains the decision process.",
      "timestamp": "2024-01-15 09:05:00",
      "isMe": false,
      "isModerator": true,
      "avatar": "https://picsum.photos/40/40?random=1&keyword=teacher",
      "attachments": ["Integration_Techniques_Guide.pdf"],
    },
    {
      "id": 5,
      "sender": "Emma Davis",
      "message": "This is really helpful! I've been struggling with these concepts.",
      "timestamp": "2024-01-15 09:07:00",
      "isMe": false,
      "isModerator": false,
      "avatar": "https://picsum.photos/40/40?random=3&keyword=student",
      "attachments": [],
    },
    {
      "id": 6,
      "sender": "Alex Rodriguez",
      "message": "Can we schedule a practice session for tomorrow? I found some challenging problems we could work through together.",
      "timestamp": "2024-01-15 09:10:00",
      "isMe": false,
      "isModerator": false,
      "avatar": "https://picsum.photos/40/40?random=4&keyword=student",
      "attachments": ["Practice_Problems_Set_3.pdf"],
    },
    {
      "id": 7,
      "sender": "You",
      "message": "That sounds great! I'm available after 3 PM tomorrow.",
      "timestamp": "2024-01-15 09:12:00",
      "isMe": true,
      "isModerator": false,
      "avatar": "https://picsum.photos/40/40?random=me&keyword=student",
      "attachments": [],
    },
  ];

  List<Map<String, dynamic>> onlineMembers = [
    {
      "name": "Dr. Sarah Johnson",
      "role": "Moderator",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=teacher",
      "isOnline": true,
    },
    {
      "name": "Mike Chen",
      "role": "Member",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=student",
      "isOnline": true,
    },
    {
      "name": "Emma Davis",
      "role": "Member",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=student",
      "isOnline": true,
    },
    {
      "name": "Alex Rodriguez",
      "role": "Member",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=student",
      "isOnline": false,
    },
    {
      "name": "Lisa Thompson",
      "role": "Member",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=student",
      "isOnline": true,
    },
  ];

  void _sendMessage() {
    if (message.trim().isNotEmpty || messageAttachments.isNotEmpty) {
      setState(() {
        messages.add({
          "id": messages.length + 1,
          "sender": "You",
          "message": message.trim(),
          "timestamp": DateTime.now().toString(),
          "isMe": true,
          "isModerator": false,
          "avatar": "https://picsum.photos/40/40?random=me&keyword=student",
          "attachments": List.from(messageAttachments),
        });
        message = "";
        messageAttachments = [];
      });
    }
  }

  void _showGroupInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Group Members",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...onlineMembers.map((member) {
              return Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${member["avatar"]}"),
                        ),
                        if (member["isOnline"] as bool)
                          Positioned(
                            right: 0,
                            bottom: 0,
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
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${member["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${member["role"]}",
                            style: TextStyle(
                              color: member["role"] == "Moderator" ? primaryColor : disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: member["isOnline"] as bool ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        member["isOnline"] as bool ? "Online" : "Offline",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Advanced Calculus Study Group"),
            Text(
              "${onlineMembers.where((m) => m["isOnline"] as bool).length} online",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showGroupInfo,
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // navigateTo('VideoCallView')
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
                final msg = messages[index];
                final isMe = msg["isMe"] as bool;
                final isModerator = msg["isModerator"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isMe) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${msg["avatar"]}"),
                        ),
                        SizedBox(width: spXs),
                      ],
                      
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isMe ? primaryColor : Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              if (!isMe)
                                Row(
                                  children: [
                                    Text(
                                      "${msg["sender"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: isModerator ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    if (isModerator) ...[
                                      SizedBox(width: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "MOD",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              
                              if (msg["message"].toString().isNotEmpty)
                                Text(
                                  "${msg["message"]}",
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black87,
                                  ),
                                ),
                              
                              // Attachments
                              if (msg["attachments"] != null && (msg["attachments"] as List).isNotEmpty)
                                Column(
                                  spacing: spXs,
                                  children: (msg["attachments"] as List).map<Widget>((attachment) {
                                    return Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: isMe ? Colors.white.withAlpha(20) : primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.attach_file,
                                            size: 16,
                                            color: isMe ? Colors.white : primaryColor,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "$attachment",
                                            style: TextStyle(
                                              color: isMe ? Colors.white : primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              
                              Text(
                                "${DateTime.parse(msg["timestamp"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isMe ? Colors.white70 : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      if (isMe) ...[
                        SizedBox(width: spXs),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${msg["avatar"]}"),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: disabledColor)),
            ),
            child: QChatField(
              label: "Message",
              value: message,
              hint: "Type your message...",
              attachments: messageAttachments,
              showAttachmentButton: true,
              showEmojiButton: true,
              showVoiceButton: true,
              onChanged: (value) {
                message = value;
                setState(() {});
              },
              onSend: _sendMessage,
              onAttachmentsChanged: (value) {
                messageAttachments = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
