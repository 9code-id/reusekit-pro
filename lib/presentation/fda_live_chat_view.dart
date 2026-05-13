import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaLiveChatView extends StatefulWidget {
  const FdaLiveChatView({super.key});

  @override
  State<FdaLiveChatView> createState() => _FdaLiveChatViewState();
}

class _FdaLiveChatViewState extends State<FdaLiveChatView> {
  String message = "";
  List<String> messageAttachments = [];
  bool isAgentTyping = false;
  bool isConnected = true;
  String agentName = "Sarah";
  String agentStatus = "Online";

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Hello! Welcome to FoodApp support. I'm Sarah, your customer service representative. How can I help you today?",
      "sender": "agent",
      "timestamp": "2024-03-20 14:30:00",
      "isRead": true,
    },
    {
      "id": "2",
      "message": "Hi! I have an issue with my recent order. It arrived cold and some items were missing.",
      "sender": "user",
      "timestamp": "2024-03-20 14:31:15",
      "isRead": true,
    },
    {
      "id": "3",
      "message": "I'm really sorry to hear about that! Let me help you resolve this immediately. Can you please provide me with your order number?",
      "sender": "agent",
      "timestamp": "2024-03-20 14:31:45",
      "isRead": true,
    },
    {
      "id": "4",
      "message": "Order number is ORD-2024-12345",
      "sender": "user",
      "timestamp": "2024-03-20 14:32:10",
      "isRead": true,
    },
    {
      "id": "5",
      "message": "Thank you! I found your order. I can see you ordered 2 burgers, fries, and 2 drinks from Tony's Diner. Let me check what happened with your delivery.",
      "sender": "agent",
      "timestamp": "2024-03-20 14:32:50",
      "isRead": true,
    },
    {
      "id": "6",
      "message": "I've processed a full refund for your order and also added \$5 credit to your account for the inconvenience. You should see the refund in 3-5 business days.",
      "sender": "agent",
      "timestamp": "2024-03-20 14:34:20",
      "isRead": false,
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Thank you!", "type": "gratitude"},
    {"text": "Order issue", "type": "category"},
    {"text": "Delivery problem", "type": "category"},
    {"text": "Refund request", "type": "category"},
    {"text": "App not working", "type": "category"},
    {"text": "Can you help with something else?", "type": "question"},
  ];

  void _sendMessage(String messageText, List<String> attachments) {
    if (messageText.isEmpty && attachments.isEmpty) return;

    Map<String, dynamic> newMessage = {
      "id": "${messages.length + 1}",
      "message": messageText,
      "sender": "user",
      "timestamp": DateTime.now().toString(),
      "isRead": true,
      "attachments": attachments,
    };

    messages.add(newMessage);
    message = "";
    messageAttachments = [];
    setState(() {});

    // Simulate agent typing
    _simulateAgentResponse();
  }

  void _simulateAgentResponse() {
    isAgentTyping = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      isAgentTyping = false;
      
      Map<String, dynamic> agentReply = {
        "id": "${messages.length + 1}",
        "message": "I've received your message. Let me help you with that right away!",
        "sender": "agent",
        "timestamp": DateTime.now().toString(),
        "isRead": false,
      };

      messages.add(agentReply);
      setState(() {});
    });
  }

  void _sendQuickReply(String text) {
    _sendMessage(text, []);
  }

  void _shareOrderDetails() {
    // Share order details
  }

  void _endChat() async {
    bool confirmed = await confirm("Are you sure you want to end this chat session?");
    if (confirmed) {
      back();
    }
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    bool isUser = msg["sender"] == "user";
    bool hasAttachments = msg["attachments"] != null && (msg["attachments"] as List).isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.support_agent,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isUser ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: isUser ? [] : [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${msg["message"]}",
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  if (hasAttachments) ...[
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (msg["attachments"] as List).map((attachment) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage("$attachment"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  SizedBox(height: spXs),
                  Text(
                    DateTime.parse(msg["timestamp"]).toString().substring(11, 16),
                    style: TextStyle(
                      color: isUser ? Colors.white.withAlpha(180) : disabledColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: spSm),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ],
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
            Text("Live Chat Support"),
            Text(
              "$agentName • $agentStatus",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.share),
                        title: Text("Share Order Details"),
                        onTap: () {
                          back();
                          _shareOrderDetails();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.call_end, color: dangerColor),
                        title: Text("End Chat", style: TextStyle(color: dangerColor)),
                        onTap: () {
                          back();
                          _endChat();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Connection Status
          if (isConnected)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs),
              color: successColor.withAlpha(20),
              child: Text(
                "Connected to support agent",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // Messages List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(spMd),
              children: [
                ...messages.map((msg) => _buildMessage(msg)).toList(),
                
                // Agent typing indicator
                if (isAgentTyping)
                  Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.support_agent,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
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
                                "$agentName is typing",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
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
                  ),
              ],
            ),
          ),

          // Quick Replies
          if (quickReplies.isNotEmpty)
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spMd),
                children: quickReplies.map((reply) {
                  return GestureDetector(
                    onTap: () => _sendQuickReply(reply["text"]),
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Center(
                        child: Text(
                          "${reply["text"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: QChatField(
              value: message,
              hint: "Type your message...",
              attachments: messageAttachments,
              showAttachmentButton: true,
              showEmojiButton: true,
              onChanged: (value) {
                message = value;
                setState(() {});
              },
              onSend: () => _sendMessage(message, messageAttachments),
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
