import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaMessageView extends StatefulWidget {
  const EmaMessageView({super.key});

  @override
  State<EmaMessageView> createState() => _EmaMessageViewState();
}

class _EmaMessageViewState extends State<EmaMessageView> {
  int currentTab = 0;
  String searchQuery = "";
  bool showOnlineOnly = false;

  List<Map<String, dynamic>> messageTabs = [
    {"label": "All", "count": 12},
    {"label": "Unread", "count": 3},
    {"label": "Groups", "count": 5},
    {"label": "Archived", "count": 8}
  ];

  List<Map<String, dynamic>> conversations = [
    {
      "id": 1,
      "type": "individual",
      "name": "Sarah Johnson",
      "title": "Product Manager",
      "avatar": "https://picsum.photos/100/100?random=601",
      "lastMessage": "Looking forward to our coffee meeting tomorrow!",
      "lastMessageTime": "2024-01-20 15:30:00",
      "unreadCount": 2,
      "isOnline": true,
      "isPinned": true,
      "lastMessageSender": "Sarah Johnson"
    },
    {
      "id": 2,
      "type": "individual",
      "name": "Michael Chen",
      "title": "Senior Developer",
      "avatar": "https://picsum.photos/100/100?random=602",
      "lastMessage": "The code review looks good, thanks!",
      "lastMessageTime": "2024-01-20 14:45:00",
      "unreadCount": 0,
      "isOnline": false,
      "isPinned": false,
      "lastMessageSender": "You"
    },
    {
      "id": 3,
      "type": "group",
      "name": "Product Team Discussion",
      "avatar": "https://picsum.photos/100/100?random=603",
      "lastMessage": "Alex: Let's schedule the sprint planning for next week",
      "lastMessageTime": "2024-01-20 13:20:00",
      "unreadCount": 5,
      "isOnline": false,
      "isPinned": true,
      "memberCount": 8,
      "lastMessageSender": "Alex Thompson"
    },
    {
      "id": 4,
      "type": "individual",
      "name": "Emily Rodriguez",
      "title": "Marketing Director",
      "avatar": "https://picsum.photos/100/100?random=604",
      "lastMessage": "Can you share the marketing deck from the presentation?",
      "lastMessageTime": "2024-01-20 12:15:00",
      "unreadCount": 1,
      "isOnline": true,
      "isPinned": false,
      "lastMessageSender": "Emily Rodriguez"
    },
    {
      "id": 5,
      "type": "group",
      "name": "Event Planning Committee",
      "avatar": "https://picsum.photos/100/100?random=605",
      "lastMessage": "Jennifer: Venue booking confirmed for next month",
      "lastMessageTime": "2024-01-20 11:30:00",
      "unreadCount": 0,
      "isOnline": false,
      "isPinned": false,
      "memberCount": 12,
      "lastMessageSender": "Jennifer Kim"
    },
    {
      "id": 6,
      "type": "individual",
      "name": "David Park",
      "title": "Healthcare Consultant",
      "avatar": "https://picsum.photos/100/100?random=606",
      "lastMessage": "Thanks for the insights on patient care technology",
      "lastMessageTime": "2024-01-20 10:45:00",
      "unreadCount": 0,
      "isOnline": false,
      "isPinned": false,
      "lastMessageSender": "David Park"
    },
    {
      "id": 7,
      "type": "group",
      "name": "Tech Innovation Hub",
      "avatar": "https://picsum.photos/100/100?random=607",
      "lastMessage": "Robert: New AI tools discussion scheduled for Friday",
      "lastMessageTime": "2024-01-20 09:20:00",
      "unreadCount": 3,
      "isOnline": false,
      "isPinned": false,
      "memberCount": 25,
      "lastMessageSender": "Robert Martinez"
    },
    {
      "id": 8,
      "type": "individual",
      "name": "Lisa Wang",
      "title": "Data Scientist",
      "avatar": "https://picsum.photos/100/100?random=608",
      "lastMessage": "The analytics report is ready for review",
      "lastMessageTime": "2024-01-19 16:30:00",
      "unreadCount": 0,
      "isOnline": true,
      "isPinned": false,
      "lastMessageSender": "Lisa Wang"
    },
    {
      "id": 9,
      "type": "group",
      "name": "Design System Updates",
      "avatar": "https://picsum.photos/100/100?random=609",
      "lastMessage": "Carlos: New component library is now available",
      "lastMessageTime": "2024-01-19 15:15:00",
      "unreadCount": 0,
      "isOnline": false,
      "isPinned": false,
      "memberCount": 6,
      "lastMessageSender": "Carlos Rodriguez"
    },
    {
      "id": 10,
      "type": "individual",
      "name": "Jennifer Kim",
      "title": "Software Engineer",
      "avatar": "https://picsum.photos/100/100?random=610",
      "lastMessage": "Great session on React best practices!",
      "lastMessageTime": "2024-01-19 14:00:00",
      "unreadCount": 0,
      "isOnline": false,
      "isPinned": false,
      "lastMessageSender": "Jennifer Kim"
    }
  ];

