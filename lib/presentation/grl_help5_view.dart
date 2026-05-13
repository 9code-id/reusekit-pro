import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlHelp5View extends StatefulWidget {
  @override
  State<GrlHelp5View> createState() => _GrlHelp5ViewState();
}

class _GrlHelp5ViewState extends State<GrlHelp5View> {
  bool isChatActive = false;
  String message = "";
  List<String> attachments = [];
  
  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "sender": "agent",
      "senderName": "Sarah from Support",
      "message": "Hi! I'm Sarah from the support team. How can I help you today?",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "type": "text"
    },
    {
      "id": 2,
      "sender": "user",
      "senderName": "You",
      "message": "Hello! I'm having trouble with uploading files. They keep failing.",
      "timestamp": DateTime.now().subtract(Duration(minutes: 1)),
      "type": "text"
    },
    {
      "id": 3,
      "sender": "agent",
      "senderName": "Sarah from Support",
      "message": "I understand your frustration. Let me help you with that. Can you tell me what file format you're trying to upload and the approximate file size?",
      "timestamp": DateTime.now().subtract(Duration(seconds: 30)),
      "type": "text"
    },
  ];

  List<Map<String, dynamic>> supportAgents = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "status": "online",
      "department": "Technical Support",
      "rating": 4.9,
      "responseTime": "< 2 min"
    },
    {
      "id": 2,
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "status": "online",
      "department": "Billing Support",
      "rating": 4.8,
      "responseTime": "< 3 min"
    },
    {
      "id": 3,
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "status": "busy",
      "department": "Account Management",
      "rating": 4.9,
      "responseTime": "< 5 min"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Chat Support"),
        actions: [
          if (isChatActive)
            IconButton(
              icon: Icon(Icons.call_end),
              onPressed: () {
                _endChat();
              },
            ),
        ],
      ),
      body: isChatActive ? _buildChatInterface() : _buildWaitingInterface(),
    );
  }

  Widget _buildWaitingInterface() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Live Chat Support",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Get instant help from our support team",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "3 agents online",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Avg. response: < 2 min",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Available Agents
          Text(
            "Available Support Agents",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...supportAgents.map((agent) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage("${agent["avatar"]}"),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: agent["status"] == "online" ? successColor : warningColor,
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
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${agent["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${agent["department"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) => Icon(
                                Icons.star,
                                size: 12,
                                color: index < (agent["rating"] as double).floor() 
                                    ? warningColor 
                                    : disabledColor,
                              )),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${agent["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "Responds in ${agent["responseTime"]}",
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
                  QButton(
                    label: "Chat Now",
                    size: bs.sm,
                    onPressed: agent["status"] == "online" ? () {
                      _startChat(agent);
                    } : null,
                  ),
                ],
              ),
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Chat Features
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: infoColor.withAlpha(50),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Chat Features",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...["File sharing and screenshots",
                  "Screen sharing assistance",
                  "Real-time typing indicators",
                  "Chat history and transcripts",
                  "Multi-language support"
                ].map((feature) => Padding(
                  padding: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Alternative Contact
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Other Ways to Reach Us",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // navigateTo(EmailSupportView());
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.email,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Email Support",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "24h response",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // navigateTo(PhoneSupportView());
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.phone,
                                color: warningColor,
                                size: 24,
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Phone Support",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "24/7 available",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildChatInterface() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Column(
        children: [
          // Chat Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("${supportAgents[0]["avatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sarah Johnson",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Online • Typically replies in minutes",
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
          ),
          
          // Messages Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: chatMessages.map((msg) => Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Row(
                    mainAxisAlignment: msg["sender"] == "user" 
                        ? MainAxisAlignment.end 
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (msg["sender"] == "agent")
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${supportAgents[0]["avatar"]}"),
                        ),
                      if (msg["sender"] == "agent")
                        SizedBox(width: spSm),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: msg["sender"] == "user" ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${msg["message"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: msg["sender"] == "user" ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${(msg["timestamp"] as DateTime).hour}:${(msg["timestamp"] as DateTime).minute.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 10,
                                color: msg["sender"] == "user" 
                                    ? Colors.white70 
                                    : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (msg["sender"] == "user")
                        SizedBox(width: spSm),
                      if (msg["sender"] == "user")
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                          child: Text(
                            "U",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                )).toList(),
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
              children: [
                if (attachments.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: spMd),
                    child: Wrap(
                      spacing: spSm,
                      children: attachments.map((attachment) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.attach_file,
                              size: 12,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "File attached",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle file attachment
                        attachments.add("file.jpg");
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.attach_file,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type your message...",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: spMd,
                              vertical: spSm,
                            ),
                          ),
                          onChanged: (value) {
                            message = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    GestureDetector(
                      onTap: message.isNotEmpty || attachments.isNotEmpty ? () {
                        _sendMessage();
                      } : null,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: message.isNotEmpty || attachments.isNotEmpty 
                              ? primaryColor 
                              : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
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

  void _startChat(Map<String, dynamic> agent) {
    isChatActive = true;
    setState(() {});
    ss("Connected to ${agent["name"]}");
  }

  void _sendMessage() {
    if (message.isNotEmpty || attachments.isNotEmpty) {
      chatMessages.add({
        "id": chatMessages.length + 1,
        "sender": "user",
        "senderName": "You",
        "message": message.isNotEmpty ? message : "File shared",
        "timestamp": DateTime.now(),
        "type": "text"
      });
      
      message = "";
      attachments.clear();
      setState(() {});
      
      // Simulate agent response
      Future.delayed(Duration(seconds: 2), () {
        chatMessages.add({
          "id": chatMessages.length + 1,
          "sender": "agent",
          "senderName": "Sarah from Support",
          "message": "Thank you for that information. Let me help you with that right away.",
          "timestamp": DateTime.now(),
          "type": "text"
        });
        setState(() {});
      });
    }
  }

  void _endChat() async {
    bool isConfirmed = await confirm("Are you sure you want to end this chat session?");
    if (isConfirmed) {
      isChatActive = false;
      setState(() {});
      ss("Chat session ended. You'll receive a transcript via email.");
    }
  }
}
