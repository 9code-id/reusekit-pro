import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStream2View extends StatefulWidget {
  @override
  State<GrlStream2View> createState() => _GrlStream2ViewState();
}

class _GrlStream2ViewState extends State<GrlStream2View> {
  bool isFollowing = false;
  bool isSubscribed = false;
  bool showChat = true;
  bool isFullscreen = false;
  String chatMessage = "";
  int currentQuality = 2; // 0: 360p, 1: 720p, 2: 1080p

  List<String> qualityOptions = ["360p", "720p", "1080p"];

  Map<String, dynamic> streamerInfo = {
    "name": "ProGamer_Alex",
    "title": "Epic Battle Royale - Road to Victory! 🏆",
    "game": "Battle Arena",
    "category": "Gaming",
    "followers": "1.2M",
    "subscribers": "890K",
    "avatar": "https://picsum.photos/60/60?random=101",
    "isVerified": true,
    "isLive": true,
    "startTime": "2h 15m ago",
    "viewers": 15420,
    "description": "Professional esports player streaming daily gameplay, tutorials, and tournaments. Join me on the road to becoming the ultimate champion!",
  };

  List<Map<String, dynamic>> chatMessages = [
    {
      "user": "gaming_fan_123",
      "message": "Amazing gameplay! 🔥",
      "time": "2 min ago",
      "isSubscriber": true,
      "isModerator": false,
    },
    {
      "user": "pro_viewer",
      "message": "That was an incredible move!",
      "time": "3 min ago",
      "isSubscriber": false,
      "isModerator": false,
    },
    {
      "user": "stream_mod",
      "message": "Welcome new viewers!",
      "time": "5 min ago",
      "isSubscriber": true,
      "isModerator": true,
    },
    {
      "user": "epic_gamer_99",
      "message": "How did you do that combo?",
      "time": "6 min ago",
      "isSubscriber": false,
      "isModerator": false,
    },
    {
      "user": "daily_watcher",
      "message": "Been watching since the beginning! 💪",
      "time": "8 min ago",
      "isSubscriber": true,
      "isModerator": false,
    },
  ];

  List<Map<String, dynamic>> relatedStreams = [
    {
      "title": "Battle Arena Championship",
      "streamer": "Tournament_Official",
      "viewers": 25000,
      "thumbnail": "https://picsum.photos/150/100?random=201",
      "category": "Gaming",
    },
    {
      "title": "Tips & Tricks for Beginners",
      "streamer": "GamingTutor_Mike",
      "viewers": 5600,
      "thumbnail": "https://picsum.photos/150/100?random=202",
      "category": "Gaming",
    },
    {
      "title": "Late Night Gaming Session",
      "streamer": "NightOwl_Gamer",
      "viewers": 3200,
      "thumbnail": "https://picsum.photos/150/100?random=203",
      "category": "Gaming",
    },
  ];

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
    
