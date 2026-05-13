import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPlayer4View extends StatefulWidget {
  @override
  State<GrlPlayer4View> createState() => _GrlPlayer4ViewState();
}

class _GrlPlayer4ViewState extends State<GrlPlayer4View> {
  bool isPlaying = true;
  bool isLiked = false;
  bool isShuffled = false;
  bool isRepeat = false;
  double currentPosition = 142.0;
  double totalDuration = 205.0;
  bool showQueue = false;
  int selectedTrack = 0;

  List<Map<String, dynamic>> queue = [
    {
      "title": "Midnight Drive",
      "artist": "Synthwave Collective",
      "duration": "3:25",
      "artwork": "https://picsum.photos/80/80?random=1&keyword=music",
      "isPlaying": true,
    },
    {
      "title": "Neon Dreams",
      "artist": "Electric Nights",
      "duration": "4:12",
      "artwork": "https://picsum.photos/80/80?random=2&keyword=music",
      "isPlaying": false,
    },
    {
      "title": "Digital Horizon",
      "artist": "Future Bass",
      "duration": "3:48",
      "artwork": "https://picsum.photos/80/80?random=3&keyword=music",
      "isPlaying": false,
    },
    {
      "title": "City Lights",
      "artist": "Urban Vibes",
      "duration": "4:03",
      "artwork": "https://picsum.photos/80/80?random=4&keyword=music",
      "isPlaying": false,
    },
    {
      "title": "Cosmic Journey",
      "artist": "Space Ambient",
      "duration": "5:21",
      "artwork": "https://picsum.photos/80/80?random=5&keyword=music",
      "isPlaying": false,
    },
  ];

  String _formatDuration(double seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = (seconds % 60).floor();
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Top Section with Artwork and Controls
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade900,
                    Colors.black,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => back(),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "PLAYING FROM PLAYLIST",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(179),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                "Synthwave Essentials",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                    
                    SizedBox(height: spLg),
                    
                    // Album Artwork
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(128),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "https://picsum.photos/400/400?random=10&keyword=synthwave",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Track Info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${queue[selectedTrack]["title"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${queue[selectedTrack]["artist"]}",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(179),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            isLiked = !isLiked;
                            setState(() {});
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.green : Colors.white.withAlpha(179),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom Section with Controls and Queue
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
              ),
              child: Column(
                children: [
                  // Progress Bar
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white.withAlpha(77),
                          thumbColor: Colors.white,
                          overlayColor: Colors.white.withAlpha(77),
                        ),
                        child: Slider(
                          value: currentPosition,
                          max: totalDuration,
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
                            _formatDuration(currentPosition),
                            style: TextStyle(
                              color: Colors.white.withAlpha(179),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatDuration(totalDuration),
                            style: TextStyle(
                              color: Colors.white.withAlpha(179),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Media Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isShuffled = !isShuffled;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.shuffle,
                          color: isShuffled ? Colors.green : Colors.white.withAlpha(179),
                          size: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectedTrack > 0) {
                            selectedTrack--;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isPlaying = !isPlaying;
                          setState(() {});
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectedTrack < queue.length - 1) {
                            selectedTrack++;
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isRepeat = !isRepeat;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.repeat,
                          color: isRepeat ? Colors.green : Colors.white.withAlpha(179),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Queue Toggle and Mini Queue
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showQueue = !showQueue;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.queue_music,
                              color: Colors.white.withAlpha(179),
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Queue",
                              style: TextStyle(
                                color: Colors.white.withAlpha(179),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.devices,
                          color: Colors.white.withAlpha(179),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.share,
                          color: Colors.white.withAlpha(179),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: showQueue ? Container(
        height: 300,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Playing Queue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showQueue = false;
                    setState(() {});
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white.withAlpha(179),
                    size: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  final track = queue[index];
                  bool isCurrentTrack = index == selectedTrack;
                  return GestureDetector(
                    onTap: () {
                      selectedTrack = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: isCurrentTrack ? Colors.white.withAlpha(26) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${track["artwork"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
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
                                    color: isCurrentTrack ? Colors.green : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${track["artist"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(179),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${track["duration"]}",
                            style: TextStyle(
                              color: Colors.white.withAlpha(179),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (isCurrentTrack)
                            Icon(
                              Icons.equalizer,
                              color: Colors.green,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ) : null,
    );
  }
}
