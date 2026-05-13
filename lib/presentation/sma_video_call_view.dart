import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaVideoCallView extends StatefulWidget {
  const SmaVideoCallView({super.key});

  @override
  State<SmaVideoCallView> createState() => _SmaVideoCallViewState();
}

class _SmaVideoCallViewState extends State<SmaVideoCallView> {
  bool isMuted = false;
  bool isCameraOff = false;
  bool isSpeakerOn = true;
  bool isCallConnected = true;
  String callDuration = "00:42";
  bool showControls = true;

  // Sample call data
  Map<String, dynamic> callInfo = {
    "isGroup": false,
    "contact": {
      "id": "1",
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/120/120?random=30&keyword=woman",
      "isOnline": true,
    },
    "groupInfo": {
      "name": "Weekend Warriors",
      "memberCount": 4,
      "activeMembers": [
        {
          "id": "1",
          "name": "Sarah Johnson",
          "avatar": "https://picsum.photos/80/80?random=31&keyword=woman",
          "isMuted": false,
          "isCameraOff": false,
        },
        {
          "id": "2", 
          "name": "Mike Chen",
          "avatar": "https://picsum.photos/80/80?random=32&keyword=man",
          "isMuted": true,
          "isCameraOff": false,
        },
        {
          "id": "3",
          "name": "Emma Wilson",
          "avatar": "https://picsum.photos/80/80?random=33&keyword=person",
          "isMuted": false,
          "isCameraOff": true,
        },
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _startCallTimer();
    _hideControlsAfterDelay();
  }

  void _startCallTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && isCallConnected) {
        final parts = callDuration.split(":");
        final minutes = int.parse(parts[0]);
        final seconds = int.parse(parts[1]);
        
        final totalSeconds = minutes * 60 + seconds + 1;
        final newMinutes = totalSeconds ~/ 60;
        final newSeconds = totalSeconds % 60;
        
        callDuration = "${newMinutes.toString().padLeft(2, '0')}:${newSeconds.toString().padLeft(2, '0')}";
        setState(() {});
        _startCallTimer();
      }
    });
  }

  void _hideControlsAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        showControls = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          showControls = !showControls;
          setState(() {});
          if (showControls) {
            _hideControlsAfterDelay();
          }
        },
        child: Stack(
          children: [
            // Main Video Feed
            Container(
              width: double.infinity,
              height: double.infinity,
              child: (callInfo["isGroup"] as bool) 
                ? _buildGroupVideoView()
                : _buildOneOnOneVideoView(),
            ),
            
            // Self Video (Picture in Picture)
            if (!isCameraOff)
              Positioned(
                top: 60,
                right: 20,
                child: Container(
                  width: 120,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [shadowMd],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/120/160?random=50&keyword=selfie"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(100),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "You",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            
            // Top Controls
            if (showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + spSm,
                    left: spMd,
                    right: spMd,
                    bottom: spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(150),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      
                      Spacer(),
                      
                      Column(
                        children: [
                          Text(
                            (callInfo["isGroup"] as bool) 
                              ? "${callInfo["groupInfo"]["name"]}"
                              : "${callInfo["contact"]["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            callDuration,
                            style: TextStyle(
                              color: Colors.white.withAlpha(180),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      
                      Spacer(),
                      
                      GestureDetector(
                        onTap: () {
                          _switchCamera();
                        },
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Bottom Controls
            if (showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: spMd,
                    left: spMd,
                    right: spMd,
                    bottom: MediaQuery.of(context).padding.bottom + spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withAlpha(150),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute Toggle
                      GestureDetector(
                        onTap: () {
                          isMuted = !isMuted;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isMuted ? dangerColor : Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            isMuted ? Icons.mic_off : Icons.mic,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      
                      // Camera Toggle
                      GestureDetector(
                        onTap: () {
                          isCameraOff = !isCameraOff;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isCameraOff ? dangerColor : Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            isCameraOff ? Icons.videocam_off : Icons.videocam,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      
                      // Speaker Toggle
                      GestureDetector(
                        onTap: () {
                          isSpeakerOn = !isSpeakerOn;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: isSpeakerOn ? primaryColor : Colors.black.withAlpha(100),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      
                      // End Call
                      GestureDetector(
                        onTap: () {
                          _endCall();
                        },
                        child: Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: dangerColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withAlpha(50),
                              width: 1,
                            ),
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
                ),
              ),
            
            // Connection Status
            if (!isCallConnected)
              Positioned(
                top: MediaQuery.of(context).padding.top + 80,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wifi_off,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Connection unstable",
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
          ],
        ),
      ),
    );
  }

  Widget _buildOneOnOneVideoView() {
    final contact = callInfo["contact"];
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("${contact["avatar"]}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(50),
              Colors.transparent,
              Colors.black.withAlpha(100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupVideoView() {
    final activeMembers = callInfo["groupInfo"]["activeMembers"] as List;
    
    return GridView.builder(
      padding: EdgeInsets.all(spSm),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: activeMembers.length <= 2 ? 1 : 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: spSm,
        mainAxisSpacing: spSm,
      ),
      itemCount: activeMembers.length,
      itemBuilder: (context, index) {
        final member = activeMembers[index];
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: Colors.white.withAlpha(50)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Stack(
              children: [
                // Video Feed
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: member["isCameraOff"] 
                      ? null
                      : DecorationImage(
                          image: NetworkImage("${member["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                    color: member["isCameraOff"] ? Colors.grey[800] : null,
                  ),
                  child: member["isCameraOff"]
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage("${member["avatar"]}"),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
                ),
                
                // Member Info
                Positioned(
                  bottom: spXs,
                  left: spXs,
                  right: spXs,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${member["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (member["isMuted"] as bool)
                          Icon(
                            Icons.mic_off,
                            color: dangerColor,
                            size: 12,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _switchCamera() {
    // Camera switch logic would go here
    si("Camera switched");
  }

  void _endCall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("End Call"),
        content: Text("Are you sure you want to end this call?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              back();
            },
            child: Text(
              "End Call",
              style: TextStyle(color: dangerColor),
            ),
          ),
        ],
      ),
    );
  }
}
