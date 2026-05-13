import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsLiveChatView extends StatefulWidget {
  const EcsLiveChatView({super.key});

  @override
  State<EcsLiveChatView> createState() => _EcsLiveChatViewState();
}

class _EcsLiveChatViewState extends State<EcsLiveChatView> {
  String message = "";
  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "message": "Hello! How can I help you today?",
      "time": "10:30 AM",
      "isSupport": true,
      "supportName": "Sarah",
      "supportAvatar": "https://picsum.photos/50/50?random=1&keyword=support"
    },
    {
      "id": 2,
      "message": "Hi, I have a question about my recent order #12345",
      "time": "10:32 AM",
      "isSupport": false,
    },
    {
      "id": 3,
      "message": "Of course! Let me check your order details. Please wait a moment.",
      "time": "10:33 AM",
      "isSupport": true,
      "supportName": "Sarah",
      "supportAvatar": "https://picsum.photos/50/50?random=1&keyword=support"
    },
    {
      "id": 4,
      "message": "I can see your order is currently being processed. It will be shipped within 2-3 business days.",
      "time": "10:35 AM",
      "isSupport": true,
      "supportName": "Sarah",
      "supportAvatar": "https://picsum.photos/50/50?random=1&keyword=support"
    },
    {
      "id": 5,
      "message": "Thank you for the quick response! When will I receive the tracking number?",
      "time": "10:36 AM",
      "isSupport": false,
    },
  ];

  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Chat Support"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/40/40?random=1&keyword=support",
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sarah Johnson",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Customer Support Agent",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Avg. response: 2 min",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isSupport = msg["isSupport"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    mainAxisAlignment: isSupport 
                        ? MainAxisAlignment.start 
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isSupport) ...[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            "${msg["supportAvatar"]}",
                          ),
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
                            color: isSupport 
                                ? Colors.grey[100] 
                                : primaryColor,
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isSupport)
                                Text(
                                  "${msg["supportName"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              if (isSupport) SizedBox(height: spXs),
                              Text(
                                "${msg["message"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSupport 
                                      ? primaryColor 
                                      : Colors.white,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${msg["time"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSupport 
                                      ? disabledBoldColor 
                                      : Colors.white.withAlpha(200),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      if (!isSupport) ...[
                        SizedBox(width: spXs),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.person,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // Typing Indicator
          if (isTyping)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      "https://picsum.photos/32/32?random=1&keyword=support",
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sarah is typing",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(width: spXs),
                        SizedBox(
                          width: 20,
                          height: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(3, (i) {
                              return Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledBoldColor,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Quick Responses
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: spXs),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              children: [
                _buildQuickResponse("Thank you"),
                _buildQuickResponse("I need more help"),
                _buildQuickResponse("Can you call me?"),
                _buildQuickResponse("Send me tracking info"),
              ],
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle attachment
                  },
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.attach_file,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
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
                  onPressed: message.isNotEmpty ? () {
                    // Send message
                    if (message.trim().isNotEmpty) {
                      messages.add({
                        "id": messages.length + 1,
                        "message": message,
                        "time": "10:40 AM",
                        "isSupport": false,
                      });
                      message = "";
                      isTyping = true;
                      setState(() {});
                      
                      // Simulate support response
                      Future.delayed(Duration(seconds: 2), () {
                        isTyping = false;
                        messages.add({
                          "id": messages.length + 1,
                          "message": "Thank you for your message. I'll get back to you shortly with more details.",
                          "time": "10:42 AM",
                          "isSupport": true,
                          "supportName": "Sarah",
                          "supportAvatar": "https://picsum.photos/50/50?random=1&keyword=support"
                        });
                        setState(() {});
                      });
                    }
                  } : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickResponse(String text) {
    return Container(
      margin: EdgeInsets.only(right: spXs),
      child: GestureDetector(
        onTap: () {
          message = text;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spSm,
            vertical: spXs,
          ),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(
              color: primaryColor.withAlpha(30),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
