import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaVideoInterviewView extends StatefulWidget {
  const RhaVideoInterviewView({super.key});

  @override
  State<RhaVideoInterviewView> createState() => _RhaVideoInterviewViewState();
}

class _RhaVideoInterviewViewState extends State<RhaVideoInterviewView> {
  bool isVideoOn = true;
  bool isAudioOn = true;
  bool isRecording = false;
  bool isScreenSharing = false;
  String currentView = "speaker"; // speaker, gallery, screen
  
  // Interview session data
  String candidateName = "Sarah Wilson";
  String candidateEmail = "sarah.wilson@email.com";
  String position = "Senior Software Engineer";
  String interviewRound = "Technical Round 1";
  String startTime = "10:00 AM";
  String duration = "60 min";
  String sessionId = "INT-2024-001";
  
  // Participants
  List<Map<String, dynamic>> participants = [
    {
      "name": "Sarah Wilson",
      "role": "Candidate",
      "image": "https://picsum.photos/100/100?random=1&keyword=woman",
      "isHost": false,
      "videoOn": true,
      "audioOn": true,
      "isConnected": true,
    },
    {
      "name": "John Smith",
      "role": "Technical Lead",
      "image": "https://picsum.photos/100/100?random=2&keyword=man",
      "isHost": true,
      "videoOn": true,
      "audioOn": true,
      "isConnected": true,
    },
    {
      "name": "Lisa Garcia",
      "role": "HR Manager",
      "image": "https://picsum.photos/100/100?random=3&keyword=woman",
      "isHost": false,
      "videoOn": false,
      "audioOn": true,
      "isConnected": true,
    },
  ];

  // Chat messages
  List<Map<String, dynamic>> chatMessages = [
    {
      "sender": "John Smith",
      "message": "Welcome Sarah! Please introduce yourself.",
      "time": "10:02 AM",
      "isMe": false,
    },
    {
      "sender": "Sarah Wilson",
      "message": "Thank you! I'm excited to be here.",
      "time": "10:03 AM",
      "isMe": false,
    },
    {
      "sender": "You",
      "message": "Let's start with technical questions.",
      "time": "10:05 AM",
      "isMe": true,
    },
  ];

  // Interview questions/notes
  List<Map<String, dynamic>> interviewNotes = [
    {
      "question": "Tell us about your experience with React",
      "answer": "5+ years experience, built multiple applications",
      "rating": 4,
      "notes": "Strong technical knowledge",
    },
    {
      "question": "How do you handle state management?",
      "answer": "Redux, Context API, and Zustand",
      "rating": 5,
      "notes": "Excellent understanding",
    },
  ];

  String chatInput = "";
  bool showChat = false;
  bool showNotes = false;

