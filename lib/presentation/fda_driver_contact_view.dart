import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaDriverContactView extends StatefulWidget {
  const FdaDriverContactView({super.key});

  @override
  State<FdaDriverContactView> createState() => _FdaDriverContactViewState();
}

class _FdaDriverContactViewState extends State<FdaDriverContactView> {
  String messageText = "";
  
  Map<String, dynamic> driverData = {
    "name": "John Driver",
    "phone": "+1 234 567 8900",
    "image": "https://picsum.photos/50/50?random=1&keyword=driver",
    "rating": 4.8,
    "vehicle_type": "Motorcycle",
    "status": "delivering",
    "order_id": "ORD-2024-001",
    "estimated_time": "8 mins"
  };

  List<Map<String, dynamic>> messages = [
    {
      "text": "Hi! I'm on my way to deliver your order. ETA is about 10 minutes.",
      "sender": "driver",
      "time": "2:45 PM",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15))
    },
    {
      "text": "Thank you! I'll be waiting at the front door.",
      "sender": "customer",
      "time": "2:46 PM",
      "timestamp": DateTime.now().subtract(Duration(minutes: 14))
    },
    {
      "text": "Perfect! I'm almost there. Just a few more minutes.",
      "sender": "driver",
      "time": "2:52 PM",
      "timestamp": DateTime.now().subtract(Duration(minutes: 8))
    },
    {
      "text": "I'm at the location but can't find the exact building. Could you help?",
      "sender": "driver",
      "time": "2:58 PM",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2))
    }
  ];

  List<String> quickReplies = [
    "I'm coming down now",
    "Please call me",
    "Wait at the gate",
    "Building 3, Floor 2",
    "Thank you!",
    "5 more minutes please"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${driverData["image"]}",
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${driverData["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    driverData["status"] == "delivering" ? "Delivering your order" : "Available",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              ss("Calling driver...");
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              _showDriverInfo();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Order Status Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              border: Border(
                bottom: BorderSide(color: disabledColor),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Order #${driverData["order_id"]} • ETA: ${driverData["estimated_time"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ss("Opening order tracking...");
                  },
                  child: Text(
                    "Track",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: List.generate(messages.length, (index) {
                  final message = messages[index];
                  final isDriver = message["sender"] == "driver";
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      mainAxisAlignment: isDriver 
                          ? MainAxisAlignment.start 
                          : MainAxisAlignment.end,
                      children: [
                        if (isDriver) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${driverData["image"]}",
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                        ],
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isDriver 
                                  ? Colors.grey[200]
                                  : primaryColor,
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${message["text"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDriver ? primaryColor : Colors.white,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${message["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDriver 
                                        ? disabledBoldColor 
                                        : Colors.white.withAlpha(180),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isDriver) ...[
                          SizedBox(width: spSm),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
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
                }),
              ),
            ),
          ),

          // Quick Replies
          if (quickReplies.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(
                  top: BorderSide(color: disabledColor),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Replies",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: quickReplies.map((reply) {
                      return GestureDetector(
                        onTap: () {
                          _sendQuickReply(reply);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: primaryColor),
                          ),
                          child: Text(
                            reply,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],

          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: disabledColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledColor),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: spSm,
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: messageText.trim().isNotEmpty ? _sendMessage : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: messageText.trim().isNotEmpty 
                          ? primaryColor 
                          : disabledColor,
                      borderRadius: BorderRadius.circular(radiusMd),
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
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageText.trim().isEmpty) return;
    
    setState(() {
      messages.add({
        "text": messageText.trim(),
        "sender": "customer",
        "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        "timestamp": DateTime.now()
      });
      messageText = "";
    });
    
    ss("Message sent to driver");
  }

  void _sendQuickReply(String reply) {
    setState(() {
      messages.add({
        "text": reply,
        "sender": "customer",
        "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        "timestamp": DateTime.now()
      });
    });
    
    ss("Quick reply sent");
  }

  void _showDriverInfo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${driverData["image"]}",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${driverData["name"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${(driverData["rating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${driverData["vehicle_type"]}",
                            style: TextStyle(
                              fontSize: 14,
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

            SizedBox(height: spMd),

            // Contact Options
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      back();
                      ss("Calling driver...");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Call Driver",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      back();
                      ss("Opening driver profile...");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "View Profile",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Emergency Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Emergency Options",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            bool isConfirmed = await confirm("Report an issue with this driver?");
                            if (isConfirmed) {
                              back();
                              ss("Issue reported");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(color: dangerColor),
                            ),
                            child: Text(
                              "Report Issue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            back();
                            ss("Emergency contact called");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Emergency",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
      ),
    );
  }
}
