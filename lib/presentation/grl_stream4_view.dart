import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream4View extends StatefulWidget {
  @override
  State<GrlStream4View> createState() => _GrlStream4ViewState();
}

class _GrlStream4ViewState extends State<GrlStream4View> {
  bool isLive = false;
  int viewersCount = 1247;
  int likesCount = 89;
  String chatMessage = "";
  bool isFollowing = false;
  String selectedQuality = "720p";

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "1080p", "value": "1080p"},
    {"label": "720p", "value": "720p"},
    {"label": "480p", "value": "480p"},
    {"label": "360p", "value": "360p"},
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "username": "StreamFan123",
      "message": "Amazing content! 🔥",
      "timestamp": "2 min ago",
      "isSuper": false,
    },
    {
      "username": "TechGuru",
      "message": "Super Chat: Thanks for the tutorial!",
      "timestamp": "3 min ago",
      "isSuper": true,
    },
    {
      "username": "GameMaster",
      "message": "When is the next stream?",
      "timestamp": "5 min ago",
      "isSuper": false,
    },
    {
      "username": "LiveViewer",
      "message": "Following for more content!",
      "timestamp": "7 min ago",
      "isSuper": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Stream Video Container
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/400/250?random=401&keyword=stream'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Live Badge
                if (isLive)
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
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Viewer Count
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(178),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(viewersCount / 1000).toStringAsFixed(1)}K",
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

                // Quality Settings
                Positioned(
                  bottom: spMd,
                  right: spMd,
                  child: GestureDetector(
                    onTap: () => _showQualitySettings(),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(178),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                // Play/Pause Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      isLive = !isLive;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(178),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isLive ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stream Controls
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                // Stream Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tech Tutorial Live Stream",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Learning Flutter Development",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),

                // Like Button
                GestureDetector(
                  onTap: () {
                    likesCount++;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 18,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "$likesCount",
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
                SizedBox(width: spSm),

                // Follow Button
                GestureDetector(
                  onTap: () {
                    isFollowing = !isFollowing;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isFollowing ? successColor : primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      isFollowing ? "Following" : "Follow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat Section
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Live Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),

                  // Chat Messages
                  Expanded(
                    child: ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (message["isSuper"] as bool) 
                                ? warningColor.withAlpha(51) 
                                : Colors.grey[900],
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: (message["isSuper"] as bool) 
                                ? Border.all(color: warningColor, width: 1)
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${message["username"]}",
                                    style: TextStyle(
                                      color: (message["isSuper"] as bool) 
                                          ? warningColor 
                                          : primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${message["timestamp"]}",
                                    style: TextStyle(
                                      color: disabledColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${message["message"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
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
                                hintStyle: TextStyle(color: disabledColor),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: spSm),
                              ),
                              onChanged: (value) {
                                chatMessage = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        GestureDetector(
                          onTap: () => _sendMessage(),
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQualitySettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Video Quality",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              ...qualityOptions.map((option) {
                return GestureDetector(
                  onTap: () {
                    selectedQuality = option["value"];
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    child: Row(
                      children: [
                        Text(
                          "${option["label"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        if (selectedQuality == option["value"])
                          Icon(
                            Icons.check,
                            color: primaryColor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage() {
    if (chatMessage.isNotEmpty) {
      chatMessages.insert(0, {
        "username": "You",
        "message": chatMessage,
        "timestamp": "now",
        "isSuper": false,
      });
      chatMessage = "";
      setState(() {});
    }
  }
}
