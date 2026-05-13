import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer2View extends StatefulWidget {
  @override
  State<GrlPlayer2View> createState() => _GrlPlayer2ViewState();
}

class _GrlPlayer2ViewState extends State<GrlPlayer2View> {
  String currentTrack = "electronic-dreams.mp3";
  String currentArtist = "SynthWave Studio";
  String currentAlbum = "Neon Nights";
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeating = false;
  double currentPosition = 0.35;
  double volume = 0.7;
  String currentTime = "2:45";
  String totalTime = "7:23";

  final List<Map<String, dynamic>> playlist = [
    {
      "title": "Electronic Dreams",
      "artist": "SynthWave Studio",
      "album": "Neon Nights",
      "duration": "7:23",
      "playing": true,
      "artwork": "https://picsum.photos/300/300?random=1&keyword=music",
    },
    {
      "title": "Midnight Drive",
      "artist": "Retro Beats",
      "album": "City Lights",
      "duration": "5:45",
      "playing": false,
      "artwork": "https://picsum.photos/300/300?random=2&keyword=city",
    },
    {
      "title": "Cyberpunk Nights",
      "artist": "Digital Dreams",
      "album": "Future Sound",
      "duration": "6:12",
      "playing": false,
      "artwork": "https://picsum.photos/300/300?random=3&keyword=cyber",
    },
    {
      "title": "Ocean Waves",
      "artist": "Nature Sounds",
      "album": "Relaxation",
      "duration": "8:30",
      "playing": false,
      "artwork": "https://picsum.photos/300/300?random=4&keyword=ocean",
    },
    {
      "title": "Jazz Cafe",
      "artist": "Smooth Jazz Collective",
      "album": "Evening Vibes",
      "duration": "4:20",
      "playing": false,
      "artwork": "https://picsum.photos/300/300?random=5&keyword=cafe",
    },
  ];

  final List<Map<String, dynamic>> recentTracks = [
    {
      "title": "Summer Breeze",
      "artist": "Acoustic Dreams",
      "duration": "3:45",
      "lastPlayed": "2 hours ago",
    },
    {
      "title": "Electric Storm",
      "artist": "Thunder Sound",
      "duration": "5:20",
      "lastPlayed": "Yesterday",
    },
    {
      "title": "Peaceful Mind",
      "artist": "Meditation Music",
      "duration": "12:00",
      "lastPlayed": "2 days ago",
    },
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

  void _playTrack(Map<String, dynamic> track) {
    currentTrack = "${track["title"]}.mp3";
    currentArtist = "${track["artist"]}";
    currentAlbum = "${track["album"]}";
    isPlaying = true;
    currentPosition = 0.0;

    // Update playlist
    for (var item in playlist) {
      item["playing"] = item["title"] == track["title"];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(40),
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
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
                    Text(
                      "Now Playing",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: spMd),
                  child: Column(
                    children: [
                      SizedBox(height: spLg),

                      // Album Artwork
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withAlpha(60),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "https://picsum.photos/280/280?random=10&keyword=vinyl",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: spXl),

                      // Track Info
                      Column(
                        children: [
                          Text(
                            "Electronic Dreams",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            currentArtist,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withAlpha(180),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            currentAlbum,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withAlpha(120),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spXl),

                      // Progress Bar
                      Column(
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spMd),
                            child: Row(
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
                          ),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // Control Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _toggleShuffle,
                            child: Icon(
                              Icons.shuffle,
                              color: isShuffled ? primaryColor : Colors.white.withAlpha(120),
                              size: 24,
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
                                color: primaryColor,
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
                              size: 24,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spXl),

                      // Volume Control
                      Row(
                        children: [
                          Icon(
                            Icons.volume_down,
                            color: Colors.white.withAlpha(120),
                            size: 20,
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.white.withAlpha(40),
                                thumbColor: Colors.white,
                                overlayColor: Colors.white.withAlpha(40),
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
                          Icon(
                            Icons.volume_up,
                            color: Colors.white.withAlpha(120),
                            size: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: spXl),

                      // Queue Section
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.queue_music,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Up Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${playlist.length - 1} songs",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(120),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            ...playlist.skip(1).take(3).map((track) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spSm),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        child: Image.network(
                                          "${track["artwork"]}",
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${track["artist"]}",
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
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),

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
}
