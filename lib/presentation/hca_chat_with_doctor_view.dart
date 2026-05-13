import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaChatWithDoctorView extends StatefulWidget {
  const HcaChatWithDoctorView({super.key});

  @override
  State<HcaChatWithDoctorView> createState() => _HcaChatWithDoctorViewState();
}

class _HcaChatWithDoctorViewState extends State<HcaChatWithDoctorView> {
  bool loading = false;
  String message = "";
  List<String> attachments = [];
  bool isDoctorOnline = true;
  bool isTyping = false;

  Map<String, dynamic> doctor = {
    "name": "Dr. Sarah Johnson",
    "specialty": "Cardiology",
    "avatar": "https://picsum.photos/100/100?random=1&face",
    "rating": 4.9,
    "experience": 15,
    "status": "online",
    "lastSeen": "Active now",
  };

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "message": "Hello! I'm Dr. Johnson. How can I help you today?",
      "timestamp": "10:00 AM",
      "isDoctor": true,
      "type": "text",
      "status": "delivered",
    },
    {
      "id": 2,
      "message": "Hi Doctor, I've been experiencing chest pain for the past few days. It's mostly when I exercise or climb stairs.",
      "timestamp": "10:02 AM",
      "isDoctor": false,
      "type": "text",
      "status": "read",
    },
    {
      "id": 3,
      "message": "I understand your concern. Can you describe the pain? Is it sharp, dull, or pressing? And on a scale of 1-10, how would you rate the intensity?",
      "timestamp": "10:03 AM",
      "isDoctor": true,
      "type": "text",
      "status": "delivered",
    },
    {
      "id": 4,
      "message": "It's more like a pressing sensation, around 6-7 on the pain scale. Sometimes I feel shortness of breath too.",
      "timestamp": "10:05 AM",
      "isDoctor": false,
      "type": "text",
      "status": "read",
    },
    {
      "id": 5,
      "message": "https://picsum.photos/300/200?random=medical",
      "timestamp": "10:06 AM",
      "isDoctor": false,
      "type": "image",
      "status": "read",
      "caption": "My latest ECG result from last week",
    },
    {
      "id": 6,
      "message": "Thank you for sharing the ECG. Based on your symptoms and this report, I'd like to schedule you for some additional tests. In the meantime, please avoid strenuous activities.",
      "timestamp": "10:10 AM",
      "isDoctor": true,
      "type": "text",
      "status": "delivered",
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Yes, I understand", "icon": Icons.check},
    {"text": "Can you explain more?", "icon": Icons.help},
    {"text": "What are the next steps?", "icon": Icons.arrow_forward},
    {"text": "Schedule appointment", "icon": Icons.calendar_today},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${doctor["avatar"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${doctor["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isDoctorOnline ? successColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        isDoctorOnline ? "Online" : "${doctor["lastSeen"]}",
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
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _startVideoCall();
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(
                Icons.videocam,
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _startVoiceCall();
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(
                Icons.call,
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDoctorInfo();
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              child: Icon(
                Icons.info,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessage(messages[index]);
              },
            ),
          ),

          // Quick Replies
          if (quickReplies.isNotEmpty)
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: quickReplies.length,
                itemBuilder: (context, index) {
                  final reply = quickReplies[index];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        _sendQuickReply(reply);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              reply["icon"] as IconData,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${reply["text"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Chat Input
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QChatField(
              label: "Type your message...",
              value: message,
              hint: "Describe your symptoms or ask questions",
              attachments: attachments,
              showAttachmentButton: true,
              showEmojiButton: false,
              showVoiceButton: true,
              onChanged: (value) {
                message = value;
                setState(() {});
              },
              onSend: () {
                _sendMessage();
              },
              onAttachmentsChanged: (value) {
                attachments = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    bool isDoctor = msg["isDoctor"] as bool;
    bool isImage = msg["type"] == "image";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: isDoctor ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDoctor) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${doctor["avatar"]}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: spXs),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isDoctor ? Colors.grey[100] : primaryColor,
                borderRadius: BorderRadius.circular(radiusMd).copyWith(
                  bottomLeft: isDoctor ? Radius.circular(radiusXs) : null,
                  bottomRight: isDoctor ? null : Radius.circular(radiusXs),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${msg["message"]}",
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (msg.containsKey("caption") && msg["caption"] != null) ...[
                      SizedBox(height: spXs),
                      Text(
                        "${msg["caption"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDoctor ? primaryColor : Colors.white,
                        ),
                      ),
                    ],
                  ] else
                    Text(
                      "${msg["message"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDoctor ? primaryColor : Colors.white,
                      ),
                    ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${msg["timestamp"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: isDoctor ? disabledBoldColor : Colors.white.withAlpha(180),
                        ),
                      ),
                      if (!isDoctor) ...[
                        SizedBox(width: spXs),
                        Icon(
                          msg["status"] == "read" ? Icons.done_all : Icons.done,
                          size: 12,
                          color: msg["status"] == "read" ? successColor : Colors.white.withAlpha(180),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (!isDoctor) SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${doctor["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spXs),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusMd).copyWith(
                bottomLeft: Radius.circular(radiusXs),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Dr. ${doctor["name"]} is typing",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: spXs),
                SizedBox(
                  width: 12,
                  height: 12,
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

  void _sendMessage() {
    if (message.trim().isEmpty && attachments.isEmpty) return;

    // Add message to list
    Map<String, dynamic> newMessage = {
      "id": messages.length + 1,
      "message": message,
      "timestamp": "Now",
      "isDoctor": false,
      "type": "text",
      "status": "delivered",
    };

    setState(() {
      messages.add(newMessage);
      message = "";
      attachments = [];
      isTyping = true;
    });

    // Simulate doctor response
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        messages.add({
          "id": messages.length + 1,
          "message": "Thank you for the information. I'll review this and get back to you shortly.",
          "timestamp": "Now",
          "isDoctor": true,
          "type": "text",
          "status": "delivered",
        });
      });
    });
  }

  void _sendQuickReply(Map<String, dynamic> reply) {
    setState(() {
      message = "${reply["text"]}";
    });
    _sendMessage();
  }

  void _startVideoCall() {
    // Start video call
    ss("Starting video call with ${doctor["name"]}");
  }

  void _startVoiceCall() {
    // Start voice call
    ss("Starting voice call with ${doctor["name"]}");
  }

  void _showDoctorInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${doctor["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${doctor["name"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${doctor["specialty"]}",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  Text(
                    "${doctor["rating"]} • ${doctor["experience"]} years experience",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Profile",
                      size: bs.sm,
                      onPressed: () {
                        back();
                        // Navigate to profile
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Schedule",
                      size: bs.sm,
                      onPressed: () {
                        back();
                        // Navigate to scheduling
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
