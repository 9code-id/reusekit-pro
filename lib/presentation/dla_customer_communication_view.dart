import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaCustomerCommunicationView extends StatefulWidget {
  const DlaCustomerCommunicationView({super.key});

  @override
  State<DlaCustomerCommunicationView> createState() => _DlaCustomerCommunicationViewState();
}

class _DlaCustomerCommunicationViewState extends State<DlaCustomerCommunicationView> {
  String message = "";
  List<String> attachments = [];
  int selectedTab = 0;

  List<Map<String, dynamic>> messageHistory = [
    {
      "id": 1,
      "sender": "Driver",
      "message": "I'm approaching your location. Please be ready for delivery.",
      "timestamp": "2024-01-15 14:30",
      "type": "text",
      "status": "delivered"
    },
    {
      "id": 2,
      "sender": "Customer",
      "message": "Thank you! I'll be waiting at the front door.",
      "timestamp": "2024-01-15 14:32",
      "type": "text",
      "status": "read"
    },
    {
      "id": 3,
      "sender": "Driver",
      "message": "",
      "timestamp": "2024-01-15 14:35",
      "type": "image",
      "attachment": "https://picsum.photos/400/300?random=1&keyword=package",
      "status": "delivered"
    },
    {
      "id": 4,
      "sender": "System",
      "message": "Package delivered successfully at 2:35 PM",
      "timestamp": "2024-01-15 14:35",
      "type": "system",
      "status": "read"
    }
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "I'm ready", "icon": Icons.check_circle},
    {"text": "Please wait 5 minutes", "icon": Icons.schedule},
    {"text": "Ring the doorbell", "icon": Icons.notifications},
    {"text": "Leave at door", "icon": Icons.door_front_door},
    {"text": "Call me", "icon": Icons.phone},
    {"text": "Thank you", "icon": Icons.thumb_up}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Communication"),
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1&keyword=person"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Smith",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "123 Main Street, Downtown",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Online",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: messageHistory.length,
              itemBuilder: (context, index) {
                final msg = messageHistory[index];
                final isCustomer = msg["sender"] == "Customer";
                final isSystem = msg["sender"] == "System";
                
                if (isSystem) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${msg["message"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    mainAxisAlignment: isCustomer ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isCustomer) ...[
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage("https://picsum.photos/60/60?random=2&keyword=driver"),
                        ),
                        SizedBox(width: spXs),
                      ],
                      
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCustomer ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                            bottomLeft: Radius.circular(isCustomer ? radiusMd : radiusXs),
                            bottomRight: Radius.circular(isCustomer ? radiusXs : radiusMd),
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (msg["type"] == "image") ...[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${msg["attachment"]}",
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (msg["message"].toString().isNotEmpty) ...[
                                SizedBox(height: spXs),
                                Text(
                                  "${msg["message"]}",
                                  style: TextStyle(
                                    color: isCustomer ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ] else ...[
                              Text(
                                "${msg["message"]}",
                                style: TextStyle(
                                  color: isCustomer ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                            SizedBox(height: spXs),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${msg["timestamp"]}".split(" ")[1],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isCustomer ? Colors.white70 : disabledColor,
                                  ),
                                ),
                                if (isCustomer) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    msg["status"] == "read" ? Icons.done_all : Icons.done,
                                    size: 12,
                                    color: msg["status"] == "read" ? Colors.blue : Colors.white70,
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      if (isCustomer) ...[
                        SizedBox(width: spXs),
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage("https://picsum.photos/60/60?random=1&keyword=person"),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: quickReplies.length,
                    itemBuilder: (context, index) {
                      final reply = quickReplies[index];
                      return Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: GestureDetector(
                          onTap: () {
                            message = reply["text"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusLg),
                              border: Border.all(color: primaryColor.withAlpha(30)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  reply["icon"],
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${reply["text"]}",
                                  style: TextStyle(
                                    fontSize: 12,
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
                
                SizedBox(height: spSm),
                
                QChatField(
                  label: "Message",
                  value: message,
                  hint: "Type your message...",
                  attachments: attachments,
                  showAttachmentButton: true,
                  showEmojiButton: true,
                  showVoiceButton: true,
                  onChanged: (value) {
                    message = value;
                    setState(() {});
                  },
                  onSend: () {
                    if (message.isNotEmpty || attachments.isNotEmpty) {
                      messageHistory.add({
                        "id": messageHistory.length + 1,
                        "sender": "Customer",
                        "message": message,
                        "timestamp": "2024-01-15 ${DateTime.now().hour}:${DateTime.now().minute}",
                        "type": attachments.isNotEmpty ? "image" : "text",
                        "attachment": attachments.isNotEmpty ? attachments.first : null,
                        "status": "sent"
                      });
                      message = "";
                      attachments = [];
                      setState(() {});
                    }
                  },
                  onAttachmentsChanged: (value) {
                    attachments = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
