import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer8View extends StatefulWidget {
  @override
  State<GrlPlayer8View> createState() => _GrlPlayer8ViewState();
}

class _GrlPlayer8ViewState extends State<GrlPlayer8View> {
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeated = false;
  bool isLiked = true;
  bool showEqualizer = false;
  double currentPosition = 0.55;
  double volume = 0.7;
  
  Map<String, dynamic> currentTrack = {
    "title": "Ethereal Waves",
    "artist": "Deep Space Orchestra", 
    "album": "Cosmic Journey",
    "duration": "5:18",
    "currentTime": "2:54",
    "artwork": "https://picsum.photos/350/350?random=40&keyword=space",
    "year": "2024",
    "genre": "Ambient",
    "bitrate": "320 kbps",
    "sampleRate": "44.1 kHz",
  };

  List<double> equalizerValues = [0.2, 0.5, 0.8, 0.3, 0.7, 0.4, 0.6, 0.9, 0.1, 0.5];
  List<String> equalizerLabels = ["32Hz", "64Hz", "125Hz", "250Hz", "500Hz", "1kHz", "2kHz", "4kHz", "8kHz", "16kHz"];

  List<Map<String, dynamic>> playQueue = [
    {
      "title": "Ethereal Waves",
      "artist": "Deep Space Orchestra",
      "duration": "5:18",
      "artwork": "https://picsum.photos/60/60?random=40&keyword=space",
      "isPlaying": true,
    },
    {
      "title": "Stellar Winds",
      "artist": "Deep Space Orchestra",
      "duration": "4:42",
      "artwork": "https://picsum.photos/60/60?random=41&keyword=stellar",
      "isPlaying": false,
    },
    {
      "title": "Nebula Dance",
      "artist": "Cosmic Collective",
      "duration": "6:15",
      "artwork": "https://picsum.photos/60/60?random=42&keyword=nebula",
      "isPlaying": false,
    },
    {
      "title": "Aurora Dreams",
      "artist": "Northern Lights",
      "duration": "3:58",
      "artwork": "https://picsum.photos/60/60?random=43&keyword=aurora",
      "isPlaying": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A1A),
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
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
                      _buildArtworkSection(),
                      _buildTrackInfo(),
                      _buildAudioSpectrum(),
                      _buildProgressSection(),
                      _buildPlayerControls(),
                      _buildVolumeSection(),
                      if (showEqualizer) _buildEqualizerSection(),
                      _buildActionButtons(),
                      _buildQueueSection(),
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
                color: Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(77),
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
                  "HIGH QUALITY AUDIO",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${currentTrack["bitrate"]} • ${currentTrack["sampleRate"]}",
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
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: primaryColor.withAlpha(77),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkSection() {
    return Container(
      padding: EdgeInsets.all(spLg),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  primaryColor.withAlpha(51),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Pulsing ring
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            width: isPlaying ? 300 : 280,
            height: isPlaying ? 300 : 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor.withAlpha(isPlaying ? 128 : 77),
                width: 2,
              ),
            ),
          ),
          // Main artwork
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(128),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: primaryColor.withAlpha(51),
                  blurRadius: 40,
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
          // Audio quality indicator
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Text(
                "HQ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                        fontSize: 24,
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
                        fontSize: 16,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isLiked ? Colors.red.withAlpha(51) : Colors.white.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isLiked ? Colors.red.withAlpha(128) : Colors.white.withAlpha(51),
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
              Spacer(),
              Text(
                "${currentTrack["genre"]}",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAudioSpectrum() {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: spLg, vertical: spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(30, (index) {
          double baseHeight = 20.0 + (index % 5) * 8;
          double animatedHeight = isPlaying ? baseHeight * (1.0 + (index % 3) * 0.3) : baseHeight * 0.3;
          
          return AnimatedContainer(
            duration: Duration(milliseconds: 200 + index * 30),
            width: 3,
            height: animatedHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  primaryColor,
                  primaryColor.withAlpha(isPlaying ? 204 : 77),
                ],
              ),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              color: Colors.white.withAlpha(26),
            ),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 6,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
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
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${currentTrack["duration"]}",
                style: TextStyle(
                  color: Colors.white.withAlpha(179),
                  fontSize: 14,
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
            size: 36,
            onTap: () {},
          ),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
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
                    color: primaryColor.withAlpha(77),
                    blurRadius: 25,
                    offset: Offset(0, 10),
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
            size: 36,
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
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withAlpha(51) : Colors.white.withAlpha(26),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isActive ? primaryColor.withAlpha(128) : Colors.white.withAlpha(51),
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

  Widget _buildVolumeSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: [
          Icon(
            Icons.volume_down,
            color: Colors.white.withAlpha(179),
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                activeTrackColor: primaryColor,
                inactiveTrackColor: Colors.white.withAlpha(51),
                thumbColor: primaryColor,
                overlayColor: primaryColor.withAlpha(51),
              ),
              child: Slider(
                value: volume,
                onChanged: (value) {
                  volume = value;
                  setState(() {});
                },
              ),
            ),
          ),
          SizedBox(width: spSm),
          Icon(
            Icons.volume_up,
            color: Colors.white.withAlpha(179),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildEqualizerSection() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.white.withAlpha(26),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Equalizer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Custom",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(equalizerValues.length, (index) {
              return Column(
                children: [
                  Container(
                    height: 100,
                    width: 20,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 8),
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: Colors.white.withAlpha(51),
                          thumbColor: primaryColor,
                          overlayColor: primaryColor.withAlpha(51),
                        ),
                        child: Slider(
                          value: equalizerValues[index],
                          onChanged: (value) {
                            equalizerValues[index] = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    equalizerLabels[index],
                    style: TextStyle(
                      color: Colors.white.withAlpha(128),
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(Icons.queue_music, "Queue", () {}),
          _buildActionButton(
            Icons.equalizer, 
            "EQ", 
            () {
              showEqualizer = !showEqualizer;
              setState(() {});
            },
            isActive: showEqualizer,
          ),
          _buildActionButton(Icons.airplay, "Cast", () {}),
          _buildActionButton(Icons.share, "Share", () {}),
          _buildActionButton(Icons.download, "Save", () {}),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap, {bool isActive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withAlpha(51) : Colors.white.withAlpha(26),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isActive ? primaryColor.withAlpha(128) : Colors.white.withAlpha(51),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? primaryColor : Colors.white.withAlpha(179),
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                color: isActive ? primaryColor : Colors.white.withAlpha(128),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueSection() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.white.withAlpha(26),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "Up Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${playQueue.length} tracks",
                  style: TextStyle(
                    color: Colors.white.withAlpha(128),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: playQueue.length,
            itemBuilder: (context, index) {
              final track = playQueue[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: (track["isPlaying"] as bool) ? primaryColor.withAlpha(26) : Colors.transparent,
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
                              color: (track["isPlaying"] as bool) ? primaryColor : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${track["artist"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(179),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${track["duration"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(128),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white.withAlpha(179),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: spSm),
        ],
      ),
    );
  }
}
