import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat6View extends StatefulWidget {
  @override
  State<GrlChat6View> createState() => _GrlChat6ViewState();
}

class _GrlChat6ViewState extends State<GrlChat6View> {
  String message = "";
  List<String> messageAttachments = [];
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Hello! I'm here to help you with any questions you might have.",
      "timestamp": "2024-01-15 10:00:00",
      "isMe": false,
      "user": {
        "name": "Support Agent",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=support",
        "role": "Customer Support"
      },
      "status": "delivered"
    },
    {
      "id": "2",
      "message": "Hi! I'm having trouble with my account settings. Can you help me?",
      "timestamp": "2024-01-15 10:02:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "status": "read"
    },
    {
      "id": "3",
      "message": "Of course! I'd be happy to help you with your account settings. What specific issue are you experiencing?",
      "timestamp": "2024-01-15 10:03:00",
      "isMe": false,
      "user": {
        "name": "Support Agent",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=support",
        "role": "Customer Support"
      },
      "status": "delivered"
    },
    {
      "id": "4",
      "message": "I can't seem to update my profile picture. Every time I try to upload, it says 'upload failed'.",
      "timestamp": "2024-01-15 10:05:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "status": "read"
    },
    {
      "id": "5",
      "message": "I understand the issue. Let me help you troubleshoot this. First, let's check a few things:",
      "timestamp": "2024-01-15 10:06:00",
      "isMe": false,
      "user": {
        "name": "Support Agent",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=support",
        "role": "Customer Support"
      },
      "status": "delivered"
    },
    {
      "id": "6",
      "message": "1. Make sure your image is under 5MB\n2. Use JPG, PNG, or GIF format\n3. Try clearing your browser cache\n\nCould you try these steps and let me know if it works?",
      "timestamp": "2024-01-15 10:07:00",
      "isMe": false,
      "user": {
        "name": "Support Agent",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=support",
        "role": "Customer Support"
      },
      "status": "delivered"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Frequently Asked Questions",
      "description": "Get answers to common questions",
      "icon": Icons.help_center,
      "action": "faq"
    },
    {
      "title": "Account Issues",
      "description": "Help with login and account problems",
      "icon": Icons.account_circle,
      "action": "account"
    },
    {
      "title": "Technical Support",
      "description": "Technical issues and troubleshooting",
      "icon": Icons.build,
      "action": "technical"
    },
    {
      "title": "Billing & Payments",
      "description": "Questions about billing and payments",
      "icon": Icons.payment,
      "action": "billing"
    }
  ];

  List<String> suggestedReplies = [
    "Thank you for your help!",
    "I need more assistance",
    "That solved my problem",
    "Can you explain further?",
    "I'll try that now"
  ];

  bool isTyping = false;
  String supportStatus = "Online";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage("https://picsum.photos/40/40?random=1&keyword=support"),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: successColor,
                      shape: BoxShape.circle,
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
                    "Customer Support",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    isTyping ? "Typing..." : supportStatus,
                    style: TextStyle(
                      fontSize: 12,
                      color: isTyping ? primaryColor : successColor,
                      fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            icon: Icons.call,
            size: bs.sm,
            onPressed: () {
              si("Calling support");
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              _showSupportInfo();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Support Status Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(
                  color: infoColor.withAlpha(30),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.support_agent,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "You're connected to our support team. Average response time: 2 minutes",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Messages Area
          Expanded(
            child: messages.isEmpty ? _buildWelcomeScreen() : _buildMessagesList(),
          ),
          
          // Suggested Replies
          if (suggestedReplies.isNotEmpty)
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  top: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spMd),
                itemCount: suggestedReplies.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        _sendMessage(suggestedReplies[index]);
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
                          suggestedReplies[index],
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
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Type your message...",
                    value: message,
                    onChanged: (value) {
                      message = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: () {
                    if (message.isNotEmpty) {
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

  Widget _buildWelcomeScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          SizedBox(height: spXl),
          
          // Welcome Section
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.support_agent,
              size: 40,
              color: primaryColor,
            ),
          ),
          
          Text(
            "Welcome to Support",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Text(
            "We're here to help you with any questions or issues you might have. How can we assist you today?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(height: spLg),
          
          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...quickActions.map((action) => _buildQuickAction(action)),
        ],
      ),
    );
  }

  Widget _buildQuickAction(Map<String, dynamic> action) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () {
          _handleQuickAction(action["action"] as String);
        },
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  action["icon"] as IconData,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${action["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${action["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final messageData = messages[index];
        final isMe = messageData["isMe"] as bool;
        
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
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
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${messageData["user"]["role"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (isMe) ...[
                          SizedBox(width: spXs),
                          Icon(
                            messageData["status"] == "read" ? Icons.done_all : Icons.done,
                            size: 12,
                            color: messageData["status"] == "read" ? primaryColor : disabledBoldColor,
                          ),
                        ],
                      ],
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
      "status": "sent"
    };
    
    messages.add(newMessage);
    setState(() {});
    
    // Simulate typing indicator
    isTyping = true;
    setState(() {});
    
    // Simulate support response after 2-3 seconds
    Future.delayed(Duration(seconds: 2), () {
      isTyping = false;
      
      final responses = [
        "Thank you for your message. Let me help you with that.",
        "I understand your concern. Here's what I can do for you:",
        "That's a great question! Let me provide you with the information you need.",
        "I've received your request and I'm looking into this for you.",
        "Thanks for reaching out. I'll assist you right away."
      ];
      
      final response = {
        "id": "${messages.length + 1}",
        "message": responses[(messages.length) % responses.length],
        "timestamp": DateTime.now().toIso8601String(),
        "isMe": false,
        "user": {
          "name": "Support Agent",
          "avatar": "https://picsum.photos/40/40?random=1&keyword=support",
          "role": "Customer Support"
        },
        "status": "delivered"
      };
      
      messages.add(response);
      setState(() {});
    });
  }

  void _handleQuickAction(String action) {
    String message = "";
    switch (action) {
      case "faq":
        message = "I'd like to browse the frequently asked questions.";
        break;
      case "account":
        message = "I'm having issues with my account. Can you help me?";
        break;
      case "technical":
        message = "I need technical support for a problem I'm experiencing.";
        break;
      case "billing":
        message = "I have a question about billing and payments.";
        break;
    }
    
    if (message.isNotEmpty) {
      _sendMessage(message);
    }
  }

  void _showSupportInfo() {
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Support Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoItem(Icons.access_time, "Response Time", "Average 2-3 minutes"),
                  _buildInfoItem(Icons.schedule, "Support Hours", "24/7 Available"),
                  _buildInfoItem(Icons.language, "Languages", "English, Spanish, French"),
                  _buildInfoItem(Icons.star, "Satisfaction", "4.8/5 Average Rating"),
                  
                  SizedBox(height: spMd),
                  
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Rate This Conversation",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                        _showRatingDialog();
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

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Rate Your Experience",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "How would you rate your support experience?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ss("Thank you for your feedback!");
                    },
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: primaryColor,
                    ),
                  );
                }),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Additional Comments (Optional)",
                value: "",
                onChanged: (value) {},
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Skip",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Submit",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Thank you for your feedback!");
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
