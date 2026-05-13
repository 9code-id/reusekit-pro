import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaChatConsultationView extends StatefulWidget {
  const MhaChatConsultationView({super.key});

  @override
  State<MhaChatConsultationView> createState() => _MhaChatConsultationViewState();
}

class _MhaChatConsultationViewState extends State<MhaChatConsultationView> {
  String messageText = "";
  List<String> attachments = [];
  
  Map<String, dynamic> doctorInfo = {
    "name": "Dr. Sarah Johnson",
    "specialty": "General Medicine",
    "image": "https://picsum.photos/120/120?random=1&keyword=doctor",
    "isOnline": true,
    "lastSeen": "Active now"
  };

  List<Map<String, dynamic>> messages = [
    {
      "id": 1,
      "sender": "doctor",
      "message": "Hello! I'm Dr. Sarah Johnson. How can I help you today?",
      "timestamp": "10:30 AM",
      "type": "text",
      "status": "sent"
    },
    {
      "id": 2,
      "sender": "patient",
      "message": "Hi Doctor, I've been experiencing headaches for the past few days.",
      "timestamp": "10:32 AM",
      "type": "text",
      "status": "delivered"
    },
    {
      "id": 3,
      "sender": "doctor",
      "message": "I understand your concern. Can you describe the type of headache? Is it throbbing, sharp, or dull?",
      "timestamp": "10:33 AM",
      "type": "text",
      "status": "sent"
    },
    {
      "id": 4,
      "sender": "patient",
      "message": "It's mostly a dull ache, especially in the morning when I wake up.",
      "timestamp": "10:35 AM",
      "type": "text",
      "status": "delivered"
    },
    {
      "id": 5,
      "sender": "doctor",
      "message": "Thank you for the details. Have you been under any stress lately or changed your sleep schedule?",
      "timestamp": "10:37 AM",
      "type": "text",
      "status": "sent"
    },
    {
      "id": 6,
      "sender": "patient",
      "message": "Yes, I've been working late hours recently and not getting enough sleep.",
      "timestamp": "10:39 AM",
      "type": "text",
      "status": "delivered"
    },
    {
      "id": 7,
      "sender": "doctor",
      "message": "That could be contributing to your headaches. Let me send you some recommendations.",
      "timestamp": "10:40 AM",
      "type": "text",
      "status": "sent"
    }
  ];

  List<Map<String, dynamic>> quickReplies = [
    {"text": "Yes, that helps", "icon": Icons.check},
    {"text": "I need more information", "icon": Icons.help},
    {"text": "I don't understand", "icon": Icons.question_mark},
    {"text": "Thank you", "icon": Icons.favorite},
  ];

