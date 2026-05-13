import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaTutoringSessionView extends StatefulWidget {
  const ElaTutoringSessionView({super.key});

  @override
  State<ElaTutoringSessionView> createState() => _ElaTutoringSessionViewState();
}

class _ElaTutoringSessionViewState extends State<ElaTutoringSessionView> {
  bool loading = false;
  bool isSessionActive = true;
  bool isMicMuted = false;
  bool isCameraOff = false;
  bool isRecording = false;
  int sessionDuration = 45; // minutes
  int elapsedTime = 23; // minutes

  Map<String, dynamic> currentSession = {
    "id": 1,
    "topic": "Reading Comprehension - Poetry Analysis",
    "tutor": {
      "name": "Dr. Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=teacher",
    },
    "student": {
      "name": "Emily Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=student",
    },
    "startTime": "2024-01-15T14:00:00",
    "endTime": "2024-01-15T14:45:00",
    "materials": [
      {
        "name": "Poetry Collection.pdf",
        "type": "document",
        "size": "2.3 MB",
      },
      {
        "name": "Analysis Worksheet",
        "type": "document", 
        "size": "1.1 MB",
      },
    ],
  };

  List<Map<String, dynamic>> sessionNotes = [
    {
      "id": 1,
      "timestamp": "14:05",
      "author": "tutor",
      "content": "Today we'll focus on analyzing the use of metaphor in Emily Dickinson's poetry",
      "type": "note",
    },
    {
      "id": 2,
      "timestamp": "14:12",
      "author": "student",
      "content": "I found the bird metaphor in 'Hope is the thing with feathers' really interesting",
      "type": "note",
    },
    {
      "id": 3,
      "timestamp": "14:18",
      "author": "tutor",
      "content": "Excellent observation! Let's explore how Dickinson uses extended metaphors",
      "type": "note",
    },
    {
      "id": 4,
      "timestamp": "14:20",
      "author": "system",
      "content": "Screen sharing started",
      "type": "system",
    },
  ];

  String newNote = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutoring Session"),
        actions: [
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              _showSessionOptions();
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (isSessionActive) _buildSessionHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVideoSection(),
                        SizedBox(height: spMd),
                        _buildSessionInfo(),
                        SizedBox(height: spMd),
                        _buildMaterialsSection(),
                        SizedBox(height: spMd),
                        _buildNotesSection(),
                      ],
                    ),
                  ),
                ),
                if (isSessionActive) _buildControlPanel(),
              ],
            ),
    );
  }

  Widget _buildSessionHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(30),
        border: Border(
          bottom: BorderSide(
            color: successColor.withAlpha(100),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: successColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "Session Active",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
          Spacer(),
          if (isRecording)
            Row(
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  color: dangerColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "Recording",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: dangerColor,
                  ),
                ),
                SizedBox(width: spMd),
              ],
            ),
          Text(
            "${elapsedTime}:00 / ${sessionDuration}:00",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          // Main video (tutor)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withAlpha(180),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage("${currentSession["tutor"]["avatar"]}"),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${currentSession["tutor"]["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Student video (picture-in-picture)
          Positioned(
            top: spMd,
            right: spMd,
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${currentSession["student"]["avatar"]}"),
                      ),
                    ),
                    if (isCameraOff)
                      Container(
                        color: Colors.black.withAlpha(180),
                        child: Center(
                          child: Icon(
                            Icons.videocam_off,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Session controls overlay
          Positioned(
            bottom: spMd,
            left: spMd,
            right: spMd,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Connection: Excellent",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
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

  Widget _buildSessionInfo() {
    return Container(
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
            "Session Details",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Topic",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentSession["topic"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Duration",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${sessionDuration} minutes",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${((elapsedTime / sessionDuration) * 100).toInt()}% Complete",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          LinearProgressIndicator(
            value: elapsedTime / sessionDuration,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsSection() {
    return Container(
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
              Expanded(
                child: Text(
                  "Session Materials",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _addMaterial();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: (currentSession["materials"] as List).map((material) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      material["type"] == "document" ? Icons.description : Icons.image,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
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
                      icon: Icons.download,
                      size: bs.sm,
                      onPressed: () {
                        ss("Downloading ${material["name"]}");
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
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
            "Session Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: sessionNotes.map((note) => _buildNoteItem(note)).toList(),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Add note...",
                  value: newNote,
                  onChanged: (value) {
                    newNote = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.send,
                size: bs.sm,
                onPressed: () {
                  _addNote();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(Map<String, dynamic> note) {
    bool isFromTutor = note["author"] == "tutor";
    bool isSystem = note["type"] == "system";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            child: Text(
              "${note["timestamp"]}",
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSystem
                    ? infoColor.withAlpha(30)
                    : isFromTutor
                        ? primaryColor.withAlpha(30)
                        : successColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSystem)
                    Text(
                      isFromTutor ? "Tutor" : "Student",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isFromTutor ? primaryColor : successColor,
                      ),
                    ),
                  if (!isSystem) SizedBox(height: spXs),
                  Text(
                    "${note["content"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isSystem
                          ? infoColor
                          : isFromTutor
                              ? primaryColor
                              : successColor,
                      fontStyle: isSystem ? FontStyle.italic : FontStyle.normal,
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

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
        border: Border(
          top: BorderSide(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: isMicMuted ? Icons.mic_off : Icons.mic,
            label: isMicMuted ? "Unmute" : "Mute",
            color: isMicMuted ? dangerColor : primaryColor,
            onPressed: () {
              isMicMuted = !isMicMuted;
              setState(() {});
              ss(isMicMuted ? "Microphone muted" : "Microphone unmuted");
            },
          ),
          _buildControlButton(
            icon: isCameraOff ? Icons.videocam_off : Icons.videocam,
            label: isCameraOff ? "Camera On" : "Camera Off",
            color: isCameraOff ? dangerColor : primaryColor,
            onPressed: () {
              isCameraOff = !isCameraOff;
              setState(() {});
              ss(isCameraOff ? "Camera turned off" : "Camera turned on");
            },
          ),
          _buildControlButton(
            icon: Icons.screen_share,
            label: "Share",
            color: infoColor,
            onPressed: () {
              ss("Screen sharing started");
            },
          ),
          _buildControlButton(
            icon: isRecording ? Icons.stop : Icons.fiber_manual_record,
            label: isRecording ? "Stop Rec" : "Record",
            color: dangerColor,
            onPressed: () {
              isRecording = !isRecording;
              setState(() {});
              ss(isRecording ? "Recording started" : "Recording stopped");
            },
          ),
          _buildControlButton(
            icon: Icons.call_end,
            label: "End",
            color: dangerColor,
            onPressed: () {
              _endSession();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _addMaterial() {
    ss("Adding material to session");
  }

  void _addNote() {
    if (newNote.trim().isNotEmpty) {
      sessionNotes.add({
        "id": sessionNotes.length + 1,
        "timestamp": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        "author": "student",
        "content": newNote.trim(),
        "type": "note",
      });
      newNote = "";
      setState(() {});
    }
  }

  void _endSession() async {
    bool isConfirmed = await confirm("Are you sure you want to end the session?");
    if (isConfirmed) {
      isSessionActive = false;
      setState(() {});
      ss("Session ended");
    }
  }

  void _showSessionOptions() {
    ss("Showing session options");
  }
}
