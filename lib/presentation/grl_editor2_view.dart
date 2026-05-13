import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlEditor2View extends StatefulWidget {
  @override
  State<GrlEditor2View> createState() => _GrlEditor2ViewState();
}

class _GrlEditor2ViewState extends State<GrlEditor2View> {
  String selectedTool = "Video";
  bool isPlaying = false;
  double playbackPosition = 0.3;
  double playbackSpeed = 1.0;
  List<Map<String, dynamic>> videoClips = [];
  int selectedClipIndex = 0;

  List<Map<String, dynamic>> editingTools = [
    {"name": "Video", "icon": Icons.video_library},
    {"name": "Audio", "icon": Icons.audiotrack},
    {"name": "Text", "icon": Icons.text_fields},
    {"name": "Transition", "icon": Icons.gradient},
    {"name": "Effect", "icon": Icons.auto_awesome},
    {"name": "Filter", "icon": Icons.filter},
  ];

  List<Map<String, dynamic>> transitionTypes = [
    {"name": "Cut", "duration": 0.0},
    {"name": "Fade", "duration": 1.0},
    {"name": "Dissolve", "duration": 1.5},
    {"name": "Slide", "duration": 0.8},
    {"name": "Zoom", "duration": 1.2},
    {"name": "Spin", "duration": 2.0},
  ];

