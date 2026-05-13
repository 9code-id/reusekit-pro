import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCamera6View extends StatefulWidget {
  @override
  State<GrlCamera6View> createState() => _GrlCamera6ViewState();
}

class _GrlCamera6ViewState extends State<GrlCamera6View> {
  bool isRecording = false;
  int recordingDuration = 0;
  String quality = "4K";
  String frameRate = "60fps";
  bool stabilization = true;
  bool audioEnabled = true;
  double audioLevel = 0.7;

  List<Map<String, dynamic>> qualityOptions = [
    {"name": "720p", "selected": false},
    {"name": "1080p", "selected": false},
    {"name": "4K", "selected": true},
    {"name": "8K", "selected": false},
  ];

  List<Map<String, dynamic>> frameRateOptions = [
    {"name": "24fps", "selected": false},
    {"name": "30fps", "selected": false},
    {"name": "60fps", "selected": true},
    {"name": "120fps", "selected": false},
  ];

  List<Map<String, dynamic>> recentVideos = [
    {
      "thumbnail": "https://picsum.photos/200/150?random=1&keyword=video",
      "duration": "2:30",
      "size": "45 MB",
    },
    {
      "thumbnail": "https://picsum.photos/200/150?random=2&keyword=video",
      "duration": "1:15",
      "size": "28 MB",
    },
    {
      "thumbnail": "https://picsum.photos/200/150?random=3&keyword=video",
      "duration": "5:42",
      "size": "156 MB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildVideoPreview(),
          ),
          _buildVideoSettings(),
          _buildRecordingControls(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + spSm,
        left: spMd,
        right: spMd,
        bottom: spSm,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            Spacer(),
            if (isRecording) ...[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
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
                      _formatDuration(recordingDuration),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
            ],
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spSm,
                vertical: spXs,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "$quality $frameRate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPreview() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusLg),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                "https://picsum.photos/400/600?random=6&keyword=video",
                fit: BoxFit.cover,
              ),
            ),
            _buildVideoOverlays(),
            _buildAudioMeter(),
            _buildStabilizationIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoOverlays() {
    return Positioned(
      top: spMd,
      left: spMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (stabilization)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spXs,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.vibration,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "OIS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "16:9",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioMeter() {
    return Positioned(
      right: spMd,
      top: spMd,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              audioEnabled = !audioEnabled;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: audioEnabled 
                    ? Colors.green.withAlpha(128)
                    : Colors.red.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                audioEnabled ? Icons.mic : Icons.mic_off,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          if (audioEnabled) ...[
            SizedBox(height: spXs),
            Container(
              width: 24,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: List.generate(8, (index) {
                  final isActive = index < (audioLevel * 8);
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: isActive 
                            ? (index > 5 ? dangerColor : successColor)
                            : Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }).reversed.toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStabilizationIndicator() {
    return Positioned(
      bottom: spMd,
      left: spMd,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(128),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.speed,
              color: Colors.white,
              size: 14,
            ),
            SizedBox(width: spXs),
            Text(
              "Ultra Stable",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSettings() {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: qualityOptions.length,
              itemBuilder: (context, index) {
                final option = qualityOptions[index];
                final isSelected = option["selected"] as bool;

                return GestureDetector(
                  onTap: () {
                    for (var q in qualityOptions) {
                      q["selected"] = false;
                    }
                    option["selected"] = true;
                    quality = option["name"] as String;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${option["name"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: frameRateOptions.length,
              itemBuilder: (context, index) {
                final option = frameRateOptions[index];
                final isSelected = option["selected"] as bool;

                return GestureDetector(
                  onTap: () {
                    for (var f in frameRateOptions) {
                      f["selected"] = false;
                    }
                    option["selected"] = true;
                    frameRate = option["name"] as String;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${option["name"]}",
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                _showVideoGallery();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: Colors.white.withAlpha(102),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm - 2),
                  child: Stack(
                    children: [
                      Image.network(
                        recentVideos.first["thumbnail"] as String,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _toggleRecording();
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isRecording ? dangerColor : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
                child: Icon(
                  isRecording ? Icons.stop : Icons.videocam,
                  color: isRecording ? Colors.white : Colors.black,
                  size: 32,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                stabilization = !stabilization;
                setState(() {});
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: stabilization ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: Colors.white.withAlpha(102),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.vibration,
                  color: stabilization ? Colors.black : Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleRecording() {
    if (isRecording) {
      isRecording = false;
      recordingDuration = 0;
    } else {
      isRecording = true;
      _startRecordingTimer();
    }
    setState(() {});
  }

  void _startRecordingTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (isRecording) {
        recordingDuration++;
        audioLevel = (0.3 + (recordingDuration % 10) * 0.07).clamp(0.0, 1.0);
        setState(() {});
        _startRecordingTimer();
      }
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _showVideoGallery() {
    // Video gallery implementation
  }
}
