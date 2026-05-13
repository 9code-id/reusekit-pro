import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat4View extends StatefulWidget {
  @override
  State<GrlChat4View> createState() => _GrlChat4ViewState();
}

class _GrlChat4ViewState extends State<GrlChat4View> {
  int currentTab = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> chats = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "lastMessage": "Hey! How's your day going?",
      "timestamp": "2024-01-15 14:30:00",
      "unreadCount": 2,
      "isOnline": true,
      "isPinned": true,
      "chatType": "personal"
    },
    {
      "id": "2",
      "name": "Team Alpha",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=team",
      "lastMessage": "Meeting scheduled for tomorrow",
      "timestamp": "2024-01-15 13:45:00",
      "unreadCount": 5,
      "isOnline": false,
      "isPinned": true,
      "chatType": "group"
    },
    {
      "id": "3",
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "lastMessage": "Thanks for the update!",
      "timestamp": "2024-01-15 12:20:00",
      "unreadCount": 0,
      "isOnline": true,
      "isPinned": false,
      "chatType": "personal"
    },
    {
      "id": "4",
      "name": "Design Team",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=design",
      "lastMessage": "New mockups ready for review",
      "timestamp": "2024-01-15 11:15:00",
      "unreadCount": 1,
      "isOnline": false,
      "isPinned": false,
      "chatType": "group"
    },
    {
      "id": "5",
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=woman",
      "lastMessage": "See you at the conference!",
      "timestamp": "2024-01-15 10:30:00",
      "unreadCount": 0,
      "isOnline": true,
      "isPinned": false,
      "chatType": "personal"
    }
  ];

  List<Map<String, dynamic>> groups = [
    {
      "id": "1",
      "name": "Product Development",
      "avatar": "https://picsum.photos/50/50?random=10&keyword=product",
      "lastMessage": "Sprint planning meeting tomorrow",
      "timestamp": "2024-01-15 15:00:00",
      "unreadCount": 3,
      "memberCount": 8,
      "description": "Main product development discussions"
    },
    {
      "id": "2",
      "name": "Marketing Team",
      "avatar": "https://picsum.photos/50/50?random=11&keyword=marketing",
      "lastMessage": "Campaign results are looking great!",
      "timestamp": "2024-01-15 14:15:00",
      "unreadCount": 0,
      "memberCount": 5,
      "description": "Marketing strategies and campaigns"
    },
    {
      "id": "3",
      "name": "UI/UX Designers",
      "avatar": "https://picsum.photos/50/50?random=12&keyword=design",
      "lastMessage": "Prototype feedback needed",
      "timestamp": "2024-01-15 13:30:00",
      "unreadCount": 2,
      "memberCount": 6,
      "description": "Design discussions and feedback"
    }
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@company.com",
      "department": "Product Management",
      "isOnline": true,
      "lastSeen": "Online"
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "phone": "+1 (555) 234-5678",
      "email": "mike.chen@company.com",
      "department": "Engineering",
      "isOnline": false,
      "lastSeen": "2 hours ago"
    },
    {
      "id": "3",
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=woman",
      "phone": "+1 (555) 345-6789",
      "email": "emma.wilson@company.com",
      "department": "Design",
      "isOnline": true,
      "lastSeen": "Online"
    },
    {
      "id": "4",
      "name": "David Brown",
      "avatar": "https://picsum.photos/50/50?random=13&keyword=man",
      "phone": "+1 (555) 456-7890",
      "email": "david.brown@company.com",
      "department": "Sales",
      "isOnline": false,
      "lastSeen": "1 day ago"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Messages",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Chats", icon: Icon(Icons.chat)),
        Tab(text: "Groups", icon: Icon(Icons.groups)),
        Tab(text: "Contacts", icon: Icon(Icons.contacts)),
      ],
      tabChildren: [
        _buildChatsTab(),
        _buildGroupsTab(),
        _buildContactsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController
      },
    );
  }

  Widget _buildChatsTab() {
    final pinnedChats = chats.where((chat) => chat["isPinned"] as bool).toList();
    final regularChats = chats.where((chat) => !(chat["isPinned"] as bool)).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search chats...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("New chat");
                },
              ),
            ],
          ),
          
          // Pinned Chats
          if (pinnedChats.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.push_pin,
                  size: 16,
                  color: primaryColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Pinned",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ...pinnedChats.map((chat) => _buildChatItem(chat)),
          ],
          
          // Regular Chats
          if (regularChats.isNotEmpty) ...[
            if (pinnedChats.isNotEmpty)
              Text(
                "All Chats",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ...regularChats.map((chat) => _buildChatItem(chat)),
          ],
        ],
      ),
    );
  }

  Widget _buildGroupsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "Groups",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  si("Create new group");
                },
              ),
            ],
          ),
          
          // Groups List
          ...groups.map((group) => _buildGroupItem(group)),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Text(
                "Contacts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {
                  si("Add new contact");
                },
              ),
            ],
          ),
          
          // Contacts List
          ...contacts.map((contact) => _buildContactItem(contact)),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("${chat["avatar"]}"),
              ),
              if (chat["chatType"] == "group")
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.group,
                      size: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (chat["chatType"] == "personal" && chat["isOnline"] as bool)
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (chat["isPinned"] as bool) ...[
                      Icon(
                        Icons.push_pin,
                        size: 12,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                    ],
                    Expanded(
                      child: Text(
                        "${chat["name"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${DateTime.parse(chat["timestamp"]).dMMMy}",
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
                    Expanded(
                      child: Text(
                        "${chat["lastMessage"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if ((chat["unreadCount"] as int) > 0)
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
                          "${chat["unreadCount"]}",
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
    );
  }

  Widget _buildGroupItem(Map<String, dynamic> group) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("${group["avatar"]}"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.group,
                    size: 8,
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
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${group["name"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${DateTime.parse(group["timestamp"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${group["memberCount"]} members",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${group["lastMessage"]}",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if ((group["unreadCount"] as int) > 0)
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
                          "${group["unreadCount"]}",
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
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage("${contact["avatar"]}"),
              ),
              if (contact["isOnline"] as bool)
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contact["name"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${contact["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: contact["isOnline"] as bool ? successColor : disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${contact["lastSeen"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: contact["isOnline"] as bool ? successColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.chat,
                size: bs.sm,
                onPressed: () {
                  si("Start chat with ${contact["name"]}");
                },
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.call,
                size: bs.sm,
                onPressed: () {
                  si("Call ${contact["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
