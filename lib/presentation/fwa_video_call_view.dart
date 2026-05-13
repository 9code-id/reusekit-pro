import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaVideoCallView extends StatefulWidget {
  const FwaVideoCallView({super.key});

  @override
  State<FwaVideoCallView> createState() => _FwaVideoCallViewState();
}

class _FwaVideoCallViewState extends State<FwaVideoCallView> {
  Map<String, dynamic> trainer = {
    "name": "Sarah Johnson",
    "title": "Certified Personal Trainer",
    "avatar": "https://picsum.photos/150/150?random=60&keyword=trainer",
  };

  Map<String, dynamic> session = {
    "type": "Strength Training Session",
    "duration": "60 minutes",
    "startTime": "2024-03-20 07:00:00",
  };

  bool isMuted = false;
  bool isVideoOn = true;
  bool isCallConnected = true;
  bool isScreenSharing = false;
  String callDuration = "00:15:30";
  
  List<Map<String, dynamic>> chatMessages = [
    {
      "sender": "trainer",
      "message": "Welcome to our training session! Ready to get started?",
      "time": "07:00",
    },
    {
      "sender": "user",
      "message": "Yes, I'm ready! What's the plan for today?",
      "time": "07:01",
    },
    {
      "sender": "trainer",
      "message": "We'll focus on upper body strength today. Let me share the workout plan.",
      "time": "07:02",
    },
  ];

  List<Map<String, dynamic>> workoutPlan = [
    {
      "exercise": "Warm-up",
      "duration": "5 min",
      "description": "Dynamic stretching and light cardio",
      "completed": true,
    },
    {
      "exercise": "Push-ups",
      "sets": 3,
      "reps": "10-12",
      "description": "Focus on proper form",
      "completed": true,
    },
    {
      "exercise": "Dumbbell Rows",
      "sets": 3,
      "reps": "8-10",
      "description": "Using 15kg dumbbells",
      "completed": false,
    },
    {
      "exercise": "Shoulder Press",
      "sets": 3,
      "reps": "10-12",
      "description": "Start with 10kg dumbbells",
      "completed": false,
    },
    {
      "exercise": "Plank Hold",
      "sets": 3,
      "reps": "30-45 sec",
      "description": "Maintain proper alignment",
      "completed": false,
    },
  ];

  String chatMessage = "";
  bool showChat = false;
  bool showWorkoutPlan = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            _buildVideoCall(),
            _buildTopBar(),
            _buildBottomControls(),
            if (showChat) _buildChatPanel(),
            if (showWorkoutPlan) _buildWorkoutPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCall() {
    return Column(
      children: [
        // Trainer's video (main)
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${trainer["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (!isVideoOn)
                  Container(
                    color: Colors.black.withAlpha(150),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            color: Colors.white,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Camera is off",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
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
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isCallConnected ? successColor : dangerColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          callDuration,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${trainer["name"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: spSm),
        // User's video (small)
        Container(
          height: 120,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: Stack(
            children: [
              if (isVideoOn)
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[700],
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              if (!isVideoOn)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.videocam_off,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              Positioned(
                bottom: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: isMuted ? dangerColor : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isMuted ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: spMd,
      right: spMd,
      child: Row(
        children: [
          _buildTopButton(
            icon: showWorkoutPlan ? Icons.fitness_center : Icons.fitness_center,
            isActive: showWorkoutPlan,
            onTap: () {
              setState(() {
                showWorkoutPlan = !showWorkoutPlan;
                if (showWorkoutPlan) showChat = false;
              });
            },
          ),
          SizedBox(width: spSm),
          _buildTopButton(
            icon: Icons.chat,
            isActive: showChat,
            onTap: () {
              setState(() {
                showChat = !showChat;
                if (showChat) showWorkoutPlan = false;
              });
            },
          ),
          SizedBox(width: spSm),
          _buildTopButton(
            icon: Icons.screen_share,
            isActive: isScreenSharing,
            onTap: () {
              setState(() {
                isScreenSharing = !isScreenSharing;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.black.withAlpha(150),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: spMd,
      left: spMd,
      right: spMd,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: isMuted ? Icons.mic_off : Icons.mic,
            isActive: !isMuted,
            onTap: () {
              setState(() {
                isMuted = !isMuted;
              });
            },
          ),
          _buildControlButton(
            icon: isVideoOn ? Icons.videocam : Icons.videocam_off,
            isActive: isVideoOn,
            onTap: () {
              setState(() {
                isVideoOn = !isVideoOn;
              });
            },
          ),
          _buildControlButton(
            icon: Icons.flip_camera_android,
            isActive: true,
            onTap: () {
              // Switch camera
            },
          ),
          _buildControlButton(
            icon: Icons.call_end,
            isActive: false,
            color: dangerColor,
            onTap: () {
              _endCall();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: color ?? (isActive ? Colors.white.withAlpha(50) : Colors.black.withAlpha(150)),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildChatPanel() {
    return Positioned(
      right: 0,
      top: 60,
      bottom: 100,
      width: 300,
      child: Container(
        margin: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowMd],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showChat = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatMessages.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> message = chatMessages[index];
                          bool isTrainer = message["sender"] == "trainer";
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              mainAxisAlignment: isTrainer 
                                  ? MainAxisAlignment.start 
                                  : MainAxisAlignment.end,
                              children: [
                                if (isTrainer) ...[
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage("${trainer["avatar"]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                ],
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: isTrainer 
                                          ? primaryColor.withAlpha(25) 
                                          : primaryColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${message["message"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isTrainer ? primaryColor : Colors.white,
                                      ),
                                    ),
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
                            label: "Type message...",
                            value: chatMessage,
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
                          onPressed: () {
                            _sendMessage();
                          },
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

  Widget _buildWorkoutPanel() {
    return Positioned(
      left: 0,
      top: 60,
      bottom: 100,
      width: 300,
      child: Container(
        margin: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowMd],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusMd),
                  topRight: Radius.circular(radiusMd),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Workout Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showWorkoutPlan = false;
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${session["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Expanded(
                      child: ListView.builder(
                        itemCount: workoutPlan.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> exercise = workoutPlan[index];
                          bool isCompleted = exercise["completed"];
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isCompleted 
                                  ? successColor.withAlpha(25) 
                                  : primaryColor.withAlpha(15),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: isCompleted ? successColor : primaryColor,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                      color: isCompleted ? successColor : primaryColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${exercise["exercise"]}",
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
                                if (exercise["sets"] != null)
                                  Text(
                                    "${exercise["sets"]} sets x ${exercise["reps"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if (exercise["duration"] != null)
                                  Text(
                                    "${exercise["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                if (exercise["description"] != null)
                                  Text(
                                    "${exercise["description"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
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

  void _sendMessage() {
    if (chatMessage.trim().isNotEmpty) {
      setState(() {
        chatMessages.add({
          "sender": "user",
          "message": chatMessage.trim(),
          "time": DateTime.now().toString().substring(11, 16),
        });
        chatMessage = "";
      });
    }
  }

  void _endCall() async {
    bool isConfirmed = await confirm("Are you sure you want to end the call?");
    if (isConfirmed) {
      back();
    }
  }
}
