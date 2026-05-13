import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStory2View extends StatefulWidget {
  @override
  State<GrlStory2View> createState() => _GrlStory2ViewState();
}

class _GrlStory2ViewState extends State<GrlStory2View> {
  int currentStoryIndex = 0;
  int currentSlideIndex = 0;
  double progressValue = 0.0;
  bool isPaused = false;
  bool showDetails = false;

  Map<String, dynamic> currentStory = {
    "id": "1",
    "author": "Sarah Chen",
    "username": "@sarah_travels",
    "avatar": "https://picsum.photos/50/50?random=1&keyword=portrait",
    "isVerified": true,
    "timestamp": "2024-03-15T14:30:00Z",
    "content": [
      {
        "type": "image",
        "url": "https://picsum.photos/400/600?random=1&keyword=sunset",
        "caption": "Beautiful sunset in Santorini ✨",
        "duration": 5000
      },
      {
        "type": "image",
        "url": "https://picsum.photos/400/600?random=2&keyword=food",
        "caption": "Amazing Greek cuisine! This place serves the best moussaka I've ever had 🍽️",
        "duration": 5000
      },
      {
        "type": "image",
        "url": "https://picsum.photos/400/600?random=3&keyword=architecture",
        "caption": "Traditional Greek architecture never gets old",
        "duration": 5000
      },
      {
        "type": "image",
        "url": "https://picsum.photos/400/600?random=4&keyword=sea",
        "caption": "The blue sea is just perfect 🌊",
        "duration": 5000
      }
    ],
    "views": 234,
    "likes": 45,
    "isLiked": false,
    "location": "Santorini, Greece"
  };

  List<Map<String, dynamic>> viewers = [
    {
      "name": "Mike Johnson",
      "username": "@mike_dev", 
      "avatar": "https://picsum.photos/40/40?random=10&keyword=portrait",
      "viewedAt": "2024-03-15T14:35:00Z"
    },
    {
      "name": "Emma Wilson",
      "username": "@emma_design",
      "avatar": "https://picsum.photos/40/40?random=11&keyword=portrait", 
      "viewedAt": "2024-03-15T14:32:00Z"
    },
    {
      "name": "David Park",
      "username": "@david_photo",
      "avatar": "https://picsum.photos/40/40?random=12&keyword=portrait",
      "viewedAt": "2024-03-15T14:31:00Z"
    },
    {
      "name": "Lisa Rodriguez",
      "username": "@lisa_writes",
      "avatar": "https://picsum.photos/40/40?random=13&keyword=portrait",
      "viewedAt": "2024-03-15T14:30:00Z"
    },
  ];

  @override
  void initState() {
    super.initState();
    _startStoryProgress();
  }

  void _startStoryProgress() {
    // Simulate story progress
    Future.delayed(Duration(milliseconds: 100), () {
      if (!isPaused && mounted) {
        setState(() {
          progressValue += 0.02;
          if (progressValue >= 1.0) {
            _nextSlide();
          } else {
            _startStoryProgress();
          }
        });
      }
    });
  }

  void _nextSlide() {
    if (currentSlideIndex < (currentStory["content"] as List).length - 1) {
      setState(() {
        currentSlideIndex++;
        progressValue = 0.0;
      });
      _startStoryProgress();
    } else {
      // Story finished, go back
      back();
    }
  }

  void _previousSlide() {
    if (currentSlideIndex > 0) {
      setState(() {
        currentSlideIndex--;
        progressValue = 0.0;
      });
      _startStoryProgress();
    }
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
    if (!isPaused) {
      _startStoryProgress();
    }
  }

  void _toggleLike() {
    setState(() {
      currentStory["isLiked"] = !(currentStory["isLiked"] as bool);
      if (currentStory["isLiked"] as bool) {
        currentStory["likes"] = (currentStory["likes"] as int) + 1;
      } else {
        currentStory["likes"] = (currentStory["likes"] as int) - 1;
      }
    });
  }

  String _formatTime(String timestamp) {
    final now = DateTime.now();
    final time = DateTime.parse(timestamp);
    final difference = now.difference(time);

    if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSlide = (currentStory["content"] as List)[currentSlideIndex];
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            showDetails = false;
          });
        },
        onTapDown: (details) {
          setState(() {
            isPaused = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            isPaused = false;
          });
          _startStoryProgress();

          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _previousSlide();
          } else {
            _nextSlide();
          }
        },
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                "${currentSlide["url"]}",
                fit: BoxFit.cover,
              ),
            ),

            // Dark Overlay for better text visibility
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(102),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withAlpha(153),
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            // Progress Bars
            Positioned(
              top: MediaQuery.of(context).padding.top + spMd,
              left: spMd,
              right: spMd,
              child: Row(
                children: List.generate((currentStory["content"] as List).length, (index) {
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: EdgeInsets.only(right: index < (currentStory["content"] as List).length - 1 ? spXs : 0),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(102),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: index < currentSlideIndex ? 1.0 : (index == currentSlideIndex ? progressValue : 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Top Bar with Author Info
            Positioned(
              top: MediaQuery.of(context).padding.top + spLg + spMd,
              left: spMd,
              right: spMd,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage("${currentStory["avatar"]}"),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${currentStory["author"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            if (currentStory["isVerified"] as bool) ...[
                              SizedBox(width: spXs),
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: infoColor,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          _formatTime(currentStory["timestamp"]),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _togglePause,
                    child: Icon(
                      isPaused ? Icons.play_arrow : Icons.pause,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Action Bar
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + spLg,
              left: spMd,
              right: spMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Caption
                  if (currentSlide["caption"] != null && (currentSlide["caption"] as String).isNotEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(102),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${currentSlide["caption"]}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Location
                  if (currentStory["location"] != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.white.withAlpha(204),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${currentStory["location"]}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                  ],

                  // Action Buttons
                  Row(
                    children: [
                      // Like Button
                      GestureDetector(
                        onTap: _toggleLike,
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            (currentStory["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                            color: (currentStory["isLiked"] as bool) ? dangerColor : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),

                      // Share Button
                      GestureDetector(
                        onTap: () {
                          ss("Share story");
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),

                      // More Options
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showDetails = !showDetails;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),

                      Spacer(),

                      // Viewers Count
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showDetails = !showDetails;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 16,
                                color: Colors.white.withAlpha(204),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${currentStory["views"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Story Details Panel
            if (showDetails) ...[
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle Bar
                      Container(
                        margin: EdgeInsets.only(top: spMd),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: disabledBoldColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),

                      // Header
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Text(
                              "Story Details",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showDetails = false;
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Stats
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${currentStory["views"]}",
                                      style: TextStyle(
                                        fontSize: fsH4,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Views",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spMd),
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${currentStory["likes"]}",
                                      style: TextStyle(
                                        fontSize: fsH4,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                    Text(
                                      "Likes",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spLg),

                      // Viewers List
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spMd),
                        child: Row(
                          children: [
                            Text(
                              "Viewers",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${viewers.length} people",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),

                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: spMd),
                          itemCount: viewers.length,
                          itemBuilder: (context, index) {
                            final viewer = viewers[index];
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage("${viewer["avatar"]}"),
                                  ),
                                  SizedBox(width: spMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${viewer["name"]}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "${viewer["username"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    _formatTime(viewer["viewedAt"]),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
