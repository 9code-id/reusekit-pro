import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial6View extends StatefulWidget {
  @override
  State<GrlSocial6View> createState() => _GrlSocial6ViewState();
}

class _GrlSocial6ViewState extends State<GrlSocial6View> {
  String messageText = "";
  List<String> selectedImages = [];
  
  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "senderId": "other",
      "message": "Hey! How was your weekend?",
      "timestamp": "10:30 AM",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 2,
      "senderId": "me",
      "message": "It was great! Went hiking with friends. Check out this view!",
      "timestamp": "10:32 AM",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 3,
      "senderId": "me",
      "message": "https://picsum.photos/300/200?random=60",
      "timestamp": "10:32 AM",
      "type": "image",
      "isRead": true,
    },
    {
      "id": 4,
      "senderId": "other",
      "message": "Wow! That's absolutely stunning! 😍 Where is this?",
      "timestamp": "10:35 AM",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 5,
      "senderId": "me",
      "message": "It's at Blue Ridge Mountains. You should come with us next time!",
      "timestamp": "10:37 AM",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 6,
      "senderId": "other",
      "message": "I'd love to! Count me in for the next adventure 🏔️",
      "timestamp": "10:38 AM",
      "type": "text",
      "isRead": false,
    },
  ];

  List<Map<String, dynamic>> recentChats = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=70",
      "lastMessage": "That sounds like a great plan! 👍",
      "timestamp": "2:30 PM",
      "unreadCount": 2,
      "isOnline": true,
    },
    {
      "id": 2,
      "name": "Mike Wilson",
      "avatar": "https://picsum.photos/50/50?random=71",
      "lastMessage": "See you tomorrow at 9 AM",
      "timestamp": "1:45 PM",
      "unreadCount": 0,
      "isOnline": false,
    },
    {
      "id": 3,
      "name": "Emily Chen",
      "avatar": "https://picsum.photos/50/50?random=72",
      "lastMessage": "Thanks for sharing the photos!",
      "timestamp": "12:20 PM",
      "unreadCount": 1,
      "isOnline": true,
    },
    {
      "id": 4,
      "name": "David Brown",
      "avatar": "https://picsum.photos/50/50?random=73",
      "lastMessage": "Let's catch up this weekend",
      "timestamp": "11:30 AM",
      "unreadCount": 0,
      "isOnline": false,
    },
    {
      "id": 5,
      "name": "Lisa Garcia",
      "avatar": "https://picsum.photos/50/50?random=74",
      "lastMessage": "Perfect! I'll be there",
      "timestamp": "10:15 AM",
      "unreadCount": 3,
      "isOnline": true,
    },
  ];

  bool isInChat = false;
  Map<String, dynamic>? selectedChat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isInChat
            ? Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isInChat = false;
                      selectedChat = null;
                      setState(() {});
                    },
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                  SizedBox(width: spMd),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${selectedChat!["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedChat!["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          selectedChat!["isOnline"] as bool ? "Online" : "Last seen 2h ago",
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedChat!["isOnline"] as bool ? successColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                "Messages",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: isInChat
            ? [
                Icon(Icons.videocam, size: 24),
                SizedBox(width: spMd),
                Icon(Icons.call, size: 24),
                SizedBox(width: spMd),
                Icon(Icons.more_vert, size: 24),
                SizedBox(width: spMd),
              ]
            : [
                Icon(Icons.search, size: 24),
                SizedBox(width: spMd),
                Icon(Icons.add_circle_outline, size: 24),
                SizedBox(width: spMd),
              ],
      ),
      body: isInChat ? _buildChatView() : _buildChatListView(),
    );
  }

  Widget _buildChatListView() {
    return Column(
      children: [
        // Online Users
        Container(
          height: 80,
          child: QHorizontalScroll(
            children: [
              Container(
                width: 60,
                margin: EdgeInsets.only(left: spMd),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Icon(
                        Icons.add,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Your Story",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ...List.generate(
                recentChats.where((chat) => chat["isOnline"] as bool).length,
                (index) {
                  final onlineChats = recentChats.where((chat) => chat["isOnline"] as bool).toList();
                  final chat = onlineChats[index];
                  
                  return Container(
                    width: 60,
                    margin: EdgeInsets.only(left: spSm),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage("${chat["avatar"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (chat["isOnline"] as bool)
                              Positioned(
                                bottom: 2,
                                right: 2,
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
                        SizedBox(height: spXs),
                        Text(
                          "${chat["name"]}".split(" ")[0],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(width: spMd),
            ],
          ),
        ),
        
        Divider(height: 1, color: disabledBoldColor.withAlpha(50)),
        
        // Chat List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: recentChats.length,
            itemBuilder: (context, index) {
              final chat = recentChats[index];
              final unreadCount = chat["unreadCount"] as int;
              
              return GestureDetector(
                onTap: () {
                  selectedChat = chat;
                  isInChat = true;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${chat["avatar"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (chat["isOnline"] as bool)
                            Positioned(
                              bottom: 2,
                              right: 2,
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
                      SizedBox(width: spMd),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${chat["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${chat["lastMessage"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: unreadCount > 0 ? primaryColor : disabledBoldColor,
                                      fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (unreadCount > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Text(
                                      "$unreadCount",
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
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        // Messages
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: chatMessages.length,
            itemBuilder: (context, index) {
              final message = chatMessages[index];
              final isMe = message["senderId"] == "me";
              final type = message["type"] as String;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isMe)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${selectedChat!["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    if (!isMe) SizedBox(width: spXs),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: isMe ? primaryColor : disabledBoldColor.withAlpha(30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                            bottomLeft: Radius.circular(isMe ? radiusLg : radiusXs),
                            bottomRight: Radius.circular(isMe ? radiusXs : radiusLg),
                          ),
                        ),
                        child: type == "image"
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${message["message"]}",
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Text(
                                "${message["message"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isMe ? Colors.white : primaryColor,
                                ),
                              ),
                      ),
                    ),
                    if (isMe) SizedBox(width: spXs),
                    if (isMe)
                      Text(
                        "${message["timestamp"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
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
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: disabledBoldColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            hintStyle: TextStyle(color: disabledBoldColor),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            messageText = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  if (messageText.isNotEmpty) {
                    // Send message logic
                    messageText = "";
                    setState(() {});
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    messageText.isNotEmpty ? Icons.send : Icons.mic,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
