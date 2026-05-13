import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaVirtualClassroomView extends StatefulWidget {
  const ElaVirtualClassroomView({super.key});

  @override
  State<ElaVirtualClassroomView> createState() => _ElaVirtualClassroomViewState();
}

class _ElaVirtualClassroomViewState extends State<ElaVirtualClassroomView> {
  bool micEnabled = true;
  bool cameraEnabled = false;
  bool screenSharing = false;
  bool handRaised = false;
  bool chatVisible = true;
  String chatMessage = "";
  
  List<Map<String, dynamic>> participants = [
    {
      "id": 1,
      "name": "Dr. Sarah Chen",
      "role": "Instructor",
      "micEnabled": true,
      "cameraEnabled": true,
      "isPresenting": true,
      "avatarUrl": "https://picsum.photos/100/100?random=1",
    },
    {
      "id": 2,
      "name": "Alice Johnson",
      "role": "Student",
      "micEnabled": false,
      "cameraEnabled": true,
      "isPresenting": false,
      "avatarUrl": "https://picsum.photos/100/100?random=2",
    },
    {
      "id": 3,
      "name": "Bob Smith",
      "role": "Student",
      "micEnabled": true,
      "cameraEnabled": false,
      "isPresenting": false,
      "avatarUrl": "https://picsum.photos/100/100?random=3",
    },
    {
      "id": 4,
      "name": "Carol Davis",
      "role": "Student",
      "micEnabled": false,
      "cameraEnabled": true,
      "isPresenting": false,
      "avatarUrl": "https://picsum.photos/100/100?random=4",
    },
    {
      "id": 5,
      "name": "David Wilson",
      "role": "Student",
      "micEnabled": false,
      "cameraEnabled": false,
      "isPresenting": false,
      "avatarUrl": "https://picsum.photos/100/100?random=5",
    },
    {
      "id": 6,
      "name": "Emma Brown",
      "role": "Student",
      "micEnabled": true,
      "cameraEnabled": true,
      "isPresenting": false,
      "avatarUrl": "https://picsum.photos/100/100?random=6",
    },
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "sender": "Dr. Sarah Chen",
      "message": "Welcome everyone to today's Advanced Calculus class!",
      "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
      "role": "Instructor",
    },
    {
      "id": 2,
      "sender": "Alice Johnson",
      "message": "Thank you professor, excited for today's lesson",
      "timestamp": DateTime.now().subtract(Duration(minutes: 4)),
      "role": "Student",
    },
    {
      "id": 3,
      "sender": "Bob Smith",
      "message": "Can you please share the presentation?",
      "timestamp": DateTime.now().subtract(Duration(minutes: 3)),
      "role": "Student",
    },
    {
      "id": 4,
      "sender": "Dr. Sarah Chen",
      "message": "Of course! I'll start sharing my screen now",
      "timestamp": DateTime.now().subtract(Duration(minutes: 2)),
      "role": "Instructor",
    },
  ];

  Widget _buildMainVideoArea() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Stack(
        children: [
          // Main presenter view
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/300?random=1&keyword=presentation"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(127),
                  ],
                ),
              ),
            ),
          ),
          // Presenter info
          Positioned(
            bottom: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(153),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${participants[0]["avatarUrl"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${participants[0]["name"]} (Presenting)",
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
          // Screen sharing indicator
          if (screenSharing)
            Positioned(
              top: spSm,
              right: spSm,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.screen_share,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Screen Sharing",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
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

  Widget _buildParticipantsList() {
    return Container(
      height: 120,
      child: QHorizontalScroll(
        children: participants.map((participant) => _buildParticipantCard(participant)).toList(),
      ),
    );
  }

  Widget _buildParticipantCard(Map<String, dynamic> participant) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: spSm),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (participant["isPresenting"] as bool) ? dangerColor : 
                           (participant["role"] == "Instructor") ? primaryColor : disabledColor,
                    width: 2,
                  ),
                ),
                child: (participant["cameraEnabled"] as bool)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${participant["avatarUrl"]}",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
              ),
              // Mic status
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: (participant["micEnabled"] as bool) ? successColor : dangerColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Icon(
                    (participant["micEnabled"] as bool) ? Icons.mic : Icons.mic_off,
                    color: Colors.white,
                    size: 8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${participant["name"]}".split(' ')[0],
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${participant["role"]}",
            style: TextStyle(
              fontSize: 8,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildControlsBar() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: micEnabled ? Icons.mic : Icons.mic_off,
            label: "Mic",
            isActive: micEnabled,
            onTap: () {
              micEnabled = !micEnabled;
              setState(() {});
              ss(micEnabled ? "Microphone enabled" : "Microphone disabled");
            },
          ),
          _buildControlButton(
            icon: cameraEnabled ? Icons.videocam : Icons.videocam_off,
            label: "Camera",
            isActive: cameraEnabled,
            onTap: () {
              cameraEnabled = !cameraEnabled;
              setState(() {});
              ss(cameraEnabled ? "Camera enabled" : "Camera disabled");
            },
          ),
          _buildControlButton(
            icon: Icons.screen_share,
            label: "Share",
            isActive: screenSharing,
            onTap: () {
              screenSharing = !screenSharing;
              setState(() {});
              ss(screenSharing ? "Screen sharing started" : "Screen sharing stopped");
            },
          ),
          _buildControlButton(
            icon: Icons.pan_tool,
            label: "Raise Hand",
            isActive: handRaised,
            onTap: () {
              handRaised = !handRaised;
              setState(() {});
              ss(handRaised ? "Hand raised" : "Hand lowered");
            },
          ),
          _buildControlButton(
            icon: Icons.chat,
            label: "Chat",
            isActive: chatVisible,
            onTap: () {
              chatVisible = !chatVisible;
              setState(() {});
            },
          ),
          _buildControlButton(
            icon: Icons.call_end,
            label: "Leave",
            isActive: false,
            color: dangerColor,
            onTap: () {
              _showLeaveDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    Color? color,
  }) {
    final buttonColor = color ?? (isActive ? primaryColor : disabledColor);
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: buttonColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(
                color: buttonColor,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: buttonColor,
              size: 20,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: buttonColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    if (!chatVisible) return SizedBox.shrink();
    
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: spSm),
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.chat,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Class Chat",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  chatVisible = false;
                  setState(() {});
                },
                child: Icon(
                  Icons.close,
                  color: disabledBoldColor,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return _buildChatMessage(message);
              },
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                    onChanged: (value) {
                      chatMessage = value;
                    },
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _sendMessage(value);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.send,
                size: bs.sm,
                onPressed: () {
                  if (chatMessage.isNotEmpty) {
                    _sendMessage(chatMessage);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(Map<String, dynamic> message) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${message["sender"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: message["role"] == "Instructor" ? primaryColor : disabledBoldColor,
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "${(message["timestamp"] as DateTime).kkmm}",
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
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    setState(() {
      chatMessages.add({
        "id": chatMessages.length + 1,
        "sender": "You",
        "message": message,
        "timestamp": DateTime.now(),
        "role": "Student",
      });
      chatMessage = "";
    });
    ss("Message sent");
  }

  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Leave Class"),
        content: Text("Are you sure you want to leave the virtual classroom?"),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              back();
              back();
              ss("Left the virtual classroom");
            },
            child: Text(
              "Leave",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advanced Calculus - Live"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dangerColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Text(
                  "LIVE",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainVideoArea(),
            SizedBox(height: spMd),
            Text(
              "Participants (${participants.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            _buildParticipantsList(),
            SizedBox(height: spMd),
            _buildControlsBar(),
            _buildChatArea(),
          ],
        ),
      ),
    );
  }
}