  List<Map<String, dynamic>> recentContacts = [
    {
      "id": 11,
      "name": "Alex Thompson",
      "title": "UX Designer",
      "avatar": "https://picsum.photos/80/80?random=701",
      "isOnline": true
    },
    {
      "id": 12,
      "name": "Maria Garcia",
      "title": "Project Manager",
      "avatar": "https://picsum.photos/80/80?random=702",
      "isOnline": false
    },
    {
      "id": 13,
      "name": "James Wilson",
      "title": "Backend Developer",
      "avatar": "https://picsum.photos/80/80?random=703",
      "isOnline": true
    },
    {
      "id": 14,
      "name": "Ana Silva",
      "title": "Content Creator",
      "avatar": "https://picsum.photos/80/80?random=704",
      "isOnline": false
    },
    {
      "id": 15,
      "name": "Tom Brown",
      "title": "DevOps Engineer",
      "avatar": "https://picsum.photos/80/80?random=705",
      "isOnline": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Toggle search mode
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: _showMessageOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search conversations...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: _showFilterOptions,
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: List.generate(messageTabs.length, (index) {
                final tab = messageTabs[index];
                final isSelected = currentTab == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentTab = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${tab["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          if ((tab["count"] as int) > 0) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${tab["count"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewConversation,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (currentTab) {
      case 0:
        return _buildAllMessages();
      case 1:
        return _buildUnreadMessages();
      case 2:
        return _buildGroupMessages();
      case 3:
        return _buildArchivedMessages();
      default:
        return _buildAllMessages();
    }
  }

  Widget _buildAllMessages() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Contacts
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Contacts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentContacts.length,
                    itemBuilder: (context, index) {
                      final contact = recentContacts[index];
                      return _buildRecentContactItem(contact);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Pinned Conversations
          if (_getPinnedConversations().isNotEmpty) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: [
                  Icon(Icons.push_pin, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Pinned",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
            ..._getPinnedConversations().map((conversation) => _buildConversationItem(conversation)).toList(),
            SizedBox(height: spMd),
          ],

          // All Conversations
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "All Conversations",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          SizedBox(height: spSm),
          ..._getUnpinnedConversations().map((conversation) => _buildConversationItem(conversation)).toList(),
          SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildUnreadMessages() {
    final unreadConversations = conversations.where((c) => (c["unreadCount"] as int) > 0).toList();
    
    if (unreadConversations.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mark_chat_read,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "All caught up!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "You have no unread messages",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ...unreadConversations.map((conversation) => _buildConversationItem(conversation)).toList(),
          SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildGroupMessages() {
    final groupConversations = conversations.where((c) => c["type"] == "group").toList();
    
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Group Conversations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${groupConversations.length} groups",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ...groupConversations.map((conversation) => _buildConversationItem(conversation)).toList(),
          SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildArchivedMessages() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.archive_outlined,
            size: 64,
            color: disabledColor,
          ),
          SizedBox(height: spMd),
          Text(
            "No archived messages",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Conversations you archive will appear here",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(right: spMd),
      child: GestureDetector(
        onTap: () {
          _startChatWithContact(contact);
        },
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
                      image: NetworkImage("${contact["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (contact["isOnline"] as bool)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
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
            Container(
              width: 60,
              child: Text(
                "${contact["name"]}".split(' ').first,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationItem(Map<String, dynamic> conversation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _openConversation(conversation);
          },
          onLongPress: () {
            _showConversationOptions(conversation);
          },
          borderRadius: BorderRadius.circular(radiusMd),
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                // Avatar with online indicator
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
                    if (conversation["type"] == "individual" && conversation["isOnline"] as bool)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    if (conversation["type"] == "group")
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: spMd),

                // Conversation details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                if (conversation["isPinned"] as bool)
                                  Container(
                                    margin: EdgeInsets.only(right: spXs),
                                    child: Icon(
                                      Icons.push_pin,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    "${conversation["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _formatTime(conversation["lastMessageTime"]),
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spXs),

                      // Subtitle
                      if (conversation["type"] == "individual" && conversation["title"] != null)
                        Text(
                          "${conversation["title"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),

                      if (conversation["type"] == "group")
                        Text(
                          "${conversation["memberCount"]} members",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),

                      SizedBox(height: spXs),

                      // Last message
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${conversation["lastMessage"]}",
                              style: TextStyle(
                                color: (conversation["unreadCount"] as int) > 0 
                                    ? Colors.black87 
                                    : disabledBoldColor,
                                fontSize: 14,
                                fontWeight: (conversation["unreadCount"] as int) > 0 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Unread count
                          if ((conversation["unreadCount"] as int) > 0)
                            Container(
                              margin: EdgeInsets.only(left: spSm),
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "${conversation["unreadCount"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
      ),
    );
  }

  List<Map<String, dynamic>> _getPinnedConversations() {
    return conversations.where((c) => c["isPinned"] as bool).toList();
  }

  List<Map<String, dynamic>> _getUnpinnedConversations() {
    return conversations.where((c) => !(c["isPinned"] as bool)).toList();
  }

  String _formatTime(String timestamp) {
    final messageTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(messageTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays}d ago";
      } else {
        return "${messageTime.day}/${messageTime.month}/${messageTime.year}";
      }
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  void _showMessageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Message Options",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ListTile(
              leading: Icon(Icons.mark_chat_read),
              title: Text("Mark all as read"),
              onTap: () {
                Navigator.pop(context);
                _markAllAsRead();
              },
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Archive all"),
              onTap: () {
                Navigator.pop(context);
                _archiveAllConversations();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Message settings"),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filter Options",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              CheckboxListTile(
                title: Text("Show online users only"),
                value: showOnlineOnly,
                onChanged: (value) {
                  showOnlineOnly = value ?? false;
                  setDialogState(() {});
                  setState(() {});
                },
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        showOnlineOnly = false;
                        setDialogState(() {});
                        setState(() {});
                      },
                      child: Text("Clear"),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Apply"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConversationOptions(Map<String, dynamic> conversation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(conversation["isPinned"] as bool ? Icons.push_pin_outlined : Icons.push_pin),
              title: Text(conversation["isPinned"] as bool ? "Unpin" : "Pin"),
              onTap: () {
                Navigator.pop(context);
                _togglePin(conversation);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_off),
              title: Text("Mute notifications"),
              onTap: () {
                Navigator.pop(context);
                _muteConversation(conversation);
              },
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Archive"),
              onTap: () {
                Navigator.pop(context);
                _archiveConversation(conversation);
              },
            ),
            if ((conversation["unreadCount"] as int) > 0)
              ListTile(
                leading: Icon(Icons.mark_chat_read),
                title: Text("Mark as read"),
                onTap: () {
                  Navigator.pop(context);
                  _markAsRead(conversation);
                },
              ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                _deleteConversation(conversation);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startNewConversation() {
    // Navigate to contact picker or create group
    si("Start new conversation functionality");
  }

  void _startChatWithContact(Map<String, dynamic> contact) {
    // Navigate to chat with this contact
    si("Starting chat with ${contact["name"]}");
  }

  void _openConversation(Map<String, dynamic> conversation) {
    // Mark as read and navigate to chat
    if ((conversation["unreadCount"] as int) > 0) {
      conversation["unreadCount"] = 0;
      setState(() {});
    }
    // Navigate to chat view
    si("Opening conversation with ${conversation["name"]}");
  }

  void _togglePin(Map<String, dynamic> conversation) {
    conversation["isPinned"] = !(conversation["isPinned"] as bool);
    setState(() {});
    si(conversation["isPinned"] as bool ? "Conversation pinned" : "Conversation unpinned");
  }

  void _muteConversation(Map<String, dynamic> conversation) {
    si("Notifications muted for ${conversation["name"]}");
  }

  void _archiveConversation(Map<String, dynamic> conversation) {
    conversations.removeWhere((c) => c["id"] == conversation["id"]);
    setState(() {});
    si("Conversation archived");
  }

  void _markAsRead(Map<String, dynamic> conversation) {
    conversation["unreadCount"] = 0;
    setState(() {});
    si("Marked as read");
  }

  void _deleteConversation(Map<String, dynamic> conversation) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this conversation?");
    if (isConfirmed) {
      conversations.removeWhere((c) => c["id"] == conversation["id"]);
      setState(() {});
      ss("Conversation deleted");
    }
  }

  void _markAllAsRead() {
    for (var conversation in conversations) {
      conversation["unreadCount"] = 0;
    }
    setState(() {});
    ss("All messages marked as read");
  }

  void _archiveAllConversations() async {
    bool isConfirmed = await confirm("Are you sure you want to archive all conversations?");
    if (isConfirmed) {
      conversations.clear();
      setState(() {});
      ss("All conversations archived");
    }
  }
}
