import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat1View extends StatefulWidget {
  @override
  State<GrlChat1View> createState() => _GrlChat1ViewState();
}

class _GrlChat1ViewState extends State<GrlChat1View> {
  String message = "";
  List<String> messageAttachments = [];
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Hey! How are you doing today?",
      "timestamp": "2024-01-15 10:30:00",
      "isMe": false,
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=woman"
      }
    },
    {
      "id": "2", 
      "message": "I'm doing great, thanks for asking! Just finished a really productive meeting.",
      "timestamp": "2024-01-15 10:32:00",
      "isMe": true,
      "user": {
        "name": "Me",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=man"
      }
    },
    {
      "id": "3",
      "message": "That's awesome! What was the meeting about?",
      "timestamp": "2024-01-15 10:33:00", 
      "isMe": false,
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=woman"
      }
    },
    {
      "id": "4",
      "message": "We're launching a new project next month. Really excited about the possibilities!",
      "timestamp": "2024-01-15 10:35:00",
      "isMe": true,
      "user": {
        "name": "Me", 
        "avatar": "https://picsum.photos/40/40?random=2&keyword=man"
      }
    },
    {
      "id": "5",
      "message": "Congratulations! I'd love to hear more details when you're ready to share.",
      "timestamp": "2024-01-15 10:36:00",
      "isMe": false,
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=woman"
      }
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://picsum.photos/40/40?random=1&keyword=woman"),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sarah Johnson",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Online",
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
            icon: Icons.videocam,
            size: bs.sm,
            onPressed: () {
              si("Video call initiated");
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.call,
            size: bs.sm,
            onPressed: () {
              si("Voice call initiated");
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("More options");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageData = messages[index];
                final isMe = messageData["isMe"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
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
                            ),
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
                  ),
                );
              },
            ),
          ),
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
              onSend: () {
                if (message.isNotEmpty || messageAttachments.isNotEmpty) {
                  _sendMessage(message, messageAttachments);
                  message = "";
                  messageAttachments = [];
                  setState(() {});
                }
              },
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

  void _sendMessage(String text, List<String> attachments) {
    final newMessage = {
      "id": "${messages.length + 1}",
      "message": text,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "user": {
        "name": "Me",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=man"
      }
    };
    
    messages.add(newMessage);
    setState(() {});
    
    // Simulate response after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      final responses = [
        "That sounds interesting!",
        "I agree with you on that.",
        "Thanks for sharing that with me.",
        "What do you think about it?",
        "That's a great point!"
      ];
      
      final response = {
        "id": "${messages.length + 1}",
        "message": responses[(messages.length) % responses.length],
        "timestamp": DateTime.now().toIso8601String(),
        "isMe": false,
        "user": {
          "name": "Sarah Johnson",
          "avatar": "https://picsum.photos/40/40?random=1&keyword=woman"
        }
      };
      
      messages.add(response);
      setState(() {});
    });
  }
}
