import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaVideoPlayerView extends StatefulWidget {
  const NmaVideoPlayerView({super.key});

  @override
  State<NmaVideoPlayerView> createState() => _NmaVideoPlayerViewState();
}

class _NmaVideoPlayerViewState extends State<NmaVideoPlayerView> {
  bool isPlaying = false;
  bool isMuted = false;
  bool showControls = true;
  double currentPosition = 0.0;
  double videoDuration = 1545.0; // 25:45 minutes in seconds
  double playbackSpeed = 1.0;
  double volume = 0.8;
  bool isFullscreen = false;
  bool showSettings = false;
  String videoQuality = "720p";

  Map<String, dynamic> videoData = {
    "id": "1",
    "title": "Advanced Social Media Marketing Strategies",
    "description": "Learn advanced techniques to boost your social media presence and engagement rates. This comprehensive tutorial covers everything from content planning to audience engagement strategies.",
    "instructor": "Sarah Johnson",
    "duration": "25:45",
    "views": 15420,
    "rating": 4.8,
    "uploadDate": "2024-01-10",
    "thumbnail": "https://picsum.photos/800/450?random=1&keyword=marketing",
    "tags": ["social media", "marketing", "strategy"],
    "isPremium": true,
  };

  List<Map<String, dynamic>> chapters = [
    {"title": "Introduction", "startTime": 0, "duration": 120},
    {"title": "Content Strategy", "startTime": 120, "duration": 300},
    {"title": "Audience Analysis", "startTime": 420, "duration": 240},
    {"title": "Engagement Tactics", "startTime": 660, "duration": 360},
    {"title": "Analytics & Optimization", "startTime": 1020, "duration": 525},
  ];

