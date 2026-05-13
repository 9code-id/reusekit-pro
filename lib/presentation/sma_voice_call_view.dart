import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaVoiceCallView extends StatefulWidget {
  const SmaVoiceCallView({super.key});

  @override
  State<SmaVoiceCallView> createState() => _SmaVoiceCallViewState();
}

class _SmaVoiceCallViewState extends State<SmaVoiceCallView> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isCallOnHold = false;
  bool isVideoEnabled = false;
  String callDuration = "00:00";
  String callStatus = "Connecting...";
  int callDurationSeconds = 0;

  final Map<String, dynamic> caller = {
    "name": "Sarah Johnson",
    "phone": "+1 (555) 123-4567",
    "image": "https://picsum.photos/150/150?random=1&keyword=person",
    "status": "Online",
    "relationship": "Friend",
  };

  final List<Map<String, dynamic>> quickActions = [
    {
      "icon": Icons.volume_up,
      "label": "Speaker",
      "action": "speaker",
    },
    {
      "icon": Icons.mic_off,
      "label": "Mute",
      "action": "mute",
    },
    {
      "icon": Icons.videocam,
      "label": "Video",
      "action": "video",
    },
    {
      "icon": Icons.pause,
      "label": "Hold",
      "action": "hold",
    },
    {
      "icon": Icons.dialpad,
      "label": "Keypad",
      "action": "keypad",
    },
    {
      "icon": Icons.person_add,
      "label": "Add Call",
      "action": "add_call",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startCallTimer();
  }

  void _startCallTimer() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        callStatus = "Connected";
        setState(() {});
        _updateCallDuration();
      }
    });
  }

  void _updateCallDuration() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && callStatus == "Connected" && !isCallOnHold) {
        callDurationSeconds++;
        int minutes = callDurationSeconds ~/ 60;
        int seconds = callDurationSeconds % 60;
        callDuration = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        setState(() {});
        _updateCallDuration();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.withAlpha(100),
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Minimize call
                        back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          callStatus,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (callStatus == "Connected")
                          Text(
                            callDuration,
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // More options
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Caller Information
              Column(
                children: [
                  // Caller Avatar
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withAlpha(50),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(100),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage: NetworkImage("${caller["image"]}"),
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Caller Name
                  Text(
                    "${caller["name"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: spXs),

                  // Caller Phone & Status
                  Text(
                    "${caller["phone"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: spXs),

                  // Relationship & Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${caller["relationship"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${caller["status"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  // Call Status Indicators
                  if (isCallOnHold) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: warningColor.withAlpha(100),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.pause,
                            color: warningColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Call on Hold",
                            style: TextStyle(
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (isMuted) ...[
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: dangerColor.withAlpha(100),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mic_off,
                            color: dangerColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Microphone Off",
                            style: TextStyle(
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              Spacer(),

              // Quick Actions Grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: spLg),
                child: ResponsiveGridView(
                  padding: EdgeInsets.all(0),
                  minItemWidth: 100,
                  children: quickActions.map((action) {
                    bool isActive = _getActionState(action["action"]);
                    return GestureDetector(
                      onTap: () => _handleAction(action["action"]),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : Colors.white.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              _getActionIcon(action["action"]),
                              color: isActive
                                  ? Colors.black
                                  : Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${action["label"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: spLg),

              // Main Action Buttons
              Padding(
                padding: EdgeInsets.all(spLg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Add Call Button
                    GestureDetector(
                      onTap: _addCall,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),

                    // End Call Button
                    GestureDetector(
                      onTap: _endCall,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: dangerColor.withAlpha(100),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),

                    // Message Button
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _getActionState(String action) {
    switch (action) {
      case "speaker":
        return isSpeakerOn;
      case "mute":
        return isMuted;
      case "video":
        return isVideoEnabled;
      case "hold":
        return isCallOnHold;
      default:
        return false;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case "speaker":
        return isSpeakerOn ? Icons.volume_up : Icons.volume_off;
      case "mute":
        return isMuted ? Icons.mic_off : Icons.mic;
      case "video":
        return isVideoEnabled ? Icons.videocam : Icons.videocam_off;
      case "hold":
        return isCallOnHold ? Icons.play_arrow : Icons.pause;
      case "keypad":
        return Icons.dialpad;
      case "add_call":
        return Icons.person_add;
      default:
        return Icons.help;
    }
  }

  void _handleAction(String action) {
    switch (action) {
      case "speaker":
        isSpeakerOn = !isSpeakerOn;
        setState(() {});
        ss(isSpeakerOn ? "Speaker enabled" : "Speaker disabled");
        break;
      case "mute":
        isMuted = !isMuted;
        setState(() {});
        ss(isMuted ? "Microphone muted" : "Microphone unmuted");
        break;
      case "video":
        isVideoEnabled = !isVideoEnabled;
        setState(() {});
        ss(isVideoEnabled ? "Video enabled" : "Video disabled");
        break;
      case "hold":
        isCallOnHold = !isCallOnHold;
        setState(() {});
        if (isCallOnHold) {
          callStatus = "On Hold";
        } else {
          callStatus = "Connected";
          _updateCallDuration();
        }
        ss(isCallOnHold ? "Call on hold" : "Call resumed");
        break;
      case "keypad":
        _showKeypad();
        break;
      case "add_call":
        _addCall();
        break;
    }
  }

  void _showKeypad() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(230),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(100),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              
              // Title
              Text(
                "Dial Pad",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: spMd),

              // Keypad Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: ResponsiveGridView(
                    padding: EdgeInsets.all(0),
                    minItemWidth: 80,
                    children: [
                      "1", "2", "3",
                      "4", "5", "6", 
                      "7", "8", "9",
                      "*", "0", "#"
                    ].map((digit) {
                      return GestureDetector(
                        onTap: () {
                          // Handle keypad input
                          ss("Pressed $digit");
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Center(
                            child: Text(
                              digit,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addCall() {
    ss("Adding another call...");
  }

  void _sendMessage() {
    ss("Opening messages...");
  }

  void _endCall() {
    ss("Call ended");
    back();
  }
}
