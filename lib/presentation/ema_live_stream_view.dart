import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaLiveStreamView extends StatefulWidget {
  const EmaLiveStreamView({super.key});

  @override
  State<EmaLiveStreamView> createState() => _EmaLiveStreamViewState();
}

class _EmaLiveStreamViewState extends State<EmaLiveStreamView> {
  bool isStreaming = false;
  bool isMuted = false;
  bool isCameraOn = true;
  bool isFullScreen = false;
  int viewerCount = 1247;
  String streamTitle = "";
  String streamDescription = "";
  String chatMessage = "";
  
  Map<String, dynamic> streamData = {
    "id": "stream_001",
    "title": "Live Healthcare AI Presentation",
    "description": "Real-time demonstration of AI-powered diagnostic tools in modern healthcare",
    "streamer": {
      "name": "Dr. Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=doctor",
      "verified": true,
      "followers": 12500,
    },
    "category": "Healthcare Technology",
    "startTime": "14:30",
    "duration": "1:45:20",
    "quality": "1080p",
    "isLive": true,
    "likes": 1850,
    "shares": 124,
  };

  List<Map<String, dynamic>> liveChat = [
    {
      "id": "chat_001",
      "username": "DrMedTech",
      "message": "Amazing demonstration! The accuracy is incredible.",
      "timestamp": "14:32",
      "isVerified": true,
      "isModerator": false,
    },
    {
      "id": "chat_002",
      "username": "HealthcareExpert",
      "message": "How long did it take to train this AI model?",
      "timestamp": "14:33",
      "isVerified": false,
      "isModerator": false,
    },
    {
      "id": "chat_003",
      "username": "ModeratorBot",
      "message": "Welcome to the live stream! Please keep discussions relevant to healthcare AI.",
      "timestamp": "14:33",
      "isVerified": false,
      "isModerator": true,
    },
    {
      "id": "chat_004",
      "username": "AIResearcher23",
      "message": "The machine learning algorithms shown here are cutting-edge",
      "timestamp": "14:34",
      "isVerified": true,
      "isModerator": false,
    },
    {
      "id": "chat_005",
      "username": "MedStudent2024",
      "message": "This is exactly what we're studying in our AI course!",
      "timestamp": "14:35",
      "isVerified": false,
      "isModerator": false,
    },
  ];

  List<Map<String, dynamic>> viewers = [
    {
      "username": "DrMedTech",
      "avatar": "https://picsum.photos/30/30?random=1&keyword=doctor",
      "isVerified": true,
    },
    {
      "username": "HealthcareExpert",
      "avatar": "https://picsum.photos/30/30?random=2&keyword=medical",
      "isVerified": false,
    },
    {
      "username": "AIResearcher23",
      "avatar": "https://picsum.photos/30/30?random=3&keyword=tech",
      "isVerified": true,
    },
    {
      "username": "MedStudent2024",
      "avatar": "https://picsum.photos/30/30?random=4&keyword=student",
      "isVerified": false,
    },
    {
      "username": "HealthTechPro",
      "avatar": "https://picsum.photos/30/30?random=5&keyword=professional",
      "isVerified": true,
    },
  ];

  void _toggleStream() {
    isStreaming = !isStreaming;
    if (isStreaming) {
      ss("Live stream started");
    } else {
      ss("Live stream ended");
    }
    setState(() {});
  }

  void _toggleMute() {
    isMuted = !isMuted;
    setState(() {});
  }

  void _toggleCamera() {
    isCameraOn = !isCameraOn;
    setState(() {});
  }

