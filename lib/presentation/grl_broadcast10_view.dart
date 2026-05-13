import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast10View extends StatefulWidget {
  @override
  State<GrlBroadcast10View> createState() => _GrlBroadcast10ViewState();
}

class _GrlBroadcast10ViewState extends State<GrlBroadcast10View> {
  String message = "";
  bool isConnected = true;
  bool soundEnabled = true;
  bool notificationsEnabled = true;
  int activeViewers = 15420;
  
  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "username": "TechExpert92",
      "message": "Great explanation about AI algorithms!",
      "timestamp": "14:32",
      "isHost": false,
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "isModerator": false,
      "isVerified": true
    },
    {
      "id": 2,
      "username": "StreamHost",
      "message": "Thanks everyone for joining! Next topic will be machine learning.",
      "timestamp": "14:30",
      "isHost": true,
      "avatar": "https://picsum.photos/40/40?random=2&keyword=host",
      "isModerator": false,
      "isVerified": true
    },
    {
      "id": 3,
      "username": "CodeMaster",
      "message": "Can you share the GitHub repo link?",
      "timestamp": "14:29",
      "isHost": false,
      "avatar": "https://picsum.photos/40/40?random=3&keyword=developer",
      "isModerator": true,
      "isVerified": false
    },
    {
      "id": 4,
      "username": "AIEnthusiast",
      "message": "This is exactly what I was looking for! 🔥",
      "timestamp": "14:28",
      "isHost": false,
      "avatar": "https://picsum.photos/40/40?random=4&keyword=woman",
      "isModerator": false,
      "isVerified": false
    },
    {
      "id": 5,
      "username": "DevNewbie",
      "message": "As a beginner, this is really helpful. Thank you!",
      "timestamp": "14:27",
      "isHost": false,
      "avatar": "https://picsum.photos/40/40?random=5&keyword=student",
      "isModerator": false,
      "isVerified": false
    }
  ];

  List<Map<String, dynamic>> viewers = [
    {
      "username": "TechExpert92",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "isVerified": true,
      "watchTime": "45 min"
    },
    {
      "username": "CodeMaster",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=developer",
      "isVerified": false,
      "watchTime": "32 min"
    },
    {
      "username": "AIEnthusiast",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=woman",
      "isVerified": false,
      "watchTime": "28 min"
    },
    {
      "username": "DevNewbie",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=student",
      "isVerified": false,
      "watchTime": "15 min"
    }
  ];

  List<Map<String, dynamic>> quickActions = [
    {"icon": Icons.thumb_up, "label": "Like", "count": 1250, "color": "success"},
    {"icon": Icons.share, "label": "Share", "count": 89, "color": "info"},
    {"icon": Icons.bookmark, "label": "Save", "count": 234, "color": "warning"},
    {"icon": Icons.report, "label": "Report", "count": 0, "color": "danger"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildMainContent(),
          ),
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(left: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: _buildChatSidebar(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildVideoPlayer(),
        _buildStreamInfo(),
        _buildInteractionBar(),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_filled,
                    size: 80,
                    color: Colors.white.withAlpha(180),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Tech Innovation Summit 2024",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 12),
                        SizedBox(width: spSm),
                        Text(
                          "LIVE • 2h 45m",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: spMd,
              left: spMd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.visibility, color: Colors.white, size: 16),
                    SizedBox(width: spSm),
                    Text(
                      "${(activeViewers / 1000).toStringAsFixed(1)}K viewers",
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
            Positioned(
              top: spMd,
              right: spMd,
              child: Row(
                children: [
                  _buildControlButton(
                    icon: soundEnabled ? Icons.volume_up : Icons.volume_off,
                    onTap: () {
                      soundEnabled = !soundEnabled;
                      setState(() {});
                    },
                  ),
                  SizedBox(width: spSm),
                  _buildControlButton(
                    icon: Icons.fullscreen,
                    onTap: () {
                      si("Fullscreen mode");
                    },
                  ),
                  SizedBox(width: spSm),
                  _buildControlButton(
                    icon: Icons.settings,
                    onTap: () {
                      si("Settings opened");
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: spMd,
              left: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Latest trends in artificial intelligence and machine learning",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Technology • Hosted by StreamHost",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(180),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QButton(
                      label: "Follow",
                      size: bs.sm,
                      onPressed: () {
                        ss("Following StreamHost");
                      },
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

  Widget _buildControlButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(150),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildStreamInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://picsum.photos/50/50?random=2&keyword=host"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "StreamHost",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.verified, color: successColor, size: 16),
                      ],
                    ),
                    Text(
                      "245K subscribers • Started streaming 2h ago",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isConnected ? successColor : dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isConnected ? Icons.wifi : Icons.wifi_off,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      isConnected ? "Connected" : "Disconnected",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Row(
        children: quickActions.map((action) {
          Color getColor() {
            switch (action["color"]) {
              case "success": return successColor;
              case "info": return infoColor;
              case "warning": return warningColor;
              case "danger": return dangerColor;
              default: return primaryColor;
            }
          }

          return Expanded(
            child: GestureDetector(
              onTap: () {
                ss("${action["label"]} pressed");
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: getColor().withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: getColor().withAlpha(30)),
                ),
                child: Column(
                  children: [
                    Icon(
                      action["icon"] as IconData,
                      color: getColor(),
                      size: 20,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${action["count"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: getColor(),
                      ),
                    ),
                    Text(
                      "${action["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChatSidebar() {
    return Column(
      children: [
        _buildChatHeader(),
        Expanded(child: _buildChatMessages()),
        _buildChatInput(),
      ],
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
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
          GestureDetector(
            onTap: () {
              notificationsEnabled = !notificationsEnabled;
              setState(() {});
            },
            child: Icon(
              notificationsEnabled ? Icons.notifications : Icons.notifications_off,
              color: notificationsEnabled ? primaryColor : disabledBoldColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.all(spSm),
      itemCount: chatMessages.length,
      itemBuilder: (context, index) {
        final message = chatMessages[chatMessages.length - 1 - index];
        return _buildChatMessage(message);
      },
    );
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (message["isHost"] as bool) ? primaryColor.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: (message["isHost"] as bool) ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage("${message["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${message["username"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (message["isHost"] as bool) ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    if (message["isVerified"] as bool) ...[
                      SizedBox(width: spXs),
                      Icon(Icons.verified, color: successColor, size: 12),
                    ],
                    if (message["isModerator"] as bool) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
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
                    ],
                    if (message["isHost"] as bool) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
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
                  ],
                ),
              ),
              Text(
                "${message["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${message["message"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Type your message...",
                  value: message,
                  onChanged: (value) {
                    message = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.send,
                size: bs.sm,
                onPressed: () {
                  if (message.isNotEmpty) {
                    chatMessages.insert(0, {
                      "id": chatMessages.length + 1,
                      "username": "YourUsername",
                      "message": message,
                      "timestamp": TimeOfDay.now().format(context),
                      "isHost": false,
                      "avatar": "https://picsum.photos/40/40?random=99&keyword=user",
                      "isModerator": false,
                      "isVerified": false
                    });
                    message = "";
                    setState(() {});
                  }
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              QButton(
                icon: Icons.emoji_emotions,
                size: bs.sm,
                onPressed: () {
                  si("Emoji picker opened");
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.gif_box,
                size: bs.sm,
                onPressed: () {
                  si("GIF picker opened");
                },
              ),
              Spacer(),
              Text(
                "${viewers.length} viewers",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
