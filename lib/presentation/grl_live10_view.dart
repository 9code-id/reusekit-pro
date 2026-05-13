import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive10View extends StatefulWidget {
  @override
  State<GrlLive10View> createState() => _GrlLive10ViewState();
}

class _GrlLive10ViewState extends State<GrlLive10View> {
  bool isHost = true;
  bool isMuted = false;
  bool isVideoOff = false;
  bool isScreenSharing = false;
  String chatMessage = "";
  
  List<Map<String, dynamic>> participants = [
    {
      "id": "host",
      "name": "Alex Chen",
      "email": "alex@company.com",
      "avatar": "https://picsum.photos/50/50?random=1",
      "isHost": true,
      "isMuted": false,
      "isVideoOff": false,
      "isPresenting": false,
      "joinTime": "10:00 AM",
    },
    {
      "id": "p1",
      "name": "Sarah Johnson",
      "email": "sarah@company.com", 
      "avatar": "https://picsum.photos/50/50?random=2",
      "isHost": false,
      "isMuted": true,
      "isVideoOff": false,
      "isPresenting": false,
      "joinTime": "10:02 AM",
    },
    {
      "id": "p2",
      "name": "Mike Wilson",
      "email": "mike@company.com",
      "avatar": "https://picsum.photos/50/50?random=3",
      "isHost": false,
      "isMuted": false,
      "isVideoOff": true,
      "isPresenting": false,
      "joinTime": "10:05 AM",
    },
    {
      "id": "p3",
      "name": "Emma Davis",
      "email": "emma@company.com",
      "avatar": "https://picsum.photos/50/50?random=4",
      "isHost": false,
      "isMuted": false,
      "isVideoOff": false,
      "isPresenting": false,
      "joinTime": "10:08 AM",
    },
    {
      "id": "p4",
      "name": "John Smith",
      "email": "john@company.com",
      "avatar": "https://picsum.photos/50/50?random=5",
      "isHost": false,
      "isMuted": true,
      "isVideoOff": true,
      "isPresenting": false,
      "joinTime": "10:12 AM",
    },
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "sender": "Alex Chen",
      "message": "Welcome everyone to our quarterly team meeting!",
      "time": "10:00 AM",
      "isHost": true,
    },
    {
      "sender": "Sarah Johnson",
      "message": "Good morning team! Ready for the presentation.",
      "time": "10:02 AM",
      "isHost": false,
    },
    {
      "sender": "Mike Wilson",
      "message": "Can you hear me clearly?",
      "time": "10:05 AM",
      "isHost": false,
    },
  ];

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void _toggleVideo() {
    setState(() {
      isVideoOff = !isVideoOff;
    });
  }

  void _toggleScreenShare() {
    setState(() {
      isScreenSharing = !isScreenSharing;
    });
    
    if (isScreenSharing) {
      ss("Screen sharing started");
    } else {
      si("Screen sharing stopped");
    }
  }

  void _leaveConference() async {
    bool isConfirmed = await confirm("Are you sure you want to leave the conference?");
    if (isConfirmed) {
      back();
    }
  }

  void _sendChatMessage() {
    if (chatMessage.trim().isNotEmpty) {
      setState(() {
        chatMessages.add({
          "sender": "You",
          "message": chatMessage,
          "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
          "isHost": isHost,
        });
        chatMessage = "";
      });
    }
  }

  void _muteParticipant(String participantId) {
    if (isHost) {
      setState(() {
        final participant = participants.firstWhere((p) => p["id"] == participantId);
        participant["isMuted"] = true;
      });
      ss("Participant muted");
    }
  }

  void _removeParticipant(String participantId) async {
    if (isHost) {
      bool isConfirmed = await confirm("Remove this participant from the conference?");
      if (isConfirmed) {
        setState(() {
          participants.removeWhere((p) => p["id"] == participantId);
        });
        ss("Participant removed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Team Conference",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${participants.length} participants",
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: _leaveConference,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          // Participant list toggle
          GestureDetector(
            onTap: () {
              _showParticipantsList();
            },
            child: Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              child: Stack(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${participants.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // More options
          GestureDetector(
            onTap: _showMoreOptions,
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              padding: EdgeInsets.all(spSm),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Video grid
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: isScreenSharing 
                  ? _buildScreenShareView()
                  : _buildVideoGrid(),
            ),
          ),

          // Chat panel
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
              ),
              child: Column(
                children: [
                  // Chat header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Conference Chat",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${chatMessages.length} messages",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Chat messages
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      child: ListView.builder(
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${message["sender"]}",
                                      style: TextStyle(
                                        color: (message["isHost"] as bool) 
                                            ? primaryColor 
                                            : Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (message["isHost"] as bool)
                                      Container(
                                        margin: EdgeInsets.only(left: spXs),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "HOST",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    Spacer(),
                                    Text(
                                      "${message["time"]}",
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${message["message"]}",
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Chat input
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                chatMessage = value;
                                setState(() {});
                              },
                              onSubmitted: (value) => _sendChatMessage(),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: _sendChatMessage,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute button
                GestureDetector(
                  onTap: _toggleMute,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isMuted ? dangerColor : Colors.grey[600],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      isMuted ? Icons.mic_off : Icons.mic,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                // Video button
                GestureDetector(
                  onTap: _toggleVideo,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isVideoOff ? dangerColor : Colors.grey[600],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      isVideoOff ? Icons.videocam_off : Icons.videocam,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                // Screen share button
                GestureDetector(
                  onTap: _toggleScreenShare,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isScreenSharing ? primaryColor : Colors.grey[600],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.screen_share,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                // Recording button (host only)
                if (isHost)
                  GestureDetector(
                    onTap: () {
                      si("Recording conference...");
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.fiber_manual_record,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                // Leave call button
                GestureDetector(
                  onTap: _leaveConference,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: participants.map((participant) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Stack(
            children: [
              // Video or avatar
              if (!(participant["isVideoOff"] as bool))
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "https://picsum.photos/200/150?random=${participant["id"]}",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${participant["avatar"]}"),
                  ),
                ),

              // Participant info overlay
              Positioned(
                bottom: spXs,
                left: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(160),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        (participant["isMuted"] as bool) ? Icons.mic_off : Icons.mic,
                        color: (participant["isMuted"] as bool) ? dangerColor : Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${participant["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (participant["isHost"] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "HOST",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Host controls overlay
              if (isHost && !(participant["isHost"] as bool))
                Positioned(
                  top: spXs,
                  right: spXs,
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 16,
                    ),
                    color: Colors.grey[800],
                    onSelected: (value) {
                      switch (value) {
                        case 'mute':
                          _muteParticipant("${participant["id"]}");
                          break;
                        case 'remove':
                          _removeParticipant("${participant["id"]}");
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'mute',
                        child: Row(
                          children: [
                            Icon(Icons.mic_off, color: Colors.white, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "Mute",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'remove',
                        child: Row(
                          children: [
                            Icon(Icons.remove_circle, color: dangerColor, size: 16),
                            SizedBox(width: spSm),
                            Text(
                              "Remove",
                              style: TextStyle(color: dangerColor, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScreenShareView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          // Screen share content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.screen_share,
                  color: Colors.white,
                  size: 80,
                ),
                SizedBox(height: spMd),
                Text(
                  "You are sharing your screen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Other participants can see your screen",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Small video thumbnails
          Positioned(
            top: spSm,
            right: spSm,
            child: Container(
              width: 120,
              height: 200,
              child: Column(
                children: participants.take(3).map((participant) {
                  return Container(
                    width: 120,
                    height: 60,
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Stack(
                      children: [
                        if (!(participant["isVideoOff"] as bool))
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${participant["avatar"]}",
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          Center(
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage("${participant["avatar"]}"),
                            ),
                          ),
                        Positioned(
                          bottom: 2,
                          left: 2,
                          child: Text(
                            "${participant["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showParticipantsList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Text(
                    "Participants (${participants.length})",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: spMd),
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  final participant = participants[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage("${participant["avatar"]}"),
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
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (participant["isHost"] as bool)
                                    Container(
                                      margin: EdgeInsets.only(left: spSm),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "HOST",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Text(
                                "${participant["email"]}",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Joined at ${participant["joinTime"]}",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Status indicators
                        Row(
                          children: [
                            Icon(
                              (participant["isMuted"] as bool) ? Icons.mic_off : Icons.mic,
                              color: (participant["isMuted"] as bool) ? dangerColor : successColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Icon(
                              (participant["isVideoOff"] as bool) ? Icons.videocam_off : Icons.videocam,
                              color: (participant["isVideoOff"] as bool) ? dangerColor : successColor,
                              size: 16,
                            ),
                          ],
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

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              child: Text(
                "Conference Options",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                "Meeting Settings",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                si("Opening meeting settings...");
              },
            ),
            
            ListTile(
              leading: Icon(Icons.security, color: Colors.white),
              title: Text(
                "Security",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                si("Opening security settings...");
              },
            ),
            
            if (isHost)
              ListTile(
                leading: Icon(Icons.lock, color: Colors.white),
                title: Text(
                  "Lock Meeting",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ss("Meeting locked - no new participants can join");
                },
              ),
            
            ListTile(
              leading: Icon(Icons.bug_report, color: Colors.white),
              title: Text(
                "Report Issue",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                si("Opening issue report...");
              },
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
