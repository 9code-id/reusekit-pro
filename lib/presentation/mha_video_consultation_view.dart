import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaVideoConsultationView extends StatefulWidget {
  const MhaVideoConsultationView({super.key});

  @override
  State<MhaVideoConsultationView> createState() => _MhaVideoConsultationViewState();
}

class _MhaVideoConsultationViewState extends State<MhaVideoConsultationView> {
  bool isVideoEnabled = true;
  bool isAudioEnabled = true;
  bool isMicMuted = false;
  bool isCameraOff = false;
  bool isCallConnected = false;
  bool isWaitingForDoctor = true;
  String consultationStatus = "Connecting...";
  String currentTime = "00:00";
  
  Map<String, dynamic> doctorInfo = {
    "name": "Dr. Sarah Johnson",
    "specialty": "General Medicine",
    "image": "https://picsum.photos/120/120?random=1&keyword=doctor",
    "experience": "8 years",
    "rating": 4.8,
    "isOnline": true
  };

  List<String> messages = [
    "Doctor will join shortly",
    "Please ensure good lighting",
    "Check your internet connection"
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Share Screen",
      "icon": Icons.screen_share,
      "enabled": true
    },
    {
      "title": "Add Notes",
      "icon": Icons.note_add,
      "enabled": true
    },
    {
      "title": "Take Photo",
      "icon": Icons.camera_alt,
      "enabled": true
    },
    {
      "title": "Upload File",
      "icon": Icons.upload_file,
      "enabled": true
    }
  ];

  @override
  void initState() {
    super.initState();
    _simulateConnection();
  }

  void _simulateConnection() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        isCallConnected = true;
        isWaitingForDoctor = false;
        consultationStatus = "Connected";
        setState(() {});
        _startTimer();
      }
    });
  }

  void _startTimer() {
    // Simulate timer for demonstration
    int seconds = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        seconds++;
        int minutes = seconds ~/ 60;
        int remainingSeconds = seconds % 60;
        currentTime = "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Main video area
            Container(
              width: double.infinity,
              height: double.infinity,
              child: isCallConnected 
                ? _buildVideoCallInterface()
                : _buildWaitingInterface(),
            ),
            
            // Top controls
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withAlpha(180), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
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
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            consultationStatus,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isCallConnected) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          currentTime,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withAlpha(180)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: isCallConnected 
                  ? _buildCallControls()
                  : _buildWaitingControls(),
              ),
            ),

            // Patient video (small window)
            if (isCallConnected)
              Positioned(
                top: 100,
                right: spMd,
                child: Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: Colors.white.withAlpha(100), width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Stack(
                      children: [
                        if (!isCameraOff)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(200)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black,
                            child: Center(
                              child: Icon(
                                Icons.videocam_off,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isMicMuted ? dangerColor : successColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isMicMuted ? Icons.mic_off : Icons.mic,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCallInterface() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Doctor's video area
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              image: DecorationImage(
                image: NetworkImage("${doctorInfo["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "${doctorInfo["name"]}",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "${doctorInfo["specialty"]}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingInterface() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 3,
          ),
          SizedBox(height: spLg),
          Text(
            "Waiting for Doctor",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Dr. ${doctorInfo["name"]} will join shortly",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(200),
            ),
          ),
          SizedBox(height: spLg),
          
          // Preparation tips
          Container(
            margin: EdgeInsets.symmetric(horizontal: spLg),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Text(
                  "Preparation Tips",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                ...messages.map((tip) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: successColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(200),
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

  Widget _buildCallControls() {
    return Column(
      children: [
        // Quick actions
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: quickActions.map((action) {
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: action["enabled"] ? () {
                    // Handle quick action
                  } : null,
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: Colors.white.withAlpha(100),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          action["icon"],
                          size: 20,
                          color: action["enabled"] ? Colors.white : disabledColor,
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "${action["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: action["enabled"] ? Colors.white : disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Main controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Mute/Unmute
            GestureDetector(
              onTap: () {
                isMicMuted = !isMicMuted;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isMicMuted ? dangerColor : Colors.black.withAlpha(150),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(100), width: 2),
                ),
                child: Icon(
                  isMicMuted ? Icons.mic_off : Icons.mic,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            
            // End call
            GestureDetector(
              onTap: () {
                back();
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(100), width: 2),
                ),
                child: Icon(
                  Icons.call_end,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
            
            // Camera on/off
            GestureDetector(
              onTap: () {
                isCameraOff = !isCameraOff;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCameraOff ? dangerColor : Colors.black.withAlpha(150),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(100), width: 2),
                ),
                child: Icon(
                  isCameraOff ? Icons.videocam_off : Icons.videocam,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaitingControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Mute/Unmute
        GestureDetector(
          onTap: () {
            isMicMuted = !isMicMuted;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isMicMuted ? dangerColor : Colors.black.withAlpha(150),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withAlpha(100), width: 2),
            ),
            child: Icon(
              isMicMuted ? Icons.mic_off : Icons.mic,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        
        // Cancel
        GestureDetector(
          onTap: () {
            back();
          },
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withAlpha(100), width: 2),
            ),
            child: Icon(
              Icons.call_end,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
        
        // Camera on/off
        GestureDetector(
          onTap: () {
            isCameraOff = !isCameraOff;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isCameraOff ? dangerColor : Colors.black.withAlpha(150),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withAlpha(100), width: 2),
            ),
            child: Icon(
              isCameraOff ? Icons.videocam_off : Icons.videocam,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
