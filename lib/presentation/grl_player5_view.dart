import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer5View extends StatefulWidget {
  @override
  State<GrlPlayer5View> createState() => _GrlPlayer5ViewState();
}

class _GrlPlayer5ViewState extends State<GrlPlayer5View> {
  String currentTrack = "summer-vibes.mp3";
  String currentArtist = "Chill Beats";
  String currentAlbum = "Sunset Sessions";
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeating = false;
  bool showLyrics = false;
  double currentPosition = 0.42;
  String currentTime = "1:45";
  String totalTime = "4:12";

  final List<Map<String, dynamic>> queue = [
    {
      "title": "Summer Vibes",
      "artist": "Chill Beats",
      "album": "Sunset Sessions",
      "duration": "4:12",
      "playing": true,
      "cover": "https://picsum.photos/300/300?random=1&keyword=summer",
    },
    {
      "title": "Golden Hour",
      "artist": "Lofi Dreams",
      "album": "Evening Moods", 
      "duration": "3:45",
      "playing": false,
      "cover": "https://picsum.photos/300/300?random=2&keyword=golden",
    },
    {
      "title": "Midnight Jazz",
      "artist": "Smooth Collective",
      "album": "Night Sessions",
      "duration": "5:20",
      "playing": false,
      "cover": "https://picsum.photos/300/300?random=3&keyword=jazz",
    },
    {
      "title": "Ocean Breeze",
      "artist": "Ambient Waves",
      "album": "Coastal Sounds",
      "duration": "6:15",
      "playing": false,
      "cover": "https://picsum.photos/300/300?random=4&keyword=ocean",
    },
  ];

  final List<String> lyrics = [
    "Waves are crashing on the shore",
    "Summer vibes and so much more",
    "Golden sunset in the sky",
    "Makes me feel like I can fly",
    "",
    "Dancing in the fading light",
    "Everything will be alright",
    "Music playing in my soul",
    "Rhythm taking full control",
    "",
    "This is our time to shine",
    "Leave the world behind",
    "In this moment we're divine",
    "Summer vibes so fine",
  ];

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _toggleShuffle() {
    isShuffled = !isShuffled;
    setState(() {});
  }

  void _toggleRepeat() {
    isRepeating = !isRepeating;
    setState(() {});
  }

  void _toggleLyrics() {
    showLyrics = !showLyrics;
    setState(() {});
  }

  void _playTrack(Map<String, dynamic> track) {
    currentTrack = "${track["title"]}.mp3";
    currentArtist = "${track["artist"]}";
    currentAlbum = "${track["album"]}";
    totalTime = "${track["duration"]}";
    isPlaying = true;
    currentPosition = 0.0;
    currentTime = "0:00";

    for (var item in queue) {
      item["playing"] = item["title"] == track["title"];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(30),
              Color(0xFF0F0F0F),
              Color(0xFF0F0F0F),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Playing from",
                          style: TextStyle(
                            color: Colors.white.withAlpha(120),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          currentAlbum,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
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
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: spMd),

                      // Album Art with Vinyl Effect
                      Container(
                        width: 300,
                        height: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Vinyl Background
                            Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1A1A),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withAlpha(40),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            // Vinyl Rings
                            Container(
                              width: 280,
                              height: 280,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withAlpha(20),
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              width: 240,
                              height: 240,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withAlpha(20),
                                  width: 1,
                                ),
                              ),
                            ),
                            // Album Cover
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  "https://picsum.photos/200/200?random=10&keyword=vinyl",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Center Hole
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF0F0F0F),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Track Info
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Column(
                          children: [
                            Text(
                              "Summer Vibes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              currentArtist,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withAlpha(180),
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.explicit,
                                  color: Colors.white.withAlpha(120),
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Pop • 2024",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(120),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Like",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(120),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(120),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.download,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                      color: Colors.white.withAlpha(120),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _toggleLyrics,
                              child: Column(
                                children: [
                                  Icon(
                                    showLyrics ? Icons.lyrics : Icons.lyrics_outlined,
                                    color: showLyrics ? primaryColor : Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "Lyrics",
                                    style: TextStyle(
                                      color: showLyrics 
                                          ? primaryColor 
                                          : Colors.white.withAlpha(120),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Progress Bar
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: Colors.white.withAlpha(40),
                                thumbColor: primaryColor,
                                overlayColor: primaryColor.withAlpha(40),
                              ),
                              child: Slider(
                                value: currentPosition,
                                onChanged: (value) {
                                  currentPosition = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentTime,
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(160),
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  totalTime,
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(160),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Control Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: _toggleShuffle,
                              child: Icon(
                                Icons.shuffle,
                                color: isShuffled ? primaryColor : Colors.white.withAlpha(120),
                                size: 28,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [primaryColor, primaryColor.withAlpha(200)],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withAlpha(60),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
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
                              child: Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            GestureDetector(
                              onTap: _toggleRepeat,
                              child: Icon(
                                Icons.repeat,
                                color: isRepeating ? primaryColor : Colors.white.withAlpha(120),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Lyrics or Queue
                      if (showLyrics) _buildLyricsSection() else _buildQueueSection(),

                      SizedBox(height: spXl),
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

  Widget _buildLyricsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.white.withAlpha(20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lyrics,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Lyrics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: _toggleLyrics,
                child: Icon(
                  Icons.close,
                  color: Colors.white.withAlpha(120),
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lyrics.asMap().entries.map((entry) {
                  int index = entry.key;
                  String line = entry.value;
                  
                  bool isCurrentLine = index >= 4 && index <= 7; // Simulate current verse
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Text(
                      line.isEmpty ? " " : line,
                      style: TextStyle(
                        color: isCurrentLine 
                            ? primaryColor 
                            : Colors.white.withAlpha(line.isEmpty ? 0 : 120),
                        fontSize: isCurrentLine ? 16 : 14,
                        fontWeight: isCurrentLine ? FontWeight.w600 : FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(
          color: Colors.white.withAlpha(20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.queue_music,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Next in Queue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${queue.length - 1} songs",
                style: TextStyle(
                  color: Colors.white.withAlpha(120),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...queue.skip(1).map((track) {
            return GestureDetector(
              onTap: () => _playTrack(track),
              child: Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${track["cover"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${track["title"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${track["artist"]} • ${track["album"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(120),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${track["duration"]}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(120),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.more_vert,
                      color: Colors.white.withAlpha(120),
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
