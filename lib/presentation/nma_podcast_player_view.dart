import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaPodcastPlayerView extends StatefulWidget {
  const NmaPodcastPlayerView({super.key});

  @override
  State<NmaPodcastPlayerView> createState() => _NmaPodcastPlayerViewState();
}

class _NmaPodcastPlayerViewState extends State<NmaPodcastPlayerView> {
  bool isPlaying = true;
  bool isShuffled = false;
  bool isRepeating = false;
  double currentPosition = 8.5; // in minutes
  double totalDuration = 28.75; // in minutes
  double playbackSpeed = 1.0;
  double volume = 0.8;
  bool showQueue = false;

  Map<String, dynamic> currentEpisode = {
    "id": "ep001",
    "title": "Fed Policy Impact on Tech Stocks",
    "description": "Analyzing how the Federal Reserve's latest policy changes are affecting technology sector valuations and what investors should watch for in the coming quarters.",
    "duration": "28:45",
    "podcastTitle": "The Daily Finance Report",
    "host": "Sarah Mitchell",
    "publishedAt": "2 hours ago",
    "season": 5,
    "episode": 15,
    "image": "https://picsum.photos/400/400?random=1&keyword=finance-podcast",
    "podcastImage": "https://picsum.photos/300/300?random=1&keyword=finance"
  };

  List<Map<String, dynamic>> upNext = [
    {
      "id": "ep002",
      "title": "Q4 Earnings Preview: Key Companies to Watch",
      "description": "A comprehensive look at the most important earnings reports coming this week.",
      "duration": "32:12",
      "podcastTitle": "The Daily Finance Report",
      "host": "Sarah Mitchell",
      "image": "https://picsum.photos/300/300?random=2&keyword=earnings"
    },
    {
      "id": "ep003",
      "title": "Cryptocurrency Market Analysis: Bitcoin ETF Impact",
      "description": "Deep dive into how the approval of Bitcoin ETFs is reshaping the cryptocurrency landscape.",
      "duration": "25:30",
      "podcastTitle": "The Daily Finance Report",
      "host": "Sarah Mitchell",
      "image": "https://picsum.photos/300/300?random=3&keyword=bitcoin"
    },
    {
      "id": "ep004",
      "title": "Real Estate Investment Trusts: Market Outlook",
      "description": "Examining REIT performance in the current interest rate environment.",
      "duration": "29:18",
      "podcastTitle": "The Daily Finance Report",
      "host": "Sarah Mitchell",
      "image": "https://picsum.photos/300/300?random=4&keyword=real-estate"
    }
  ];

  List<double> speedOptions = [0.75, 1.0, 1.25, 1.5, 2.0];

  String _formatTime(double minutes) {
    final totalSeconds = (minutes * 60).round();
    final mins = totalSeconds ~/ 60;
    final secs = totalSeconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _skipForward() {
    currentPosition = (currentPosition + 0.5).clamp(0.0, totalDuration);
    setState(() {});
  }

  void _skipBackward() {
    currentPosition = (currentPosition - 0.5).clamp(0.0, totalDuration);
    setState(() {});
  }

  void _changeSpeed() {
    final currentIndex = speedOptions.indexOf(playbackSpeed);
    final nextIndex = (currentIndex + 1) % speedOptions.length;
    playbackSpeed = speedOptions[nextIndex];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = currentPosition / totalDuration;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withAlpha(50),
              Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () => back(),
                    ),
                    Column(
                      children: [
                        Text(
                          "NOW PLAYING",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          "${currentEpisode["podcastTitle"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        // Show more options
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: spLg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Episode Artwork
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowLg],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${currentEpisode["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: spLg),

                      // Episode Info
                      Column(
                        children: [
                          Text(
                            "${currentEpisode["title"]}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${currentEpisode["host"]}",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "S${currentEpisode["season"]}E${currentEpisode["episode"]} • ${currentEpisode["publishedAt"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // Progress Bar
                      Column(
                        children: [
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatTime(currentPosition),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                _formatTime(totalDuration),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // Playback Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Shuffle
                          IconButton(
                            icon: Icon(
                              Icons.shuffle,
                              color: isShuffled ? primaryColor : disabledBoldColor,
                              size: 24,
                            ),
                            onPressed: () {
                              isShuffled = !isShuffled;
                              setState(() {});
                            },
                          ),

                          // Previous Episode
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              color: primaryColor,
                              size: 32,
                            ),
                            onPressed: () {
                              // Previous episode
                            },
                          ),

                          // Rewind 15s
                          IconButton(
                            icon: Icon(
                              Icons.replay,
                              color: primaryColor,
                              size: 28,
                            ),
                            onPressed: _skipBackward,
                          ),

                          // Play/Pause
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [shadowMd],
                              ),
                              child: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),

                          // Forward 15s
                          IconButton(
                            icon: Icon(
                              Icons.forward,
                              color: primaryColor,
                              size: 28,
                            ),
                            onPressed: _skipForward,
                          ),

                          // Next Episode
                          IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              color: primaryColor,
                              size: 32,
                            ),
                            onPressed: () {
                              // Next episode
                            },
                          ),

                          // Repeat
                          IconButton(
                            icon: Icon(
                              Icons.repeat,
                              color: isRepeating ? primaryColor : disabledBoldColor,
                              size: 24,
                            ),
                            onPressed: () {
                              isRepeating = !isRepeating;
                              setState(() {});
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: spLg),

                      // Additional Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Speed Control
                          GestureDetector(
                            onTap: _changeSpeed,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${playbackSpeed}x",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),

                          // Volume Control
                          Row(
                            children: [
                              Icon(
                                Icons.volume_down,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 100,
                                child: Slider(
                                  value: volume,
                                  onChanged: (value) {
                                    volume = value;
                                    setState(() {});
                                  },
                                  activeColor: primaryColor,
                                  inactiveColor: Colors.grey.shade300,
                                ),
                              ),
                              Icon(
                                Icons.volume_up,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                            ],
                          ),

                          // Queue
                          GestureDetector(
                            onTap: () {
                              showQueue = !showQueue;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: showQueue ? primaryColor.withAlpha(50) : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.queue_music,
                                color: showQueue ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Up Next Queue (Collapsible)
              if (showQueue) ...[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                    boxShadow: [shadowLg],
                  ),
                  child: Column(
                    children: [
                      // Queue Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Up Next",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${upNext.length} episodes",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Queue List
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          child: Column(
                            spacing: spSm,
                            children: upNext.map((episode) {
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    // Episode Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusXs),
                                      child: Image.network(
                                        "${episode["image"]}",
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: spSm),

                                    // Episode Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${episode["title"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${episode["description"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${episode["duration"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Play Button
                                    IconButton(
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: primaryColor,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        // Play this episode
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Action Bar
                Container(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.bookmark_border,
                          color: disabledBoldColor,
                          size: 28,
                        ),
                        onPressed: () {
                          // Add to bookmarks
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.download,
                          color: disabledBoldColor,
                          size: 28,
                        ),
                        onPressed: () {
                          // Download episode
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: disabledBoldColor,
                          size: 28,
                        ),
                        onPressed: () {
                          // Share episode
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.bedtime,
                          color: disabledBoldColor,
                          size: 28,
                        ),
                        onPressed: () {
                          // Set sleep timer
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
