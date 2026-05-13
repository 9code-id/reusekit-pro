import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaChatSupportView extends StatefulWidget {
  const BfaChatSupportView({super.key});

  @override
  State<BfaChatSupportView> createState() => _BfaChatSupportViewState();
}

class _BfaChatSupportViewState extends State<BfaChatSupportView> {
  String message = "";
  List<String> attachments = [];
  bool isTyping = false;
  String supportStatus = "online";

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "sender": "support",
      "senderName": "Sarah Wilson",
      "message": "Hello! I'm Sarah from BankFirst customer support. How can I help you today?",
      "timestamp": "2024-06-16 09:00:00",
      "type": "text",
      "isRead": true,
    },
    {
      "id": "2",
      "sender": "user",
      "message": "Hi, I have a question about my credit card statement.",
      "timestamp": "2024-06-16 09:01:00",
      "type": "text",
      "isRead": true,
    },
    {
      "id": "3",
      "sender": "support",
      "senderName": "Sarah Wilson",
      "message": "I'd be happy to help you with your credit card statement. Could you please tell me which specific part you have questions about?",
      "timestamp": "2024-06-16 09:02:00",
      "type": "text",
      "isRead": true,
    },
    {
      "id": "4",
      "sender": "user",
      "message": "I see some charges that I don't recognize from last week.",
      "timestamp": "2024-06-16 09:03:00",
      "type": "text",
      "isRead": true,
    },
    {
      "id": "5",
      "sender": "support",
      "senderName": "Sarah Wilson",
      "message": "I understand your concern about unrecognized charges. For security purposes, I'll need to verify your identity first. Can you provide the last 4 digits of your card and your full name?",
      "timestamp": "2024-06-16 09:04:00",
      "type": "text",
      "isRead": true,
    },
    {
      "id": "6",
      "sender": "support",
      "senderName": "Sarah Wilson",
      "message": "Also, please note that I cannot see your full card details for security reasons. Would you like me to guide you through checking your transaction history in the app?",
      "timestamp": "2024-06-16 09:04:30",
      "type": "text",
      "isRead": true,
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Check account balance", "icon": Icons.account_balance_wallet},
    {"text": "Report fraud", "icon": Icons.security},
    {"text": "Card issues", "icon": Icons.credit_card},
    {"text": "Transfer money", "icon": Icons.swap_horiz},
    {"text": "Loan information", "icon": Icons.monetization_on},
    {"text": "Technical support", "icon": Icons.build},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Chat Support"),
            Text(
              "Sarah Wilson • $supportStatus",
              style: TextStyle(
                fontSize: 12,
                color: supportStatus == "online" ? successColor : disabledBoldColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              si("Calling customer support: 1-800-BANK-HELP");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showChatOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(bottom: BorderSide(color: Colors.grey.withAlpha(30))),
            ),
            child: Row(
              children: [
                Icon(Icons.info, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Your messages are encrypted and secure. Average response time: 2 minutes",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isTyping) {
                  return _buildTypingIndicator();
                }
                
                final message = messages[index];
                final isUser = message["sender"] == "user";
                final previousMessage = index > 0 ? messages[index - 1] : null;
                final showAvatar = !isUser && (previousMessage == null || previousMessage["sender"] != "support");
                
                return _buildMessageBubble(message, isUser, showAvatar);
              },
            ),
          ),

          if (quickReplies.isNotEmpty && messages.length <= 2)
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: quickReplies.length,
                itemBuilder: (context, index) {
                  final reply = quickReplies[index];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: InkWell(
                      onTap: () {
                        _sendQuickReply("${reply["text"]}");
                      },
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                          boxShadow: [shadowSm],
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
                                fontSize: 13,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
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

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.withAlpha(30))),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                if (attachments.isNotEmpty)
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: attachments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.insert_drive_file,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    attachments.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      size: 10,
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

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showAttachmentOptions();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
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
                        hint: "How can we help you today?",
                        onChanged: (value) {
                          message = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: message.trim().isEmpty && attachments.isEmpty ? null : _sendMessage,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: message.trim().isEmpty && attachments.isEmpty
                              ? disabledColor
                              : primaryColor,
                          shape: BoxShape.circle,
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

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isUser, bool showAvatar) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: showAvatar ? primaryColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: showAvatar
                  ? Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          if (isUser) Spacer(),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isUser ? primaryColor : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                  bottomLeft: Radius.circular(isUser ? radiusMd : radiusXs),
                  bottomRight: Radius.circular(isUser ? radiusXs : radiusMd),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  if (!isUser && showAvatar)
                    Text(
                      "${message["senderName"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  Text(
                    "${message["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    "${DateTime.parse(message["timestamp"]).dMMMy} ${TimeOfDay.fromDateTime(DateTime.parse(message["timestamp"])).kkmm}",
                    style: TextStyle(
                      fontSize: 11,
                      color: isUser ? Colors.white70 : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isUser) Spacer(),
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
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent,
              color: Colors.white,
              size: 18,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sarah is typing",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: spXs),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (message.trim().isEmpty && attachments.isEmpty) return;

    setState(() {
      messages.add({
        "id": "${messages.length + 1}",
        "sender": "user",
        "message": message.trim(),
        "timestamp": DateTime.now().toString(),
        "type": "text",
        "isRead": true,
      });
      
      message = "";
      attachments.clear();
      isTyping = true;
    });

    // Simulate support response
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        messages.add({
          "id": "${messages.length + 1}",
          "sender": "support",
          "senderName": "Sarah Wilson",
          "message": "Thank you for your message. I'm reviewing your request and will provide assistance shortly.",
          "timestamp": DateTime.now().toString(),
          "type": "text",
          "isRead": true,
        });
      });
    });
  }

  void _sendQuickReply(String text) {
    setState(() {
      messages.add({
        "id": "${messages.length + 1}",
        "sender": "user",
        "message": text,
        "timestamp": DateTime.now().toString(),
        "type": "text",
        "isRead": true,
      });
      isTyping = true;
    });

    // Simulate support response
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isTyping = false;
        messages.add({
          "id": "${messages.length + 1}",
          "sender": "support",
          "senderName": "Sarah Wilson",
          "message": "I can help you with that. Let me gather the relevant information for you.",
          "timestamp": DateTime.now().toString(),
          "type": "text",
          "isRead": true,
        });
      });
    });
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Add Attachment",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.camera_alt, color: primaryColor),
              title: Text("Take Photo"),
              onTap: () {
                back();
                attachments.add("camera_${DateTime.now().millisecondsSinceEpoch}");
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: primaryColor),
              title: Text("Choose from Gallery"),
              onTap: () {
                back();
                attachments.add("gallery_${DateTime.now().millisecondsSinceEpoch}");
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_drive_file, color: primaryColor),
              title: Text("Upload Document"),
              onTap: () {
                back();
                attachments.add("document_${DateTime.now().millisecondsSinceEpoch}");
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(50),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Chat Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.email, color: primaryColor),
              title: Text("Email Transcript"),
              onTap: () {
                back();
                ss("Chat transcript sent to your email");
              },
            ),
            ListTile(
              leading: Icon(Icons.star, color: primaryColor),
              title: Text("Rate This Chat"),
              onTap: () {
                back();
                si("Thank you for rating this chat session");
              },
            ),
            ListTile(
              leading: Icon(Icons.report, color: dangerColor),
              title: Text("Report Issue"),
              onTap: () {
                back();
                si("Issue reported to our quality team");
              },
            ),
          ],
        ),
      ),
    );
  }
}
