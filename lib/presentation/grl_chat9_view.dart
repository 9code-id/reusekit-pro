import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlChat9View extends StatefulWidget {
  @override
  State<GrlChat9View> createState() => _GrlChat9ViewState();
}

class _GrlChat9ViewState extends State<GrlChat9View> {
  String message = "";
  List<String> messageAttachments = [];
  bool isRecording = false;
  
  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Welcome to our live event! 🎉 Thank you all for joining us today. We have an exciting program ahead!",
      "timestamp": "2024-01-15 14:00:00",
      "isMe": false,
      "user": {
        "name": "Event Host",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=host",
        "role": "Host",
        "verified": true
      },
      "type": "announcement",
      "reactions": [
        {"emoji": "👏", "count": 45, "users": []},
        {"emoji": "🎉", "count": 32, "users": []},
        {"emoji": "❤️", "count": 28, "users": []}
      ]
    },
    {
      "id": "2",
      "message": "Excited to be here! Looking forward to the keynote 🚀",
      "timestamp": "2024-01-15 14:01:00",
      "isMe": false,
      "user": {
        "name": "Sarah Johnson",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
        "role": "Attendee"
      },
      "type": "message",
      "reactions": [
        {"emoji": "👍", "count": 12, "users": []}
      ]
    },
    {
      "id": "3",
      "message": "This is amazing! Great turnout today 👥",
      "timestamp": "2024-01-15 14:02:00",
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=person"
      },
      "type": "message",
      "reactions": [
        {"emoji": "💯", "count": 8, "users": []}
      ]
    },
    {
      "id": "4",
      "message": "📢 ANNOUNCEMENT: The keynote will begin in 5 minutes. Please take your seats!",
      "timestamp": "2024-01-15 14:05:00",
      "isMe": false,
      "user": {
        "name": "Event Host",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=host",
        "role": "Host",
        "verified": true
      },
      "type": "announcement",
      "reactions": [
        {"emoji": "📢", "count": 67, "users": []},
        {"emoji": "👏", "count": 23, "users": []}
      ]
    },
    {
      "id": "5",
      "message": "Can't wait! Who else is here from the tech community? 👋",
      "timestamp": "2024-01-15 14:06:00",
      "isMe": false,
      "user": {
        "name": "Mike Chen",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
        "role": "Developer"
      },
      "type": "message",
      "reactions": [
        {"emoji": "👋", "count": 19, "users": []},
        {"emoji": "💻", "count": 15, "users": []}
      ]
    },
    {
      "id": "6",
      "message": "Here! 🙋‍♀️ Excited about the AI session later today",
      "timestamp": "2024-01-15 14:07:00",
      "isMe": false,
      "user": {
        "name": "Emma Davis",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=designer",
        "role": "AI Researcher"
      },
      "type": "message",
      "reactions": [
        {"emoji": "🤖", "count": 22, "users": []},
        {"emoji": "🧠", "count": 18, "users": []}
      ]
    }
  ];

  List<Map<String, dynamic>> participants = [
    {
      "name": "Event Host",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=host",
      "role": "Host",
      "verified": true,
      "isOnline": true
    },
    {
      "name": "Sarah Johnson", 
      "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
      "role": "Attendee",
      "verified": false,
      "isOnline": true
    },
    {
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man", 
      "role": "Developer",
      "verified": false,
      "isOnline": true
    },
    {
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=designer",
      "role": "AI Researcher", 
      "verified": false,
      "isOnline": true
    }
  ];

  List<String> quickReactions = ["👏", "🎉", "❤️", "👍", "🚀", "💯", "🔥", "👋"];
  
  int totalParticipants = 1247;
  bool isLive = true;
  String eventTitle = "Tech Innovation Summit 2024";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isLive ? dangerColor : disabledBoldColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  isLive ? "LIVE" : "ENDED",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isLive ? dangerColor : disabledBoldColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    eventTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              "$totalParticipants participants",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
              ),
            ),
          ],
        ),
        actions: [
          QButton(
            icon: Icons.people,
            size: bs.sm,
            onPressed: () {
              _showParticipants();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              si("Share event");
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showEventOptions();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Live Event Info Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [dangerColor.withAlpha(10), warningColor.withAlpha(10)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: dangerColor.withAlpha(30),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.live_tv,
                  color: dangerColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Join the conversation! Share your thoughts and reactions with other attendees.",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.notifications,
                  size: bs.sm,
                  onPressed: () {
                    si("Event notifications");
                  },
                ),
              ],
            ),
          ),
          
          // Quick Reactions Bar
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: quickReactions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _sendReaction(quickReactions[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: primaryColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        quickReactions[index],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Messages Area
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
                  child: _buildMessage(messageData, isMe, messageType, index),
                );
              },
            ),
          ),
          
          // Message Input Area
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: isLive ? "Join the live conversation..." : "Event has ended",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      enabled: isLive,
                      onChanged: (value) {
                        message = value;
                        setState(() {});
                      },
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.send,
                  size: bs.sm,
                  onPressed: isLive && message.isNotEmpty ? () {
                    _sendMessage(message);
                    message = "";
                    setState(() {});
                  } : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> messageData, bool isMe, String messageType, int index) {
    if (messageType == "announcement") {
      return _buildAnnouncementMessage(messageData, index);
    }
    
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
                      if (messageData["user"]["verified"] == true) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.verified,
                          size: 12,
                          color: primaryColor,
                        ),
                      ],
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
              
              // Reactions
              if (messageData["reactions"] != null && (messageData["reactions"] as List).isNotEmpty)
                _buildReactions(messageData["reactions"] as List, index),
              
              SizedBox(height: spXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  if (!isMe) ...[
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite_border,
                      size: bs.sm,
                      onPressed: () {
                        _addReaction(index, "❤️");
                      },
                    ),
                  ],
                ],
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

  Widget _buildAnnouncementMessage(Map<String, dynamic> messageData, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withAlpha(10), secondaryColor.withAlpha(10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: primaryColor.withAlpha(30),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage("${messageData["user"]["avatar"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "${messageData["user"]["name"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      if (messageData["user"]["verified"] == true) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: primaryColor,
                        ),
                      ],
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "ANNOUNCEMENT",
                          style: TextStyle(
                            fontSize: 9,
                            color: warningColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.campaign,
                  color: warningColor,
                  size: 16,
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${messageData["message"]}",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            
            // Reactions
            if (messageData["reactions"] != null && (messageData["reactions"] as List).isNotEmpty)
              _buildReactions(messageData["reactions"] as List, index),
            
            SizedBox(height: spXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${DateTime.parse(messageData["timestamp"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  icon: Icons.favorite_border,
                  size: bs.sm,
                  onPressed: () {
                    _addReaction(index, "❤️");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactions(List reactions, int messageIndex) {
    return Container(
      margin: EdgeInsets.only(top: spSm),
      child: Wrap(
        spacing: spXs,
        children: reactions.map<Widget>((reaction) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: primaryColor.withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  reaction["emoji"],
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 2),
                Text(
                  "${reaction["count"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _sendMessage(String text) {
    final newMessage = {
      "id": "${messages.length + 1}",
      "message": text,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=person"
      },
      "type": "message",
      "reactions": []
    };
    
    messages.add(newMessage);
    setState(() {});
    
    // Simulate other participants reacting
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        _addReaction(messages.length - 1, "👏");
      }
    });
  }

  void _sendReaction(String emoji) {
    final reactionMessage = {
      "id": "${messages.length + 1}",
      "message": emoji,
      "timestamp": DateTime.now().toIso8601String(),
      "isMe": true,
      "user": {
        "name": "You",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=person"
      },
      "type": "message",
      "reactions": []
    };
    
    messages.add(reactionMessage);
    setState(() {});
  }

  void _addReaction(int messageIndex, String emoji) {
    if (messageIndex < messages.length) {
      final reactions = messages[messageIndex]["reactions"] as List;
      final existingReaction = reactions.firstWhere(
        (r) => r["emoji"] == emoji,
        orElse: () => null,
      );
      
      if (existingReaction != null) {
        existingReaction["count"] = (existingReaction["count"] as int) + 1;
      } else {
        reactions.add({
          "emoji": emoji,
          "count": 1,
          "users": ["You"]
        });
      }
      
      setState(() {});
      si("Reaction added!");
    }
  }

  void _showParticipants() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                    "Participants ($totalParticipants)",
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
            
            // Active Speakers
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Speakers",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...participants.map((participant) => _buildParticipantItem(participant)),
                ],
              ),
            ),
            
            // All Participants Counter
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "And ${totalParticipants - participants.length} more participants watching live",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantItem(Map<String, dynamic> participant) {
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
                radius: 18,
                backgroundImage: NetworkImage("${participant["avatar"]}"),
              ),
              if (participant["isOnline"] as bool)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
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
                    Text(
                      "${participant["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    if (participant["verified"] == true) ...[
                      SizedBox(width: spXs),
                      Icon(
                        Icons.verified,
                        size: 14,
                        color: primaryColor,
                      ),
                    ],
                  ],
                ),
                Text(
                  "${participant["role"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (participant["role"] == "Host")
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "HOST",
                style: TextStyle(
                  fontSize: 10,
                  color: warningColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showEventOptions() {
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
                "Event Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: primaryColor),
              title: Text("Event Details"),
              onTap: () {
                Navigator.pop(context);
                si("Show event details");
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule, color: primaryColor),
              title: Text("Event Schedule"),
              onTap: () {
                Navigator.pop(context);
                si("Show event schedule");
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: primaryColor),
              title: Text("Notifications"),
              onTap: () {
                Navigator.pop(context);
                si("Event notification settings");
              },
            ),
            ListTile(
              leading: Icon(Icons.report, color: dangerColor),
              title: Text("Report Event"),
              onTap: () {
                Navigator.pop(context);
                sw("Event reported");
              },
            ),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
