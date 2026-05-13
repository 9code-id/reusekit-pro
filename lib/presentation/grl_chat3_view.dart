import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat3View extends StatefulWidget {
  @override
  State<GrlChat3View> createState() => _GrlChat3ViewState();
}

class _GrlChat3ViewState extends State<GrlChat3View> {
  String message = "";
  List<String> messageAttachments = [];
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Welcome to the Product Launch Team! 🚀",
      "timestamp": "2024-01-15 09:00:00",
      "isMe": false,
      "user": {
        "name": "Alex Smith",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=manager",
        "role": "Team Lead"
      },
      "type": "text"
    },
    {
      "id": "2",
      "message": "Hey everyone! Excited to be part of this team.",
      "timestamp": "2024-01-15 09:05:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text"
    },
    {
      "id": "3",
      "message": "Here's our project timeline for the next quarter",
      "timestamp": "2024-01-15 09:10:00",
      "isMe": false,
      "user": {
        "name": "Sarah Wilson",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
        "role": "Project Manager"
      },
      "type": "file",
      "fileUrl": "https://picsum.photos/200/150?random=10&keyword=document",
      "fileName": "Q1_Timeline.pdf",
      "fileSize": "2.4 MB"
    },
    {
      "id": "4",
      "message": "Thanks for sharing! I'll review this by end of day.",
      "timestamp": "2024-01-15 09:15:00",
      "isMe": false,
      "user": {
        "name": "Mike Johnson",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=developer",
        "role": "Lead Developer"
      },
      "type": "text"
    },
    {
      "id": "5",
      "message": "Great! Also, here are some initial mockups from our design team",
      "timestamp": "2024-01-15 09:20:00",
      "isMe": false,
      "user": {
        "name": "Emma Davis",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=designer",
        "role": "UI Designer"
      },
      "type": "image",
      "imageUrl": "https://picsum.photos/300/200?random=11&keyword=mockup"
    },
    {
      "id": "6",
      "message": "The designs look fantastic! Love the color scheme and layout.",
      "timestamp": "2024-01-15 09:25:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text"
    },
    {
      "id": "7",
      "message": "Meeting scheduled for tomorrow at 2 PM to discuss next steps",
      "timestamp": "2024-01-15 09:30:00",
      "isMe": false,
      "user": {
        "name": "Alex Smith",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=manager",
        "role": "Team Lead"
      },
      "type": "announcement"
    }
  ];

  List<Map<String, dynamic>> teamMembers = [
    {
      "name": "Alex Smith",
      "role": "Team Lead",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=manager",
      "isOnline": true
    },
    {
      "name": "Sarah Wilson", 
      "role": "Project Manager",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "isOnline": true
    },
    {
      "name": "Mike Johnson",
      "role": "Lead Developer", 
      "avatar": "https://picsum.photos/40/40?random=4&keyword=developer",
      "isOnline": false
    },
    {
      "name": "Emma Davis",
      "role": "UI Designer",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=designer", 
      "isOnline": true
    },
    {
      "name": "You",
      "role": "Team Member",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "isOnline": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Icon(
                Icons.groups,
                color: primaryColor,
                size: 20,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Launch Team",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${teamMembers.where((m) => m["isOnline"] as bool).length} of ${teamMembers.length} online",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            icon: Icons.people,
            size: bs.sm,
            onPressed: () {
              _showTeamMembers();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("Group options");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageData = messages[index];
                final isMe = messageData["isMe"] as bool;
                final messageType = messageData["type"] as String;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  child: _buildMessage(messageData, isMe, messageType),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: QChatField(
              label: "Message",
              value: message,
              hint: "Type your message to the group...",
              attachments: messageAttachments,
              showAttachmentButton: true,
              showEmojiButton: true,
              showVoiceButton: true,
              onChanged: (value) {
                message = value;
                setState(() {});
              },
              onSend: () {
                if (message.isNotEmpty || messageAttachments.isNotEmpty) {
                  _sendMessage(message, messageAttachments);
                  message = "";
                  messageAttachments = [];
                  setState(() {});
                }
              },
              onAttachmentsChanged: (value) {
                messageAttachments = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> messageData, bool isMe, String messageType) {
    switch (messageType) {
      case "text":
        return _buildTextMessage(messageData, isMe);
      case "image":
        return _buildImageMessage(messageData, isMe);
      case "file":
        return _buildFileMessage(messageData, isMe);
      case "announcement":
        return _buildAnnouncementMessage(messageData);
      default:
        return _buildTextMessage(messageData, isMe);
    }
  }

  Widget _buildTextMessage(Map<String, dynamic> messageData, bool isMe) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
          SizedBox(width: spSm),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsets.only(bottom: spXs, left: spXs),
                  child: Row(
                    children: [
                      Text(
                        "${messageData["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      if (messageData["user"]["role"] != null) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${messageData["user"]["role"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: isMe ? primaryColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "${messageData["message"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: isMe ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (isMe) ...[
          SizedBox(width: spSm),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
        ],
      ],
    );
  }

  Widget _buildImageMessage(Map<String, dynamic> messageData, bool isMe) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
          SizedBox(width: spSm),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsets.only(bottom: spXs, left: spXs),
                  child: Row(
                    children: [
                      Text(
                        "${messageData["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      if (messageData["user"]["role"] != null) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${messageData["user"]["role"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: isMe ? primaryColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    if (messageData["message"] != null && messageData["message"].toString().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Text(
                          "${messageData["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${messageData["imageUrl"]}",
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (isMe) ...[
          SizedBox(width: spSm),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
        ],
      ],
    );
  }

  Widget _buildFileMessage(Map<String, dynamic> messageData, bool isMe) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
          SizedBox(width: spSm),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsets.only(bottom: spXs, left: spXs),
                  child: Row(
                    children: [
                      Text(
                        "${messageData["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                      if (messageData["user"]["role"] != null) ...[
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${messageData["user"]["role"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isMe ? primaryColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  children: [
                    if (messageData["message"] != null && messageData["message"].toString().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: spSm),
                        child: Text(
                          "${messageData["message"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: isMe ? Colors.white : primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${messageData["fileName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isMe ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                "${messageData["fileSize"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isMe ? Colors.white.withAlpha(180) : disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            si("Downloading ${messageData["fileName"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (isMe) ...[
          SizedBox(width: spSm),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
          ),
        ],
      ],
    );
  }

  Widget _buildAnnouncementMessage(Map<String, dynamic> messageData) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.symmetric(horizontal: spXl),
        decoration: BoxDecoration(
          color: warningColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: warningColor.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.campaign,
                  color: warningColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Announcement",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spXs),
            Text(
              "${messageData["message"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              "${DateTime.parse(messageData["timestamp"]).dMMMy}",
              style: TextStyle(
                fontSize: 11,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(String text, List<String> attachments) {
    final newMessage = {
      "id": "${messages.length + 1}",
      "message": text,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=person"
      },
      "type": "text"
    };
    
    messages.add(newMessage);
    setState(() {});
  }

  void _showTeamMembers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Team Members (${teamMembers.length})",
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
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage("${member["avatar"]}"),
                            ),
                            if (member["isOnline"] as bool)
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
                                "${member["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${member["role"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          member["isOnline"] as bool ? "Online" : "Offline",
                          style: TextStyle(
                            fontSize: 12,
                            color: member["isOnline"] as bool ? successColor : disabledBoldColor,
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
    );
  }
}
