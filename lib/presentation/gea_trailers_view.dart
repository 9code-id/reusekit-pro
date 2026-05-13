import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaTrailersView extends StatefulWidget {
  const GeaTrailersView({super.key});

  @override
  State<GeaTrailersView> createState() => _GeaTrailersViewState();
}

class _GeaTrailersViewState extends State<GeaTrailersView> {
  int selectedVideo = 0;
  bool isPlaying = false;
  bool isMuted = false;
  bool isFullscreen = false;
  String selectedCategory = "All";

  List<String> categories = [
    "All",
    "Gameplay",
    "Cinematic",
    "Developer Diary",
    "Behind the Scenes",
    "Reviews",
    "Teasers"
  ];

  List<Map<String, dynamic>> trailers = [
    {
      "id": 1,
      "title": "Official Launch Trailer",
      "description": "Experience the ultimate cyberpunk adventure in this action-packed launch trailer showcasing the game's most exciting moments.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=1&keyword=cyberpunk",
      "videoUrl": "https://picsum.photos/800/450?random=11&keyword=trailer",
      "duration": "2:45",
      "uploadDate": "2024-05-20",
      "views": 2580000,
      "likes": 125000,
      "category": "Cinematic",
      "quality": "4K HDR",
      "developer": "NeonStudio",
      "tags": ["Launch", "Action", "Cyberpunk", "Adventure"],
    },
    {
      "id": 2,
      "title": "Gameplay Deep Dive",
      "description": "Detailed look at the gameplay mechanics, combat system, and character progression in this comprehensive overview.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=2&keyword=gameplay",
      "videoUrl": "https://picsum.photos/800/450?random=12&keyword=gaming",
      "duration": "8:32",
      "uploadDate": "2024-05-15",
      "views": 1940000,
      "likes": 98000,
      "category": "Gameplay",
      "quality": "4K",
      "developer": "NeonStudio",
      "tags": ["Gameplay", "Mechanics", "Combat", "RPG"],
    },
    {
      "id": 3,
      "title": "Character Creation Showcase",
      "description": "Explore the extensive character customization system and create your perfect cyberpunk protagonist.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=3&keyword=character",
      "videoUrl": "https://picsum.photos/800/450?random=13&keyword=avatar",
      "duration": "5:18",
      "uploadDate": "2024-05-10",
      "views": 1520000,
      "likes": 78000,
      "category": "Gameplay",
      "quality": "1080p",
      "developer": "NeonStudio",
      "tags": ["Character", "Customization", "Avatar", "Creation"],
    },
    {
      "id": 4,
      "title": "Developer Diary: World Building",
      "description": "Behind-the-scenes look at how the development team created the immersive cyberpunk world.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=4&keyword=development",
      "videoUrl": "https://picsum.photos/800/450?random=14&keyword=studio",
      "duration": "12:05",
      "uploadDate": "2024-05-05",
      "views": 890000,
      "likes": 45000,
      "category": "Developer Diary",
      "quality": "1080p",
      "developer": "NeonStudio",
      "tags": ["Development", "Behind Scenes", "World Building", "Design"],
    },
    {
      "id": 5,
      "title": "Combat System Breakdown",
      "description": "Detailed analysis of the game's combat mechanics, weapons, and special abilities.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=5&keyword=combat",
      "videoUrl": "https://picsum.photos/800/450?random=15&keyword=fighting",
      "duration": "6:42",
      "uploadDate": "2024-05-01",
      "views": 1340000,
      "likes": 67000,
      "category": "Gameplay",
      "quality": "4K",
      "developer": "NeonStudio",
      "tags": ["Combat", "Weapons", "Abilities", "Fighting"],
    },
    {
      "id": 6,
      "title": "First Look Teaser",
      "description": "The very first glimpse of the game that started the hype train rolling.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=6&keyword=teaser",
      "videoUrl": "https://picsum.photos/800/450?random=16&keyword=preview",
      "duration": "1:30",
      "uploadDate": "2024-04-01",
      "views": 3200000,
      "likes": 185000,
      "category": "Teasers",
      "quality": "4K HDR",
      "developer": "NeonStudio",
      "tags": ["Teaser", "First Look", "Announcement", "Hype"],
    },
    {
      "id": 7,
      "title": "IGN Review - 9/10",
      "description": "Professional review from IGN highlighting the game's strengths and innovative features.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=7&keyword=review",
      "videoUrl": "https://picsum.photos/800/450?random=17&keyword=rating",
      "duration": "10:22",
      "uploadDate": "2024-05-18",
      "views": 750000,
      "likes": 32000,
      "category": "Reviews",
      "quality": "1080p",
      "developer": "IGN",
      "tags": ["Review", "Professional", "Rating", "Analysis"],
    },
    {
      "id": 8,
      "title": "Motion Capture Behind the Scenes",
      "description": "See how the development team brought characters to life using cutting-edge motion capture technology.",
      "thumbnailUrl": "https://picsum.photos/800/450?random=8&keyword=mocap",
      "videoUrl": "https://picsum.photos/800/450?random=18&keyword=technology",
      "duration": "7:55",
      "uploadDate": "2024-04-25",
      "views": 620000,
      "likes": 28000,
      "category": "Behind the Scenes",
      "quality": "1080p",
      "developer": "NeonStudio",
      "tags": ["Motion Capture", "Technology", "Animation", "Characters"],
    },
  ];

