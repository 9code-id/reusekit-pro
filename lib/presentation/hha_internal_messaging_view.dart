import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaInternalMessagingView extends StatefulWidget {
  const HhaInternalMessagingView({super.key});

  @override
  State<HhaInternalMessagingView> createState() => _HhaInternalMessagingViewState();
}

class _HhaInternalMessagingViewState extends State<HhaInternalMessagingView> {
  String searchQuery = "";
  String selectedChat = "";
  String messageText = "";
  
  List<Map<String, dynamic>> chats = [
    {
      "id": "chat_001",
      "type": "group",
      "name": "Front Desk Team",
      "participants": ["Maria Santos", "Lisa Chen", "John Wilson", "Sarah Johnson"],
      "avatar": null,
      "last_message": "New guest checking in at 3 PM needs special assistance",
      "last_message_time": "2024-12-15T14:30:00",
      "last_sender": "Maria Santos",
      "unread_count": 2,
      "is_online": true,
    },
    {
      "id": "chat_002",
      "type": "direct",
      "name": "David Brown",
      "participants": ["David Brown"],
      "avatar": "https://picsum.photos/100/100?random=1&keyword=person",
      "last_message": "Can you check the HVAC system in room 305?",
      "last_message_time": "2024-12-15T13:45:00",
      "last_sender": "David Brown",
      "unread_count": 0,
      "is_online": true,
    },
    {
      "id": "chat_003",
      "type": "group",
      "name": "Housekeeping Team",
      "participants": ["Lisa Chen", "Maria Santos", "Anna Rodriguez", "Tom Johnson"],
      "avatar": null,
      "last_message": "Room 208 is ready for inspection",
      "last_message_time": "2024-12-15T12:20:00",
      "last_sender": "Anna Rodriguez",
      "unread_count": 5,
      "is_online": false,
    },
    {
      "id": "chat_004",
      "type": "direct",
      "name": "Sarah Johnson",
      "participants": ["Sarah Johnson"],
      "avatar": "https://picsum.photos/100/100?random=2&keyword=woman",
      "last_message": "Thanks for the update on the training schedule",
      "last_message_time": "2024-12-15T11:15:00",
      "last_sender": "You",
      "unread_count": 0,
      "is_online": false,
    },
    {
      "id": "chat_005",
      "type": "group",
      "name": "Management Team",
      "participants": ["John Wilson", "Maria Santos", "David Brown"],
      "avatar": null,
      "last_message": "Monthly review meeting scheduled for tomorrow",
      "last_message_time": "2024-12-15T10:30:00",
      "last_sender": "John Wilson",
      "unread_count": 1,
      "is_online": true,
    },
    {
      "id": "chat_006",
      "type": "direct",
      "name": "Mike Rodriguez",
      "participants": ["Mike Rodriguez"],
      "avatar": "https://picsum.photos/100/100?random=3&keyword=man",
      "last_message": "Pool maintenance completed successfully",
      "last_message_time": "2024-12-14T16:45:00",
      "last_sender": "Mike Rodriguez",
      "unread_count": 0,
      "is_online": false,
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "msg_001",
      "chat_id": "chat_001",
      "sender": "Maria Santos",
      "sender_avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "message": "New guest checking in at 3 PM needs special assistance. Wheelchair accessible room required.",
      "message_type": "text",
      "timestamp": "2024-12-15T14:30:00",
      "is_read": true,
      "is_own_message": false,
    },
    {
      "id": "msg_002",
      "chat_id": "chat_001", 
      "sender": "Lisa Chen",
      "sender_avatar": "https://picsum.photos/100/100?random=5&keyword=asian",
      "message": "Room 101 is prepared and ready. Wheelchair ramp is clear.",
      "message_type": "text",
      "timestamp": "2024-12-15T14:32:00",
      "is_read": true,
      "is_own_message": false,
    },
    {
      "id": "msg_003",
      "chat_id": "chat_001",
      "sender": "You",
      "sender_avatar": null,
      "message": "Perfect! I'll inform the guest. Thank you both.",
      "message_type": "text",
      "timestamp": "2024-12-15T14:35:00",
      "is_read": false,
      "is_own_message": true,
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (searchQuery.isEmpty) return chats;
    
    return chats.where((chat) {
      return "${chat["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
             "${chat["last_message"]}".toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  List<Map<String, dynamic>> get currentChatMessages {
    if (selectedChat.isEmpty) return [];
    return messages.where((msg) => msg["chat_id"] == selectedChat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internal Messaging"),
        actions: [
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {
              // Create new group chat
            },
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Start new direct message
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Chat List Panel
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: QTextField(
                    label: "Search conversations...",
                    value: searchQuery,
                    hint: "Search by name or message",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),

                // Chat List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = filteredChats[index];
                      final isSelected = selectedChat == chat["id"];
                      
                      return GestureDetector(
                        onTap: () {
                          selectedChat = "${chat["id"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor.withAlpha(50),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: chat["type"] == "group" 
                                        ? infoColor.withAlpha(30)
                                        : primaryColor.withAlpha(30),
                                    backgroundImage: chat["avatar"] != null 
                                        ? NetworkImage("${chat["avatar"]}")
                                        : null,
                                    child: chat["avatar"] == null
                                        ? Icon(
                                            chat["type"] == "group" ? Icons.group : Icons.person,
                                            color: chat["type"] == "group" ? infoColor : primaryColor,
                                            size: 20,
                                          )
                                        : null,
                                  ),
                                  if (chat["is_online"] == true && chat["type"] == "direct")
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
                              
                              // Chat Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${chat["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          DateTime.parse("${chat["last_message_time"]}").dMMMykkss,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        if (chat["last_sender"] != "You")
                                          Text(
                                            "${chat["last_sender"]}: ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        Expanded(
                                          child: Text(
                                            "${chat["last_message"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if ((chat["unread_count"] as int) > 0)
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: dangerColor,
                                              borderRadius: BorderRadius.circular(radiusLg),
                                            ),
                                            child: Text(
                                              "${chat["unread_count"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
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
                    },
                  ),
                ),
              ],
            ),
          ),

          // Chat Messages Panel
          Expanded(
            child: selectedChat.isEmpty
                ? Container(
                    color: Colors.grey[50],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Select a conversation to start messaging",
                            style: TextStyle(
                              fontSize: fsH6,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        // Chat Header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor.withAlpha(30),
                                child: Icon(
                                  Icons.group,
                                  color: primaryColor,
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chats.firstWhere((c) => c["id"] == selectedChat)["name"],
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${(chats.firstWhere((c) => c["id"] == selectedChat)["participants"] as List).length} participants",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                icon: Icons.info,
                                size: bs.sm,
                                onPressed: () {
                                  // Show chat info
                                },
                              ),
                            ],
                          ),
                        ),

                        // Messages Area
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(spSm),
                            itemCount: currentChatMessages.length,
                            itemBuilder: (context, index) {
                              final message = currentChatMessages[index];
                              final isOwnMessage = message["is_own_message"] as bool;
                              
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                child: Row(
                                  mainAxisAlignment: isOwnMessage 
                                      ? MainAxisAlignment.end 
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!isOwnMessage) ...[
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: primaryColor.withAlpha(30),
                                        backgroundImage: message["sender_avatar"] != null
                                            ? NetworkImage("${message["sender_avatar"]}")
                                            : null,
                                        child: message["sender_avatar"] == null
                                            ? Text(
                                                "${message["sender"]}".split(' ').map((name) => name[0]).join(''),
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : null,
                                      ),
                                      SizedBox(width: spXs),
                                    ],
                                    
                                    Flexible(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                                        ),
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: isOwnMessage 
                                              ? primaryColor 
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(radiusMd),
                                          boxShadow: [shadowSm],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (!isOwnMessage)
                                              Text(
                                                "${message["sender"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            if (!isOwnMessage)
                                              SizedBox(height: spXs),
                                            Text(
                                              "${message["message"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isOwnMessage 
                                                    ? Colors.white 
                                                    : disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              DateTime.parse("${message["timestamp"]}").dMMMy + " " + 
                                              DateTime.parse("${message["timestamp"]}").hour.toString().padLeft(2, '0') + ":" +
                                              DateTime.parse("${message["timestamp"]}").minute.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isOwnMessage 
                                                    ? Colors.white.withAlpha(180)
                                                    : disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    if (isOwnMessage) ...[
                                      SizedBox(width: spXs),
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: primaryColor.withAlpha(30),
                                        child: Text(
                                          "YU",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // Message Input
                        Container(
                          padding: EdgeInsets.all(spSm),
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
                              QButton(
                                icon: Icons.attach_file,
                                size: bs.sm,
                                onPressed: () {
                                  // Attach file
                                },
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QTextField(
                                  label: "Type a message...",
                                  value: messageText,
                                  hint: "Type your message here",
                                  onChanged: (value) {
                                    messageText = value;
                                    setState(() {});
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.send,
                                size: bs.sm,
                                onPressed: () {
                                  if (messageText.trim().isNotEmpty) {
                                    // Send message
                                    messageText = "";
                                    setState(() {});
                                    ss("Message sent!");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
