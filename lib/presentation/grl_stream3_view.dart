import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream3View extends StatefulWidget {
  @override
  State<GrlStream3View> createState() => _GrlStream3ViewState();
}

class _GrlStream3ViewState extends State<GrlStream3View> {
  bool isLive = true;
  bool isMuted = false;
  bool isFullscreen = false;
  int selectedQuality = 1;
  int currentViewers = 12547;
  
  List<Map<String, dynamic>> qualityOptions = [
    {"label": "360p", "value": 0},
    {"label": "720p", "value": 1},
    {"label": "1080p", "value": 2},
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "username": "StreamFan123",
      "message": "Amazing content! Keep it up! 🔥",
      "timestamp": "12:45",
      "isModerator": false,
      "isSubscriber": true,
      "avatar": "https://picsum.photos/40/40?random=301",
    },
    {
      "id": 2,
      "username": "ModeratorAlex",
      "message": "Welcome everyone to tonight's stream!",
      "timestamp": "12:44",
      "isModerator": true,
      "isSubscriber": true,
      "avatar": "https://picsum.photos/40/40?random=302",
    },
    {
      "id": 3,
      "username": "NewViewer",
      "message": "First time watching, love this!",
      "timestamp": "12:43",
      "isModerator": false,
      "isSubscriber": false,
      "avatar": "https://picsum.photos/40/40?random=303",
    },
    {
      "id": 4,
      "username": "RegularFan",
      "message": "Can you show that trick again? 😍",
      "timestamp": "12:42",
      "isModerator": false,
      "isSubscriber": true,
      "avatar": "https://picsum.photos/40/40?random=304",
    },
    {
      "id": 5,
      "username": "TechExpert",
      "message": "The quality is incredible today!",
      "timestamp": "12:41",
      "isModerator": false,
      "isSubscriber": true,
      "avatar": "https://picsum.photos/40/40?random=305",
    },
  ];

  Map<String, dynamic> streamInfo = {
    "title": "Epic Gaming Session - Building the Ultimate Base",
    "streamer": "ProGamerStreamer",
    "avatar": "https://picsum.photos/60/60?random=401",
    "category": "Gaming",
    "followers": 45200,
    "isFollowing": false,
    "isVerified": true,
    "streamDuration": "2:34:15",
    "totalViews": 1234567,
  };

  String chatInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player Area
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radiusLg),
                    bottomRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Stack(
                  children: [
                    // Video Background (Simulated)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/800/600?random=501&keyword=gaming"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusLg),
                          bottomRight: Radius.circular(radiusLg),
                        ),
                      ),
                    ),

                    // Video Overlay with Gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(100),
                            Colors.transparent,
                            Colors.black.withAlpha(150),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radiusLg),
                          bottomRight: Radius.circular(radiusLg),
                        ),
                      ),
                    ),

                    // Top Controls
                    Positioned(
                      top: spSm,
                      left: spSm,
                      right: spSm,
                      child: Row(
                        children: [
                          // Back Button
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                              onPressed: () {},
                            ),
                          ),

                          Spacer(),

                          // Live Indicator
                          if (isLive)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: dangerColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
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

                          SizedBox(width: spSm),

                          // Viewer Count
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.visibility, color: Colors.white, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "${((currentViewers) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: spSm),

                          // More Options
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.more_vert, color: Colors.white, size: 20),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Center Controls
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Mute Button
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                isMuted = !isMuted;
                                setState(() {});
                              },
                            ),
                          ),

                          SizedBox(width: spLg),

                          // Fullscreen Button
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                isFullscreen = !isFullscreen;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Stream Info
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      right: spSm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Stream Title
                          Text(
                            "${streamInfo["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: spXs),

                          // Streamer Info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${streamInfo["avatar"]}",
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${streamInfo["streamer"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (streamInfo["isVerified"] as bool)
                                          Padding(
                                            padding: EdgeInsets.only(left: spXs),
                                            child: Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: successColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      "${((streamInfo["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withAlpha(180),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: streamInfo["isFollowing"] as bool 
                                      ? disabledBoldColor 
                                      : primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  streamInfo["isFollowing"] as bool ? "Following" : "Follow",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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

            // Chat and Controls Area
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radiusLg),
                    topRight: Radius.circular(radiusLg),
                  ),
                ),
                child: Column(
                  children: [
                    // Stream Stats Bar
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.schedule, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${streamInfo["streamDuration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${streamInfo["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.share, size: 20, color: primaryColor),
                          SizedBox(width: spSm),
                          Icon(Icons.favorite_border, size: 20, color: primaryColor),
                        ],
                      ),
                    ),

                    // Chat Header
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: disabledColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Live Chat",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${chatMessages.length} messages",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.settings,
                            size: 18,
                            color: disabledBoldColor,
                          ),
                        ],
                      ),
                    ),

                    // Chat Messages
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(spSm),
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${message["avatar"]}",
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${message["username"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (message["isModerator"] as bool)
                                            Container(
                                              margin: EdgeInsets.only(left: spXs),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 1,
                                              ),
                                              decoration: BoxDecoration(
                                                color: warningColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "MOD",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          if (message["isSubscriber"] as bool)
                                            Container(
                                              margin: EdgeInsets.only(left: spXs),
                                              child: Icon(
                                                Icons.star,
                                                size: 12,
                                                color: warningColor,
                                              ),
                                            ),
                                          Spacer(),
                                          Text(
                                            "${message["timestamp"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${message["message"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
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
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: disabledColor, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Type a message...",
                              value: chatInput,
                              onChanged: (value) {
                                chatInput = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.emoji_emotions,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.send,
                            size: bs.sm,
                            onPressed: () {
                              if (chatInput.isNotEmpty) {
                                // Add message to chat
                                chatInput = "";
                                setState(() {});
                              }
                            },
                          ),
                        ],
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
  }
}
