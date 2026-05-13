import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed3View extends StatefulWidget {
  @override
  State<GrlFeed3View> createState() => _GrlFeed3ViewState();
}

class _GrlFeed3ViewState extends State<GrlFeed3View> {
  List<Map<String, dynamic>> videoFeed = [
    {
      "id": 1,
      "title": "Advanced Flutter Animations: Creating Smooth Transitions",
      "description": "Learn how to create beautiful, performant animations in Flutter using the Animation framework and best practices for smooth user experiences.",
      "creator": {
        "name": "Flutter Dev",
        "avatar": "https://picsum.photos/50/50?random=240",
        "subscribers": "125K",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/400/225?random=250",
      "duration": "15:32",
      "views": 45630,
      "likes": 3256,
      "uploadedAt": "2 days ago",
      "category": "Education",
      "quality": "4K",
      "isLiked": false,
      "isSaved": true,
      "tags": ["Flutter", "Animation", "Mobile Development"],
    },
    {
      "id": 2,
      "title": "Morning Workout Routine: 20 Minutes Full Body",
      "description": "Start your day with this energizing 20-minute full-body workout routine. No equipment needed, perfect for beginners and advanced fitness enthusiasts.",
      "creator": {
        "name": "FitLife Studio",
        "avatar": "https://picsum.photos/50/50?random=241",
        "subscribers": "892K",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/400/225?random=251",
      "duration": "20:45",
      "views": 128450,
      "likes": 8934,
      "uploadedAt": "1 day ago",
      "category": "Fitness",
      "quality": "HD",
      "isLiked": true,
      "isSaved": false,
      "tags": ["Fitness", "Workout", "Morning Routine"],
    },
    {
      "id": 3,
      "title": "Cooking Italian Pasta: Authentic Carbonara Recipe",
      "description": "Master the art of authentic Italian carbonara with this step-by-step tutorial. Learn the traditional techniques passed down through generations.",
      "creator": {
        "name": "Chef Marco",
        "avatar": "https://picsum.photos/50/50?random=242",
        "subscribers": "567K",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/400/225?random=252",
      "duration": "12:18",
      "views": 89340,
      "likes": 6789,
      "uploadedAt": "3 days ago",
      "category": "Cooking",
      "quality": "4K",
      "isLiked": false,
      "isSaved": true,
      "tags": ["Cooking", "Italian", "Pasta", "Recipe"],
    },
    {
      "id": 4,
      "title": "Travel Vlog: Hidden Gems of Tokyo You Must Visit",
      "description": "Discover the secret spots in Tokyo that most tourists never see. From hidden shrines to underground food markets, explore the real Tokyo.",
      "creator": {
        "name": "Wanderlust Adventures",
        "avatar": "https://picsum.photos/50/50?random=243",
        "subscribers": "234K",
        "isVerified": false,
      },
      "thumbnail": "https://picsum.photos/400/225?random=253",
      "duration": "25:10",
      "views": 67890,
      "likes": 4532,
      "uploadedAt": "5 days ago",
      "category": "Travel",
      "quality": "4K",
      "isLiked": true,
      "isSaved": false,
      "tags": ["Travel", "Tokyo", "Japan", "Hidden Gems"],
    },
    {
      "id": 5,
      "title": "Music Production Basics: Creating Your First Beat",
      "description": "Complete beginner's guide to music production. Learn how to create your first beat using digital audio workstations and essential production techniques.",
      "creator": {
        "name": "BeatMaker Pro",
        "avatar": "https://picsum.photos/50/50?random=244",
        "subscribers": "445K",
        "isVerified": true,
      },
      "thumbnail": "https://picsum.photos/400/225?random=254",
      "duration": "18:55",
      "views": 34567,
      "likes": 2891,
      "uploadedAt": "1 week ago",
      "category": "Music",
      "quality": "HD",
      "isLiked": false,
      "isSaved": true,
      "tags": ["Music", "Production", "Beats", "Tutorial"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.apps, "isSelected": true},
    {"name": "Education", "icon": Icons.school, "isSelected": false},
    {"name": "Entertainment", "icon": Icons.movie, "isSelected": false},
    {"name": "Music", "icon": Icons.music_note, "isSelected": false},
    {"name": "Gaming", "icon": Icons.sports_esports, "isSelected": false},
    {"name": "Sports", "icon": Icons.sports, "isSelected": false},
    {"name": "Cooking", "icon": Icons.restaurant, "isSelected": false},
    {"name": "Travel", "icon": Icons.flight, "isSelected": false},
    {"name": "Tech", "icon": Icons.computer, "isSelected": false},
  ];

  List<Map<String, dynamic>> trendingCreators = [
    {
      "name": "TechReviewer",
      "avatar": "https://picsum.photos/60/60?random=260",
      "subscribers": "2.1M",
      "category": "Technology",
      "isSubscribed": false,
    },
    {
      "name": "CookingMaster",
      "avatar": "https://picsum.photos/60/60?random=261",
      "subscribers": "1.8M",
      "category": "Cooking",
      "isSubscribed": true,
    },
    {
      "name": "FitnessGuru",
      "avatar": "https://picsum.photos/60/60?random=262",
      "subscribers": "945K",
      "category": "Fitness",
      "isSubscribed": false,
    },
    {
      "name": "TravelExplorer",
      "avatar": "https://picsum.photos/60/60?random=263",
      "subscribers": "678K",
      "category": "Travel",
      "isSubscribed": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Video Feed",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.cast, size: 24),
          SizedBox(width: spMd),
          Icon(Icons.notifications_outlined, size: 24),
          SizedBox(width: spMd),
          Icon(Icons.search, size: 24),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            Container(
              height: 50,
              child: QHorizontalScroll(
                children: [
                  SizedBox(width: spMd),
                  ...List.generate(categories.length, (index) {
                    final category = categories[index];
                    final isSelected = category["isSelected"] as bool;
                    
                    return GestureDetector(
                      onTap: () {
                        for (var cat in categories) {
                          cat["isSelected"] = false;
                        }
                        categories[index]["isSelected"] = true;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledBoldColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category["icon"] as IconData,
                              size: 16,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${category["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: spMd),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Trending Creators
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Trending Creators",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            Container(
              height: 120,
              child: QHorizontalScroll(
                children: [
                  SizedBox(width: spMd),
                  ...List.generate(trendingCreators.length, (index) {
                    final creator = trendingCreators[index];
                    final isSubscribed = creator["isSubscribed"] as bool;
                    
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(right: spMd),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${creator["avatar"]}"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                color: isSubscribed ? primaryColor : disabledBoldColor,
                                width: 2,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${creator["name"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "${creator["subscribers"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(width: spMd),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Videos
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Recommended for You",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...List.generate(videoFeed.length, (index) {
              final video = videoFeed[index];
              final creator = video["creator"] as Map<String, dynamic>;
              final isLiked = video["isLiked"] as bool;
              final isSaved = video["isSaved"] as bool;
              final tags = video["tags"] as List;
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd, left: spMd, right: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Thumbnail
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${video["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        
                        // Play Button
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        
                        // Duration
                        Positioned(
                          bottom: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(180),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${video["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        
                        // Quality Badge
                        Positioned(
                          top: spSm,
                          left: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: video["quality"] == "4K" ? dangerColor : infoColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${video["quality"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        
                        // Category
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${video["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Video Info
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            "${video["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Description
                          Text(
                            "${video["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Creator Info
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${creator["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
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
                                          "${creator["name"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (creator["isVerified"] as bool)
                                          Padding(
                                            padding: EdgeInsets.only(left: spXs),
                                            child: Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${creator["subscribers"]} subscribers",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              QButton(
                                label: "Subscribe",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Video Stats
                          Row(
                            children: [
                              Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${_formatNumber(video["views"] as int)} views",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Text(
                                "• ${video["uploadedAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: List.generate(tags.length, (tagIndex) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "#${tags[tagIndex]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Actions
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  videoFeed[index]["isLiked"] = !isLiked;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                                      color: isLiked ? primaryColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${_formatNumber(video["likes"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(width: spMd),
                              
                              Icon(
                                Icons.thumb_down_outlined,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                              
                              SizedBox(width: spMd),
                              
                              Icon(
                                Icons.share_outlined,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                              
                              SizedBox(width: spMd),
                              
                              Icon(
                                Icons.download_outlined,
                                color: disabledBoldColor,
                                size: 20,
                              ),
                              
                              Spacer(),
                              
                              GestureDetector(
                                onTap: () {
                                  videoFeed[index]["isSaved"] = !isSaved;
                                  setState(() {});
                                },
                                child: Icon(
                                  isSaved ? Icons.playlist_add_check : Icons.playlist_add,
                                  color: isSaved ? primaryColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }
}
