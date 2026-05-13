import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmLiveChatView extends StatefulWidget {
  const CrmLiveChatView({super.key});

  @override
  State<CrmLiveChatView> createState() => _CrmLiveChatViewState();
}

class _CrmLiveChatViewState extends State<CrmLiveChatView> {
  String messageText = "";
  List<String> attachments = [];
  bool isTyping = false;
  
  Map<String, dynamic> currentChat = {
    "id": "CHT-001",
    "customer": {
      "name": "John Doe",
      "email": "john.doe@email.com",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=man",
      "location": "New York, USA",
      "status": "online",
      "joinedAt": "2024-12-19 14:30:00",
    },
    "agent": {
      "name": "Sarah Wilson",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "status": "online",
    },
    "priority": "High",
    "category": "Payment",
    "status": "active",
    "startedAt": "2024-12-19 14:30:00",
    "duration": "00:15:30",
  };

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "sender": "customer",
      "type": "text",
      "content": "Hello, I'm having trouble with my payment processing",
      "timestamp": "2024-12-19 14:30:15",
      "status": "read",
    },
    {
      "id": 2,
      "sender": "agent",
      "type": "text",
      "content": "Hi John! I'm Sarah and I'll be helping you today. Can you tell me more about the payment issue you're experiencing?",
      "timestamp": "2024-12-19 14:30:45",
      "status": "read",
    },
    {
      "id": 3,
      "sender": "customer",
      "type": "text",
      "content": "When I try to process a payment, I get an error message saying 'Transaction failed'. This has been happening for the past 2 days.",
      "timestamp": "2024-12-19 14:31:20",
      "status": "read",
    },
    {
      "id": 4,
      "sender": "agent",
      "type": "text",
      "content": "I understand how frustrating that must be. Let me check your account settings. Can you please tell me which payment method you're trying to use?",
      "timestamp": "2024-12-19 14:32:10",
      "status": "read",
    },
    {
      "id": 5,
      "sender": "customer",
      "type": "text",
      "content": "I'm using my Visa credit card ending in 4321. It's the same card I've been using for months without any issues.",
      "timestamp": "2024-12-19 14:33:05",
      "status": "read",
    },
    {
      "id": 6,
      "sender": "agent",
      "type": "image",
      "content": "https://picsum.photos/300/200?random=10&keyword=payment",
      "caption": "Here's a screenshot of the payment settings page. Can you see if this matches what you're seeing?",
      "timestamp": "2024-12-19 14:34:15",
      "status": "read",
    },
    {
      "id": 7,
      "sender": "customer",
      "type": "text",
      "content": "Yes, that's exactly what I see. But when I click the 'Process Payment' button, that's when I get the error.",
      "timestamp": "2024-12-19 14:35:30",
      "status": "read",
    },
    {
      "id": 8,
      "sender": "agent",
      "type": "text",
      "content": "Thank you for confirming. I can see there's an issue with your payment gateway connection. I'm going to refresh your payment methods now. This should resolve the issue.",
      "timestamp": "2024-12-19 14:36:45",
      "status": "delivered",
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Let me check that for you", "category": "general"},
    {"text": "I understand your concern", "category": "empathy"},
    {"text": "Can you provide more details?", "category": "inquiry"},
    {"text": "I'll escalate this to our technical team", "category": "escalation"},
    {"text": "Is there anything else I can help you with?", "category": "closing"},
    {"text": "Thank you for your patience", "category": "gratitude"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildChatAppBar(),
      body: Column(
        children: [
          _buildChatInfo(),
          Expanded(
            child: _buildMessagesList(),
          ),
          _buildTypingIndicator(),
          _buildQuickReplies(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildChatAppBar() {
    return AppBar(
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${currentChat["customer"]["avatar"]}"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: currentChat["customer"]["status"] == "online" 
                        ? successColor 
                        : disabledBoldColor,
                    borderRadius: BorderRadius.circular(radiusLg),
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
                  "${currentChat["customer"]["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${currentChat["customer"]["status"]} • ${currentChat["customer"]["location"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.call),
          onPressed: () {
            _initiateCall();
          },
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {
            _initiateVideoCall();
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            _showChatOptions();
          },
        ),
      ],
    );
  }

  Widget _buildChatInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: _getPriorityColor(currentChat["priority"]).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${currentChat["priority"]} Priority",
              style: TextStyle(
                fontSize: 11,
                color: _getPriorityColor(currentChat["priority"]),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: secondaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${currentChat["category"]}",
              style: TextStyle(
                fontSize: 11,
                color: secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.access_time, size: 14, color: disabledBoldColor),
          SizedBox(width: spXs),
          Text(
            "${currentChat["duration"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Container(
      color: disabledColor.withAlpha(30),
      child: ListView.builder(
        padding: EdgeInsets.all(spSm),
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[messages.length - 1 - index];
          return _buildMessage(message);
        },
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    bool isAgent = message["sender"] == "agent";
    bool isCustomer = message["sender"] == "customer";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: isAgent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCustomer) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage("${currentChat["customer"]["avatar"]}"),
            ),
            SizedBox(width: spXs),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isAgent 
                  ? CrossAxisAlignment.end 
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isAgent 
                        ? primaryColor 
                        : Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd).copyWith(
                      bottomLeft: isAgent 
                          ? Radius.circular(radiusMd) 
                          : Radius.circular(radiusXs),
                      bottomRight: isAgent 
                          ? Radius.circular(radiusXs) 
                          : Radius.circular(radiusMd),
                    ),
                    boxShadow: [shadowXs],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message["type"] == "text")
                        Text(
                          "${message["content"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isAgent ? Colors.white : primaryColor,
                            height: 1.4,
                          ),
                        ),
                      if (message["type"] == "image") ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${message["content"]}",
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (message["caption"] != null) ...[
                          SizedBox(height: spXs),
                          Text(
                            "${message["caption"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: isAgent ? Colors.white : primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${DateTime.parse(message["timestamp"]).toString().substring(11, 16)}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (isAgent) ...[
                      SizedBox(width: spXs),
                      Icon(
                        message["status"] == "read" 
                            ? Icons.done_all 
                            : Icons.done,
                        size: 12,
                        color: message["status"] == "read" 
                            ? successColor 
                            : disabledBoldColor,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isAgent) ...[
            SizedBox(width: spXs),
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage("${currentChat["agent"]["avatar"]}"),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    if (!isTyping) return SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage("${currentChat["customer"]["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(100),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Typing",
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
                    strokeWidth: 1,
                    valueColor: AlwaysStoppedAnimation<Color>(disabledBoldColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplies() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: spSm),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: quickReplies.map((reply) {
          return Container(
            margin: EdgeInsets.only(right: spXs),
            child: GestureDetector(
              onTap: () {
                messageText = reply["text"];
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor.withAlpha(100)),
                ),
                child: Text(
                  "${reply["text"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Column(
        children: [
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
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            attachments[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              attachments.removeAt(index);
                              setState(() {});
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
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
          QChatField(
            label: "Type a message",
            value: messageText,
            hint: "Type your message here...",
            attachments: attachments,
            showAttachmentButton: true,
            showEmojiButton: true,
            showVoiceButton: true,
            onChanged: (value) {
              messageText = value;
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
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageText.trim().isNotEmpty || attachments.isNotEmpty) {
      final newMessage = {
        "id": messages.length + 1,
        "sender": "agent",
        "type": attachments.isNotEmpty ? "image" : "text",
        "content": attachments.isNotEmpty ? attachments.first : messageText,
        "caption": attachments.isNotEmpty && messageText.isNotEmpty ? messageText : null,
        "timestamp": DateTime.now().toString(),
        "status": "delivered",
      };

      messages.add(newMessage);
      messageText = "";
      attachments = [];
      
      // Simulate customer typing response
      Future.delayed(Duration(seconds: 2), () {
        isTyping = true;
        setState(() {});
        
        Future.delayed(Duration(seconds: 3), () {
          isTyping = false;
          _simulateCustomerResponse();
        });
      });
      
      setState(() {});
    }
  }

  void _simulateCustomerResponse() {
    final responses = [
      "Thank you so much! That worked perfectly.",
      "I see the difference now. The payment went through successfully.",
      "Great! Is there anything else I should know about this?",
      "Perfect! I really appreciate your help with this issue.",
    ];
    
    final randomResponse = responses[(messages.length % responses.length)];
    
    final customerMessage = {
      "id": messages.length + 1,
      "sender": "customer",
      "type": "text",
      "content": randomResponse,
      "timestamp": DateTime.now().toString(),
      "status": "read",
    };

    messages.add(customerMessage);
    setState(() {});
  }

  void _initiateCall() {
    si("Voice call feature would be implemented here");
  }

  void _initiateVideoCall() {
    si("Video call feature would be implemented here");
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Chat Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.transfer_within_a_station),
              title: Text("Transfer Chat"),
              onTap: () {
                Navigator.pop(context);
                _transferChat();
              },
            ),
            ListTile(
              leading: Icon(Icons.escalator_warning),
              title: Text("Escalate to Supervisor"),
              onTap: () {
                Navigator.pop(context);
                _escalateChat();
              },
            ),
            ListTile(
              leading: Icon(Icons.note_add),
              title: Text("Add Internal Note"),
              onTap: () {
                Navigator.pop(context);
                _addInternalNote();
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text("End Chat"),
              onTap: () {
                Navigator.pop(context);
                _endChat();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _transferChat() {
    si("Chat transfer dialog would be shown here");
  }

  void _escalateChat() {
    si("Chat escalation dialog would be shown here");
  }

  void _addInternalNote() {
    si("Internal note dialog would be shown here");
  }

  void _endChat() async {
    bool isConfirmed = await confirm("Are you sure you want to end this chat session?");
    if (isConfirmed) {
      ss("Chat session ended successfully");
      // Navigate back
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
