import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaVideoConferenceView extends StatefulWidget {
  const PmaVideoConferenceView({super.key});

  @override
  State<PmaVideoConferenceView> createState() => _PmaVideoConferenceViewState();
}

class _PmaVideoConferenceViewState extends State<PmaVideoConferenceView> {
  bool isMuted = false;
  bool isVideoOn = true;
  bool isScreenSharing = false;
  bool isRecording = false;
  bool showParticipants = true;
  bool showChat = false;
  String chatMessage = "";

  List<Map<String, dynamic>> participants = [
    {
      "id": "1",
      "name": "Sarah Johnson",
      "role": "Host",
      "avatar": "https://picsum.photos/60/60?random=1",
      "is_muted": false,
      "is_video_on": true,
      "is_speaking": true,
      "is_host": true,
      "joined_at": "2024-01-15T10:00:00Z",
      "connection_quality": "excellent",
    },
    {
      "id": "2",
      "name": "Alex Chen",
      "role": "Presenter",
      "avatar": "https://picsum.photos/60/60?random=2",
      "is_muted": false,
      "is_video_on": true,
      "is_speaking": false,
      "is_host": false,
      "joined_at": "2024-01-15T10:01:00Z",
      "connection_quality": "good",
    },
    {
      "id": "3",
      "name": "Mike Wilson",
      "role": "Participant",
      "avatar": "https://picsum.photos/60/60?random=3",
      "is_muted": true,
      "is_video_on": false,
      "is_speaking": false,
      "is_host": false,
      "joined_at": "2024-01-15T10:02:00Z",
      "connection_quality": "poor",
    },
    {
      "id": "4",
      "name": "Emma Davis",
      "role": "Participant",
      "avatar": "https://picsum.photos/60/60?random=4",
      "is_muted": false,
      "is_video_on": true,
      "is_speaking": false,
      "is_host": false,
      "joined_at": "2024-01-15T10:03:00Z",
      "connection_quality": "excellent",
    },
    {
      "id": "5",
      "name": "David Lee",
      "role": "Participant",
      "avatar": "https://picsum.photos/60/60?random=5",
      "is_muted": true,
      "is_video_on": true,
      "is_speaking": false,
      "is_host": false,
      "joined_at": "2024-01-15T10:05:00Z",
      "connection_quality": "good",
    },
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "id": "1",
      "sender": "Alex Chen",
      "message": "Can everyone see my screen?",
      "timestamp": "2024-01-15T10:15:00Z",
      "type": "text",
    },
    {
      "id": "2",
      "sender": "Emma Davis",
      "message": "Yes, screen is visible clearly!",
      "timestamp": "2024-01-15T10:15:30Z",
      "type": "text",
    },
    {
      "id": "3",
      "sender": "Sarah Johnson",
      "message": "Great presentation Alex! The new design looks fantastic.",
      "timestamp": "2024-01-15T10:18:00Z",
      "type": "text",
    },
    {
      "id": "4",
      "sender": "System",
      "message": "Mike Wilson has joined the meeting",
      "timestamp": "2024-01-15T10:20:00Z",
      "type": "system",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: showParticipants || showChat ? 3 : 1,
                  child: _buildMainVideoArea(),
                ),
                if (showParticipants && !showChat)
                  Container(
                    width: 320,
                    child: _buildParticipantsPanel(),
                  ),
                if (showChat && !showParticipants)
                  Container(
                    width: 320,
                    child: _buildChatPanel(),
                  ),
                if (showParticipants && showChat)
                  Container(
                    width: 320,
                    child: Column(
                      children: [
                        Expanded(
                          child: _buildParticipantsPanel(),
                        ),
                        Container(
                          height: 300,
                          child: _buildChatPanel(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(179),
        border: Border(
          bottom: BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.videocam,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sprint Planning Session",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${participants.length} participants • ${isRecording ? "Recording" : "Not recording"}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (isRecording)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "REC",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(width: spMd),
          Row(
            children: [
              Icon(
                Icons.signal_cellular_4_bar,
                color: _getConnectionColor("excellent"),
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Connection: Excellent",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(width: spMd),
          Text(
            "45:23",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainVideoArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      child: Stack(
        children: [
          // Main video/screen share area
          Positioned.fill(
            child: isScreenSharing ? _buildScreenShareView() : _buildMainVideoView(),
          ),
          // Picture-in-picture for presenter when screen sharing
          if (isScreenSharing)
            Positioned(
              top: spMd,
              right: spMd,
              child: _buildPictureInPicture(),
            ),
          // Screen share controls overlay
          if (isScreenSharing)
            Positioned(
              bottom: spMd,
              left: spMd,
              child: _buildScreenShareControls(),
            ),
        ],
      ),
    );
  }

  Widget _buildMainVideoView() {
    // Show main speaker or gallery view
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusXl),
              child: Image.network(
                "${participants[1]["avatar"]}",
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "${participants[1]["name"]}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "${participants[1]["role"]}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            if (participants[1]["is_speaking"] as bool)
              Container(
                margin: EdgeInsets.only(top: spSm),
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: successColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  "Speaking",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenShareView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.screen_share,
              color: Colors.white70,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "Alex Chen is sharing screen",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Mobile App Wireframes",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPictureInPicture() {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: Colors.white24,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusLg),
                  child: Image.network(
                    "${participants[1]["avatar"]}",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(153),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${participants[1]["name"]}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenShareControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(179),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.screen_share,
            color: primaryColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Text(
            "You are sharing your screen",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spMd),
          GestureDetector(
            onTap: () {
              setState(() {
                isScreenSharing = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Stop Sharing",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(
          left: BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Participants (${participants.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showParticipants = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: participants.length,
              itemBuilder: (context, index) {
                final participant = participants[index];
                return _buildParticipantItem(participant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantItem(Map<String, dynamic> participant) {
    Color connectionColor = _getConnectionColor(participant["connection_quality"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: participant["is_speaking"] as bool 
            ? successColor.withAlpha(51) 
            : Colors.transparent,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: participant["is_speaking"] as bool 
              ? successColor 
              : Colors.white24,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusLg),
                child: participant["is_video_on"] as bool
                    ? Image.network(
                        "${participant["avatar"]}",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 20,
                        ),
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: connectionColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
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
                    Expanded(
                      child: Text(
                        "${participant["name"]}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (participant["is_host"] as bool)
                      Container(
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
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${participant["role"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Row(
            children: [
              Icon(
                participant["is_muted"] as bool 
                    ? Icons.mic_off 
                    : Icons.mic,
                color: participant["is_muted"] as bool 
                    ? dangerColor 
                    : Colors.white70,
                size: 16,
              ),
              SizedBox(width: spXs),
              Icon(
                participant["is_video_on"] as bool 
                    ? Icons.videocam 
                    : Icons.videocam_off,
                color: participant["is_video_on"] as bool 
                    ? Colors.white70 
                    : dangerColor,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatPanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        border: Border(
          left: BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white24,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Chat",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showChat = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return _buildChatMessage(message);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white24,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (value) {
                        chatMessage = value;
                      },
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {
                    // Send message
                    if (chatMessage.isNotEmpty) {
                      chatMessage = "";
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
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

  Widget _buildChatMessage(Map<String, dynamic> message) {
    bool isSystemMessage = message["type"] == "system";
    
    if (isSystemMessage) {
      return Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${message["message"]}",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${message["sender"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "10:15 AM",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          Text(
            "${message["message"]}",
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(204),
        border: Border(
          top: BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildControlButton(
            icon: isMuted ? Icons.mic_off : Icons.mic,
            isActive: !isMuted,
            onTap: () {
              setState(() {
                isMuted = !isMuted;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
            isActive: isVideoOn,
            onTap: () {
              setState(() {
                isVideoOn = !isVideoOn;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: Icons.screen_share,
            isActive: isScreenSharing,
            onTap: () {
              setState(() {
                isScreenSharing = !isScreenSharing;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: Icons.chat,
            isActive: showChat,
            onTap: () {
              setState(() {
                showChat = !showChat;
                if (showChat) showParticipants = false;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: Icons.people,
            isActive: showParticipants,
            onTap: () {
              setState(() {
                showParticipants = !showParticipants;
                if (showParticipants) showChat = false;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: isRecording ? Icons.stop_circle : Icons.fiber_manual_record,
            isActive: isRecording,
            color: dangerColor,
            onTap: () {
              setState(() {
                isRecording = !isRecording;
              });
            },
          ),
          SizedBox(width: spMd),
          _buildControlButton(
            icon: Icons.more_vert,
            isActive: false,
            onTap: () {
              // Show more options
            },
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spLg,
              vertical: spMd,
            ),
            decoration: BoxDecoration(
              color: dangerColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Leave",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    Color? color,
  }) {
    Color buttonColor = color ?? primaryColor;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? buttonColor : Colors.grey[700],
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Color _getConnectionColor(String quality) {
    switch (quality) {
      case 'excellent':
        return successColor;
      case 'good':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
