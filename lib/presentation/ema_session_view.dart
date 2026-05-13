import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSessionView extends StatefulWidget {
  const EmaSessionView({super.key});

  @override
  State<EmaSessionView> createState() => _EmaSessionViewState();
}

class _EmaSessionViewState extends State<EmaSessionView> {
  bool isJoined = false;
  bool isAudioMuted = false;
  bool isVideoOff = false;
  bool isChatOpen = false;
  bool isFullScreen = false;
  String sessionStatus = "live";
  
  Map<String, dynamic> sessionData = {
    "id": "session_001",
    "title": "Digital Transformation in Healthcare",
    "speaker": {
      "name": "Dr. Sarah Johnson",
      "title": "Chief Technology Officer",
      "company": "MedTech Solutions",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=doctor",
      "bio": "Leading expert in healthcare technology with 15+ years experience",
    },
    "description": "Exploring how digital technologies are revolutionizing patient care and medical procedures",
    "startTime": "14:00",
    "endTime": "15:30",
    "duration": 90,
    "attendees": 324,
    "maxAttendees": 500,
    "category": "Healthcare Technology",
    "level": "Intermediate",
    "language": "English",
    "isRecorded": true,
    "tags": ["Digital Health", "Innovation", "Technology"],
    "materials": [
      {
        "name": "Session Slides",
        "type": "pdf",
        "size": "2.4 MB",
        "url": "https://example.com/slides.pdf"
      },
      {
        "name": "Research Paper",
        "type": "pdf", 
        "size": "1.8 MB",
        "url": "https://example.com/research.pdf"
      },
      {
        "name": "Additional Resources",
        "type": "link",
        "url": "https://example.com/resources"
      },
    ],
    "chatMessages": [
      {
        "id": "1",
        "user": "Alice Cooper",
        "message": "Great insights on AI implementation!",
        "time": "14:15",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=woman",
      },
      {
        "id": "2",
        "user": "John Smith",
        "message": "Can you share more about data privacy concerns?",
        "time": "14:18",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=man",
      },
      {
        "id": "3",
        "user": "Dr. Sarah Johnson",
        "message": "Absolutely! Let me address that in the next slide.",
        "time": "14:19",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=doctor",
        "isSpeaker": true,
      },
    ],
  };

  void _toggleJoinSession() {
    isJoined = !isJoined;
    setState(() {});
    if (isJoined) {
      ss("Joined session successfully");
    } else {
      ss("Left session");
    }
  }

  void _toggleAudio() {
    isAudioMuted = !isAudioMuted;
    setState(() {});
  }

  void _toggleVideo() {
    isVideoOff = !isVideoOff;
    setState(() {});
  }

  void _toggleChat() {
    isChatOpen = !isChatOpen;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Session"),
        actions: [
          GestureDetector(
            onTap: () {
              //navigateTo session settings
            },
            child: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Session Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
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
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${sessionData["attendees"]} watching",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${sessionData["title"]}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${sessionData["description"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${sessionData["startTime"]} - ${sessionData["endTime"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Icon(Icons.language, color: Colors.white, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${sessionData["language"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(220),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Video Player Area
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  // Video placeholder
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/400/200?random=10&keyword=presentation"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Video controls overlay
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          if (isJoined) ...[
                            GestureDetector(
                              onTap: _toggleAudio,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isAudioMuted ? dangerColor : Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isAudioMuted ? Icons.mic_off : Icons.mic,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: _toggleVideo,
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isVideoOff ? dangerColor : Colors.white.withAlpha(50),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isVideoOff ? Icons.videocam_off : Icons.videocam,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                          ],
                          Spacer(),
                          GestureDetector(
                            onTap: _toggleChat,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: isChatOpen ? primaryColor : Colors.white.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.chat,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              isFullScreen = !isFullScreen;
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

            SizedBox(height: spLg),

            // Join/Leave Session Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isJoined ? "Leave Session" : "Join Session",
                size: bs.md,
                onPressed: _toggleJoinSession,
              ),
            ),

            SizedBox(height: spLg),

            // Speaker Information
            Text(
              "Speaker",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      image: DecorationImage(
                        image: NetworkImage("${sessionData["speaker"]["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${sessionData["speaker"]["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${sessionData["speaker"]["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${sessionData["speaker"]["company"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "View Profile",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo speaker profile
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Session Details
            Text(
              "Session Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: disabledBoldColor, size: 20),
                      SizedBox(width: spMd),
                      Text(
                        "Category:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${sessionData["category"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, color: disabledBoldColor, size: 20),
                      SizedBox(width: spMd),
                      Text(
                        "Level:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${sessionData["level"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: disabledBoldColor, size: 20),
                      SizedBox(width: spMd),
                      Text(
                        "Duration:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${sessionData["duration"]} minutes",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.videocam, color: disabledBoldColor, size: 20),
                      SizedBox(width: spMd),
                      Text(
                        "Recording:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        sessionData["isRecorded"] ? "Available" : "Not available",
                        style: TextStyle(
                          fontSize: 14,
                          color: sessionData["isRecorded"] ? successColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Session Materials
            Text(
              "Session Materials",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ...(sessionData["materials"] as List).map((material) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    material["type"] == "pdf" ? Icons.picture_as_pdf : Icons.link,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${material["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        if (material["size"] != null)
                          Text(
                            "${material["size"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Download",
                    size: bs.sm,
                    onPressed: () {
                      ss("Downloading ${material["name"]}");
                    },
                  ),
                ],
              ),
            )).toList(),

            if (isChatOpen) ...[
              SizedBox(height: spLg),

              // Chat Section
              Text(
                "Live Chat",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),

              Container(
                height: 300,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: (sessionData["chatMessages"] as List).map((message) => Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${message["avatar"]}"),
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
                                            "${message["user"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: message["isSpeaker"] == true ? primaryColor : disabledBoldColor,
                                            ),
                                          ),
                                          if (message["isSpeaker"] == true) ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "SPEAKER",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                          Spacer(),
                                          Text(
                                            "${message["time"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "${message["message"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    if (isJoined)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "Type your message...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.send,
                            size: bs.sm,
                            onPressed: () {
                              ss("Message sent");
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
