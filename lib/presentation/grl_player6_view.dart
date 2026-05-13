import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer6View extends StatefulWidget {
  @override
  State<GrlPlayer6View> createState() => _GrlPlayer6ViewState();
}

class _GrlPlayer6ViewState extends State<GrlPlayer6View> with TickerProviderStateMixin {
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeated = false;
  bool isLiked = false;
  double currentPosition = 0.6;
  double volume = 0.8;
  bool showQueue = false;
  
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  
  Map<String, dynamic> currentTrack = {
    "title": "Midnight Vibes",
    "artist": "Synthwave Collective",
    "album": "Neon Dreams",
    "duration": "3:47",
    "currentTime": "2:16",
    "artwork": "https://picsum.photos/350/350?random=20&keyword=neon",
    "year": "2024",
    "genre": "Synthwave",
    "bpm": "128",
    "key": "C Major",
  };

  List<Map<String, dynamic>> queue = [
    {
      "title": "Midnight Vibes",
      "artist": "Synthwave Collective",
      "duration": "3:47",
      "artwork": "https://picsum.photos/60/60?random=20&keyword=neon",
      "isPlaying": true,
    },
    {
      "title": "Cyber Dreams",
      "artist": "Synthwave Collective",
      "duration": "4:12",
      "artwork": "https://picsum.photos/60/60?random=21&keyword=cyber",
      "isPlaying": false,
    },
    {
      "title": "Electric Nights",
      "artist": "Neon Future",
      "duration": "3:35",
      "artwork": "https://picsum.photos/60/60?random=22&keyword=electric",
      "isPlaying": false,
    },
    {
      "title": "Digital Sunset",
      "artist": "Retro Wave",
      "duration": "4:58",
      "artwork": "https://picsum.photos/60/60?random=23&keyword=sunset",
      "isPlaying": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    if (isPlaying) {
      _rotationController.repeat();
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
              Color(0xFF2D3748),
            ],
          ),
        ),
        child: Stack(
          children: [
            _buildMainContent(),
            if (showQueue) _buildQueueOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildArtworkSection(),
          _buildTrackDetails(),
          _buildProgressSection(),
          _buildPlayerControls(),
          _buildVolumeControl(),
          _buildSecondaryControls(),
          SizedBox(height: spXl),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spSm),
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
                  color: Colors.white.withAlpha(51),
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
                    color: Colors.white.withAlpha(179),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${currentTrack["album"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                  color: Colors.white.withAlpha(51),
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
          // Outer glow effect
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 320 + (_pulseController.value * 20),
                height: 320 + (_pulseController.value * 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withAlpha((77 * _pulseController.value).round()),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          // Main artwork
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * 3.14159,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(128),
                        blurRadius: 30,
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
              );
            },
          ),
          // Center hole
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1B263B),
              border: Border.all(
                color: Colors.white.withAlpha(51),
                width: 2,
              ),
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withAlpha(179),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackDetails() {
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
                        fontSize: 26,
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
          SizedBox(height: spMd),
          Row(
            children: [
              _buildInfoChip("${currentTrack["genre"]}", Icons.music_note),
              SizedBox(width: spSm),
              _buildInfoChip("${currentTrack["bpm"]} BPM", Icons.speed),
              SizedBox(width: spSm),
              _buildInfoChip("${currentTrack["key"]}", Icons.piano),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.white.withAlpha(51),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 14,
          ),
          SizedBox(width: spXs),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withAlpha(179),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
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
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              color: Colors.white.withAlpha(26),
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
          GestureDetector(
            onTap: () {
              isShuffled = !isShuffled;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isShuffled ? primaryColor.withAlpha(51) : Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isShuffled ? primaryColor.withAlpha(128) : Colors.white.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.shuffle,
                color: isShuffled ? primaryColor : Colors.white.withAlpha(179),
                size: 20,
              ),
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
                  color: Colors.white.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              isPlaying = !isPlaying;
              if (isPlaying) {
                _rotationController.repeat();
                _pulseController.repeat(reverse: true);
              } else {
                _rotationController.stop();
                _pulseController.stop();
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
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: Colors.white.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              isRepeated = !isRepeated;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isRepeated ? primaryColor.withAlpha(51) : Colors.white.withAlpha(26),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isRepeated ? primaryColor.withAlpha(128) : Colors.white.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.repeat,
                color: isRepeated ? primaryColor : Colors.white.withAlpha(179),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeControl() {
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

  Widget _buildSecondaryControls() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(Icons.airplay, "AirPlay", () {}),
          _buildControlButton(Icons.queue_music, "Queue", () {
            showQueue = true;
            setState(() {});
          }),
          _buildControlButton(Icons.equalizer, "EQ", () {}),
          _buildControlButton(Icons.share, "Share", () {}),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(26),
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: Colors.white.withAlpha(51),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withAlpha(179),
              size: 20,
            ),
            SizedBox(height: spXs),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withAlpha(128),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueOverlay() {
    return Container(
      color: Colors.black.withAlpha(128),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(spMd, MediaQuery.of(context).padding.top + spSm, spMd, spSm),
            decoration: BoxDecoration(
              color: Color(0xFF1B263B),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showQueue = false;
                    setState(() {});
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Queue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFF0D1B2A),
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  final track = queue[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (track["isPlaying"] as bool) ? primaryColor.withAlpha(26) : Colors.white.withAlpha(13),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: (track["isPlaying"] as bool) ? primaryColor.withAlpha(77) : Colors.white.withAlpha(26),
                        width: 1,
                      ),
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
                        Icon(
                          Icons.drag_handle,
                          color: Colors.white.withAlpha(128),
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
