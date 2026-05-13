import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaGroupChatView extends StatefulWidget {
  const EmaGroupChatView({super.key});

  @override
  State<EmaGroupChatView> createState() => _EmaGroupChatViewState();
}

class _EmaGroupChatViewState extends State<EmaGroupChatView> {
  String messageText = "";
  List<String> attachments = [];
  
  Map<String, dynamic> groupData = {
    "id": "group_001",
    "name": "Healthcare Innovation Team",
    "description": "Discussing latest healthcare technology trends and AI implementations",
    "avatar": "https://picsum.photos/60/60?random=1&keyword=team",
    "memberCount": 127,
    "isOnline": true,
    "lastActive": "2 minutes ago",
    "type": "public",
    "category": "Healthcare",
    "created": "2024-01-15",
  };

  List<Map<String, dynamic>> members = [
    {
      "id": "user_001",
      "name": "Dr. Sarah Johnson",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=doctor",
      "role": "Admin",
      "isOnline": true,
      "lastSeen": "now",
      "expertise": "AI Healthcare",
    },
    {
      "id": "user_002", 
      "name": "Prof. Michael Chen",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=professor",
      "role": "Moderator",
      "isOnline": true,
      "lastSeen": "5 minutes ago",
      "expertise": "Medical Technology",
    },
    {
      "id": "user_003",
      "name": "Dr. Emily Rodriguez",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=doctor",
      "role": "Member",
      "isOnline": false,
      "lastSeen": "1 hour ago",
      "expertise": "Digital Health",
    },
    {
      "id": "user_004",
      "name": "Alex Thompson",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=tech",
      "role": "Member",
      "isOnline": true,
      "lastSeen": "now",
      "expertise": "Healthcare Software",
    },
    {
      "id": "user_005",
      "name": "Dr. Maria Garcia",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=medical",
      "role": "Member",
      "isOnline": false,
      "lastSeen": "3 hours ago",
      "expertise": "Telemedicine",
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "msg_001",
      "senderId": "user_002",
      "senderName": "Prof. Michael Chen",
      "senderAvatar": "https://picsum.photos/40/40?random=2&keyword=professor",
      "message": "Great presentation on AI diagnostics yesterday! The accuracy improvements are remarkable.",
      "timestamp": "10:30",
      "type": "text",
      "isOwn": false,
      "reactions": [
        {"emoji": "👍", "count": 5, "users": ["user_001", "user_003", "user_004", "user_005"]},
        {"emoji": "💡", "count": 2, "users": ["user_001", "user_004"]},
      ],
    },
    {
      "id": "msg_002",
      "senderId": "user_001",
      "senderName": "Dr. Sarah Johnson",
      "senderAvatar": "https://picsum.photos/40/40?random=1&keyword=doctor",
      "message": "Thank you! The machine learning model showed 94% accuracy in early stage detection.",
      "timestamp": "10:32",
      "type": "text",
      "isOwn": false,
      "reactions": [],
    },
    {
      "id": "msg_003",
      "senderId": "user_004",
      "senderName": "Alex Thompson",
      "senderAvatar": "https://picsum.photos/40/40?random=4&keyword=tech",
      "message": "I've been working on similar algorithms. Would love to collaborate on this project.",
      "timestamp": "10:35",
      "type": "text",
      "isOwn": true,
      "reactions": [
        {"emoji": "🤝", "count": 3, "users": ["user_001", "user_002", "user_003"]},
      ],
    },
    {
      "id": "msg_004",
      "senderId": "user_003",
      "senderName": "Dr. Emily Rodriguez",
      "senderAvatar": "https://picsum.photos/40/40?random=3&keyword=doctor",
      "message": "Research papers shared in files",
      "timestamp": "10:38",
      "type": "file",
      "isOwn": false,
      "files": [
        {
          "name": "AI_Healthcare_Research_2024.pdf",
          "size": "2.4 MB",
          "type": "pdf",
        },
        {
          "name": "Medical_AI_Guidelines.docx",
          "size": "1.8 MB",
          "type": "doc",
        },
      ],
      "reactions": [],
    },
    {
      "id": "msg_005",
      "senderId": "user_001",
      "senderName": "Dr. Sarah Johnson",
      "senderAvatar": "https://picsum.photos/40/40?random=1&keyword=doctor",
      "message": "Excellent resources! This will help with our upcoming conference presentation.",
      "timestamp": "10:40",
      "type": "text",
      "isOwn": false,
      "reactions": [
        {"emoji": "📚", "count": 4, "users": ["user_002", "user_003", "user_004", "user_005"]},
      ],
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Group Chat",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Chat", icon: Icon(Icons.chat)),
        Tab(text: "Members", icon: Icon(Icons.people)),
        Tab(text: "Files", icon: Icon(Icons.folder)),
        Tab(text: "Info", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildChatTab(),
        _buildMembersTab(),
        _buildFilesTab(),
        _buildInfoTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        // Group Header
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${groupData["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${groupData["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${groupData["memberCount"]} members • ${groupData["lastActive"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (groupData["isOnline"]) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 11,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Messages List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              bool isOwn = message["isOwn"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isOwn) ...[
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          image: DecorationImage(
                            image: NetworkImage("${message["senderAvatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (!isOwn) ...[
                            Row(
                              children: [
                                Text(
                                  "${message["senderName"]}",
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
                          
                          Container(
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: isOwn ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (message["type"] == "text") ...[
                                  Text(
                                    "${message["message"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isOwn ? Colors.white : primaryColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ] else if (message["type"] == "file") ...[
                                  Text(
                                    "${message["message"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isOwn ? Colors.white : primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  ...(message["files"] as List).map((file) => Container(
                                    margin: EdgeInsets.only(bottom: spXs),
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: isOwn ? Colors.white.withAlpha(25) : primaryColor.withAlpha(25),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          file["type"] == "pdf" ? Icons.picture_as_pdf : Icons.file_present,
                                          color: isOwn ? Colors.white : primaryColor,
                                          size: 20,
                                        ),
                                        SizedBox(width: spSm),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${file["name"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: isOwn ? Colors.white : primaryColor,
                                                ),
                                              ),
                                              Text(
                                                "${file["size"]}",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: isOwn ? Colors.white.withAlpha(180) : disabledBoldColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.download,
                                          color: isOwn ? Colors.white : primaryColor,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  )).toList(),
                                ],
                                
                                if (isOwn) ...[
                                  SizedBox(height: spXs),
                                  Text(
                                    "${message["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withAlpha(180),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Reactions
                          if ((message["reactions"] as List).isNotEmpty) ...[
                            SizedBox(height: spXs),
                            Row(
                              children: (message["reactions"] as List).map((reaction) => Container(
                                margin: EdgeInsets.only(right: spXs),
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "${reaction["emoji"]}",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${reaction["count"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )).toList().cast<Widget>(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isOwn) ...[
                      SizedBox(width: spMd),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                          color: primaryColor,
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
          child: QChatField(
            label: "Type a message",
            value: messageText,
            hint: "Share your thoughts with the team...",
            attachments: attachments,
            showAttachmentButton: true,
            showEmojiButton: true,
            showVoiceButton: true,
            onChanged: (value) {
              messageText = value;
              setState(() {});
            },
            onSend: () {
              if (messageText.isNotEmpty || attachments.isNotEmpty) {
                ss("Message sent");
                messageText = "";
                attachments = [];
                setState(() {});
              }
            },
            onAttachmentsChanged: (value) {
              attachments = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMembersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Group Members (${members.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...members.map((member) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
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
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${member["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (member["isOnline"]) ...[
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
                  ],
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${member["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: member["role"] == "Admin" ? dangerColor.withAlpha(25) :
                                    member["role"] == "Moderator" ? warningColor.withAlpha(25) :
                                    primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${member["role"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: member["role"] == "Admin" ? dangerColor :
                                      member["role"] == "Moderator" ? warningColor :
                                      primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${member["expertise"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        member["isOnline"] ? "Online now" : "Last seen ${member["lastSeen"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: member["isOnline"] ? successColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.message,
                  size: bs.sm,
                  onPressed: () {
                    ss("Opening chat with ${member["name"]}");
                  },
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildFilesTab() {
    List<Map<String, dynamic>> files = [
      {
        "name": "AI_Healthcare_Research_2024.pdf",
        "size": "2.4 MB",
        "type": "pdf",
        "uploadedBy": "Dr. Emily Rodriguez",
        "uploadedDate": "2024-12-15",
        "downloads": 23,
      },
      {
        "name": "Medical_AI_Guidelines.docx",
        "size": "1.8 MB",
        "type": "doc",
        "uploadedBy": "Prof. Michael Chen",
        "uploadedDate": "2024-12-14",
        "downloads": 18,
      },
      {
        "name": "Healthcare_Trends_2024.pptx",
        "size": "5.2 MB",
        "type": "ppt",
        "uploadedBy": "Dr. Sarah Johnson",
        "uploadedDate": "2024-12-13",
        "downloads": 31,
      },
      {
        "name": "AI_Implementation_Chart.xlsx",
        "size": "892 KB",
        "type": "excel",
        "uploadedBy": "Alex Thompson",
        "uploadedDate": "2024-12-12",
        "downloads": 15,
      },
      {
        "name": "Team_Photo_Conference.jpg",
        "size": "3.1 MB",
        "type": "image",
        "uploadedBy": "Dr. Maria Garcia",
        "uploadedDate": "2024-12-11",
        "downloads": 42,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shared Files",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...files.map((file) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    file["type"] == "pdf" ? Icons.picture_as_pdf :
                    file["type"] == "doc" ? Icons.description :
                    file["type"] == "ppt" ? Icons.slideshow :
                    file["type"] == "excel" ? Icons.table_chart :
                    file["type"] == "image" ? Icons.image : Icons.file_present,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${file["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Uploaded by ${file["uploadedBy"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${file["size"]} • ${file["downloads"]} downloads",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    ss("Downloading ${file["name"]}");
                  },
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Group Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    image: DecorationImage(
                      image: NetworkImage("${groupData["avatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "${groupData["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spSm),
                Text(
                  "${groupData["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Group Statistics
          Text(
            "Group Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${groupData["memberCount"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Members",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.message, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "1,247",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Messages Sent",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.folder, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "45",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Files Shared",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.schedule, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "8",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Months Active",
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

          SizedBox(height: spLg),

          // Group Settings
          Text(
            "Group Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.public, color: primaryColor, size: 24),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Group Type",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${groupData["type"].toString().toUpperCase()}",
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
                SizedBox(height: spMd),
                Divider(color: disabledOutlineBorderColor),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(Icons.category, color: primaryColor, size: 24),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${groupData["category"]}",
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
                SizedBox(height: spMd),
                Divider(color: disabledOutlineBorderColor),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: primaryColor, size: 24),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Created Date",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${groupData["created"]}",
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
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Action Buttons
          Container(
            width: double.infinity,
            child: QButton(
              label: "Leave Group",
              color: dangerColor,
              size: bs.md,
              onPressed: () {
                ss("Left group: ${groupData["name"]}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
