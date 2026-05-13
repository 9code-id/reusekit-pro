import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaChatTrainerView extends StatefulWidget {
  const FwaChatTrainerView({super.key});

  @override
  State<FwaChatTrainerView> createState() => _FwaChatTrainerViewState();
}

class _FwaChatTrainerViewState extends State<FwaChatTrainerView> {
  String message = "";
  List<String> attachments = [];
  
  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "sender": "trainer",
      "senderName": "Sarah Johnson",
      "message": "Hi! I've reviewed your workout plan for this week. You're making great progress! 💪",
      "timestamp": "10:30 AM",
      "date": "2024-03-15",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 2,
      "sender": "user",
      "senderName": "You",
      "message": "Thank you! I'm feeling much stronger already. Should I increase the weights this week?",
      "timestamp": "10:32 AM", 
      "date": "2024-03-15",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 3,
      "sender": "trainer",
      "senderName": "Sarah Johnson",
      "message": "Absolutely! Let's increase by 10% for upper body exercises. Here's your updated plan:",
      "timestamp": "10:35 AM",
      "date": "2024-03-15",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 4,
      "sender": "trainer", 
      "senderName": "Sarah Johnson",
      "message": "",
      "timestamp": "10:36 AM",
      "date": "2024-03-15",
      "type": "workout_plan",
      "isRead": true,
      "workoutPlan": {
        "title": "Week 3 - Strength Focus",
        "exercises": [
          {"name": "Bench Press", "sets": 3, "reps": "8-10", "weight": "55kg"},
          {"name": "Squats", "sets": 4, "reps": "10-12", "weight": "60kg"},
          {"name": "Deadlifts", "sets": 3, "reps": "6-8", "weight": "70kg"},
        ]
      }
    },
    {
      "id": 5,
      "sender": "user",
      "senderName": "You", 
      "message": "Perfect! I'll follow this plan. Quick question about my form on deadlifts...",
      "timestamp": "10:40 AM",
      "date": "2024-03-15", 
      "type": "text",
      "isRead": true,
    },
    {
      "id": 6,
      "sender": "user",
      "senderName": "You",
      "message": "",
      "timestamp": "10:41 AM",
      "date": "2024-03-15",
      "type": "video",
      "isRead": true,
      "videoUrl": "https://picsum.photos/200/150?random=20&keyword=fitness",
      "duration": "0:45"
    },
    {
      "id": 7,
      "sender": "trainer",
      "senderName": "Sarah Johnson",
      "message": "Great form! Just focus on keeping your chest up a bit more. I'll send you a tutorial video.",
      "timestamp": "10:45 AM",
      "date": "2024-03-15",
      "type": "text", 
      "isRead": true,
    },
    {
      "id": 8,
      "sender": "trainer",
      "senderName": "Sarah Johnson",
      "message": "",
      "timestamp": "10:46 AM", 
      "date": "2024-03-15",
      "type": "exercise_demo",
      "isRead": true,
      "exercise": {
        "name": "Proper Deadlift Form",
        "thumbnail": "https://picsum.photos/200/150?random=21&keyword=deadlift",
        "duration": "3:20",
        "tips": ["Keep chest up", "Neutral spine", "Drive through heels"]
      }
    },
    {
      "id": 9,
      "sender": "user", 
      "senderName": "You",
      "message": "Thanks! That's exactly what I needed. See you for our session tomorrow!",
      "timestamp": "10:50 AM",
      "date": "2024-03-15",
      "type": "text",
      "isRead": true,
    },
    {
      "id": 10,
      "sender": "trainer",
      "senderName": "Sarah Johnson",
      "message": "Looking forward to it! We'll focus on perfecting your deadlift technique. 🎯",
      "timestamp": "10:52 AM",
      "date": "2024-03-15", 
      "type": "text",
      "isRead": false,
    },
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Thanks!", "emoji": "👍"},
    {"text": "Got it", "emoji": "✅"}, 
    {"text": "Question", "emoji": "❓"},
    {"text": "Great idea", "emoji": "💡"},
    {"text": "See you soon", "emoji": "👋"},
  ];

  Map<String, dynamic> trainerInfo = {
    "name": "Sarah Johnson",
    "specialization": "Strength & Conditioning",
    "avatar": "https://picsum.photos/60/60?random=10&keyword=trainer",
    "isOnline": true,
    "lastSeen": "Active now",
    "responseTime": "Usually replies within 1 hour"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("${trainerInfo["avatar"]}"),
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
                    "${trainerInfo["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: trainerInfo["isOnline"] ? successColor : disabledColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${trainerInfo["lastSeen"]}",
                        style: TextStyle(
                          fontSize: 12,
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
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              // navigateTo('video_call')
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // navigateTo('voice_call')
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showChatOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Response Time Info
          if (trainerInfo["responseTime"] != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
              color: infoColor.withAlpha(20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: infoColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${trainerInfo["responseTime"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

          // Messages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isTrainer = message["sender"] == "trainer";
                final messageType = message["type"] as String;

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    mainAxisAlignment: isTrainer ? MainAxisAlignment.start : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isTrainer) ...[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusLg),
                            image: DecorationImage(
                              image: NetworkImage("${trainerInfo["avatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                      ],
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isTrainer ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: [
                            _buildMessageBubble(message, isTrainer, messageType),
                            SizedBox(height: spXs),
                            Text(
                              "${message["timestamp"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isTrainer) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // Quick Replies
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quickReplies.length,
              itemBuilder: (context, index) {
                final reply = quickReplies[index];
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _sendQuickReply(reply["text"]);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${reply["emoji"]}",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${reply["text"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Attachments Preview
                if (attachments.isNotEmpty) ...[
                  Container(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: attachments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.only(right: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(attachments[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      attachments.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
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
                  SizedBox(height: spSm),
                ],
                
                // Input Row
                Row(
                  children: [
                    // Attachment Button
                    GestureDetector(
                      onTap: () {
                        _showAttachmentOptions();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    // Text Input
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QTextField(
                          label: "",
                          value: message,
                          hint: "Type a message...",
                          onChanged: (value) {
                            message = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    // Send Button
                    GestureDetector(
                      onTap: message.isNotEmpty || attachments.isNotEmpty ? () {
                        _sendMessage();
                      } : null,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: message.isNotEmpty || attachments.isNotEmpty ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.send,
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
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isTrainer, String messageType) {
    switch (messageType) {
      case "workout_plan":
        return _buildWorkoutPlanBubble(message, isTrainer);
      case "video":
        return _buildVideoBubble(message, isTrainer);
      case "exercise_demo":
        return _buildExerciseDemoBubble(message, isTrainer);
      default:
        return _buildTextBubble(message, isTrainer);
    }
  }

  Widget _buildTextBubble(Map<String, dynamic> message, bool isTrainer) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spSm),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        color: isTrainer ? Colors.grey[100] : primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusSm),
          topRight: Radius.circular(radiusSm),
          bottomLeft: Radius.circular(isTrainer ? radiusXs : radiusSm),
          bottomRight: Radius.circular(isTrainer ? radiusSm : radiusXs),
        ),
      ),
      child: Text(
        "${message["message"]}",
        style: TextStyle(
          fontSize: 14,
          color: isTrainer ? primaryColor : Colors.white,
        ),
      ),
    );
  }

  Widget _buildWorkoutPlanBubble(Map<String, dynamic> message, bool isTrainer) {
    final workoutPlan = message["workoutPlan"] as Map<String, dynamic>;
    final exercises = workoutPlan["exercises"] as List;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isTrainer ? Colors.grey[50] : primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "${workoutPlan["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ...exercises.map((exercise) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${exercise["name"]}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "${exercise["sets"]}x${exercise["reps"]} • ${exercise["weight"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Full Plan",
              size: bs.sm,
              onPressed: () {
                // navigateTo('workout_plan_detail')
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoBubble(Map<String, dynamic> message, bool isTrainer) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusSm),
        image: DecorationImage(
          image: NetworkImage("${message["videoUrl"]}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              color: Colors.black.withAlpha(100),
            ),
          ),
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: primaryColor,
                size: 30,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(150),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "${message["duration"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDemoBubble(Map<String, dynamic> message, bool isTrainer) {
    final exercise = message["exercise"] as Map<String, dynamic>;
    final tips = exercise["tips"] as List;

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: isTrainer ? Colors.grey[50] : primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusSm),
                topRight: Radius.circular(radiusSm),
              ),
              image: DecorationImage(
                image: NetworkImage("${exercise["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusSm),
                      topRight: Radius.circular(radiusSm),
                    ),
                    color: Colors.black.withAlpha(100),
                  ),
                ),
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${exercise["duration"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${exercise["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Key Tips:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                ...tips.map((tip) {
                  return Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 12),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "$tip",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (message.isNotEmpty || attachments.isNotEmpty) {
      // Add message to list
      setState(() {
        message = "";
        attachments.clear();
      });
      ss("Message sent");
    }
  }

  void _sendQuickReply(String replyText) {
    // Send quick reply
    ss("Quick reply sent: $replyText");
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Share Content",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 100,
              children: [
                _buildAttachmentOption(Icons.photo_camera, "Camera", () {
                  Navigator.pop(context);
                  _selectFromCamera();
                }),
                _buildAttachmentOption(Icons.photo_library, "Gallery", () {
                  Navigator.pop(context);
                  _selectFromGallery();
                }),
                _buildAttachmentOption(Icons.videocam, "Video", () {
                  Navigator.pop(context);
                  _recordVideo();
                }),
                _buildAttachmentOption(Icons.fitness_center, "Workout", () {
                  Navigator.pop(context);
                  _shareWorkout();
                }),
                _buildAttachmentOption(Icons.restaurant, "Meal Plan", () {
                  Navigator.pop(context);
                  _shareMealPlan();
                }),
                _buildAttachmentOption(Icons.insert_chart, "Progress", () {
                  Navigator.pop(context);
                  _shareProgress();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryColor, size: 32),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Chat Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...[
              {"icon": Icons.person, "title": "View Profile", "action": () {}},
              {"icon": Icons.schedule, "title": "Book Session", "action": () {}},
              {"icon": Icons.star, "title": "Rate Trainer", "action": () {}},
              {"icon": Icons.notifications_off, "title": "Mute Notifications", "action": () {}},
              {"icon": Icons.report, "title": "Report Issue", "action": () {}},
            ].map((option) {
              return ListTile(
                leading: Icon(option["icon"] as IconData, color: primaryColor),
                title: Text(
                  "${option["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  (option["action"] as VoidCallback)();
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _selectFromCamera() {
    // Simulate camera selection
    ss("Camera selected");
  }

  void _selectFromGallery() {
    // Simulate gallery selection
    ss("Gallery selected");
  }

  void _recordVideo() {
    // Simulate video recording
    ss("Video recording started");
  }

  void _shareWorkout() {
    // Share workout plan
    ss("Workout plan shared");
  }

  void _shareMealPlan() {
    // Share meal plan
    ss("Meal plan shared");
  }

  void _shareProgress() {
    // Share progress data
    ss("Progress data shared");
  }
}
