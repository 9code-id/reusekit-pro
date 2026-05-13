import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaStreamingView extends StatefulWidget {
  const GeaStreamingView({super.key});

  @override
  State<GeaStreamingView> createState() => _GeaStreamingViewState();
}

class _GeaStreamingViewState extends State<GeaStreamingView> {
  String streamTitle = "";
  String streamDescription = "";
  String selectedGame = "Valorant";
  bool isLive = false;
  int viewerCount = 0;
  List<String> chatMessages = [];
  String chatMessage = "";

  List<Map<String, dynamic>> games = [
    {"label": "Valorant", "value": "Valorant"},
    {"label": "CS2", "value": "CS2"},
    {"label": "Dota 2", "value": "Dota 2"},
    {"label": "League of Legends", "value": "League of Legends"},
    {"label": "Apex Legends", "value": "Apex Legends"},
  ];

  List<Map<String, dynamic>> featuredStreams = [
    {
      "streamer": "ProGamer123",
      "game": "Valorant",
      "viewers": 1200,
      "title": "Ranked Climb to Immortal",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=gaming",
      "isLive": true,
    },
    {
      "streamer": "StreamQueen",
      "game": "League of Legends",
      "viewers": 850,
      "title": "Solo Queue Adventures",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=gaming",
      "isLive": true,
    },
    {
      "streamer": "ElitePlayer",
      "game": "CS2",
      "viewers": 2100,
      "title": "Professional Match Review",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=gaming",
      "isLive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GEA Streaming"),
        actions: [
          QButton(
            icon: Icons.videocam,
            size: bs.sm,
            onPressed: () => _startStream(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStreamControls(),
            _buildFeaturedStreams(),
            _buildStreamChat(),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamControls() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stream Setup",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Stream Title",
            value: streamTitle,
            hint: "Enter your stream title",
            onChanged: (value) {
              streamTitle = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Stream Description",
            value: streamDescription,
            hint: "Describe your stream content",
            onChanged: (value) {
              streamDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Game Category",
            items: games,
            value: selectedGame,
            onChanged: (value, label) {
              selectedGame = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isLive ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isLive ? successColor : disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        isLive ? "LIVE" : "OFFLINE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isLive ? successColor : disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      if (isLive)
                        Text(
                          "${viewerCount} viewers",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: isLive ? "Stop Stream" : "Go Live",
                size: bs.sm,
                onPressed: () => _toggleStream(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedStreams() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Featured Streams",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: featuredStreams.map((stream) => _buildStreamCard(stream)).toList(),
        ),
      ],
    );
  }

  Widget _buildStreamCard(Map<String, dynamic> stream) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${stream["thumbnail"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              if (stream["isLive"] as bool)
                Positioned(
                  top: spXs,
                  left: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility, color: Colors.white, size: 12),
                      SizedBox(width: 2),
                      Text(
                        "${(stream["viewers"] as int) >= 1000 ? '${((stream["viewers"] as int) / 1000).toStringAsFixed(1)}K' : stream["viewers"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spXs,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stream["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${stream["streamer"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${stream["game"]}",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
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

  Widget _buildStreamChat() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Stream Chat",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(Icons.people, color: disabledBoldColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "127 chatting",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: ListView(
                children: [
                  _buildChatMessage("ProGamer", "GG! Nice play!", true),
                  _buildChatMessage("ViewerXYZ", "How did you do that?", false),
                  _buildChatMessage("StreamFan", "Amazing content!", false),
                  _buildChatMessage("GamerGirl", "Can you teach us that trick?", false),
                  _buildChatMessage("ElitePro", "Sub hype! 🔥", false),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Type a message...",
                  value: chatMessage,
                  hint: "Say something nice!",
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
                onPressed: () => _sendChatMessage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(String username, String message, bool isStreamer) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$username: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isStreamer ? primaryColor : secondaryColor,
                fontSize: 12,
              ),
            ),
            TextSpan(
              text: message,
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startStream() {
    if (streamTitle.isEmpty) {
      se("Please enter a stream title");
      return;
    }
    ss("Stream setup completed! Ready to go live.");
  }

  void _toggleStream() {
    isLive = !isLive;
    if (isLive) {
      viewerCount = 1;
      ss("Stream started! You're now live!");
    } else {
      viewerCount = 0;
      si("Stream ended. Thanks for streaming!");
    }
    setState(() {});
  }

  void _sendChatMessage() {
    if (chatMessage.isNotEmpty) {
      chatMessages.add(chatMessage);
      chatMessage = "";
      setState(() {});
    }
  }
}
