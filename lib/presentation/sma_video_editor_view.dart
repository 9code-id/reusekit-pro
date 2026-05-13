import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaVideoEditorView extends StatefulWidget {
  const SmaVideoEditorView({super.key});

  @override
  State<SmaVideoEditorView> createState() => _SmaVideoEditorViewState();
}

class _SmaVideoEditorViewState extends State<SmaVideoEditorView> {
  String currentVideo = "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4";
  int selectedTab = 0;
  bool isPlaying = false;
  double currentPosition = 0.0;
  double videoDuration = 30.0; // seconds
  
  // Trim settings
  double trimStart = 0.0;
  double trimEnd = 30.0;
  
  // Effect settings
  String selectedEffect = "none";
  double playbackSpeed = 1.0;
  double videoVolume = 1.0;
  
  // Filter settings
  String selectedFilter = "none";
  double brightness = 0.0;
  double contrast = 0.0;
  double saturation = 0.0;
  
  // Text overlay settings
  String textOverlay = "";
  String textColor = "white";
  String textSize = "medium";
  double textStartTime = 0.0;
  double textDuration = 5.0;
  
  // Audio settings
  String backgroundMusic = "";
  double musicVolume = 0.5;
  bool muteOriginalAudio = false;
  
  List<Map<String, dynamic>> effectOptions = [
    {"name": "None", "value": "none"},
    {"name": "Fade In", "value": "fade_in"},
    {"name": "Fade Out", "value": "fade_out"},
    {"name": "Slow Motion", "value": "slow_motion"},
    {"name": "Fast Forward", "value": "fast_forward"},
    {"name": "Reverse", "value": "reverse"},
    {"name": "Zoom In", "value": "zoom_in"},
    {"name": "Zoom Out", "value": "zoom_out"},
  ];
  
  List<Map<String, dynamic>> filterOptions = [
    {"name": "None", "value": "none"},
    {"name": "Vintage", "value": "vintage"},
    {"name": "Black & White", "value": "bw"},
    {"name": "Sepia", "value": "sepia"},
    {"name": "Cinematic", "value": "cinematic"},
    {"name": "Warm", "value": "warm"},
    {"name": "Cool", "value": "cool"},
    {"name": "Vivid", "value": "vivid"},
  ];
  
  List<String> musicTracks = [
    "Upbeat Pop",
    "Chill Acoustic",
    "Electronic Beat",
    "Ambient Sound",
    "Rock Energy",
    "Jazz Smooth",
  ];
  
  void _playPause() {
    isPlaying = !isPlaying;
    setState(() {});
    
    if (isPlaying) {
      si("Video playing");
    } else {
      si("Video paused");
    }
  }
  
  void _exportVideo() async {
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("Video exported successfully");
    back();
  }
  
