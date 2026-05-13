import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive5View extends StatefulWidget {
  @override
  State<GrlLive5View> createState() => _GrlLive5ViewState();
}

class _GrlLive5ViewState extends State<GrlLive5View> {
  int currentIndex = 0;
  bool isMuted = false;
  bool isVideoOff = false;
  bool showParticipants = false;
  String chatMessage = "";

  List<Map<String, dynamic>> participants = [
    {
      "name": "Alex Chen",
      "avatar": "https://picsum.photos/50/50?random=1",
      "isMuted": false,
      "isVideoOff": false,
      "isHost": true,
    },
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=2",
      "isMuted": true,
      "isVideoOff": false,
      "isHost": false,
    },
    {
      "name": "Mike Wilson",
      "avatar": "https://picsum.photos/50/50?random=3",
      "isMuted": false,
      "isVideoOff": true,
      "isHost": false,
    },
    {
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/50/50?random=4",
      "isMuted": false,
      "isVideoOff": false,
      "isHost": false,
    },
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "sender": "Alex Chen",
      "message": "Welcome everyone to our weekly team meeting!",
      "time": "10:30 AM",
      "isMe": false,
    },
    {
      "sender": "Sarah Johnson",
      "message": "Thanks for hosting, Alex!",
      "time": "10:31 AM",
      "isMe": false,
    },
    {
      "sender": "You",
      "message": "Looking forward to the discussion",
      "time": "10:32 AM",
      "isMe": true,
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

  void _endCall() {
    back();
  }

  void _sendChatMessage() {
    if (chatMessage.trim().isNotEmpty) {
      setState(() {
        chatMessages.add({
          "sender": "You",
          "message": chatMessage,
          "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
          "isMe": true,
        });
        chatMessage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Video grid area
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(spSm, 40, spSm, spSm),
              child: currentIndex == 0 ? _buildVideoGrid() : _buildChatArea(),
            ),
          ),

          // Bottom controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Column(
              children: [
                // Main controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute button
                    GestureDetector(
                      onTap: _toggleMute,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isMuted ? dangerColor : Colors.grey[700],
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
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isVideoOff ? dangerColor : Colors.grey[700],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          isVideoOff ? Icons.videocam_off : Icons.videocam,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    // End call button
                    GestureDetector(
                      onTap: _endCall,
                      child: Container(
                        width: 60,
                        height: 60,
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

                    // Participants button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showParticipants = !showParticipants;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: showParticipants ? primaryColor : Colors.grey[700],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${participants.length}",
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
                      ),
                    ),

                    // More options
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Tab navigation
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: currentIndex == 0 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Video",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: currentIndex == 1 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Chat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildVideoGrid() {
    return Column(
      children: [
        // Main video area
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "https://picsum.photos/400/300?random=10&keyword=meeting",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(160),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Alex Chen (Host)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: spSm),

        // Participant grid
        if (showParticipants)
          Container(
            height: 120,
            child: Row(
              children: participants.skip(1).map((participant) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Stack(
                      children: [
                        if (!(participant["isVideoOff"] as bool))
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
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
                              radius: 25,
                              backgroundImage: NetworkImage("${participant["avatar"]}"),
                            ),
                          ),
                        Positioned(
                          bottom: spXs,
                          left: spXs,
                          right: spXs,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(160),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  (participant["isMuted"] as bool) ? Icons.mic_off : Icons.mic,
                                  color: (participant["isMuted"] as bool) ? dangerColor : Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 2),
                                Expanded(
                                  child: Text(
                                    "${participant["name"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildChatArea() {
    return Column(
      children: [
        // Chat messages
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!(message["isMe"] as bool))
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "${message["sender"]}".substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (!(message["isMe"] as bool)) SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: (message["isMe"] as bool) 
                              ? CrossAxisAlignment.end 
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (message["isMe"] as bool) 
                                    ? primaryColor 
                                    : Colors.grey[700],
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!(message["isMe"] as bool))
                                    Text(
                                      "${message["sender"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (!(message["isMe"] as bool)) SizedBox(height: 2),
                                  Text(
                                    "${message["message"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${message["time"]}",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if ((message["isMe"] as bool)) SizedBox(width: spSm),
                      if ((message["isMe"] as bool))
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              "Y",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: spMd),

        // Chat input
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
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
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