  List<Map<String, dynamic>> get filteredTrailers {
    if (selectedCategory == "All") return trailers;
    return trailers.where((trailer) => 
        trailer["category"] == selectedCategory).toList();
  }

  String formatViews(int views) {
    if (views >= 1000000) {
      return "${(views / 1000000).toStringAsFixed(1)}M";
    } else if (views >= 1000) {
      return "${(views / 1000).toStringAsFixed(0)}K";
    }
    return views.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Trailers"),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_play),
            onPressed: () {
              si("Playing all trailers in sequence");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Video Player
            Container(
              color: Colors.black,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      isPlaying = !isPlaying;
                      setState(() {});
                    },
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.network(
                            isPlaying 
                                ? "${filteredTrailers[selectedVideo]["videoUrl"]}"
                                : "${filteredTrailers[selectedVideo]["thumbnailUrl"]}",
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
                          // Duration Badge
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${filteredTrailers[selectedVideo]["duration"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          // Quality Badge
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${filteredTrailers[selectedVideo]["quality"]}",
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
                    ),
                  ),
                  // Top Controls
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: Row(
                      children: [
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
                              size: 20,
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
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Video Information
            Container(
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
                        "${filteredTrailers[selectedVideo]["title"]}",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${formatViews(filteredTrailers[selectedVideo]["views"] as int)} views",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${filteredTrailers[selectedVideo]["uploadDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "by ${filteredTrailers[selectedVideo]["developer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
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
                                "${formatViews(filteredTrailers[selectedVideo]["likes"] as int)}",
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
                                Icons.playlist_add,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Playlist",
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

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredTrailers[selectedVideo]["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),

                  // Tags
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tags",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Wrap(
                        spacing: spSm,
                        runSpacing: spXs,
                        children: (filteredTrailers[selectedVideo]["tags"] as List<String>).map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "#$tag",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      selectedVideo = 0;
                      setState(() {});
                    },
                  ),

                  // All Trailers List
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "All Trailers",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${filteredTrailers.length} videos",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      ...filteredTrailers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final trailer = entry.value;
                        final isSelected = index == selectedVideo;
                        
                        return GestureDetector(
                          onTap: () {
                            selectedVideo = index;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(radiusMd),
                              boxShadow: [shadowSm],
                              border: Border.all(
                                color: isSelected ? primaryColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Thumbnail
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(radiusSm),
                                      child: Image.network(
                                        "${trailer["thumbnailUrl"]}",
                                        width: 120,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Center(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            borderRadius: BorderRadius.circular(radiusLg),
                                          ),
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
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
                                          "${trailer["duration"]}",
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
                                SizedBox(width: spSm),
                                // Video Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Text(
                                        "${trailer["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${trailer["developer"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${formatViews(trailer["views"] as int)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Icon(
                                            Icons.thumb_up,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${formatViews(trailer["likes"] as int)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected ? primaryColor : primaryColor.withAlpha(100),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${trailer["category"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: isSelected ? Colors.white : primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),

                  // Statistics
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.video_library,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${trailers.length}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Videos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.visibility,
                                color: infoColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${formatViews((trailers.fold(0, (sum, t) => sum + (t["views"] as int))))}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Total Views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${formatViews((trailers.fold(0, (sum, t) => sum + (t["likes"] as int))))}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Likes",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
