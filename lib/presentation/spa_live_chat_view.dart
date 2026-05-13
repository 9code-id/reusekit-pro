import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaLiveChatView extends StatefulWidget {
  const SpaLiveChatView({Key? key}) : super(key: key);

  @override
  State<SpaLiveChatView> createState() => _SpaLiveChatViewState();
}

class _SpaLiveChatViewState extends State<SpaLiveChatView> {
  String message = "";
  bool isTyping = false;
  bool agentOnline = true;
  String agentName = "Sarah Johnson";
  String agentStatus = "Online";
  List<String> attachments = [];

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "message": "Hello! Welcome to Spa Luxury support. I'm Sarah, your customer service representative. How can I help you today?",
      "sender": "agent",
      "timestamp": "2024-01-20 14:30:00",
      "type": "text",
      "agent": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=10&keyword=woman",
        "role": "Senior Support Specialist",
      },
    },
    {
      "id": 2,
      "message": "Hi Sarah! I'm having trouble with my booking for tomorrow. I need to change the time.",
      "sender": "user",
      "timestamp": "2024-01-20 14:31:15",
      "type": "text",
    },
    {
      "id": 3,
      "message": "I'd be happy to help you with that! Can you please provide me with your booking reference number?",
      "sender": "agent",
      "timestamp": "2024-01-20 14:31:45",
      "type": "text",
      "agent": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=10&keyword=woman",
        "role": "Senior Support Specialist",
      },
    },
    {
      "id": 4,
      "message": "Sure! It's SP-2024-BR-001234",
      "sender": "user",
      "timestamp": "2024-01-20 14:32:10",
      "type": "text",
    },
    {
      "id": 5,
      "message": "Perfect! I can see your booking for the Relaxation Package tomorrow at 2:00 PM. What time would you prefer to change it to?",
      "sender": "agent",
      "timestamp": "2024-01-20 14:32:35",
      "type": "text",
      "agent": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/100/100?random=10&keyword=woman",
        "role": "Senior Support Specialist",
      },
    },
    {
      "id": 6,
      "message": "Would 4:00 PM be available?",
      "sender": "user",
      "timestamp": "2024-01-20 14:33:00",
      "type": "text",
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Yes, that works for me", "icon": Icons.check},
    {"text": "No, I need a different time", "icon": Icons.close},
    {"text": "What other times are available?", "icon": Icons.schedule},
    {"text": "Can I speak to a manager?", "icon": Icons.person},
  ];

  List<Map<String, dynamic>> suggestedActions = [
    {
      "title": "View Booking Details",
      "description": "Check your current reservation",
      "icon": Icons.calendar_today,
      "action": "view_booking",
    },
    {
      "title": "Modify Booking",
      "description": "Change date, time, or services",
      "icon": Icons.edit,
      "action": "modify_booking",
    },
    {
      "title": "Cancel Booking",
      "description": "Cancel your reservation",
      "icon": Icons.cancel,
      "action": "cancel_booking",
    },
    {
      "title": "Add Services",
      "description": "Add more treatments",
      "icon": Icons.add,
      "action": "add_services",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildChatAppBar(),
      body: Column(
        children: [
          // Agent Status
          _buildAgentStatus(),
          
          // Messages
          Expanded(
            child: _buildMessagesList(),
          ),
          
          // Quick Replies
          if (quickReplies.isNotEmpty) _buildQuickReplies(),
          
          // Suggested Actions
          if (suggestedActions.isNotEmpty) _buildSuggestedActions(),
          
          // Typing Indicator
          if (isTyping) _buildTypingIndicator(),
          
          // Message Input
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
                backgroundImage: NetworkImage("https://picsum.photos/100/100?random=10&keyword=woman"),
              ),
              if (agentOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
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
                  agentName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  agentStatus,
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
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {
            _startVideoCall();
          },
        ),
        IconButton(
          icon: Icon(Icons.phone),
          onPressed: () {
            _startVoiceCall();
          },
        ),
        PopupMenuButton<String>(
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            PopupMenuItem(value: "history", child: Text("Chat History")),
            PopupMenuItem(value: "transfer", child: Text("Transfer to Manager")),
            PopupMenuItem(value: "feedback", child: Text("Rate Support")),
            PopupMenuItem(value: "end", child: Text("End Chat")),
          ],
        ),
      ],
    );
  }

  Widget _buildAgentStatus() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(25),
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: successColor, size: 8),
          SizedBox(width: spXs),
          Text(
            "Sarah is online and ready to help",
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(
            "Average response: 30 seconds",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isUser = message["sender"] == "user";
          final showAvatar = !isUser && (index == 0 || messages[index - 1]["sender"] == "user");
          
          return _buildMessageBubble(message, isUser, showAvatar);
        },
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isUser, bool showAvatar) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser && showAvatar)
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message["agent"]["avatar"]),
            )
          else if (!isUser)
            SizedBox(width: 32),
          
          if (!isUser) SizedBox(width: spXs),
          
          Expanded(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isUser && showAvatar)
                  Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Text(
                      "${message["agent"]["name"]} • ${message["agent"]["role"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isUser ? primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                      bottomLeft: Radius.circular(isUser ? radiusMd : radiusXs),
                      bottomRight: Radius.circular(isUser ? radiusXs : radiusMd),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${message["message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isUser ? Colors.white : Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      
                      // Attachments
                      if (message["attachments"] != null)
                        ..._buildMessageAttachments(message["attachments"]),
                    ],
                  ),
                ),
                
                SizedBox(height: spXs),
                Text(
                  _formatTimestamp(message["timestamp"]),
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          if (isUser) SizedBox(width: spXs),
          
          if (isUser)
            CircleAvatar(
              radius: 16,
              backgroundColor: primaryColor,
              child: Text(
                "You",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildMessageAttachments(List attachments) {
    return attachments.map<Widget>((attachment) {
      return Container(
        margin: EdgeInsets.only(top: spXs),
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.attach_file, size: 16),
            SizedBox(width: spXs),
            Text(
              attachment["name"],
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildQuickReplies() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickReplies.length,
        itemBuilder: (context, index) {
          final reply = quickReplies[index];
          return Container(
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () => _sendQuickReply(reply["text"]),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: primaryColor, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(reply["icon"] as IconData, color: primaryColor, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      reply["text"],
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
    );
  }

  Widget _buildSuggestedActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: suggestedActions.map((action) {
                return Container(
                  width: 140,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () => _performSuggestedAction(action),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            action["icon"] as IconData,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${action["title"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${action["description"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
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
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://picsum.photos/100/100?random=10&keyword=woman"),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTypingDot(0),
                      _buildTypingDot(1),
                      _buildTypingDot(2),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Sarah is typing...",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: disabledBoldColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Attachments Preview
          if (attachments.isNotEmpty) _buildAttachmentsPreview(),
          
          // Input Row
          Row(
            children: [
              // Attachment Button
              GestureDetector(
                onTap: _showAttachmentOptions,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(Icons.attach_file, color: disabledBoldColor, size: 20),
                ),
              ),
              SizedBox(width: spSm),
              
              // Text Input
              Expanded(
                child: QTextField(
                  label: "Type your message...",
                  value: message,
                  hint: "Ask anything about your spa experience",
                  onChanged: (value) {
                    message = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              
              // Send Button
              QButton(
                icon: message.isNotEmpty ? Icons.send : Icons.mic,
                size: bs.sm,
                onPressed: message.isNotEmpty ? _sendMessage : _startVoiceMessage,
              ),
            ],
          ),
          
          // Message Options
          SizedBox(height: spXs),
          Row(
            children: [
              GestureDetector(
                onTap: _showEmojiPicker,
                child: Icon(Icons.emoji_emotions, color: disabledBoldColor, size: 18),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: _showGifPicker,
                child: Icon(Icons.gif, color: disabledBoldColor, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsPreview() {
    return Container(
      height: 60,
      margin: EdgeInsets.only(bottom: spSm),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: attachments.length,
        itemBuilder: (context, index) {
          final attachment = attachments[index];
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: spXs),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file, color: disabledBoldColor),
                      Text(
                        "File",
                        style: TextStyle(fontSize: 10, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeAttachment(index),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  void _sendMessage() {
    if (message.trim().isEmpty) return;
    
    setState(() {
      messages.add({
        "id": messages.length + 1,
        "message": message.trim(),
        "sender": "user",
        "timestamp": DateTime.now().toString(),
        "type": "text",
      });
      message = "";
      attachments.clear();
    });
    
    // Simulate agent response
    _simulateAgentResponse();
  }

  void _sendQuickReply(String replyText) {
    setState(() {
      messages.add({
        "id": messages.length + 1,
        "message": replyText,
        "sender": "user",
        "timestamp": DateTime.now().toString(),
        "type": "text",
      });
      quickReplies.clear();
    });
    
    _simulateAgentResponse();
  }

  void _simulateAgentResponse() {
    setState(() {
      isTyping = true;
    });
    
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        messages.add({
          "id": messages.length + 1,
          "message": "Great! Let me check that for you. I can see that 4:00 PM slot is available. I'll go ahead and update your booking now.",
          "sender": "agent",
          "timestamp": DateTime.now().toString(),
          "type": "text",
          "agent": {
            "name": "Sarah Johnson",
            "avatar": "https://picsum.photos/100/100?random=10&keyword=woman",
            "role": "Senior Support Specialist",
          },
        });
      });
    });
  }

  void _startVideoCall() {
    ss("Starting video call with Sarah...");
    //navigateTo ( SpaVideoCallView )
  }

  void _startVoiceCall() {
    ss("Starting voice call...");
    //navigateTo ( SpaVoiceCallView )
  }

  void _startVoiceMessage() {
    ss("Recording voice message...");
    // Start voice recording
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share Content",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption("Camera", Icons.camera_alt, () {
                  _attachFile("camera");
                }),
                _buildAttachmentOption("Gallery", Icons.photo, () {
                  _attachFile("gallery");
                }),
                _buildAttachmentOption("Document", Icons.description, () {
                  _attachFile("document");
                }),
                _buildAttachmentOption("Location", Icons.location_on, () {
                  _attachFile("location");
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 24),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _attachFile(String type) {
    back();
    attachments.add("file_$type.pdf");
    setState(() {});
    ss("$type attached");
  }

  void _removeAttachment(int index) {
    attachments.removeAt(index);
    setState(() {});
  }

  void _showEmojiPicker() {
    ss("Opening emoji picker...");
    // Show emoji picker
  }

  void _showGifPicker() {
    ss("Opening GIF picker...");
    // Show GIF picker
  }

  void _performSuggestedAction(Map<String, dynamic> action) {
    String actionType = action["action"];
    ss("Performing action: ${action["title"]}");
    
    switch (actionType) {
      case "view_booking":
        //navigateTo ( SpaBookingDetailView )
        break;
      case "modify_booking":
        //navigateTo ( SpaModifyBookingView )
        break;
      case "cancel_booking":
        //navigateTo ( SpaCancelBookingView )
        break;
      case "add_services":
        //navigateTo ( SpaAddServicesView )
        break;
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "history":
        //navigateTo ( SpaChatHistoryView )
        break;
      case "transfer":
        ss("Transferring to manager...");
        break;
      case "feedback":
        //navigateTo ( SpaFeedbackView )
        break;
      case "end":
        _endChat();
        break;
    }
  }

  void _endChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("End Chat"),
        content: Text("Are you sure you want to end this chat session?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back(); // Close dialog
              back(); // Close chat
              ss("Chat session ended");
            },
            child: Text("End Chat"),
          ),
        ],
      ),
    );
  }
}
