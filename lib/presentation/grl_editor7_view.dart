import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEditor7View extends StatefulWidget {
  @override
  State<GrlEditor7View> createState() => _GrlEditor7ViewState();
}

class _GrlEditor7ViewState extends State<GrlEditor7View> {
  String projectName = "My Video Project";
  double videoDuration = 120.0; // seconds
  double currentTime = 45.0;
  bool isPlaying = false;
  bool isRecording = false;
  
  List<Map<String, dynamic>> videoTracks = [
    {
      "name": "Main Video",
      "type": "video",
      "duration": 120.0,
      "startTime": 0.0,
      "color": "#2196F3",
      "thumbnail": "https://picsum.photos/100/60?random=1&keyword=video"
    },
    {
      "name": "Background Music",
      "type": "audio", 
      "duration": 120.0,
      "startTime": 0.0,
      "color": "#4CAF50",
      "thumbnail": ""
    },
    {
      "name": "Voice Over",
      "type": "audio",
      "duration": 60.0,
      "startTime": 30.0,
      "color": "#FF9800",
      "thumbnail": ""
    },
    {
      "name": "Title Text",
      "type": "text",
      "duration": 10.0,
      "startTime": 5.0,
      "color": "#9C27B0",
      "thumbnail": ""
    }
  ];

  List<Map<String, dynamic>> effects = [
    {"name": "Fade In", "icon": Icons.trending_up, "category": "Transition"},
    {"name": "Fade Out", "icon": Icons.trending_down, "category": "Transition"},
    {"name": "Blur", "icon": Icons.blur_on, "category": "Filter"},
    {"name": "Brightness", "icon": Icons.brightness_6, "category": "Color"},
    {"name": "Contrast", "icon": Icons.contrast, "category": "Color"},
    {"name": "Zoom In", "icon": Icons.zoom_in, "category": "Transform"},
    {"name": "Slow Motion", "icon": Icons.slow_motion_video, "category": "Time"},
    {"name": "Speed Up", "icon": Icons.fast_forward, "category": "Time"}
  ];

  List<Map<String, dynamic>> mediaLibrary = [
    {
      "name": "intro_video.mp4",
      "type": "video",
      "duration": "00:30",
      "size": "125 MB",
      "thumbnail": "https://picsum.photos/150/100?random=2&keyword=intro"
    },
    {
      "name": "background_music.mp3",
      "type": "audio",
      "duration": "03:45",
      "size": "8.5 MB",
      "thumbnail": ""
    },
    {
      "name": "logo.png",
      "type": "image",
      "duration": "N/A",
      "size": "2.1 MB",
      "thumbnail": "https://picsum.photos/150/100?random=3&keyword=logo"
    },
    {
      "name": "outro_clip.mp4",
      "type": "video",
      "duration": "00:15",
      "size": "75 MB",
      "thumbnail": "https://picsum.photos/150/100?random=4&keyword=outro"
    }
  ];

  Map<String, dynamic> exportSettings = {
    "resolution": "1920x1080",
    "fps": 30,
    "quality": "High",
    "format": "MP4"
  };