  List<Map<String, dynamic>> consultationTools = [
    {
      "title": "Symptom Checker",
      "icon": Icons.health_and_safety,
      "description": "Use AI to analyze symptoms"
    },
    {
      "title": "Upload Photo",
      "icon": Icons.camera_alt,
      "description": "Share medical images"
    },
    {
      "title": "Medical History",
      "icon": Icons.history,
      "description": "Share your health records"
    },
    {
      "title": "Prescription Request",
      "icon": Icons.description,
      "description": "Request digital prescription"
    }
  ];

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
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("${doctorInfo["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: doctorInfo["isOnline"] 
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: successColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  )
                : null,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${doctorInfo["name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${doctorInfo["lastSeen"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
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
              // Switch to video call
            },
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              // Switch to voice call
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
          // Messages list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spSm),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isDoctor = message["sender"] == "doctor";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    mainAxisAlignment: isDoctor 
                      ? MainAxisAlignment.start 
                      : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDoctor) ...[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${doctorInfo["image"]}"),
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
                            color: isDoctor 
                              ? Colors.grey[100] 
                              : primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                              bottomLeft: isDoctor 
                                ? Radius.circular(radiusXs)
                                : Radius.circular(radiusMd),
                              bottomRight: isDoctor 
                                ? Radius.circular(radiusMd)
                                : Radius.circular(radiusXs),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${message["message"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDoctor ? Colors.black : Colors.white,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${message["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isDoctor 
                                        ? disabledBoldColor 
                                        : Colors.white.withAlpha(180),
                                    ),
                                  ),
                                  if (!isDoctor) ...[
                                    SizedBox(width: spXs),
                                    Icon(
                                      message["status"] == "sent" 
                                        ? Icons.done
                                        : message["status"] == "delivered"
                                          ? Icons.done_all
                                          : Icons.schedule,
                                      size: 12,
                                      color: Colors.white.withAlpha(180),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isDoctor) ...[
                        SizedBox(width: spSm),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 20,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          // Quick replies
          if (quickReplies.isNotEmpty)
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: spSm),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: quickReplies.length,
                itemBuilder: (context, index) {
                  final reply = quickReplies[index];
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        _sendQuickReply("${reply["text"]}");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor.withAlpha(100)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              reply["icon"],
                              size: 16,
                              color: primaryColor,
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

          // Consultation tools
          Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: consultationTools.length,
              itemBuilder: (context, index) {
                final tool = consultationTools[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      _useConsultationTool(tool);
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            tool["icon"],
                            size: 24,
                            color: primaryColor,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${tool["title"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Message input
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showAttachmentOptions();
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QChatField(
                    label: "Type your message...",
                    value: messageText,
                    attachments: attachments,
                    showAttachmentButton: false,
                    showEmojiButton: true,
                    showVoiceButton: true,
                    onChanged: (value) {
                      messageText = value;
                      setState(() {});
                    },
                    onSend: () {
                      if (messageText.isNotEmpty || attachments.isNotEmpty) {
                        _sendMessage();
                      }
                    },
                    onAttachmentsChanged: (value) {
                      attachments = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (messageText.trim().isEmpty && attachments.isEmpty) return;

    Map<String, dynamic> newMessage = {
      "id": messages.length + 1,
      "sender": "patient",
      "message": messageText.trim(),
      "timestamp": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
      "type": "text",
      "status": "sending"
    };

    messages.add(newMessage);
    messageText = "";
    attachments = [];
    setState(() {});

    // Simulate message delivery
    Future.delayed(Duration(seconds: 1), () {
      messages.last["status"] = "delivered";
      setState(() {});
    });

    // Simulate doctor response
    Future.delayed(Duration(seconds: 3), () {
      _simulateDoctorResponse();
    });
  }

  void _sendQuickReply(String reply) {
    messageText = reply;
    _sendMessage();
  }

  void _simulateDoctorResponse() {
    List<String> responses = [
      "Thank you for sharing that information.",
      "I understand your concern. Let me provide some guidance.",
      "That's helpful to know. Based on what you've told me...",
      "I'd like to recommend the following steps...",
    ];

    Map<String, dynamic> doctorResponse = {
      "id": messages.length + 1,
      "sender": "doctor",
      "message": responses[messages.length % responses.length],
      "timestamp": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
      "type": "text",
      "status": "sent"
    };

    messages.add(doctorResponse);
    setState(() {});
  }

  void _useConsultationTool(Map<String, dynamic> tool) {
    switch (tool["title"]) {
      case "Symptom Checker":
        // Navigate to symptom checker
        break;
      case "Upload Photo":
        _showAttachmentOptions();
        break;
      case "Medical History":
        // Navigate to medical history
        break;
      case "Prescription Request":
        // Navigate to prescription request
        break;
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Attach File",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAttachmentOption("Camera", Icons.camera_alt),
                  _buildAttachmentOption("Gallery", Icons.photo_library),
                  _buildAttachmentOption("Document", Icons.description),
                  _buildAttachmentOption("Voice", Icons.mic),
                ],
              ),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        back();
        // Handle attachment type
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.info, color: primaryColor),
                title: Text("Doctor Info"),
                onTap: () {
                  back();
                  // Show doctor details
                },
              ),
              ListTile(
                leading: Icon(Icons.history, color: primaryColor),
                title: Text("Chat History"),
                onTap: () {
                  back();
                  // Show chat history
                },
              ),
              ListTile(
                leading: Icon(Icons.report, color: dangerColor),
                title: Text("Report Issue"),
                onTap: () {
                  back();
                  // Report issue
                },
              ),
              ListTile(
                leading: Icon(Icons.block, color: dangerColor),
                title: Text("End Consultation"),
                onTap: () {
                  back();
                  // End consultation
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
