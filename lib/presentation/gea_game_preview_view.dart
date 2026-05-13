import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGamePreviewView extends StatefulWidget {
  const GeaGamePreviewView({super.key});

  @override
  State<GeaGamePreviewView> createState() => _GeaGamePreviewViewState();
}

class _GeaGamePreviewViewState extends State<GeaGamePreviewView> {
  bool isPlaying = false;
  bool isMuted = false;
  bool isFullscreen = false;
  double currentTime = 0.0;
  double totalTime = 180.0; // 3 minutes

  Map<String, dynamic> gamePreview = {
    "id": 1,
    "title": "Cyberpunk Adventures",
    "developer": "NeonStudio",
    "genre": "Action RPG",
    "rating": 4.8,
    "trailerUrl": "https://picsum.photos/800/450?random=1&keyword=cyberpunk",
    "thumbnailUrl": "https://picsum.photos/800/450?random=2&keyword=gaming",
    "duration": "3:00",
    "views": 1250000,
    "likes": 98500,
    "description": "Get an exclusive first look at the most anticipated cyberpunk game of the year. Experience the neon-lit streets, intense combat, and immersive storyline that will redefine the genre.",
    "uploadDate": "2024-05-15",
    "quality": "4K HDR",
    "chapters": [
      {"title": "Introduction", "startTime": 0, "duration": 30},
      {"title": "Gameplay Overview", "startTime": 30, "duration": 60},
      {"title": "Character Creation", "startTime": 90, "duration": 45},
      {"title": "Combat System", "startTime": 135, "duration": 45},
    ],
  };

  List<Map<String, dynamic>> relatedVideos = [
    {
      "id": 2,
      "title": "Behind the Scenes: Development",
      "thumbnail": "https://picsum.photos/300/200?random=11&keyword=development",
      "duration": "15:32",
      "views": 850000,
      "uploadDate": "2024-05-10",
    },
    {
      "id": 3,
      "title": "Character Customization Deep Dive",
      "thumbnail": "https://picsum.photos/300/200?random=12&keyword=character",
      "duration": "8:45",
      "views": 642000,
      "uploadDate": "2024-05-08",
    },
    {
      "id": 4,
      "title": "Combat Mechanics Explained",
      "thumbnail": "https://picsum.photos/300/200?random=13&keyword=combat",
      "duration": "12:18",
      "views": 720000,
      "uploadDate": "2024-05-05",
    },
    {
      "id": 5,
      "title": "Open World Exploration",
      "thumbnail": "https://picsum.photos/300/200?random=14&keyword=world",
      "duration": "20:05",
      "views": 980000,
      "uploadDate": "2024-05-01",
    },
  ];

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "username": "GameExplorer2024",
      "avatar": "https://picsum.photos/50/50?random=21&keyword=avatar",
      "comment": "This looks absolutely incredible! The graphics are mind-blowing and the gameplay seems so smooth. Can't wait for the release!",
      "timestamp": "2 hours ago",
      "likes": 1240,
      "replies": 45,
      "isVerified": true,
    },
    {
      "id": 2,
      "username": "CyberNinja",
      "avatar": "https://picsum.photos/50/50?random=22&keyword=profile",
      "comment": "Finally! A cyberpunk game that actually delivers on its promises. The character customization looks amazing.",
      "timestamp": "5 hours ago",
      "likes": 892,
      "replies": 23,
      "isVerified": false,
    },
    {
      "id": 3,
      "username": "TechReviewer",
      "avatar": "https://picsum.photos/50/50?random=23&keyword=user",
      "comment": "The ray tracing effects in this preview are stunning. This is what next-gen gaming should look like!",
      "timestamp": "1 day ago",
      "likes": 567,
      "replies": 12,
      "isVerified": true,
    },
  ];

  String formatTime(double seconds) {
    int minutes = (seconds ~/ 60);
    int secs = (seconds % 60).round();
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    isPlaying = !isPlaying;
                    setState(() {});
                  },
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          isPlaying 
                              ? "${gamePreview["trailerUrl"]}"
                              : "${gamePreview["thumbnailUrl"]}",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        if (!isPlaying)
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        // Top Controls
                        Positioned(
                          top: 40,
                          left: spMd,
                          right: spMd,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => back(),
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  isMuted = !isMuted;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    isMuted ? Icons.volume_off : Icons.volume_up,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              GestureDetector(
                                onTap: () {
                                  isFullscreen = !isFullscreen;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Bottom Progress Bar
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withAlpha(200),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                // Progress Slider
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: Colors.white.withAlpha(100),
                                    thumbColor: primaryColor,
                                    overlayColor: primaryColor.withAlpha(50),
                                    trackHeight: 3,
                                  ),
                                  child: Slider(
                                    value: currentTime,
                                    max: totalTime,
                                    onChanged: (value) {
                                      currentTime = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                // Time and Controls
                                Row(
                                  children: [
                                    Text(
                                      formatTime(currentTime),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " / ${formatTime(totalTime)}",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(150),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${gamePreview["quality"]}",
                                        style: TextStyle(
                                          color: Colors.white,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Video Info Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Video Title and Stats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "${gamePreview["title"]} - Official Gameplay Trailer",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${((gamePreview["views"] as int) / 1000).toStringAsFixed(0)}K views",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${gamePreview["uploadDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((gamePreview["likes"] as int) / 1000).toStringAsFixed(0)}K",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Share",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Game Info Card
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: primaryColor.withAlpha(100),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${gamePreview["developer"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${gamePreview["genre"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${gamePreview["rating"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "View Game",
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo('GeaGameDetailView', arguments: gamePreview)
                          },
                        ),
                      ],
                    ),
                  ),

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "About This Preview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${gamePreview["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                  // Video Chapters
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Video Chapters",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      ...(gamePreview["chapters"] as List<Map<String, dynamic>>).map((chapter) {
                        return GestureDetector(
                          onTap: () {
                            currentTime = (chapter["startTime"] as int).toDouble();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(100),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      formatTime((chapter["startTime"] as int).toDouble()),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${chapter["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),

                  // Related Videos
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Text(
                        "Related Videos",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QHorizontalScroll(
                        children: relatedVideos.map((video) {
                          return Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusMd),
                                        topRight: Radius.circular(radiusMd),
                                      ),
                                      child: Image.network(
                                        "${video["thumbnail"]}",
                                        width: double.infinity,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: spXs,
                                      right: spXs,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(200),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${video["duration"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(spSm),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "${video["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${((video["views"] as int) / 1000).toStringAsFixed(0)}K views • ${video["uploadDate"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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

                  // Comments Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Comments",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "Add Comment",
                            size: bs.sm,
                            onPressed: () {
                              // Add comment functionality
                            },
                          ),
                        ],
                      ),
                      ...comments.map((comment) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowSm],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    child: Image.network(
                                      "${comment["avatar"]}",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${comment["username"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (comment["isVerified"] == true) ...[
                                              SizedBox(width: spXs),
                                              Icon(
                                                Icons.verified,
                                                color: successColor,
                                                size: 16,
                                              ),
                                            ],
                                          ],
                                        ),
                                        Text(
                                          "${comment["timestamp"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${comment["comment"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  height: 1.5,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${comment["likes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Icon(
                                    Icons.reply,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${comment["replies"]} replies",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
