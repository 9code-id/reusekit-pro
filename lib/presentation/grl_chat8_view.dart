import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat8View extends StatefulWidget {
  @override
  State<GrlChat8View> createState() => _GrlChat8ViewState();
}

class _GrlChat8ViewState extends State<GrlChat8View> {
  int currentIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> recentChats = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "lastMessage": "Thanks for the meeting notes!",
      "timestamp": "2024-01-15 14:30:00",
      "unreadCount": 0,
      "isOnline": true,
      "lastSeen": "Online",
      "chatType": "direct"
    },
    {
      "id": "2",
      "name": "Development Team",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=team",
      "lastMessage": "Sprint review meeting at 3 PM",
      "timestamp": "2024-01-15 13:45:00",
      "unreadCount": 3,
      "memberCount": 8,
      "chatType": "group"
    },
    {
      "id": "3",
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "lastMessage": "The bug fix is ready for testing",
      "timestamp": "2024-01-15 12:20:00",
      "unreadCount": 1,
      "isOnline": false,
      "lastSeen": "2 hours ago",
      "chatType": "direct"
    }
  ];

  List<Map<String, dynamic>> contacts = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "department": "Product Management",
      "phone": "+1 (555) 123-4567",
      "email": "sarah.j@company.com",
      "isOnline": true,
      "status": "Available"
    },
    {
      "id": "2",
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "department": "Engineering",
      "phone": "+1 (555) 234-5678",
      "email": "mike.c@company.com",
      "isOnline": false,
      "status": "Away"
    },
    {
      "id": "3",
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=designer",
      "department": "Design",
      "phone": "+1 (555) 345-6789",
      "email": "emma.d@company.com",
      "isOnline": true,
      "status": "In a meeting"
    },
    {
      "id": "4",
      "name": "David Wilson",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=manager",
      "department": "Project Management",
      "phone": "+1 (555) 456-7890",
      "email": "david.w@company.com",
      "isOnline": true,
      "status": "Available"
    }
  ];

  List<Map<String, dynamic>> calls = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
      "callType": "video",
      "direction": "incoming",
      "duration": "23:45",
      "timestamp": "2024-01-15 14:00:00",
      "status": "completed"
    },
    {
      "id": "2",
      "name": "Development Team",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=team",
      "callType": "video",
      "direction": "outgoing",
      "duration": "01:12:30",
      "timestamp": "2024-01-15 10:30:00",
      "status": "completed",
      "participants": 8
    },
    {
      "id": "3",
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "callType": "voice",
      "direction": "missed",
      "duration": "00:00",
      "timestamp": "2024-01-15 09:15:00",
      "status": "missed"
    },
    {
      "id": "4",
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=designer",
      "callType": "voice",
      "direction": "outgoing",
      "duration": "15:20",
      "timestamp": "2024-01-14 16:45:00",
      "status": "completed"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Messages",
      selectedIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.chat),
              if (_getTotalUnreadCount() > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${_getTotalUnreadCount()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          label: "Chats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: "Contacts",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: "Calls",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
      children: [
        _buildChatsTab(),
        _buildContactsTab(),
        _buildCallsTab(),
        _buildSettingsTab(),
      ],
      onTap: (index) {
        currentIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildChatsTab() {
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
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showNewChatOptions();
                },
              ),
            ],
          ),
          
          // Status Update
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: primaryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("https://picsum.photos/40/40?random=99&keyword=person"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update your status",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Let others know what you're up to",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    _showStatusUpdate();
                  },
                ),
              ],
            ),
          ),
          
          // Recent Chats
          Text(
            "Recent Conversations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...recentChats.map((chat) => _buildChatItem(chat)),
          
          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  Icons.group_add,
                  "Create Group",
                  "Start a group conversation",
                  () => si("Create group chat"),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionCard(
                  Icons.campaign,
                  "Broadcast",
                  "Send message to multiple contacts",
                  () => si("Create broadcast"),
                ),
              ),
            ],
          ),
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
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search contacts...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.person_add,
                size: bs.sm,
                onPressed: () {
                  si("Add new contact");
                },
              ),
            ],
          ),
          
          // Online Contacts
          Text(
            "Online (${contacts.where((c) => c["isOnline"] as bool).length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...contacts.where((c) => c["isOnline"] as bool).map((contact) => _buildContactItem(contact)),
          
          // Offline Contacts
          Text(
            "Offline (${contacts.where((c) => !(c["isOnline"] as bool)).length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...contacts.where((c) => !(c["isOnline"] as bool)).map((contact) => _buildContactItem(contact)),
        ],
      ),
    );
  }

  Widget _buildCallsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Call Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Voice Call",
                  icon: Icons.call,
                  size: bs.md,
                  onPressed: () {
                    _showContactPicker("voice");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Video Call",
                  icon: Icons.videocam,
                  size: bs.md,
                  onPressed: () {
                    _showContactPicker("video");
                  },
                ),
              ),
            ],
          ),
          
          // Call History
          Text(
            "Recent Calls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...calls.map((call) => _buildCallItem(call)),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("https://picsum.photos/60/60?random=99&keyword=person"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "john.doe@company.com",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 11,
                            color: successColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {
                    si("Edit profile");
                  },
                ),
              ],
            ),
          ),
          
          // Settings Options
          Text(
            "Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          _buildSettingItem(Icons.notifications, "Notifications", "Manage notification preferences", () {
            si("Notification settings");
          }),
          
          _buildSettingItem(Icons.privacy_tip, "Privacy", "Control who can see your information", () {
            si("Privacy settings");
          }),
          
          _buildSettingItem(Icons.security, "Security", "Manage security and login options", () {
            si("Security settings");
          }),
          
          _buildSettingItem(Icons.storage, "Storage", "Manage chat storage and backups", () {
            si("Storage settings");
          }),
          
          _buildSettingItem(Icons.language, "Language", "Change app language", () {
            si("Language settings");
          }),
          
          _buildSettingItem(Icons.dark_mode, "Theme", "Switch between light and dark theme", () {
            si("Theme settings");
          }),
          
          // Help & Support
          Text(
            "Help & Support",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          _buildSettingItem(Icons.help, "Help Center", "Get help and support", () {
            si("Help center");
          }),
          
          _buildSettingItem(Icons.contact_support, "Contact Us", "Contact support team", () {
            si("Contact support");
          }),
          
          _buildSettingItem(Icons.info, "About", "App version and information", () {
            si("About app");
          }),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: () {
          si("Open chat with ${chat["name"]}");
        },
        child: Container(
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
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.group, size: 8, color: Colors.white),
                      ),
                    ),
                  if (chat["chatType"] == "direct" && chat["isOnline"] as bool)
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
                    Row(
                      children: [
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
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
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
        ),
      ),
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Container(
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
                  radius: 22,
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
                  Text(
                    "${contact["status"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: contact["isOnline"] as bool ? successColor : disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
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
      ),
    );
  }

  Widget _buildCallItem(Map<String, dynamic> call) {
    Color callStatusColor = primaryColor;
    IconData callIcon = Icons.call;
    
    if (call["status"] == "missed") {
      callStatusColor = dangerColor;
    }
    
    if (call["callType"] == "video") {
      callIcon = Icons.videocam;
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage("${call["avatar"]}"),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        call["direction"] == "incoming" ? Icons.call_received :
                        call["direction"] == "outgoing" ? Icons.call_made : Icons.call_received,
                        size: 14,
                        color: callStatusColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${call["name"]}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${DateTime.parse(call["timestamp"]).dMMMy}",
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
                      Icon(
                        callIcon,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        call["status"] == "missed" ? "Missed" : "${call["duration"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: call["status"] == "missed" ? dangerColor : disabledBoldColor,
                        ),
                      ),
                      if (call["participants"] != null) ...[
                        SizedBox(width: spSm),
                        Text(
                          "${call["participants"]} participants",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            QButton(
              icon: callIcon,
              size: bs.sm,
              onPressed: () {
                si("${call["callType"] == "video" ? "Video" : "Voice"} call to ${call["name"]}");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(color: primaryColor.withAlpha(30), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            SizedBox(height: spSm),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXs),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
            ],
          ),
        ),
      ),
    );
  }

  int _getTotalUnreadCount() {
    return recentChats.fold(0, (sum, chat) => sum + (chat["unreadCount"] as int));
  }

  void _showNewChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "New Chat",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: Text("New Direct Chat"),
              onTap: () {
                Navigator.pop(context);
                si("Start new direct chat");
              },
            ),
            ListTile(
              leading: Icon(Icons.group, color: primaryColor),
              title: Text("New Group Chat"),
              onTap: () {
                Navigator.pop(context);
                si("Create new group");
              },
            ),
            ListTile(
              leading: Icon(Icons.campaign, color: primaryColor),
              title: Text("New Broadcast"),
              onTap: () {
                Navigator.pop(context);
                si("Create broadcast list");
              },
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showStatusUpdate() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Update Status",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "What's on your mind?",
                value: "",
                onChanged: (value) {},
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Cancel",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Update",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                        ss("Status updated!");
                      },
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

  void _showContactPicker(String callType) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: disabledOutlineBorderColor, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Select Contact",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${contact["avatar"]}"),
                    ),
                    title: Text("${contact["name"]}"),
                    subtitle: Text("${contact["department"]}"),
                    onTap: () {
                      Navigator.pop(context);
                      si("${callType == "video" ? "Video" : "Voice"} calling ${contact["name"]}");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