  Widget _buildVideoGrid() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          // Main video view
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/800/400?random=10&keyword=office"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Video overlay info
          Positioned(
            top: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.videocam,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "HD Video Call",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Recording indicator
          if (isRecording) ...[
            Positioned(
              top: spSm,
              right: spSm,
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
                      "REC",
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
          ],
          
          // Participant thumbnails
          Positioned(
            bottom: spSm,
            right: spSm,
            child: Column(
              children: participants.take(3).map((participant) => 
                Container(
                  width: 80,
                  height: 60,
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: participant["isHost"] ? primaryColor : Colors.white,
                      width: 2,
                    ),
                    image: participant["videoOn"] ? DecorationImage(
                      image: NetworkImage("${participant["image"]}"),
                      fit: BoxFit.cover,
                    ) : null,
                    color: participant["videoOn"] ? null : Colors.grey[800],
                  ),
                  child: !participant["videoOn"] ? Center(
                    child: Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 20,
                    ),
                  ) : null,
                ),
              ).toList(),
            ),
          ),
          
          // Video controls overlay
          Positioned(
            bottom: spSm,
            left: spSm,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${participants.length}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(128),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "25:30",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Microphone
          GestureDetector(
            onTap: () {
              isAudioOn = !isAudioOn;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isAudioOn ? primaryColor.withAlpha(51) : dangerColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isAudioOn ? primaryColor : dangerColor,
                  width: 2,
                ),
              ),
              child: Icon(
                isAudioOn ? Icons.mic : Icons.mic_off,
                color: isAudioOn ? primaryColor : dangerColor,
                size: 24,
              ),
            ),
          ),
          
          // Video
          GestureDetector(
            onTap: () {
              isVideoOn = !isVideoOn;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isVideoOn ? primaryColor.withAlpha(51) : dangerColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isVideoOn ? primaryColor : dangerColor,
                  width: 2,
                ),
              ),
              child: Icon(
                isVideoOn ? Icons.videocam : Icons.videocam_off,
                color: isVideoOn ? primaryColor : dangerColor,
                size: 24,
              ),
            ),
          ),
          
          // Screen Share
          GestureDetector(
            onTap: () {
              isScreenSharing = !isScreenSharing;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isScreenSharing ? warningColor.withAlpha(51) : disabledColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isScreenSharing ? warningColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.screen_share,
                color: isScreenSharing ? warningColor : disabledBoldColor,
                size: 24,
              ),
            ),
          ),
          
          // Record
          GestureDetector(
            onTap: () {
              isRecording = !isRecording;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isRecording ? dangerColor.withAlpha(51) : disabledColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: isRecording ? dangerColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: Icon(
                isRecording ? Icons.stop : Icons.fiber_manual_record,
                color: isRecording ? dangerColor : disabledBoldColor,
                size: 24,
              ),
            ),
          ),
          
          // Chat
          GestureDetector(
            onTap: () {
              showChat = !showChat;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: showChat ? infoColor.withAlpha(51) : disabledColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: showChat ? infoColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.chat,
                color: showChat ? infoColor : disabledBoldColor,
                size: 24,
              ),
            ),
          ),
          
          // Notes
          GestureDetector(
            onTap: () {
              showNotes = !showNotes;
              setState(() {});
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: showNotes ? successColor.withAlpha(51) : disabledColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: showNotes ? successColor : disabledBoldColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.note_add,
                color: showNotes ? successColor : disabledBoldColor,
                size: 24,
              ),
            ),
          ),
          
          // End Call
          GestureDetector(
            onTap: () {
              // End call action
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(
                Icons.call_end,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Participants (${participants.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...participants.map((participant) => 
            Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${participant["image"]}"),
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
                          "${participant["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${participant["role"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        participant["audioOn"] ? Icons.mic : Icons.mic_off,
                        size: 16,
                        color: participant["audioOn"] ? successColor : dangerColor,
                      ),
                      SizedBox(width: spXs),
                      Icon(
                        participant["videoOn"] ? Icons.videocam : Icons.videocam_off,
                        size: 16,
                        color: participant["videoOn"] ? successColor : dangerColor,
                      ),
                      if (participant["isHost"]) ...[
                        SizedBox(width: spXs),
                        Icon(
                          Icons.admin_panel_settings,
                          size: 16,
                          color: primaryColor,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildSessionInfo() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: disabledOutlineBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Interview Session",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "$candidateName - $position",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.event,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Text(
                interviewRound,
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Text(
                "$startTime • $duration",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.confirmation_number,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spSm),
              Text(
                "Session ID: $sessionId",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Interview"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.fullscreen),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Session Info
            _buildSessionInfo(),
            SizedBox(height: spSm),
            
            // Video Grid
            _buildVideoGrid(),
            SizedBox(height: spSm),
            
            // Control Panel
            _buildControlPanel(),
            SizedBox(height: spSm),
            
            // Participants List
            _buildParticipantsList(),
            
            if (showChat) ...[
              SizedBox(height: spSm),
              Container(
                height: 200,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chat",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = chatMessages[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${message["sender"]} • ${message["time"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${message["message"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Type a message",
                            value: chatInput,
                            onChanged: (value) {
                              chatInput = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.send,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            
            if (showNotes) ...[
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Interview Notes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        QButton(
                          label: "Add Note",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...interviewNotes.map((note) => 
                      Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Q: ${note["question"]}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "A: ${note["answer"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (note["notes"].isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Text(
                                "Notes: ${note["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "Rating:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                ...List.generate(5, (index) => 
                                  Icon(
                                    index < note["rating"] ? Icons.star : Icons.star_border,
                                    size: 16,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
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
