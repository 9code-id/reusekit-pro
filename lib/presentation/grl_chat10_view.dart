import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat10View extends StatefulWidget {
  @override
  State<GrlChat10View> createState() => _GrlChat10ViewState();
}

class _GrlChat10ViewState extends State<GrlChat10View> {
  String searchQuery = "";
  String selectedFilter = "All";
  String newMessage = "";
  List<String> attachments = [];
  bool isTyping = false;
  String selectedChatId = "";

  List<Map<String, dynamic>> chatRooms = [
    {
      "id": "room1",
      "name": "General Discussion",
      "type": "public",
      "participants": 124,
      "lastMessage": "Welcome everyone! Please introduce yourselves.",
      "lastTime": "2 min ago",
      "unreadCount": 3,
      "avatar": "https://picsum.photos/50/50?random=1",
      "isOnline": true,
      "category": "General"
    },
    {
      "id": "room2", 
      "name": "Tech Talk",
      "type": "public",
      "participants": 89,
      "lastMessage": "What's your favorite programming language?",
      "lastTime": "5 min ago",
      "unreadCount": 0,
      "avatar": "https://picsum.photos/50/50?random=2",
      "isOnline": true,
      "category": "Technology"
    },
    {
      "id": "room3",
      "name": "Coffee Break",
      "type": "private",
      "participants": 15,
      "lastMessage": "Anyone up for coffee at 3 PM?",
      "lastTime": "12 min ago", 
      "unreadCount": 1,
      "avatar": "https://picsum.photos/50/50?random=3",
      "isOnline": false,
      "category": "Social"
    },
    {
      "id": "room4",
      "name": "Project Alpha",
      "type": "private",
      "participants": 8,
      "lastMessage": "Deadline moved to next Friday",
      "lastTime": "1 hour ago",
      "unreadCount": 0,
      "avatar": "https://picsum.photos/50/50?random=4",
      "isOnline": true,
      "category": "Work"
    },
    {
      "id": "room5",
      "name": "Gaming Squad",
      "type": "public",
      "participants": 67,
      "lastMessage": "New tournament starts tonight!",
      "lastTime": "2 hours ago",
      "unreadCount": 5,
      "avatar": "https://picsum.photos/50/50?random=5",
      "isOnline": true,
      "category": "Gaming"
    }
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "msg1",
      "userId": "user1",
      "userName": "Alex Johnson",
      "userAvatar": "https://picsum.photos/40/40?random=10",
      "message": "Welcome everyone! Please introduce yourselves.",
      "timestamp": "2:30 PM",
      "type": "text",
      "isCurrentUser": false,
      "reactions": [
        {"emoji": "👋", "count": 5, "users": ["user2", "user3", "user4", "user5", "user6"]},
        {"emoji": "❤️", "count": 2, "users": ["user7", "user8"]}
      ]
    },
    {
      "id": "msg2",
      "userId": "user2", 
      "userName": "Sarah Wilson",
      "userAvatar": "https://picsum.photos/40/40?random=11",
      "message": "Hi everyone! I'm Sarah, a web developer from San Francisco.",
      "timestamp": "2:32 PM",
      "type": "text",
      "isCurrentUser": false,
      "reactions": []
    },
    {
      "id": "msg3",
      "userId": "current",
      "userName": "You",
      "userAvatar": "https://picsum.photos/40/40?random=12",
      "message": "Hello! Great to meet you all. I'm a mobile developer.",
      "timestamp": "2:35 PM",
      "type": "text", 
      "isCurrentUser": true,
      "reactions": [
        {"emoji": "👍", "count": 3, "users": ["user1", "user2", "user3"]}
      ]
    },
    {
      "id": "msg4",
      "userId": "user3",
      "userName": "Mike Chen",
      "userAvatar": "https://picsum.photos/40/40?random=13",
      "message": "https://picsum.photos/300/200?random=20",
      "timestamp": "2:38 PM",
      "type": "image",
      "isCurrentUser": false,
      "reactions": [
        {"emoji": "🔥", "count": 4, "users": ["user1", "user2", "user4", "user5"]}
      ]
    }
  ];

  List<String> filterOptions = ["All", "General", "Technology", "Social", "Work", "Gaming"];

  List<Map<String, dynamic>> get filteredChatRooms {
    List<Map<String, dynamic>> filtered = chatRooms;
    
    if (selectedFilter != "All") {
      filtered = filtered.where((room) => room["category"] == selectedFilter).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((room) => 
        (room["name"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  void _sendMessage() {
    if (newMessage.trim().isEmpty && attachments.isEmpty) return;
    
    if (newMessage.trim().isNotEmpty) {
      messages.add({
        "id": "msg${messages.length + 1}",
        "userId": "current",
        "userName": "You", 
        "userAvatar": "https://picsum.photos/40/40?random=12",
        "message": newMessage,
        "timestamp": "Now",
        "type": "text",
        "isCurrentUser": true,
        "reactions": []
      });
    }
    
    newMessage = "";
    attachments = [];
    setState(() {});
    
    si("Message sent successfully!");
  }

  void _joinRoom(String roomId) {
    selectedChatId = roomId;
    setState(() {});
    ss("Joined chat room successfully!");
  }

  void _leaveRoom() {
    selectedChatId = "";
    setState(() {});
    si("Left chat room");
  }

  void _addReaction(String messageId, String emoji) {
    final messageIndex = messages.indexWhere((msg) => msg["id"] == messageId);
    if (messageIndex != -1) {
      List<Map<String, dynamic>> reactions = List<Map<String, dynamic>>.from(messages[messageIndex]["reactions"]);
      
      final existingReactionIndex = reactions.indexWhere((reaction) => reaction["emoji"] == emoji);
      if (existingReactionIndex != -1) {
        List<String> users = List<String>.from(reactions[existingReactionIndex]["users"]);
        if (users.contains("current")) {
          users.remove("current");
          reactions[existingReactionIndex]["count"] = (reactions[existingReactionIndex]["count"] as int) - 1;
          reactions[existingReactionIndex]["users"] = users;
          
          if (reactions[existingReactionIndex]["count"] == 0) {
            reactions.removeAt(existingReactionIndex);
          }
        } else {
          users.add("current");
          reactions[existingReactionIndex]["count"] = (reactions[existingReactionIndex]["count"] as int) + 1;
          reactions[existingReactionIndex]["users"] = users;
        }
      } else {
        reactions.add({
          "emoji": emoji,
          "count": 1,
          "users": ["current"]
        });
      }
      
      messages[messageIndex]["reactions"] = reactions;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedChatId.isEmpty) {
      return _buildChatRoomList();
    } else {
      return _buildChatInterface();
    }
  }

  Widget _buildChatRoomList() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Rooms"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Create new chat room");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("More options");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter Section
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search chat rooms...",
                    value: searchQuery,
                    hint: "Enter room name",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    si("Searching for: $searchQuery");
                  },
                ),
              ],
            ),

            // Filter Chips
            QHorizontalScroll(
              children: filterOptions.map((filter) {
                final isSelected = selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Chat Rooms List
            Text(
              "Available Rooms (${filteredChatRooms.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredChatRooms.map((room) {
              final isPrivate = room["type"] == "private";
              return GestureDetector(
                onTap: () => _joinRoom(room["id"]),
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Room Avatar
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusLg),
                              image: DecorationImage(
                                image: NetworkImage("${room["avatar"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (room["isOnline"])
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXl),
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

                      // Room Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${room["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (isPrivate)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Private",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${room["participants"]} members",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${room["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${room["lastMessage"]}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),

                      // Time and Unread Count
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${room["lastTime"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          if ((room["unreadCount"] as int) > 0) ...[
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusXl),
                              ),
                              child: Text(
                                "${room["unreadCount"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create Room",
                          size: bs.sm,
                          icon: Icons.add_circle_outline,
                          onPressed: () {
                            si("Create new chat room");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Join Private",
                          size: bs.sm,
                          icon: Icons.vpn_key,
                          onPressed: () {
                            si("Join private room");
                          },
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

  Widget _buildChatInterface() {
    final currentRoom = chatRooms.firstWhere((room) => room["id"] == selectedChatId);
    
    return Scaffold(
      appBar: AppBar(
        leading: QButton(
          icon: Icons.arrow_back,
          size: bs.sm,
          onPressed: _leaveRoom,
        ),
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${currentRoom["avatar"]}"),
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
                    "${currentRoom["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${currentRoom["participants"]} members",
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
          QButton(
            icon: Icons.videocam,
            size: bs.sm,
            onPressed: () {
              si("Start video call");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.call,
            size: bs.sm,
            onPressed: () {
              si("Start voice call");
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("Room settings");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message["isCurrentUser"] as bool;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCurrentUser) ...[
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXl),
                            image: DecorationImage(
                              image: NetworkImage("${message["userAvatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: isCurrentUser 
                            ? CrossAxisAlignment.end 
                            : CrossAxisAlignment.start,
                          children: [
                            if (!isCurrentUser) ...[
                              Row(
                                children: [
                                  Text(
                                    "${message["userName"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${message["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                            ],
                            
                            // Message Content
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.7,
                              ),
                              padding: EdgeInsets.all(spMd),
                              decoration: BoxDecoration(
                                color: isCurrentUser 
                                  ? primaryColor 
                                  : Colors.grey.withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: message["type"] == "image"
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        child: Image.network(
                                          "${message["message"]}",
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    "${message["message"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isCurrentUser 
                                        ? Colors.white 
                                        : primaryColor,
                                    ),
                                  ),
                            ),
                            
                            // Reactions
                            if ((message["reactions"] as List).isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Wrap(
                                spacing: spXs,
                                children: (message["reactions"] as List<Map<String, dynamic>>).map((reaction) {
                                  final users = reaction["users"] as List<String>;
                                  final hasCurrentUserReaction = users.contains("current");
                                  
                                  return GestureDetector(
                                    onTap: () => _addReaction(message["id"], reaction["emoji"]),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: hasCurrentUserReaction 
                                          ? primaryColor.withAlpha(20)
                                          : Colors.grey.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                        border: Border.all(
                                          color: hasCurrentUserReaction 
                                            ? primaryColor
                                            : Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        "${reaction["emoji"]} ${reaction["count"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: hasCurrentUserReaction 
                                            ? primaryColor
                                            : disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: spXs),
                              // Quick Reaction Buttons
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...["👍", "❤️", "😊", "🔥"].map((emoji) {
                                    return GestureDetector(
                                      onTap: () => _addReaction(message["id"], emoji),
                                      child: Container(
                                        margin: EdgeInsets.only(right: spXs),
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          emoji,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                            
                            if (isCurrentUser) ...[
                              SizedBox(height: spXs),
                              Text(
                                "${message["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isCurrentUser) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusXl),
                            image: DecorationImage(
                              image: NetworkImage("${message["userAvatar"]}"),
                              fit: BoxFit.cover,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
              border: Border(
                top: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                if (attachments.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Wrap(
                      spacing: spSm,
                      children: attachments.map((attachment) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.attach_file,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                attachment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                
                QChatField(
                  label: "Type a message...",
                  value: newMessage,
                  hint: "Share your thoughts with the room",
                  attachments: attachments,
                  showAttachmentButton: true,
                  showEmojiButton: true,
                  showVoiceButton: true,
                  onChanged: (value) {
                    newMessage = value;
                    setState(() {});
                  },
                  onSend: _sendMessage,
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
