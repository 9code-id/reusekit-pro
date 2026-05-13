import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer10View extends StatefulWidget {
  @override
  State<GrlPlayer10View> createState() => _GrlPlayer10ViewState();
}

class _GrlPlayer10ViewState extends State<GrlPlayer10View> with TickerProviderStateMixin {
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeated = false;
  bool isLiked = true;
  double currentPosition = 0.65;
  bool showVisualization = true;
  
  late AnimationController _waveController;
  late AnimationController _rotationController;
  
  Map<String, dynamic> currentTrack = {
    "title": "Neon Dreams",
    "artist": "Synthwave Future",
    "album": "Cyberpunk 2084",
    "duration": "4:07",
    "currentTime": "2:41",
    "artwork": "https://picsum.photos/400/400?random=60&keyword=cyberpunk",
    "year": "2024",
    "genre": "Synthwave",
    "energy": 0.8,
    "mood": "Energetic",
  };

  List<Map<String, dynamic>> audioFeatures = [
    {"label": "Energy", "value": 0.8, "color": Colors.red},
    {"label": "Danceability", "value": 0.6, "color": Colors.orange},
    {"label": "Valence", "value": 0.7, "color": Colors.yellow},
    {"label": "Acousticness", "value": 0.2, "color": Colors.green},
    {"label": "Instrumentalness", "value": 0.9, "color": Colors.blue},
    {"label": "Speechiness", "value": 0.1, "color": Colors.purple},
  ];

  List<Map<String, dynamic>> similarTracks = [
    {
      "title": "Electric Sunset",
      "artist": "Synthwave Future",
      "duration": "3:54",
      "artwork": "https://picsum.photos/60/60?random=61&keyword=electric",
      "similarity": 95,
    },
    {
      "title": "Digital Highway",
      "artist": "Retro Collective",
      "duration": "4:23",
      "artwork": "https://picsum.photos/60/60?random=62&keyword=highway",
      "similarity": 89,
    },
    {
      "title": "Cyber Romance",
      "artist": "Future Past",
      "duration": "5:11",
      "artwork": "https://picsum.photos/60/60?random=63&keyword=romance",
      "similarity": 87,
    },
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    
    if (isPlaying) {
      _waveController.repeat();
      _rotationController.repeat();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0a0a0a),
              Color(0xFF1a0a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildArtworkVisualization(),
                      _buildTrackInfo(),
                      _buildProgressSection(),
                      _buildPlayerControls(),
                      _buildAudioFeatures(),
                      _buildSimilarTracks(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => back(),
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Color(0xFF1a1a2e),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(128),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "NOW PLAYING",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${currentTrack["mood"]} • ${currentTrack["genre"]}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(179),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showVisualization = !showVisualization;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: showVisualization ? primaryColor.withAlpha(51) : Color(0xFF1a1a2e),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(128),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.graphic_eq,
                color: showVisualization ? primaryColor : Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkVisualization() {
    return Container(
      height: 400,
      padding: EdgeInsets.all(spLg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background particle effect
          if (showVisualization) ...[
            ...List.generate(20, (index) {
              return AnimatedBuilder(
                animation: _waveController,
                builder: (context, child) {
                  double size = 5 + (index % 3) * 3;
                  double offset = (_waveController.value * 360 + index * 18) * 3.14159 / 180;
                  double radius = 150 + (index % 4) * 20;
                  
                  return Positioned(
                    left: 200 + radius * Math.cos(offset) - size / 2,
                    top: 200 + radius * Math.sin(offset) - size / 2,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha((128 * _waveController.value).round()),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              );
            }),
          ],
          
          // Rotating outer ring
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * 3.14159,
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryColor.withAlpha(77),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: List.generate(8, (index) {
                      double angle = (index * 45) * 3.14159 / 180;
                      return Positioned(
                        left: 150 + 145 * Math.cos(angle),
                        top: 150 + 145 * Math.sin(angle),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
          
          // Main artwork
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(128),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: primaryColor.withAlpha(77),
                  blurRadius: 50,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                "${currentTrack["artwork"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Center play indicator
          if (isPlaying)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(179),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrackInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${currentTrack["title"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${currentTrack["artist"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(179),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  isLiked = !isLiked;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isLiked ? Colors.red.withAlpha(51) : Color(0xFF1a1a2e),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isLiked ? Colors.red.withAlpha(128) : primaryColor.withAlpha(77),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.white.withAlpha(179),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${currentTrack["album"]} • ${currentTrack["year"]}",
                style: TextStyle(
                  color: Colors.white.withAlpha(128),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          SizedBox(height: spMd),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              color: Color(0xFF1a1a2e),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 8,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
                activeTrackColor: primaryColor,
                inactiveTrackColor: Colors.white.withAlpha(51),
                thumbColor: primaryColor,
                overlayColor: primaryColor.withAlpha(51),
              ),
              child: Slider(
                value: currentPosition,
                onChanged: (value) {
                  currentPosition = value;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${currentTrack["currentTime"]}",
                style: TextStyle(
                  color: Colors.white.withAlpha(179),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${currentTrack["duration"]}",
                style: TextStyle(
                  color: Colors.white.withAlpha(179),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerControls() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: Icons.shuffle,
            isActive: isShuffled,
            onTap: () {
              isShuffled = !isShuffled;
              setState(() {});
            },
          ),
          _buildControlButton(
            icon: Icons.skip_previous,
            size: 40,
            onTap: () {},
          ),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
              if (isPlaying) {
                _waveController.repeat();
                _rotationController.repeat();
              } else {
                _waveController.stop();
                _rotationController.stop();
              }
              setState(() {});
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(204),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(128),
                    blurRadius: 30,
                    offset: Offset(0, 15),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withAlpha(51),
                  width: 2,
                ),
              ),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          _buildControlButton(
            icon: Icons.skip_next,
            size: 40,
            onTap: () {},
          ),
          _buildControlButton(
            icon: Icons.repeat,
            isActive: isRepeated,
            onTap: () {
              isRepeated = !isRepeated;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    bool isActive = false,
    double size = 24,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withAlpha(51) : Color(0xFF1a1a2e),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isActive ? primaryColor.withAlpha(128) : primaryColor.withAlpha(77),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? primaryColor : Colors.white.withAlpha(179),
          size: size,
        ),
      ),
    );
  }

  Widget _buildAudioFeatures() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Color(0xFF1a1a2e),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: primaryColor.withAlpha(77),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Audio Features",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: audioFeatures.map((feature) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${feature["label"]}",
                          style: TextStyle(
                            color: Colors.white.withAlpha(179),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${((feature["value"] as double) * 100).round()}%",
                          style: TextStyle(
                            color: feature["color"] as Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: Colors.white.withAlpha(26),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: feature["value"] as double,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            color: feature["color"] as Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarTracks() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Color(0xFF1a1a2e),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: primaryColor.withAlpha(77),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.library_music,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Similar Tracks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: similarTracks.length,
            itemBuilder: (context, index) {
              final track = similarTracks[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(13),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${track["artwork"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${track["title"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${track["artist"]}",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(179),
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${track["similarity"]}% match",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
