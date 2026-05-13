import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCoursePreviewView extends StatefulWidget {
  const ElaCoursePreviewView({super.key});

  @override
  State<ElaCoursePreviewView> createState() => _ElaCoursePreviewViewState();
}

class _ElaCoursePreviewViewState extends State<ElaCoursePreviewView> {
  int currentVideoIndex = 0;
  bool isPlaying = false;
  double videoProgress = 0.35;
  bool isFullscreen = false;
  double playbackSpeed = 1.0;
  bool subtitlesEnabled = true;
  String videoQuality = "720p";

  Map<String, dynamic> course = {
    "title": "Complete Flutter Development Masterclass",
    "instructor": "Dr. Sarah Johnson",
    "rating": 4.8,
    "students": 12543,
    "duration": "12h 45m",
    "level": "Intermediate",
    "price": 89.99,
    "originalPrice": 199.99,
    "discount": 55,
    "thumbnail": "https://picsum.photos/400/300?random=1&keyword=coding",
    "description": "Master Flutter development from basics to advanced concepts. Build real-world apps with clean architecture, state management, and best practices.",
    "whatYouLearn": [
      "Build professional Flutter applications",
      "Master state management with Provider and Bloc",
      "Implement clean architecture patterns",
      "Connect to REST APIs and databases",
      "Deploy apps to App Store and Google Play",
      "Advanced animation and custom widgets"
    ],
    "requirements": [
      "Basic programming knowledge",
      "Computer with Flutter SDK installed",
      "Willingness to learn and practice"
    ]
  };

  List<Map<String, dynamic>> previewVideos = [
    {
      "title": "Course Introduction",
      "duration": "03:45",
      "description": "Overview of what you'll learn in this comprehensive Flutter course",
      "isLocked": false,
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=intro",
    },
    {
      "title": "Setting Up Your Development Environment",
      "duration": "08:20",
      "description": "Step-by-step guide to installing Flutter and setting up your IDE",
      "isLocked": false,
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=setup",
    },
    {
      "title": "Building Your First App",
      "duration": "15:30",
      "description": "Create a simple but functional Flutter application from scratch",
      "isLocked": true,
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=app",
    },
    {
      "title": "Understanding State Management",
      "duration": "12:15",
      "description": "Deep dive into different state management approaches in Flutter",
      "isLocked": true,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=state",
    },
  ];

  List<Map<String, dynamic>> relatedCourses = [
    {
      "title": "Advanced Flutter Animations",
      "instructor": "Mike Chen",
      "rating": 4.7,
      "price": 79.99,
      "students": 8934,
      "thumbnail": "https://picsum.photos/200/120?random=6&keyword=animation",
    },
    {
      "title": "Flutter for Web Development",
      "instructor": "Lisa Park",
      "rating": 4.6,
      "price": 69.99,
      "students": 6721,
      "thumbnail": "https://picsum.photos/200/120?random=7&keyword=web",
    },
    {
      "title": "Flutter Testing Masterclass",
      "instructor": "John Smith",
      "rating": 4.9,
      "price": 59.99,
      "students": 4532,
      "thumbnail": "https://picsum.photos/200/120?random=8&keyword=testing",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Preview"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareContent(),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () => _toggleWishlist(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildVideoPlayer(),
            _buildVideoControls(),
            _buildCourseInfo(),
            _buildPreviewLessons(),
            _buildCourseContent(),
            _buildRelatedCourses(),
            _buildEnrollmentCTA(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: isFullscreen ? MediaQuery.of(context).size.height : 220,
      color: Colors.black,
      child: Stack(
        children: [
          // Video thumbnail/player area
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${course["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withAlpha(100),
              child: Center(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Video progress bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              child: LinearProgressIndicator(
                value: videoProgress,
                backgroundColor: Colors.white.withAlpha(60),
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
          // Fullscreen toggle
          Positioned(
            top: spMd,
            right: spMd,
            child: GestureDetector(
              onTap: _toggleFullscreen,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(150),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.grey[100],
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.speed, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "${playbackSpeed}x",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.high_quality, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  videoQuality,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: spSm),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: subtitlesEnabled ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: subtitlesEnabled ? primaryColor : disabledOutlineBorderColor,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.subtitles,
                  size: 16,
                  color: subtitlesEnabled ? Colors.white : disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "CC",
                  style: TextStyle(
                    fontSize: 12,
                    color: subtitlesEnabled ? Colors.white : disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "${(videoProgress * 100).toInt()}% completed",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "${course["title"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${course["instructor"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.star, color: warningColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${course["rating"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.group, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${course["students"]} students",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${course["level"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${course["duration"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              if (course["discount"] != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${course["discount"]}% OFF",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Text(
                "\$${((course["price"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              if (course["originalPrice"] != null) ...[
                SizedBox(width: spSm),
                Text(
                  "\$${((course["originalPrice"] as num).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          Text(
            "${course["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewLessons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Preview Lessons",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: previewVideos.map((video) {
              bool isCurrentVideo = previewVideos.indexOf(video) == currentVideoIndex;
              return Container(
                decoration: BoxDecoration(
                  color: isCurrentVideo ? primaryColor.withAlpha(20) : Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isCurrentVideo ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${video["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          if (video["isLocked"] as bool)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(100),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Icon(
                                  isCurrentVideo && isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "${video["duration"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "${video["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${video["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!(video["isLocked"] as bool))
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: QButton(
                          icon: isCurrentVideo && isPlaying ? Icons.pause : Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () => _playVideo(previewVideos.indexOf(video)),
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

  Widget _buildCourseContent() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "What You'll Learn",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: (course["whatYouLearn"] as List).map((item) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$item",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Text(
            "Requirements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: (course["requirements"] as List).map((item) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, color: disabledBoldColor, size: 8),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$item",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedCourses() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Related Courses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: relatedCourses.map((course) {
              return Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                        image: DecorationImage(
                          image: NetworkImage("${course["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${course["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${course["instructor"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 14),
                              SizedBox(width: spXs),
                              Text(
                                "${course["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "(${course["students"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\$${((course["price"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
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

  Widget _buildEnrollmentCTA() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        border: Border(
          top: BorderSide(color: primaryColor),
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${((course["price"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (course["originalPrice"] != null)
                      Text(
                        "Save \$${(((course["originalPrice"] as num) - (course["price"] as num)).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
              QButton(
                label: "Enroll Now",
                size: bs.md,
                onPressed: _enrollInCourse,
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Add to Cart",
                  icon: Icons.shopping_cart,
                  size: bs.sm,
                  onPressed: _addToCart,
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Try Free",
                  icon: Icons.play_circle,
                  size: bs.sm,
                  onPressed: _startFreeTrial,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _togglePlayPause() {
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _toggleFullscreen() {
    isFullscreen = !isFullscreen;
    setState(() {});
  }

  void _playVideo(int index) {
    currentVideoIndex = index;
    isPlaying = true;
    setState(() {});
  }

  void _shareContent() {
    si("Sharing course...");
  }

  void _toggleWishlist() {
    si("Added to wishlist!");
  }

  void _enrollInCourse() {
    ss("Enrolled in course successfully!");
  }

  void _addToCart() {
    ss("Course added to cart!");
  }

  void _startFreeTrial() {
    si("Starting free trial...");
  }
}