    if (isFollowing) {
      ss("Now following ${streamerInfo["name"]}!");
    } else {
      si("Unfollowed ${streamerInfo["name"]}");
    }
  }

  void _toggleSubscribe() {
    setState(() {
      isSubscribed = !isSubscribed;
    });
    
    if (isSubscribed) {
      ss("Subscribed to ${streamerInfo["name"]}! Thank you for your support!");
    } else {
      si("Unsubscribed from ${streamerInfo["name"]}");
    }
  }

  void _sendChatMessage() {
    if (chatMessage.trim().isNotEmpty) {
      setState(() {
        chatMessages.insert(0, {
          "user": "You",
          "message": chatMessage,
          "time": "now",
          "isSubscriber": isSubscribed,
          "isModerator": false,
        });
        chatMessage = "";
        
        if (chatMessages.length > 20) {
          chatMessages.removeLast();
        }
      });
    }
  }

  void _shareStream() {
    ss("Stream link copied to clipboard!");
  }

  void _reportStream() {
    si("Report submitted. Thank you for helping keep our community safe.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isFullscreen ? _buildFullscreenView() : _buildNormalView(),
    );
  }

  Widget _buildNormalView() {
    return Column(
      children: [
        // Video player area
        Container(
          height: 250,
          width: double.infinity,
          child: Stack(
            children: [
              // Video background
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(
                  "https://picsum.photos/400/250?random=10&keyword=gaming",
                  fit: BoxFit.cover,
                ),
              ),

              // Top controls
              Positioned(
                top: 40,
                left: spMd,
                right: spMd,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Live indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // More options
                    GestureDetector(
                      onTap: _showStreamOptions,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Center play controls
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Quality selector
                    GestureDetector(
                      onTap: _showQualityOptions,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          qualityOptions[currentQuality],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: spMd),

                    // Fullscreen button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFullscreen = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom info overlay
              Positioned(
                bottom: spSm,
                left: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
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
                        "${streamerInfo["viewers"]} viewers",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Started ${streamerInfo["startTime"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Content area
        Expanded(
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                // Main content
                Expanded(
                  flex: showChat ? 2 : 1,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stream title
                        Text(
                          "${streamerInfo["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: spSm),

                        // Streamer info
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(
                                  color: successColor,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${streamerInfo["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
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
                                        "${streamerInfo["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (streamerInfo["isVerified"] as bool)
                                        Container(
                                          margin: EdgeInsets.only(left: spXs),
                                          child: Icon(
                                            Icons.verified,
                                            color: primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    "${streamerInfo["game"]} • ${streamerInfo["category"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${streamerInfo["followers"]} followers • ${streamerInfo["subscribers"]} subscribers",
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

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: isFollowing ? "Following" : "Follow",
                                size: bs.sm,
                                onPressed: _toggleFollow,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: spSm),
                                decoration: BoxDecoration(
                                  color: isSubscribed ? Colors.amber : Colors.transparent,
                                  border: Border.all(
                                    color: isSubscribed ? Colors.amber : primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: GestureDetector(
                                  onTap: _toggleSubscribe,
                                  child: Text(
                                    isSubscribed ? "Subscribed ⭐" : "Subscribe",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSubscribed ? Colors.white : primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: _shareStream,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  border: Border.all(color: disabledOutlineBorderColor),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.share,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spMd),

                        // Description
                        Text(
                          "About",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${streamerInfo["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: spMd),

                        // Related streams
                        Text(
                          "Related Streams",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spSm),

                        ...relatedStreams.map((stream) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: disabledOutlineBorderColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    child: Image.network(
                                      "${stream["thumbnail"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${stream["title"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${stream["streamer"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            size: 10,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${stream["viewers"]} viewers",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
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
                        }).toList(),
                      ],
                    ),
                  ),
                ),

                // Chat panel
                if (showChat)
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border(
                        left: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Chat header
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: disabledOutlineBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.chat,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Live Chat",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Chat messages
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: EdgeInsets.all(spSm),
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
                                          "${message["user"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: (message["isModerator"] as bool) 
                                                ? successColor 
                                                : (message["isSubscriber"] as bool)
                                                    ? primaryColor
                                                    : Colors.black,
                                          ),
                                        ),
                                        if (message["isSubscriber"] as bool)
                                          Container(
                                            margin: EdgeInsets.only(left: spXs),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 10,
                                            ),
                                          ),
                                        if (message["isModerator"] as bool)
                                          Container(
                                            margin: EdgeInsets.only(left: spXs),
                                            child: Icon(
                                              Icons.shield,
                                              color: successColor,
                                              size: 10,
                                            ),
                                          ),
                                        Spacer(),
                                        Text(
                                          "${message["time"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "${message["message"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // Chat input
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: disabledOutlineBorderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: disabledOutlineBorderColor),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Say something...",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(fontSize: 12),
                                    ),
                                    style: TextStyle(fontSize: 12),
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
                                  padding: EdgeInsets.all(spXs),
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
              ],
            ),
          ),
        ),

        // Bottom controls
        if (!showChat)
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: disabledOutlineBorderColor),
              ),
            ),
            child: Row(
              children: [
                QButton(
                  label: "Show Chat",
                  size: bs.sm,
                  onPressed: () {
                    setState(() {
                      showChat = true;
                    });
                  },
                ),
                Spacer(),
                Text(
                  "${chatMessages.length} messages",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFullscreenView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Video background
          Image.network(
            "https://picsum.photos/800/600?random=10&keyword=gaming",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Controls overlay
          Positioned(
            top: 40,
            left: spMd,
            right: spMd,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFullscreen = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                Spacer(),
                
                // Quality selector
                GestureDetector(
                  onTap: _showQualityOptions,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      qualityOptions[currentQuality],
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
          ),

          // Bottom info
          Positioned(
            bottom: 40,
            left: spMd,
            right: spMd,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(120),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "${streamerInfo["name"]} - ${streamerInfo["title"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${streamerInfo["viewers"]} viewers",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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

  void _showQualityOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                "Video Quality",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...qualityOptions.asMap().entries.map((entry) {
              int index = entry.key;
              String quality = entry.value;
              bool isSelected = currentQuality == index;
              
              return ListTile(
                title: Text(quality),
                trailing: isSelected ? Icon(Icons.check, color: primaryColor) : null,
                onTap: () {
                  setState(() {
                    currentQuality = index;
                  });
                  Navigator.pop(context);
                  si("Quality changed to $quality");
                },
              );
            }).toList(),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showStreamOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                "Stream Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Stream"),
              onTap: () {
                Navigator.pop(context);
                _shareStream();
              },
            ),
            
            ListTile(
              leading: Icon(Icons.report),
              title: Text("Report Stream"),
              onTap: () {
                Navigator.pop(context);
                _reportStream();
              },
            ),
            
            ListTile(
              leading: Icon(Icons.volume_off),
              title: Text("Mute Stream"),
              onTap: () {
                Navigator.pop(context);
                si("Stream muted");
              },
            ),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
