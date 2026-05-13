import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive4View extends StatefulWidget {
  @override
  State<GrlLive4View> createState() => _GrlLive4ViewState();
}

class _GrlLive4ViewState extends State<GrlLive4View> {
  String chatMessage = "";
  bool isLiked = false;
  bool isFollowing = false;
  bool showChat = true;
  int viewerCount = 1247;
  int likeCount = 856;
  
  List<Map<String, dynamic>> chatMessages = [
    {
      "username": "alex_gamer",
      "message": "Amazing stream! 🔥",
      "timestamp": "2 min ago",
      "verified": true,
    },
    {
      "username": "sarah_fan",
      "message": "Can you play that song again?",
      "timestamp": "3 min ago",
      "verified": false,
    },
    {
      "username": "mike_supporter",
      "message": "Just sent you a gift! 💎",
      "timestamp": "5 min ago",
      "verified": false,
    },
    {
      "username": "lisa_viewer",
      "message": "Love your content!",
      "timestamp": "7 min ago",
      "verified": true,
    },
  ];

  List<Map<String, dynamic>> gifts = [
    {
      "name": "Heart",
      "icon": "❤️",
      "coins": 10,
    },
    {
      "name": "Star",
      "icon": "⭐",
      "coins": 25,
    },
    {
      "name": "Diamond",
      "icon": "💎",
      "coins": 100,
    },
    {
      "name": "Crown",
      "icon": "👑",
      "coins": 500,
    },
  ];

  void _sendMessage() {
    if (chatMessage.trim().isNotEmpty) {
      setState(() {
        chatMessages.insert(0, {
          "username": "you",
          "message": chatMessage,
          "timestamp": "now",
          "verified": false,
        });
        chatMessage = "";
      });
      ss("Message sent!");
    }
  }

  void _sendGift(Map<String, dynamic> gift) {
    si("Sent ${gift["name"]} for ${gift["coins"]} coins!");
    back();
  }

  void _showGiftSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Send Gift",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...gifts.map((gift) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _sendGift(gift),
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${gift["icon"]}",
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${gift["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${gift["coins"]} coins",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(100),
                  Colors.black.withAlpha(200),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + spSm,
                left: spMd,
                right: spMd,
                bottom: spSm,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(150),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${((viewerCount as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showChat = !showChat;
                      setState(() {});
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        showChat ? Icons.chat_bubble : Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Chat Section
          if (showChat)
            Positioned(
              bottom: 120,
              left: spMd,
              right: spMd,
              top: 120,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${message["username"]}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (message["verified"] as bool)
                                      Padding(
                                        padding: EdgeInsets.only(left: spXs),
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                          size: 12,
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
                  ),
                ],
              ),
            ),

          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: spMd,
                right: spMd,
                bottom: MediaQuery.of(context).padding.bottom + spMd,
                top: spMd,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(200),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Streamer Info
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "https://picsum.photos/50/50?random=1&keyword=streamer",
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
                              "@live_streamer_pro",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Gaming & Entertainment",
                              style: TextStyle(
                                color: disabledColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isFollowing = !isFollowing;
                          setState(() {});
                          if (isFollowing) {
                            ss("Now following @live_streamer_pro");
                          } else {
                            si("Unfollowed @live_streamer_pro");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: isFollowing ? disabledBoldColor : primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            isFollowing ? "Following" : "Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Say something...",
                              hintStyle: TextStyle(color: disabledColor),
                              filled: true,
                              fillColor: Colors.black.withAlpha(150),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(radiusSm),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: spSm),
                            ),
                            onChanged: (value) {
                              chatMessage = value;
                              setState(() {});
                            },
                            onSubmitted: (value) => _sendMessage(),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: _sendMessage,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          isLiked = !isLiked;
                          if (isLiked) {
                            likeCount++;
                          } else {
                            likeCount--;
                          }
                          setState(() {});
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isLiked ? dangerColor : Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: _showGiftSelector,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.card_giftcard,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