  List<Map<String, dynamic>> videoEffects = [
    {"name": "Slow Motion", "speed": 0.5},
    {"name": "Fast Forward", "speed": 2.0},
    {"name": "Reverse", "speed": -1.0},
    {"name": "Stabilization", "enabled": false},
    {"name": "Color Pop", "enabled": false},
    {"name": "Blur Background", "enabled": false},
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideoClips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildVideoEditorHeader(),
          Expanded(
            child: _buildVideoPreview(),
          ),
          _buildTimelineArea(),
          _buildToolSelector(),
          _buildToolOptions(),
        ],
      ),
    );
  }

  Widget _buildVideoEditorHeader() {
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
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.video_camera_back,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Video Editor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${playbackSpeed}x",
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
            SizedBox(width: spMd),
            GestureDetector(
              onTap: () {
                _exportVideo();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spMd,
                  vertical: spSm,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "Export",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
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
                "https://picsum.photos/400/600?random=13&keyword=video",
                fit: BoxFit.cover,
              ),
            ),
            _buildVideoControls(),
            _buildPlaybackOverlay(),
            _buildTimecode(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Positioned(
      bottom: spMd,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Previous frame
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: spMd),
            GestureDetector(
              onTap: () {
                isPlaying = !isPlaying;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            SizedBox(width: spMd),
            GestureDetector(
              onTap: () {
                // Next frame
              },
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaybackOverlay() {
    if (!isPlaying) return Container();
    
    return Container(
      color: Colors.black.withAlpha(51),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(128),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildTimecode() {
    return Positioned(
      top: spMd,
      right: spMd,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(128),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          "00:${(playbackPosition * 60).toInt().toString().padLeft(2, '0')}:${((playbackPosition * 60 % 1) * 60).toInt().toString().padLeft(2, '0')}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineArea() {
    return Container(
      height: 120,
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildTimelineBar(),
          SizedBox(height: spSm),
          _buildVideoTracks(),
        ],
      ),
    );
  }

  Widget _buildTimelineBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: spSm),
            child: Row(
              children: List.generate(10, (index) {
                return Expanded(
                  child: Container(
                    height: 20,
                    margin: EdgeInsets.only(right: 1),
                    decoration: BoxDecoration(
                      color: index < (playbackPosition * 10)
                          ? primaryColor
                          : Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            left: playbackPosition * (MediaQuery.of(context).size.width - spMd * 2),
            child: Container(
              width: 2,
              height: 40,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoTracks() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videoClips.length,
        itemBuilder: (context, index) {
          final clip = videoClips[index];
          final isSelected = selectedClipIndex == index;

          return GestureDetector(
            onTap: () {
              selectedClipIndex = index;
              setState(() {});
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.white.withAlpha(102),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm - 2),
                child: Stack(
                  children: [
                    Image.network(
                      clip["thumbnail"] as String,
                      width: 80,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(128),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "${clip["duration"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolSelector() {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        itemCount: editingTools.length,
        itemBuilder: (context, index) {
          final tool = editingTools[index];
          final isSelected = selectedTool == tool["name"];

          return GestureDetector(
            onTap: () {
              selectedTool = tool["name"] as String;
              setState(() {});
            },
            child: Container(
              width: 70,
              margin: EdgeInsets.only(right: spSm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      tool["icon"] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${tool["name"]}",
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.white,
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolOptions() {
    return Container(
      height: 120,
      padding: EdgeInsets.all(spMd),
      child: _buildToolContent(),
    );
  }

  Widget _buildToolContent() {
    switch (selectedTool) {
      case "Video":
        return _buildVideoOptions();
      case "Audio":
        return _buildAudioOptions();
      case "Text":
        return _buildTextOptions();
      case "Transition":
        return _buildTransitionOptions();
      case "Effect":
        return _buildEffectOptions();
      case "Filter":
        return _buildFilterOptions();
      default:
        return Container();
    }
  }

  Widget _buildVideoOptions() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Speed",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Colors.white.withAlpha(102),
                  thumbColor: primaryColor,
                ),
                child: Slider(
                  value: playbackSpeed,
                  min: 0.25,
                  max: 4.0,
                  divisions: 15,
                  onChanged: (value) {
                    playbackSpeed = value;
                    setState(() {});
                  },
                ),
              ),
            ),
            Text(
              "${playbackSpeed.toStringAsFixed(2)}x",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildVideoButton("Split", Icons.content_cut),
            _buildVideoButton("Duplicate", Icons.content_copy),
            _buildVideoButton("Delete", Icons.delete),
            _buildVideoButton("Crop", Icons.crop),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              label,
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

  Widget _buildAudioOptions() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Volume",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                  activeTrackColor: successColor,
                  inactiveTrackColor: Colors.white.withAlpha(102),
                  thumbColor: successColor,
                ),
                child: Slider(
                  value: 0.7,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {},
                ),
              ),
            ),
            Text(
              "70%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAudioButton("Music", Icons.library_music),
            _buildAudioButton("Voice", Icons.mic),
            _buildAudioButton("SFX", Icons.audiotrack),
            _buildAudioButton("Mute", Icons.volume_off),
          ],
        ),
      ],
    );
  }

  Widget _buildAudioButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              label,
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

  Widget _buildTextOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTextButton("Add Text", Icons.text_fields),
        _buildTextButton("Title", Icons.title),
        _buildTextButton("Caption", Icons.closed_caption),
        _buildTextButton("Animated", Icons.animation),
      ],
    );
  }

  Widget _buildTextButton(String label, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              label,
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

  Widget _buildTransitionOptions() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: transitionTypes.length,
      itemBuilder: (context, index) {
        final transition = transitionTypes[index];
        
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 80,
            margin: EdgeInsets.only(right: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(128),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.gradient,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${transition["name"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${transition["duration"]}s",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEffectOptions() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videoEffects.length,
      itemBuilder: (context, index) {
        final effect = videoEffects[index];
        
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 80,
            margin: EdgeInsets.only(right: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(128),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${effect["name"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOptions() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 80,
            margin: EdgeInsets.only(right: spSm),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: Colors.white.withAlpha(102),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm - 1),
                    child: Image.network(
                      "https://picsum.photos/60/60?random=${index + 10}&keyword=filter",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Filter ${index + 1}",
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
      },
    );
  }

  void _initializeVideoClips() {
    videoClips = [
      {
        "thumbnail": "https://picsum.photos/80/60?random=1&keyword=video",
        "duration": "3.2s",
      },
      {
        "thumbnail": "https://picsum.photos/80/60?random=2&keyword=video",
        "duration": "2.8s",
      },
      {
        "thumbnail": "https://picsum.photos/80/60?random=3&keyword=video",
        "duration": "4.1s",
      },
      {
        "thumbnail": "https://picsum.photos/80/60?random=4&keyword=video",
        "duration": "1.9s",
      },
    ];
  }

  void _exportVideo() {
    // Export video implementation
    ss("Video exported successfully!");
  }
}