  List<Map<String, dynamic>> playbackSpeeds = [
    {"label": "0.5x", "value": 0.5},
    {"label": "0.75x", "value": 0.75},
    {"label": "Normal", "value": 1.0},
    {"label": "1.25x", "value": 1.25},
    {"label": "1.5x", "value": 1.5},
    {"label": "2x", "value": 2.0},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Auto", "value": "auto"},
    {"label": "1080p", "value": "1080p"},
    {"label": "720p", "value": "720p"},
    {"label": "480p", "value": "480p"},
    {"label": "360p", "value": "360p"},
  ];

  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "user": "Mike Chen",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "comment": "Great tutorial! Really helped me understand content strategy better.",
      "timestamp": "2 hours ago",
      "likes": 12,
    },
    {
      "id": "2",
      "user": "Emma Rodriguez",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "comment": "The analytics section was particularly useful. Thank you!",
      "timestamp": "5 hours ago",
      "likes": 8,
    },
    {
      "id": "3",
      "user": "David Park",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "comment": "Could you make a follow-up video about advanced analytics?",
      "timestamp": "1 day ago",
      "likes": 15,
    },
  ];

  String newComment = "";

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    // Simulate video initialization
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // Player initialized
      });
    });
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Video Player Area
            Expanded(
              flex: isFullscreen ? 1 : 2,
              child: Container(
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  children: [
                    // Video Content (placeholder)
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${videoData["thumbnail"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                          ),
                        ),
                      ),
                    ),
                    
                    // Video Controls Overlay
                    if (showControls)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withAlpha(150),
                              Colors.transparent,
                              Colors.black.withAlpha(150),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            // Top Controls
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back, color: Colors.white),
                                    onPressed: () {
                                      //navigateTo back
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${videoData["title"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.cast, color: Colors.white),
                                    onPressed: () {
                                      // Cast to device
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.more_vert, color: Colors.white),
                                    onPressed: () {
                                      // Show more options
                                    },
                                  ),
                                ],
                              ),
                            ),
                            
                            Spacer(),
                            
                            // Center Play/Pause Button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: primaryColor,
                                  size: 48,
                                ),
                              ),
                            ),
                            
                            Spacer(),
                            
                            // Bottom Controls
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  // Progress Bar
                                  Row(
                                    children: [
                                      Text(
                                        _formatDuration(currentPosition),
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      Expanded(
                                        child: Slider(
                                          value: currentPosition,
                                          max: videoDuration,
                                          activeColor: primaryColor,
                                          inactiveColor: Colors.white.withAlpha(100),
                                          onChanged: (value) {
                                            setState(() {
                                              currentPosition = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(videoDuration),
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  
                                  // Control Buttons
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.replay_10, color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            currentPosition = (currentPosition - 10).clamp(0, videoDuration);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isPlaying ? Icons.pause : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPlaying = !isPlaying;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.forward_10, color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            currentPosition = (currentPosition + 10).clamp(0, videoDuration);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isMuted ? Icons.volume_off : Icons.volume_up,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isMuted = !isMuted;
                                          });
                                        },
                                      ),
                                      
                                      Spacer(),
                                      
                                      Text(
                                        "${playbackSpeed}x",
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      SizedBox(width: spXs),
                                      IconButton(
                                        icon: Icon(Icons.settings, color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            showSettings = !showSettings;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isFullscreen = !isFullscreen;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    // Settings Panel
                    if (showSettings)
                      Positioned(
                        right: spSm,
                        bottom: 80,
                        child: Container(
                          width: 200,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(220),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Text(
                                "Playback Speed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              ...playbackSpeeds.map((speed) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      playbackSpeed = speed["value"] as double;
                                      showSettings = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          playbackSpeed == speed["value"]
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${speed["label"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              
                              Divider(color: Colors.white.withAlpha(50)),
                              
                              Text(
                                "Quality",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              ...qualityOptions.map((quality) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      videoQuality = quality["value"] as String;
                                      showSettings = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Icon(
                                          videoQuality == quality["value"]
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_unchecked,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${quality["label"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Video Info and Comments (only show when not fullscreen)
            if (!isFullscreen)
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spMd,
                      children: [
                        // Video Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${videoData["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Row(
                              children: [
                                Text(
                                  "${((videoData["views"] as int) / 1000).toStringAsFixed(1)}K views",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "•",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${videoData["uploadDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: warningColor, size: 16),
                                    SizedBox(width: 2),
                                    Text(
                                      "${videoData["rating"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            Text(
                              "By ${videoData["instructor"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            
                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (videoData["tags"] as List<String>).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: secondaryColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                icon: Icons.thumb_up,
                                label: "Like",
                                size: bs.sm,
                                onPressed: () {
                                  // Like video
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                icon: Icons.bookmark,
                                label: "Save",
                                size: bs.sm,
                                onPressed: () {
                                  // Save to playlist
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                icon: Icons.share,
                                label: "Share",
                                size: bs.sm,
                                onPressed: () {
                                  // Share video
                                },
                              ),
                            ),
                          ],
                        ),
                        
                        // Description
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${videoData["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.5,
                          ),
                        ),
                        
                        // Chapters
                        Text(
                          "Chapters",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: chapters.length,
                          itemBuilder: (context, index) {
                            final chapter = chapters[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _formatDuration((chapter["startTime"] as int).toDouble()),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${chapter["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.play_arrow, color: primaryColor, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        currentPosition = (chapter["startTime"] as int).toDouble();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        
                        // Comments Section
                        Text(
                          "Comments (${comments.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        
                        // Add Comment
                        Row(
                          children: [
                            Expanded(
                              child: QTextField(
                                label: "Write a comment...",
                                value: newComment,
                                onChanged: (value) {
                                  newComment = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Post",
                              size: bs.sm,
                              onPressed: () {
                                if (newComment.isNotEmpty) {
                                  // Post comment
                                  newComment = "";
                                  setState(() {});
                                  ss("Comment posted successfully!");
                                }
                              },
                            ),
                          ],
                        ),
                        
                        // Comments List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: spSm),
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: disabledOutlineBorderColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage("${comment["avatar"]}"),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${comment["user"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              "${comment["timestamp"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.thumb_up, size: 14, color: disabledBoldColor),
                                          SizedBox(width: 2),
                                          Text(
                                            "${comment["likes"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${comment["comment"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
