import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaScreenshotsCaptureView extends StatefulWidget {
  const GeaScreenshotsCaptureView({super.key});

  @override
  State<GeaScreenshotsCaptureView> createState() => _GeaScreenshotsCaptureViewState();
}

class _GeaScreenshotsCaptureViewState extends State<GeaScreenshotsCaptureView> {
  bool isRecording = false;
  int selectedQuality = 1;
  bool includeAudio = true;
  bool showControls = true;
  String selectedFormat = "PNG";
  
  List<Map<String, dynamic>> qualityOptions = [
    {"label": "720p", "value": 0},
    {"label": "1080p", "value": 1},
    {"label": "1440p", "value": 2},
    {"label": "4K", "value": 3},
  ];

  List<Map<String, dynamic>> formatOptions = [
    {"label": "PNG", "value": "PNG"},
    {"label": "JPG", "value": "JPG"},
    {"label": "WebP", "value": "WebP"},
  ];

  List<Map<String, dynamic>> recentCaptures = [
    {
      "id": "1",
      "type": "screenshot",
      "title": "Epic Victory Screenshot",
      "game": "Dragon's Quest",
      "timestamp": "2024-06-15T14:30:00",
      "size": "2.4 MB",
      "resolution": "1920x1080",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=game",
      "likes": 124,
      "views": 1850,
      "shared": true,
    },
    {
      "id": "2",
      "type": "video",
      "title": "Amazing Combo Gameplay",
      "game": "Space Warriors",
      "timestamp": "2024-06-15T12:15:00",
      "size": "45.2 MB",
      "duration": "0:32",
      "resolution": "1920x1080",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=space",
      "likes": 89,
      "views": 1205,
      "shared": false,
    },
    {
      "id": "3",
      "type": "screenshot",
      "title": "Beautiful Landscape",
      "game": "Mystery Manor",
      "timestamp": "2024-06-14T18:45:00",
      "size": "3.1 MB",
      "resolution": "2560x1440",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=landscape",
      "likes": 67,
      "views": 892,
      "shared": true,
    },
    {
      "id": "4",
      "type": "video",
      "title": "Boss Fight Highlight",
      "game": "Dragon's Quest",
      "timestamp": "2024-06-14T16:20:00",
      "size": "78.9 MB",
      "duration": "1:15",
      "resolution": "1920x1080",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=boss",
      "likes": 156,
      "views": 2340,
      "shared": true,
    },
  ];

  void _takeScreenshot() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    setState(() {
      recentCaptures.insert(0, {
        "id": "${recentCaptures.length + 1}",
        "type": "screenshot",
        "title": "New Screenshot",
        "game": "Current Game",
        "timestamp": DateTime.now().toIso8601String(),
        "size": "2.8 MB",
        "resolution": "1920x1080",
        "thumbnail": "https://picsum.photos/300/200?random=${recentCaptures.length + 5}&keyword=gaming",
        "likes": 0,
        "views": 0,
        "shared": false,
      });
    });
    
    ss("Screenshot captured successfully!");
  }

  void _startStopRecording() async {
    if (isRecording) {
      showLoading();
      await Future.delayed(Duration(seconds: 3));
      hideLoading();
      
      setState(() {
        isRecording = false;
        recentCaptures.insert(0, {
          "id": "${recentCaptures.length + 1}",
          "type": "video",
          "title": "New Recording",
          "game": "Current Game",
          "timestamp": DateTime.now().toIso8601String(),
          "size": "32.5 MB",
          "duration": "0:45",
          "resolution": "1920x1080",
          "thumbnail": "https://picsum.photos/300/200?random=${recentCaptures.length + 5}&keyword=recording",
          "likes": 0,
          "views": 0,
          "shared": false,
        });
      });
      
      ss("Recording saved successfully!");
    } else {
      setState(() {
        isRecording = true;
      });
      si("Recording started");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screenshots & Capture"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () {
              _showSettingsDialog();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Capture Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(25),
                    infoColor.withAlpha(25),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Quick Capture",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  // Capture Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Screenshot",
                          size: bs.md,
                          onPressed: _takeScreenshot,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: isRecording ? "Stop Recording" : "Start Recording",
                          size: bs.md,
                          onPressed: _startStopRecording,
                        ),
                      ),
                    ],
                  ),
                  
                  if (isRecording) ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Recording in progress...",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "00:${DateTime.now().second.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Settings Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Current Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => _showSettingsDialog(),
                        child: Text(
                          "Change",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSettingItem(
                          "Quality",
                          qualityOptions[selectedQuality]["label"],
                          Icons.high_quality,
                        ),
                      ),
                      Expanded(
                        child: _buildSettingItem(
                          "Format",
                          selectedFormat,
                          Icons.image,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildSettingItem(
                          "Audio",
                          includeAudio ? "Enabled" : "Disabled",
                          Icons.volume_up,
                        ),
                      ),
                      Expanded(
                        child: _buildSettingItem(
                          "Controls",
                          showControls ? "Visible" : "Hidden",
                          Icons.control_camera,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent Captures
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Captures",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${recentCaptures.length} items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  ...List.generate(recentCaptures.length, (index) {
                    final capture = recentCaptures[index];
                    final isVideo = capture["type"] == "video";
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Thumbnail
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${capture["thumbnail"]}",
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isVideo ? dangerColor : successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    isVideo ? "VIDEO" : "PHOTO",
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              if (isVideo) ...[
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(width: spSm),
                          
                          // Capture Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${capture["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${capture["game"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      "${capture["resolution"]} • ${capture["size"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    if (isVideo) ...[
                                      Text(
                                        " • ${capture["duration"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      color: primaryColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${capture["views"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.favorite,
                                      color: dangerColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${capture["likes"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Actions
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  si("Share ${capture["title"]}");
                                },
                                child: Icon(
                                  Icons.share,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: spXs),
                              GestureDetector(
                                onTap: () {
                                  si("More options for ${capture["title"]}");
                                },
                                child: Icon(
                                  Icons.more_vert,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  
                  // View All Button
                  Center(
                    child: QButton(
                      label: "View All Captures",
                      size: bs.sm,
                      onPressed: () {
                        si("View all captures");
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Storage Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    warningColor.withAlpha(25),
                    successColor.withAlpha(25),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.storage,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Storage Usage",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Used: 2.4 GB / 5.0 GB",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.48,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Manage",
                        size: bs.sm,
                        onPressed: () {
                          si("Manage storage");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 16,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    // This would show a settings dialog in a real implementation
    si("Settings dialog would open here");
  }
}
