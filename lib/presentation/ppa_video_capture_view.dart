import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaVideoCaptureView extends StatefulWidget {
  const PpaVideoCaptureView({super.key});

  @override
  State<PpaVideoCaptureView> createState() => _PpaVideoCaptureViewState();
}

class _PpaVideoCaptureViewState extends State<PpaVideoCaptureView> {
  bool isRecording = false;
  bool isPaused = false;
  int recordingDuration = 0;
  String selectedQuality = "1080p";
  String selectedFrameRate = "30fps";
  bool isFlashOn = false;
  bool isMuted = false;
  double zoomLevel = 1.0;

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "4K", "value": "4k", "description": "3840×2160"},
    {"label": "1080p", "value": "1080p", "description": "1920×1080"},
    {"label": "720p", "value": "720p", "description": "1280×720"},
    {"label": "480p", "value": "480p", "description": "854×480"},
  ];

  List<Map<String, dynamic>> frameRateOptions = [
    {"label": "24fps", "value": "24fps", "description": "Cinematic"},
    {"label": "30fps", "value": "30fps", "description": "Standard"},
    {"label": "60fps", "value": "60fps", "description": "Smooth"},
    {"label": "120fps", "value": "120fps", "description": "Slow-mo"},
  ];

  void startRecording() async {
    isRecording = true;
    isPaused = false;
    recordingDuration = 0;
    setState(() {});

    ss("Recording started");
  }

  void stopRecording() {
    isRecording = false;
    isPaused = false;
    recordingDuration = 0;
    setState(() {});

    ss("Recording stopped and saved");
    //navigateTo('PpaVideoEditView')
  }

  void pauseRecording() {
    isPaused = true;
    setState(() {});
    ss("Recording paused");
  }

  void resumeRecording() {
    isPaused = false;
    setState(() {});
    ss("Recording resumed");
  }

  void toggleFlash() {
    isFlashOn = !isFlashOn;
    setState(() {});
  }

  void toggleMute() {
    isMuted = !isMuted;
    setState(() {});
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  // Video preview
                  Positioned.fill(
                    child: Image.network(
                      "https://picsum.photos/400/800?random=1&keyword=video-capture",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Recording Overlay
                  if (isRecording)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: dangerColor,
                            width: 4,
                          ),
                        ),
                      ),
                    ),

                  // Recording Indicator
                  if (isRecording)
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "REC ${formatDuration(recordingDuration)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Paused Indicator
                  if (isPaused)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withAlpha(150),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(spLg),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.pause,
                                  size: 48,
                                  color: primaryColor,
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "Recording Paused",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  formatDuration(recordingDuration),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Top Controls
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(200),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Back Button
                    GestureDetector(
                      onTap: () {
                        if (isRecording) {
                          stopRecording();
                        }
                        back();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isRecording ? Icons.stop : Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Video Mode Info
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.videocam,
                            color: dangerColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Video • $selectedQuality • $selectedFrameRate",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // Flash Toggle
                    GestureDetector(
                      onTap: toggleFlash,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isFlashOn ? warningColor : Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Mute Toggle
                    GestureDetector(
                      onTap: toggleMute,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isMuted ? dangerColor : Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isMuted ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: spSm),

                    // Settings
                    GestureDetector(
                      onTap: isRecording ? null : () => _showSettingsBottomSheet(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.settings,
                          color: isRecording ? disabledColor : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Zoom Controls
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                child: Column(
                  children: [
                    // Zoom In
                    GestureDetector(
                      onTap: () {
                        if (zoomLevel < 10) {
                          zoomLevel += 0.5;
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Zoom Level
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${zoomLevel.toStringAsFixed(1)}x",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: spSm),

                    // Zoom Out
                    GestureDetector(
                      onTap: () {
                        if (zoomLevel > 0.5) {
                          zoomLevel -= 0.5;
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.remove,
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha(200),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Recording Duration (when recording)
                    if (isRecording && !isPaused)
                      Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          formatDuration(recordingDuration),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // Main Controls
                    Row(
                      children: [
                        // Gallery Button
                        GestureDetector(
                          onTap: isRecording ? null : () {
                            //navigateTo('PpaGalleryView')
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isRecording ? disabledColor : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "https://picsum.photos/100/100?random=5&keyword=thumbnail",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                color: isRecording ? Colors.grey : null,
                                colorBlendMode: isRecording ? BlendMode.saturation : null,
                              ),
                            ),
                          ),
                        ),

                        Spacer(),

                        // Recording Controls
                        if (!isRecording) ...[
                          // Start Recording Button
                          GestureDetector(
                            onTap: startRecording,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: dangerColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                              ),
                              child: Icon(
                                Icons.fiber_manual_record,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ] else ...[
                          // Recording Control Buttons
                          Row(
                            children: [
                              // Pause/Resume Button
                              GestureDetector(
                                onTap: isPaused ? resumeRecording : pauseRecording,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    isPaused ? Icons.play_arrow : Icons.pause,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),

                              SizedBox(width: spMd),

                              // Stop Recording Button
                              GestureDetector(
                                onTap: stopRecording,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 4),
                                  ),
                                  child: Icon(
                                    Icons.stop,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        Spacer(),

                        // Switch Camera
                        GestureDetector(
                          onTap: isRecording ? null : () {
                            ss("Camera switched");
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isRecording ? Colors.grey : Colors.black.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
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

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withAlpha(230),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    "Video Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Quality Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video Quality",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      children: qualityOptions.map((option) {
                        final isSelected = selectedQuality == option["value"];
                        return GestureDetector(
                          onTap: () {
                            selectedQuality = option["value"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${option["label"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${option["description"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Frame Rate Selection
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Frame Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Wrap(
                      spacing: spSm,
                      children: frameRateOptions.map((option) {
                        final isSelected = selectedFrameRate == option["value"];
                        return GestureDetector(
                          onTap: () {
                            selectedFrameRate = option["value"];
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${option["label"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${option["description"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