  int selectedTab = 0;
  String selectedEffect = "";
  double zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Editor"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () => _saveProject(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.file_download,
            size: bs.sm,
            color: successColor,
            onPressed: () => _exportVideo(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () => _showProjectSettings(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Main Video Preview and Timeline Area
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Left Sidebar - Media Library & Effects
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(right: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Column(
                    children: [
                      // Sidebar Tabs
                      Container(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Media",
                                size: bs.sm,
                                color: selectedTab == 0 ? primaryColor : disabledColor,
                                onPressed: () {
                                  selectedTab = 0;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Effects",
                                size: bs.sm,
                                color: selectedTab == 1 ? primaryColor : disabledColor,
                                onPressed: () {
                                  selectedTab = 1;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: selectedTab == 0 ? _buildMediaLibraryPanel() : _buildEffectsPanel(),
                      ),
                    ],
                  ),
                ),
                
                // Video Preview Area
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: Column(
                      children: [
                        // Video Preview Controls
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                          ),
                          child: Row(
                            children: [
                              Text(
                                projectName,
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${(currentTime / 60).floor()}:${(currentTime % 60).floor().toString().padLeft(2, '0')} / ${(videoDuration / 60).floor()}:${(videoDuration % 60).floor().toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(width: spMd),
                              QButton(
                                icon: Icons.zoom_out,
                                size: bs.sm,
                                color: Colors.white54,
                                onPressed: () => _zoomOut(),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${(zoom * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.zoom_in,
                                size: bs.sm,
                                color: Colors.white54,
                                onPressed: () => _zoomIn(),
                              ),
                            ],
                          ),
                        ),
                        
                        // Video Preview Screen
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      image: DecorationImage(
                                        image: NetworkImage("https://picsum.photos/300/200?random=5&keyword=video"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isPlaying ? Icons.pause : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spMd),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      QButton(
                                        icon: Icons.skip_previous,
                                        size: bs.sm,
                                        color: Colors.white54,
                                        onPressed: () => _previousFrame(),
                                      ),
                                      SizedBox(width: spMd),
                                      QButton(
                                        icon: isPlaying ? Icons.pause : Icons.play_arrow,
                                        size: bs.md,
                                        color: Colors.white,
                                        onPressed: () => _togglePlayback(),
                                      ),
                                      SizedBox(width: spMd),
                                      QButton(
                                        icon: Icons.skip_next,
                                        size: bs.sm,
                                        color: Colors.white54,
                                        onPressed: () => _nextFrame(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Timeline Area
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Column(
              children: [
                // Timeline Controls
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timeline, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () => _addTrack(),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: isRecording ? Icons.stop : Icons.fiber_manual_record,
                        size: bs.sm,
                        color: isRecording ? dangerColor : dangerColor,
                        onPressed: () => _toggleRecording(),
                      ),
                    ],
                  ),
                ),
                
                // Timeline Tracks
                Expanded(
                  child: Row(
                    children: [
                      // Track Labels
                      Container(
                        width: 120,
                        child: Column(
                          children: videoTracks.map((track) => 
                            Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: spSm),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _getTrackIcon(track["type"]),
                                    size: 16,
                                    color: Color(int.parse(track["color"].replaceAll('#', '0xFF'))),
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${track["name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                      
                      // Timeline Content
                      Expanded(
                        child: Container(
                          child: Column(
                            children: videoTracks.map((track) => 
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                                ),
                                child: _buildTimelineTrack(track),
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Timeline Scrubber
                Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Row(
                    children: [
                      Container(width: 120), // Offset for track labels
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            Positioned(
                              left: (currentTime / videoDuration) * (MediaQuery.of(context).size.width - 120 - 32),
                              child: Container(
                                width: 2,
                                height: 20,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaLibraryPanel() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          child: Container(
            width: double.infinity,
            child: QButton(
              label: "Import Media",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () => _importMedia(),
            ),
          ),
        ),
        
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            itemCount: mediaLibrary.length,
            itemBuilder: (context, index) {
              final media = mediaLibrary[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (media["thumbnail"] != "")
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${media["thumbnail"]}",
                          width: double.infinity,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (media["thumbnail"] != "") SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Icon(
                          _getMediaIcon(media["type"]),
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${media["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "${media["duration"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${media["size"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEffectsPanel() {
    return ListView.builder(
      padding: EdgeInsets.all(spSm),
      itemCount: effects.length,
      itemBuilder: (context, index) {
        final effect = effects[index];
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: GestureDetector(
            onTap: () => _selectEffect(effect),
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: selectedEffect == effect["name"] ? primaryColor.withAlpha(20) : Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: selectedEffect == effect["name"] ? primaryColor : disabledOutlineBorderColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    effect["icon"] as IconData,
                    color: selectedEffect == effect["name"] ? primaryColor : disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${effect["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: selectedEffect == effect["name"] ? primaryColor : primaryColor,
                          ),
                        ),
                        Text(
                          "${effect["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
      },
    );
  }

  Widget _buildTimelineTrack(Map<String, dynamic> track) {
    double trackWidth = (track["duration"] as double) / videoDuration * 200;
    double trackStart = (track["startTime"] as double) / videoDuration * 200;
    
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Stack(
        children: [
          Positioned(
            left: trackStart,
            child: Container(
              width: trackWidth,
              height: 30,
              decoration: BoxDecoration(
                color: Color(int.parse(track["color"].replaceAll('#', '0xFF'))).withAlpha(150),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: Color(int.parse(track["color"].replaceAll('#', '0xFF'))),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spXs),
                child: Row(
                  children: [
                    if (track["thumbnail"] != "")
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXxs),
                        child: Image.network(
                          "${track["thumbnail"]}",
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (track["thumbnail"] != "") SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${track["name"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTrackIcon(String type) {
    switch (type) {
      case "video":
        return Icons.videocam;
      case "audio":
        return Icons.audiotrack;
      case "text":
        return Icons.text_fields;
      default:
        return Icons.layers;
    }
  }

  IconData _getMediaIcon(String type) {
    switch (type) {
      case "video":
        return Icons.video_file;
      case "audio":
        return Icons.audio_file;
      case "image":
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _saveProject() {
    ss("Project saved successfully");
  }

  void _exportVideo() {
    ss("Video export started");
  }

  void _showProjectSettings() {
    ss("Project settings opened");
  }

  void _importMedia() {
    ss("Media import dialog opened");
  }

  void _selectEffect(Map<String, dynamic> effect) {
    selectedEffect = effect["name"];
    setState(() {});
    ss("Selected effect: ${effect["name"]}");
  }

  void _addTrack() {
    ss("New track added to timeline");
  }

  void _toggleRecording() {
    isRecording = !isRecording;
    setState(() {});
    ss(isRecording ? "Recording started" : "Recording stopped");
  }

  void _togglePlayback() {
    isPlaying = !isPlaying;
    setState(() {});
    ss(isPlaying ? "Playback started" : "Playback paused");
  }

  void _previousFrame() {
    if (currentTime > 0) {
      currentTime = (currentTime - 1).clamp(0, videoDuration);
      setState(() {});
    }
  }

  void _nextFrame() {
    if (currentTime < videoDuration) {
      currentTime = (currentTime + 1).clamp(0, videoDuration);
      setState(() {});
    }
  }

  void _zoomIn() {
    zoom = (zoom + 0.1).clamp(0.5, 3.0);
    setState(() {});
  }

  void _zoomOut() {
    zoom = (zoom - 0.1).clamp(0.5, 3.0);
    setState(() {});
  }
}
