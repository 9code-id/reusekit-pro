import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLive8View extends StatefulWidget {
  @override
  State<GrlLive8View> createState() => _GrlLive8ViewState();
}

class _GrlLive8ViewState extends State<GrlLive8View> {
  bool isRecording = false;
  bool showChat = true;
  bool showViewers = false;
  int viewerCount = 0;
  int heartCount = 0;
  String streamTitle = "My Live Stream";
  String streamDescription = "";

  List<Map<String, dynamic>> chatMessages = [];
  List<Map<String, dynamic>> viewers = [];
  List<Map<String, dynamic>> giftHistory = [];

  void _startStream() {
    setState(() {
      isRecording = true;
      viewerCount = 1;
    });

    // Simulate viewer growth
    _simulateViewerGrowth();
    _simulateChat();
  }

  void _endStream() async {
    bool isConfirmed = await confirm("Are you sure you want to end the stream?");
    if (isConfirmed) {
      setState(() {
        isRecording = false;
        viewerCount = 0;
        chatMessages.clear();
        viewers.clear();
      });
      
      _showStreamSummary();
    }
  }

  void _simulateViewerGrowth() {
    if (!isRecording) return;
    
    Future.delayed(Duration(seconds: 2), () {
      if (isRecording) {
        setState(() {
          viewerCount += (1 + (viewerCount * 0.1).round());
          if (viewerCount > 10000) viewerCount = 10000;
        });
        _simulateViewerGrowth();
      }
    });
  }

  void _simulateChat() {
    if (!isRecording) return;

    List<String> sampleMessages = [
      "Welcome to the stream! 👋",
      "Great content as always!",
      "Love your setup!",
      "Can you show us more?",
      "Amazing stream! 🔥",
      "Keep it up!",
      "This is so cool!",
      "First time watching, love it!",
    ];

    List<String> usernames = [
      "viewer_123", "stream_fan", "daily_watcher", "music_lover",
      "tech_enthusiast", "creative_mind", "night_owl", "regular_user"
    ];

    Future.delayed(Duration(seconds: 3 + (DateTime.now().millisecond % 5)), () {
      if (isRecording && chatMessages.length < 50) {
        setState(() {
          chatMessages.insert(0, {
            "user": usernames[DateTime.now().millisecond % usernames.length],
            "message": sampleMessages[DateTime.now().millisecond % sampleMessages.length],
            "time": DateTime.now(),
            "avatar": "https://picsum.photos/40/40?random=${DateTime.now().millisecond}",
          });
          
          if (chatMessages.length > 20) {
            chatMessages.removeLast();
          }
        });
        _simulateChat();
      }
    });
  }

  void _showStreamSummary() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  Icon(Icons.celebration, color: primaryColor),
                  SizedBox(width: spSm),
                  Text(
                    "Stream Ended!",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    // Stream stats
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Stream Summary",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spMd),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${viewerCount}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Peak Viewers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${chatMessages.length + 15}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Chat Messages",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${heartCount + 50}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Hearts",
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
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Share Stream",
                            size: bs.md,
                            onPressed: () {
                              Navigator.pop(context);
                              ss("Stream link copied to clipboard!");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                back();
                              },
                              child: Text(
                                "Done",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview background
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  "https://picsum.photos/400/800?random=40&keyword=livestream",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Dark overlay when not recording
                if (!isRecording)
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withAlpha(120),
                  ),
              ],
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
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                
                Spacer(),
                
                // Live indicator and viewer count
                if (isRecording)
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
                          width: 8,
                          height: 8,
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.visibility,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "$viewerCount",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                Spacer(),

                // Settings
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(120),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat overlay (when recording)
          if (isRecording && showChat)
            Positioned(
              right: spMd,
              top: 120,
              bottom: 200,
              child: Container(
                width: 250,
                child: Column(
                  children: [
                    // Chat header
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          topRight: Radius.circular(radiusSm),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Live Chat",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Chat messages
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(120),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusSm),
                            bottomRight: Radius.circular(radiusSm),
                          ),
                        ),
                        child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.all(spSm),
                          itemCount: chatMessages.length,
                          itemBuilder: (context, index) {
                            final message = chatMessages[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusLg),
                                      child: Image.network(
                                        "${message["avatar"]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${message["user"]}",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${message["message"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
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
                    ),
                  ],
                ),
              ),
            ),

          // Show chat button (when chat is hidden)
          if (isRecording && !showChat)
            Positioned(
              right: spMd,
              top: 120,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showChat = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(120),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${chatMessages.length}",
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
            ),

          // Start stream setup (when not recording)
          if (!isRecording)
            Positioned(
              bottom: 80,
              left: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(160),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Text(
                      "Ready to Go Live?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "What's your stream about?",
                          hintStyle: TextStyle(color: Colors.white.withAlpha(180)),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          streamDescription = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withAlpha(120)),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Settings",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Go Live",
                            size: bs.md,
                            onPressed: _startStream,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Bottom controls (when recording)
          if (isRecording)
            Positioned(
              bottom: 40,
              left: spMd,
              right: spMd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Flip camera
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // Effects
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // End stream
                  GestureDetector(
                    onTap: _endStream,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // Share
                  GestureDetector(
                    onTap: () {
                      ss("Stream link copied to clipboard!");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // More options
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(120),
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
            ),
        ],
      ),
    );
  }
}
