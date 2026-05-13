import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFeed1View extends StatefulWidget {
  @override
  State<GrlFeed1View> createState() => _GrlFeed1ViewState();
}

class _GrlFeed1ViewState extends State<GrlFeed1View> {
  List<Map<String, dynamic>> feedItems = [
    {
      "id": 1,
      "type": "article",
      "title": "10 Essential Design Principles Every Developer Should Know",
      "description": "Understanding these fundamental design principles will help you create better user interfaces and improve user experience in your applications.",
      "author": {
        "name": "Sarah Design",
        "avatar": "https://picsum.photos/50/50?random=200",
        "title": "Senior UI/UX Designer",
      },
      "image": "https://picsum.photos/400/250?random=210",
      "category": "Design",
      "readTime": "5 min read",
      "publishedAt": "2 hours ago",
      "likes": 142,
      "comments": 28,
      "shares": 15,
      "isLiked": false,
      "isBookmarked": false,
      "tags": ["Design", "UI/UX", "Development"],
    },
    {
      "id": 2,
      "type": "video",
      "title": "Building Responsive Layouts with Flutter",
      "description": "Learn how to create beautiful, responsive layouts that work perfectly across all device sizes using Flutter's flexible widget system.",
      "author": {
        "name": "Mike Flutter",
        "avatar": "https://picsum.photos/50/50?random=201",
        "title": "Flutter Developer",
      },
      "image": "https://picsum.photos/400/250?random=211",
      "category": "Development",
      "duration": "12:45",
      "publishedAt": "4 hours ago",
      "likes": 89,
      "comments": 12,
      "shares": 8,
      "isLiked": true,
      "isBookmarked": true,
      "tags": ["Flutter", "Mobile", "Responsive"],
    },
    {
      "id": 3,
      "type": "podcast",
      "title": "The Future of Mobile Development: Trends and Predictions",
      "description": "Join industry experts as they discuss emerging trends in mobile development and what developers should focus on in 2024.",
      "author": {
        "name": "Tech Podcast",
        "avatar": "https://picsum.photos/50/50?random=202",
        "title": "Technology Podcast",
      },
      "image": "https://picsum.photos/400/250?random=212",
      "category": "Technology",
      "duration": "45:30",
      "publishedAt": "1 day ago",
      "likes": 234,
      "comments": 45,
      "shares": 32,
      "isLiked": false,
      "isBookmarked": false,
      "tags": ["Mobile", "Technology", "Trends"],
    },
    {
      "id": 4,
      "type": "article",
      "title": "Mastering State Management in Modern Web Applications",
      "description": "A comprehensive guide to choosing and implementing the right state management solution for your web application project.",
      "author": {
        "name": "Anna Developer",
        "avatar": "https://picsum.photos/50/50?random=203",
        "title": "Full Stack Developer",
      },
      "image": "https://picsum.photos/400/250?random=213",
      "category": "Development",
      "readTime": "8 min read",
      "publishedAt": "2 days ago",
      "likes": 178,
      "comments": 19,
      "shares": 22,
      "isLiked": true,
      "isBookmarked": false,
      "tags": ["Web Dev", "State Management", "React"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "isSelected": true},
    {"name": "Design", "isSelected": false},
    {"name": "Development", "isSelected": false},
    {"name": "Technology", "isSelected": false},
    {"name": "Business", "isSelected": false},
    {"name": "Lifestyle", "isSelected": false},
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"topic": "Flutter Development", "posts": "2.4K"},
    {"topic": "UI/UX Design", "posts": "1.8K"},
    {"topic": "Mobile Apps", "posts": "3.2K"},
    {"topic": "Web Development", "posts": "5.1K"},
    {"topic": "Tech Trends", "posts": "1.2K"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feed",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search, size: 24),
          SizedBox(width: spMd),
          Icon(Icons.bookmark_outline, size: 24),
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
                        child: Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(width: spMd),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Trending Topics
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Trending Topics",
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
                  ...List.generate(trendingTopics.length, (index) {
                    final topic = trendingTopics[index];
                    
                    return Container(
                      width: 140,
                      margin: EdgeInsets.only(right: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowSm],
                        border: Border.all(color: primaryColor.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${topic["topic"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacer(),
                          Text(
                            "${topic["posts"]} posts",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
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
            
            // Feed Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Text(
                "Latest Posts",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: spSm),
            
            ...List.generate(feedItems.length, (index) {
              final item = feedItems[index];
              final author = item["author"] as Map<String, dynamic>;
              final type = item["type"] as String;
              final isLiked = item["isLiked"] as bool;
              final isBookmarked = item["isBookmarked"] as bool;
              final tags = item["tags"] as List;
              
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
                    // Post Image
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          topRight: Radius.circular(radiusLg),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("${item["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(100),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Content Type Badge
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTypeColor(type),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getTypeIcon(type),
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      type.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Duration or Read Time
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  type == "article" 
                                      ? "${item["readTime"]}"
                                      : "${item["duration"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Play Button for Video/Podcast
                            if (type == "video" || type == "podcast")
                              Positioned.fill(
                                child: Center(
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(200),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 30,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Post Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and Published Date
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${item["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${item["publishedAt"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Title
                          Text(
                            "${item["title"]}",
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
                            "${item["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
                                  color: disabledBoldColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tags[tagIndex]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Author Info
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${author["avatar"]}"),
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
                                      "${author["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${author["title"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              QButton(
                                label: "Follow",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Actions
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  feedItems[index]["isLiked"] = !isLiked;
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                      color: isLiked ? dangerColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(item["likes"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(width: spMd),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(item["comments"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(width: spMd),
                              
                              Row(
                                children: [
                                  Icon(
                                    Icons.share_outlined,
                                    color: disabledBoldColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(item["shares"] as int)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Spacer(),
                              
                              GestureDetector(
                                onTap: () {
                                  feedItems[index]["isBookmarked"] = !isBookmarked;
                                  setState(() {});
                                },
                                child: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: isBookmarked ? primaryColor : disabledBoldColor,
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

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "article":
        return Icons.article;
      case "video":
        return Icons.play_circle;
      case "podcast":
        return Icons.mic;
      default:
        return Icons.article;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "article":
        return primaryColor;
      case "video":
        return dangerColor;
      case "podcast":
        return successColor;
      default:
        return primaryColor;
    }
  }
}
