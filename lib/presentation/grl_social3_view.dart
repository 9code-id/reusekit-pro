import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial3View extends StatefulWidget {
  @override
  State<GrlSocial3View> createState() => _GrlSocial3ViewState();
}

class _GrlSocial3ViewState extends State<GrlSocial3View> {
  List<Map<String, dynamic>> conversations = [
    {
      "id": "1",
      "type": "private",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "lastMessage": "Hey! Did you see the latest episode? It was amazing! 🎬",
      "timestamp": "2024-12-22T14:45:00Z",
      "unreadCount": 2,
      "isOnline": true,
      "isTyping": false,
      "verified": true
    },
    {
      "id": "2",
      "type": "private", 
      "name": "Marcus Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "lastMessage": "Thanks for the recommendation! I'll check it out",
      "timestamp": "2024-12-22T13:20:00Z",
      "unreadCount": 0,
      "isOnline": false,
      "isTyping": false,
      "verified": false
    },
    {
      "id": "3",
      "type": "group",
      "name": "Photography Club",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=camera",
      "lastMessage": "Alex: Who's joining the weekend photowalk?",
      "timestamp": "2024-12-22T12:15:00Z",
      "unreadCount": 5,
      "isOnline": false,
      "isTyping": true,
      "verified": false,
      "participantCount": 12
    },
    {
      "id": "4",
      "type": "private",
      "name": "Emily Rodriguez",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "lastMessage": "Love your latest artwork! So inspiring 🎨",
      "timestamp": "2024-12-22T11:30:00Z",
      "unreadCount": 0,
      "isOnline": true,
      "isTyping": false,
      "verified": true
    },
    {
      "id": "5",
      "type": "group",
      "name": "Tech Enthusiasts",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=computer",
      "lastMessage": "David: Check out this new AI tool I found",
      "timestamp": "2024-12-22T10:45:00Z",
      "unreadCount": 8,
      "isOnline": false,
      "isTyping": false,
      "verified": false,
      "participantCount": 24
    },
    {
      "id": "6",
      "type": "private",
      "name": "Maya Patel",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
      "lastMessage": "Recipe shared! Let me know how it turns out 👩‍🍳",
      "timestamp": "2024-12-22T09:20:00Z",
      "unreadCount": 1,
      "isOnline": false,
      "isTyping": false,
      "verified": true
    },
    {
      "id": "7",
      "type": "group",
      "name": "Fitness Motivation",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=fitness",
      "lastMessage": "Ryan: Great workout session today! 💪",
      "timestamp": "2024-12-21T19:30:00Z",
      "unreadCount": 0,
      "isOnline": false,
      "isTyping": false,
      "verified": false,
      "participantCount": 8
    }
  ];

  List<Map<String, dynamic>> activeUsers = [
    {
      "id": "a1",
      "name": "Alex",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=person"
    },
    {
      "id": "a2",
      "name": "Luna",
      "avatar": "https://picsum.photos/100/100?random=9&keyword=woman"
    },
    {
      "id": "a3",
      "name": "James",
      "avatar": "https://picsum.photos/100/100?random=10&keyword=man"
    },
    {
      "id": "a4",
      "name": "Sophie",
      "avatar": "https://picsum.photos/100/100?random=11&keyword=woman"
    },
    {
      "id": "a5",
      "name": "Ryan",
      "avatar": "https://picsum.photos/100/100?random=12&keyword=man"
    }
  ];

  String searchQuery = "";
  String selectedFilter = "all";

  void _startNewChat() {
    si("Opening new chat dialog...");
  }

  void _createGroup() {
    si("Creating new group chat...");
  }

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration diff = now.difference(dateTime);
    