  void _previewVideo() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    si("Preview generated");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Editor"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: _previewVideo,
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportVideo,
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Preview
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 300,
                        maxWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.videocam,
                              size: 80,
                              color: Colors.white.withAlpha(100),
                            ),
                          ),
                          // Filter overlay
                          if (selectedFilter != "none")
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedFilter == "vintage" ? Colors.brown.withAlpha(30) :
                                         selectedFilter == "bw" ? Colors.grey.withAlpha(50) :
                                         selectedFilter == "sepia" ? Colors.orange.withAlpha(40) :
                                         selectedFilter == "cinematic" ? Colors.black.withAlpha(20) :
                                         selectedFilter == "warm" ? Colors.orange.withAlpha(20) :
                                         selectedFilter == "cool" ? Colors.blue.withAlpha(20) :
                                         Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Play/Pause Button
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _playPause,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [shadowMd],
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Text overlay preview
                  if (textOverlay.isNotEmpty)
                    Positioned(
                      bottom: 100,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          textOverlay,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor == "white" ? Colors.white : 
                                   textColor == "black" ? Colors.black :
                                   textColor == "red" ? Colors.red : Colors.white,
                            fontSize: textSize == "small" ? 14 :
                                      textSize == "medium" ? 18 :
                                      textSize == "large" ? 24 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Video Timeline
          Container(
            padding: EdgeInsets.all(spSm),
            color: Colors.grey[100],
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${(currentPosition).toInt()}s",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: currentPosition,
                        min: 0.0,
                        max: videoDuration,
                        activeColor: primaryColor,
                        inactiveColor: disabledColor,
                        onChanged: (value) {
                          currentPosition = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Text(
                      "${videoDuration.toInt()}s",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                // Trim indicators
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: (trimStart / videoDuration) * MediaQuery.of(context).size.width * 0.8,
                        child: Container(
                          width: 2,
                          height: 30,
                          color: successColor,
                        ),
                      ),
                      Positioned(
                        left: (trimEnd / videoDuration) * MediaQuery.of(context).size.width * 0.8,
                        child: Container(
                          width: 2,
                          height: 30,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Editor Tools
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  // Tab Bar
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        _buildTabButton("Trim", 0),
                        _buildTabButton("Effects", 1),
                        _buildTabButton("Filters", 2),
                        _buildTabButton("Text", 3),
                        _buildTabButton("Audio", 4),
                      ],
                    ),
                  ),
                  
                  // Tab Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(spSm),
                      child: _buildTabContent(),
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
  
  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTab = index;
          setState(() {});
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildTrimTab();
      case 1:
        return _buildEffectsTab();
      case 2:
        return _buildFiltersTab();
      case 3:
        return _buildTextTab();
      case 4:
        return _buildAudioTab();
      default:
        return Container();
    }
  }
  
  Widget _buildTrimTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Trim Video",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Start: ${trimStart.toInt()}s",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: trimStart,
                    min: 0.0,
                    max: videoDuration - 1,
                    activeColor: successColor,
                    inactiveColor: disabledColor,
                    onChanged: (value) {
                      if (value < trimEnd) {
                        trimStart = value;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "End: ${trimEnd.toInt()}s",
                    style: TextStyle(
                      fontSize: 12,
                      color: dangerColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: trimEnd,
                    min: 1.0,
                    max: videoDuration,
                    activeColor: dangerColor,
                    inactiveColor: disabledColor,
                    onChanged: (value) {
                      if (value > trimStart) {
                        trimEnd = value;
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: infoColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Text(
            "Trimmed duration: ${(trimEnd - trimStart).toInt()} seconds",
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Set Current Position",
                size: bs.sm,
                onPressed: () {
                  trimStart = currentPosition;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Reset Trim",
                size: bs.sm,
                onPressed: () {
                  trimStart = 0.0;
                  trimEnd = videoDuration;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildEffectsTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Video Effects",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QDropdownField(
          label: "Select Effect",
          items: effectOptions.map((effect) => {
            "label": effect["name"],
            "value": effect["value"],
          }).toList(),
          value: selectedEffect,
          onChanged: (value, label) {
            selectedEffect = value;
            setState(() {});
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Playback Speed: ${playbackSpeed.toStringAsFixed(1)}x",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: playbackSpeed,
              min: 0.25,
              max: 4.0,
              divisions: 15,
              activeColor: primaryColor,
              inactiveColor: disabledColor,
              onChanged: (value) {
                playbackSpeed = value;
                setState(() {});
              },
            ),
          ],
        ),
        if (selectedEffect != "none")
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "Effect '${effectOptions.firstWhere((e) => e["value"] == selectedEffect)["name"]}' will be applied",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildFiltersTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Video Filters",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: filterOptions.map((filter) {
            bool isSelected = selectedFilter == filter["value"];
            return Container(
              width: 80,
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedFilter = filter["value"];
                  setState(() {});
                },
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "https://picsum.photos/60/60?random=${filterOptions.indexOf(filter) + 10}&keyword=filter",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      filter["name"],
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        _buildSlider("Brightness", brightness, (value) {
          brightness = value;
          setState(() {});
        }),
        _buildSlider("Contrast", contrast, (value) {
          contrast = value;
          setState(() {});
        }),
        _buildSlider("Saturation", saturation, (value) {
          saturation = value;
          setState(() {});
        }),
      ],
    );
  }
  
  Widget _buildTextTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Add Text Overlay",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QTextField(
          label: "Text Content",
          value: textOverlay,
          hint: "Enter text to overlay on video",
          onChanged: (value) {
            textOverlay = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Text Color",
                items: [
                  {"label": "White", "value": "white"},
                  {"label": "Black", "value": "black"},
                  {"label": "Red", "value": "red"},
                  {"label": "Blue", "value": "blue"},
                ],
                value: textColor,
                onChanged: (value, label) {
                  textColor = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Text Size",
                items: [
                  {"label": "Small", "value": "small"},
                  {"label": "Medium", "value": "medium"},
                  {"label": "Large", "value": "large"},
                ],
                value: textSize,
                onChanged: (value, label) {
                  textSize = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Show at: ${textStartTime.toInt()}s",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: textStartTime,
              min: 0.0,
              max: videoDuration - textDuration,
              activeColor: primaryColor,
              inactiveColor: disabledColor,
              onChanged: (value) {
                textStartTime = value;
                setState(() {});
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Duration: ${textDuration.toInt()}s",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: textDuration,
              min: 1.0,
              max: 10.0,
              divisions: 9,
              activeColor: primaryColor,
              inactiveColor: disabledColor,
              onChanged: (value) {
                textDuration = value;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildAudioTab() {
    return Column(
      spacing: spSm,
      children: [
        Text(
          "Audio Settings",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Video Volume: ${(videoVolume * 100).toInt()}%",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: videoVolume,
              min: 0.0,
              max: 1.0,
              activeColor: primaryColor,
              inactiveColor: disabledColor,
              onChanged: (value) {
                videoVolume = value;
                setState(() {});
              },
            ),
          ],
        ),
        QSwitch(
          items: [
            {
              "label": "Mute original audio",
              "value": "mute",
              "checked": muteOriginalAudio,
            }
          ],
          value: [if (muteOriginalAudio) {"label": "Mute original audio", "value": "mute", "checked": true}],
          onChanged: (values, ids) {
            muteOriginalAudio = values.isNotEmpty;
            setState(() {});
          },
        ),
        QDropdownField(
          label: "Background Music",
          items: [
            {"label": "No Music", "value": ""},
            ...musicTracks.map((track) => {
              "label": track,
              "value": track.toLowerCase().replaceAll(" ", "_"),
            }),
          ],
          value: backgroundMusic,
          onChanged: (value, label) {
            backgroundMusic = value;
            setState(() {});
          },
        ),
        if (backgroundMusic.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Music Volume: ${(musicVolume * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: musicVolume,
                min: 0.0,
                max: 1.0,
                activeColor: primaryColor,
                inactiveColor: disabledColor,
                onChanged: (value) {
                  musicVolume = value;
                  setState(() {});
                },
              ),
            ],
          ),
      ],
    );
  }
  
  Widget _buildSlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${(value * 100).toInt()}%",
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: value,
          min: -1.0,
          max: 1.0,
          divisions: 100,
          activeColor: primaryColor,
          inactiveColor: disabledColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