  void _sendChatMessage() {
    if (chatMessage.isNotEmpty) {
      ss("Message sent to live chat");
      chatMessage = "";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen ? null : AppBar(
        title: Text("Live Stream"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo stream settings
            },
            child: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: isFullScreen ? _buildFullScreenView() : _buildNormalView(),
    );
  }

  Widget _buildNormalView() {
    return Column(
      children: [
        // Video Stream Area
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [shadowMd],
          ),
          child: Stack(
            children: [
              // Video Content
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/800/450?random=1&keyword=healthcare"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: !isCameraOn ? Container(
                  color: Colors.black.withAlpha(180),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam_off,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "Camera Off",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : null,
              ),

              // Live Indicator
              if (isStreaming) ...[
                Positioned(
                  top: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "LIVE",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Viewer Count
              Positioned(
                top: spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "$viewerCount",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Stream Controls
              Positioned(
                bottom: spMd,
                left: spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _toggleStream,
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isStreaming ? dangerColor : successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isStreaming ? Icons.stop : Icons.play_arrow,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: _toggleMute,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isMuted ? dangerColor : Colors.white.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isMuted ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: _toggleCamera,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: !isCameraOn ? dangerColor : Colors.white.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCameraOn ? Icons.videocam : Icons.videocam_off,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Spacer(),
                      if (isStreaming) ...[
                        Text(
                          "${streamData["duration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                      ],
                      GestureDetector(
                        onTap: () {
                          isFullScreen = true;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.fullscreen,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Stream Information & Chat
        Expanded(
          child: Row(
            children: [
              // Stream Info
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stream Title & Stats
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    image: DecorationImage(
                                      image: NetworkImage("${streamData["streamer"]["avatar"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${streamData["streamer"]["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (streamData["streamer"]["verified"]) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.verified,
                                              color: primaryColor,
                                              size: 16,
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${(streamData["streamer"]["followers"] as int)} followers",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "Follow",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Following ${streamData["streamer"]["name"]}");
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Text(
                              "${streamData["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${streamData["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${streamData["category"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${streamData["quality"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Stream Stats
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
                                Icon(Icons.favorite, color: dangerColor, size: 24),
                                SizedBox(height: spSm),
                                Text(
                                  "${streamData["likes"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Likes",
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
                                Icon(Icons.share, color: primaryColor, size: 24),
                                SizedBox(height: spSm),
                                Text(
                                  "${streamData["shares"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Shares",
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

                      // Viewers List
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Active Viewers",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spMd),
                            QHorizontalScroll(
                              children: viewers.map((viewer) => Container(
                                margin: EdgeInsets.only(right: spMd),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(radiusMd),
                                            image: DecorationImage(
                                              image: NetworkImage("${viewer["avatar"]}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        if (viewer["isVerified"]) ...[
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.verified,
                                                color: primaryColor,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${viewer["username"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Live Chat
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    // Chat Header
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "Live Chat",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${liveChat.length}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Chat Messages
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: liveChat.length,
                        itemBuilder: (context, index) {
                          final chat = liveChat[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spMd),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (chat["isModerator"]) ...[
                                      Icon(
                                        Icons.shield,
                                        color: warningColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                    ],
                                    Text(
                                      "${chat["username"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: chat["isModerator"] ? warningColor : primaryColor,
                                      ),
                                    ),
                                    if (chat["isVerified"]) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        color: primaryColor,
                                        size: 12,
                                      ),
                                    ],
                                    Spacer(),
                                    Text(
                                      "${chat["timestamp"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${chat["message"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Chat Input
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Type a message",
                              value: chatMessage,
                              hint: "Join the conversation...",
                              onChanged: (value) {
                                chatMessage = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.send,
                            size: bs.sm,
                            onPressed: _sendChatMessage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFullScreenView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Full Screen Video
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/800/450?random=1&keyword=healthcare"),
                fit: BoxFit.contain,
              ),
            ),
            child: !isCameraOn ? Container(
              color: Colors.black.withAlpha(180),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 64,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Camera Off",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ) : null,
          ),

          // Full Screen Controls
          Positioned(
            bottom: spLg,
            left: spLg,
            right: spLg,
            child: Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(200),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _toggleStream,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: isStreaming ? dangerColor : successColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isStreaming ? Icons.stop : Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(width: spLg),
                  GestureDetector(
                    onTap: _toggleMute,
                    child: Icon(
                      isMuted ? Icons.mic_off : Icons.mic,
                      color: isMuted ? dangerColor : Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: spLg),
                  GestureDetector(
                    onTap: _toggleCamera,
                    child: Icon(
                      isCameraOn ? Icons.videocam : Icons.videocam_off,
                      color: !isCameraOn ? dangerColor : Colors.white,
                      size: 32,
                    ),
                  ),
                  Spacer(),
                  if (isStreaming) ...[
                    Text(
                      "${streamData["duration"]}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: spLg),
                  ],
                  GestureDetector(
                    onTap: () {
                      isFullScreen = false;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Full Screen Live Indicator
          if (isStreaming) ...[
            Positioned(
              top: spLg,
              left: spLg,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "LIVE",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Full Screen Viewer Count
          Positioned(
            top: spLg,
            right: spLg,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.visibility,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "$viewerCount viewers",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