    if (diff.inDays > 0) {
      if (diff.inDays == 1) {
        return "Yesterday";
      } else if (diff.inDays < 7) {
        return "${diff.inDays}d ago";
      } else {
        return "${dateTime.day}/${dateTime.month}";
      }
    } else if (diff.inHours > 0) {
      return "${diff.inHours}h ago";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}m ago";
    } else {
      return "now";
    }
  }

  List<Map<String, dynamic>> _getFilteredConversations() {
    List<Map<String, dynamic>> filtered = List.from(conversations);
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((conv) {
        return conv["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               conv["lastMessage"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    // Filter by type
    if (selectedFilter != "all") {
      filtered = filtered.where((conv) => conv["type"] == selectedFilter).toList();
    }
    
    // Sort by timestamp (most recent first)
    filtered.sort((a, b) => b["timestamp"].toString().compareTo(a["timestamp"].toString()));
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredConversations = _getFilteredConversations();
    int totalUnread = conversations.fold(0, (sum, conv) => sum + (conv["unreadCount"] as int));
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Messages"),
            if (totalUnread > 0) ...[
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  totalUnread > 99 ? "99+" : totalUnread.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _startNewChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // Active Users Section
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Text(
                    "Active Now",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: activeUsers.length,
                    itemBuilder: (context, index) {
                      final user = activeUsers[index];
                      
                      return Container(
                        width: 60,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage("${user["avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: successColor,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${user["name"]}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.group_add,
                      size: bs.sm,
                      onPressed: _createGroup,
                    ),
                  ],
                ),
                QHorizontalScroll(
                  children: [
                    _buildFilterChip("All", "all"),
                    _buildFilterChip("Private", "private"),
                    _buildFilterChip("Groups", "group"),
                    _buildFilterChip("Unread", "unread"),
                  ],
                ),
              ],
            ),
          ),

          // Conversations List
          Expanded(
            child: filteredConversations.isEmpty
                ? Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: disabledBoldColor,
                        ),
                        Text(
                          searchQuery.isNotEmpty 
                              ? "No conversations found"
                              : "No messages yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          searchQuery.isNotEmpty
                              ? "Try a different search term"
                              : "Start a conversation with someone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Start New Chat",
                          icon: Icons.add,
                          size: bs.md,
                          onPressed: _startNewChat,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredConversations.length,
                    itemBuilder: (context, index) {
                      final conversation = filteredConversations[index];
                      bool isGroup = conversation["type"] == "group";
                      bool hasUnread = (conversation["unreadCount"] as int) > 0;
                      bool isOnline = conversation["isOnline"] as bool;
                      bool isTyping = conversation["isTyping"] as bool;
                      bool isVerified = conversation["verified"] as bool;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: hasUnread ? primaryColor.withAlpha(5) : Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: disabledColor.withAlpha(30),
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Navigate to chat
                            si("Opening chat with ${conversation["name"]}");
                          },
                          child: Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage("${conversation["avatar"]}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (isOnline && !isGroup)
                                      Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: successColor,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                    if (isGroup)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                          child: Icon(
                                            Icons.group,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${conversation["name"]}",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                if (isVerified) ...[
                                                  SizedBox(width: spXs),
                                                  Icon(
                                                    Icons.verified,
                                                    size: 14,
                                                    color: primaryColor,
                                                  ),
                                                ],
                                                if (isGroup) ...[
                                                  SizedBox(width: spXs),
                                                  Text(
                                                    "(${conversation["participantCount"]})",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          Text(
                                            _formatTimestamp("${conversation["timestamp"]}"),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: hasUnread ? primaryColor : disabledBoldColor,
                                              fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              isTyping ? "Typing..." : "${conversation["lastMessage"]}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: isTyping ? primaryColor : 
                                                       hasUnread ? primaryColor : disabledBoldColor,
                                                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                                                fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          if (hasUnread)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusLg),
                                              ),
                                              child: Text(
                                                "${conversation["unreadCount"]}",
                                                style: TextStyle(
                                                  fontSize: 11,
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewChat,
        backgroundColor: primaryColor,
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    bool isSelected = selectedFilter == value || 
                     (value == "unread" && selectedFilter == "unread");
    
    // For unread filter, show count
    int unreadCount = 0;
    if (value == "unread") {
      unreadCount = conversations.where((conv) => (conv["unreadCount"] as int) > 0).length;
      isSelected = selectedFilter == "unread";
    }
    
    return GestureDetector(
      onTap: () {
        if (value == "unread") {
          selectedFilter = selectedFilter == "unread" ? "all" : "unread";
        } else {
          selectedFilter = value;
        }
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledBoldColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (value == "unread" && unreadCount > 0) ...[
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : dangerColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? primaryColor : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
