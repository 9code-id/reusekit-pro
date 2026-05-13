import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore1View extends StatefulWidget {
  @override
  State<GrlExplore1View> createState() => _GrlExplore1ViewState();
}

class _GrlExplore1ViewState extends State<GrlExplore1View> {
  String searchQuery = "";
  int selectedCategory = 0;
  int selectedFilter = 0;
  
  List<String> categories = [
    "All",
    "Trending",
    "Photography",
    "Art & Design",
    "Technology",
    "Travel",
    "Food",
    "Fashion"
  ];

  List<String> filters = [
    "Latest",
    "Most Popular",
    "Most Liked",
    "Most Viewed"
  ];

  List<Map<String, dynamic>> exploreContent = [
    {
      "id": "1",
      "type": "image",
      "title": "Golden Hour Cityscape",
      "image": "https://picsum.photos/400/600?random=1&keyword=city",
      "author": {
        "name": "Sarah Mitchell",
        "username": "@sarahmitchell",
        "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
        "verified": true
      },
      "category": "Photography",
      "likes": 2847,
      "views": 15632,
      "comments": 156,
      "shares": 89,
      "timestamp": "2024-03-20T08:30:00",
      "trending": true,
      "tags": ["cityscape", "golden hour", "urban", "photography"]
    },
    {
      "id": "2",
      "type": "image",
      "title": "Abstract Digital Art",
      "image": "https://picsum.photos/400/500?random=2&keyword=abstract",
      "author": {
        "name": "Alex Thompson",
        "username": "@alexthompson",
        "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
        "verified": false
      },
      "category": "Art & Design",
      "likes": 1923,
      "views": 8745,
      "comments": 92,
      "shares": 45,
      "timestamp": "2024-03-20T06:15:00",
      "trending": false,
      "tags": ["abstract", "digital art", "colorful", "modern"]
    },
    {
      "id": "3",
      "type": "image",
      "title": "Mountain Adventure",
      "image": "https://picsum.photos/400/550?random=3&keyword=mountain",
      "author": {
        "name": "Emma Rodriguez",
        "username": "@emmarodriguez",
        "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
        "verified": true
      },
      "category": "Travel",
      "likes": 3456,
      "views": 22341,
      "comments": 287,
      "shares": 134,
      "timestamp": "2024-03-19T16:45:00",
      "trending": true,
      "tags": ["mountain", "adventure", "nature", "hiking"]
    },
    {
      "id": "4",
      "type": "image",
      "title": "Modern Web Interface",
      "image": "https://picsum.photos/400/480?random=4&keyword=design",
      "author": {
        "name": "David Chen",
        "username": "@davidchen",
        "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
        "verified": false
      },
      "category": "Technology",
      "likes": 1567,
      "views": 9832,
      "comments": 78,
      "shares": 67,
      "timestamp": "2024-03-19T14:20:00",
      "trending": false,
      "tags": ["ui", "web design", "interface", "modern"]
    },
    {
      "id": "5",
      "type": "image",
      "title": "Gourmet Food Plating",
      "image": "https://picsum.photos/400/520?random=5&keyword=food",
      "author": {
        "name": "Maria Garcia",
        "username": "@mariagarcia",
        "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
        "verified": true
      },
      "category": "Food",
      "likes": 2134,
      "views": 12456,
      "comments": 189,
      "shares": 98,
      "timestamp": "2024-03-19T12:10:00",
      "trending": true,
      "tags": ["food", "gourmet", "plating", "chef"]
    },
    {
      "id": "6",
      "type": "image",
      "title": "Street Fashion Style",
      "image": "https://picsum.photos/400/600?random=6&keyword=fashion",
      "author": {
        "name": "Lisa Park",
        "username": "@lisapark",
        "avatar": "https://picsum.photos/40/40?random=6&keyword=woman",
        "verified": false
      },
      "category": "Fashion",
      "likes": 2876,
      "views": 16789,
      "comments": 245,
      "shares": 112,
      "timestamp": "2024-03-18T18:30:00",
      "trending": false,
      "tags": ["fashion", "street style", "outfit", "trendy"]
    },
    {
      "id": "7",
      "type": "image",
      "title": "Minimalist Architecture",
      "image": "https://picsum.photos/400/580?random=7&keyword=architecture",
      "author": {
        "name": "James Wilson",
        "username": "@jameswilson",
        "avatar": "https://picsum.photos/40/40?random=7&keyword=man",
        "verified": true
      },
      "category": "Photography",
      "likes": 1789,
      "views": 11234,
      "comments": 134,
      "shares": 76,
      "timestamp": "2024-03-18T15:45:00",
      "trending": false,
      "tags": ["architecture", "minimalist", "building", "modern"]
    },
    {
      "id": "8",
      "type": "image",
      "title": "Digital Illustration",
      "image": "https://picsum.photos/400/500?random=8&keyword=illustration",
      "author": {
        "name": "Sophie Turner",
        "username": "@sophieturner",
        "avatar": "https://picsum.photos/40/40?random=8&keyword=woman",
        "verified": false
      },
      "category": "Art & Design",
      "likes": 2345,
      "views": 14567,
      "comments": 178,
      "shares": 89,
      "timestamp": "2024-03-18T10:20:00",
      "trending": true,
      "tags": ["illustration", "digital art", "creative", "design"]
    }
  ];

  List<Map<String, dynamic>> get filteredContent {
    List<Map<String, dynamic>> filtered = exploreContent;
    
    // Filter by category
    if (selectedCategory > 0) {
      if (selectedCategory == 1) { // Trending
        filtered = filtered.where((content) => content["trending"] as bool).toList();
      } else {
        filtered = filtered.where((content) => 
          content["category"] == categories[selectedCategory]).toList();
      }
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((content) =>
        (content["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (content["author"]["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (content["tags"] as List).any((tag) => 
          (tag as String).toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }
    
    // Sort by filter
    switch (selectedFilter) {
      case 0: // Latest
        filtered.sort((a, b) => (b["timestamp"] as String).compareTo(a["timestamp"] as String));
        break;
      case 1: // Most Popular
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case 2: // Most Liked
        filtered.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case 3: // Most Viewed
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
    }
    
    return filtered;
  }

  void _likeContent(int index) {
    setState(() {
      filteredContent[index]["likes"] = (filteredContent[index]["likes"] as int) + 1;
    });
    ss("Liked!");
  }

  void _shareContent(int index) {
    final content = filteredContent[index];
    setState(() {
      content["shares"] = (content["shares"] as int) + 1;
    });
    ss("Shared: ${content["title"]}");
  }

  String _getTimeAgo(String timestamp) {
    DateTime contentTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(contentTime);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Just now";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Search feature coming soon");
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            QTextField(
              label: "Search content, creators, tags...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Categories
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: categories[selectedCategory],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Filter and Results Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filteredContent.length} Results",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: DropdownButton<int>(
                    value: selectedFilter,
                    underline: SizedBox.shrink(),
                    items: filters.asMap().entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(
                          entry.value,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedFilter = value ?? 0;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Content Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: List.generate(filteredContent.length, (index) {
                final content = filteredContent[index];
                final author = content["author"] as Map<String, dynamic>;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Content Image
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              image: DecorationImage(
                                image: NetworkImage("${content["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (content["trending"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.local_fire_department,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Trending",
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
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${content["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
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
                          children: [
                            // Title
                            Text(
                              "${content["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Author Info
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
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
                                      Row(
                                        children: [
                                          Text(
                                            "${author["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (author["verified"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Icon(
                                              Icons.verified,
                                              size: 14,
                                              color: successColor,
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        _getTimeAgo(content["timestamp"] as String),
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
                            
                            SizedBox(height: spSm),
                            
                            // Stats
                            Row(
                              children: [
                                _buildStatIcon(Icons.favorite, "${content["likes"]}"),
                                SizedBox(width: spSm),
                                _buildStatIcon(Icons.visibility, "${content["views"]}"),
                                SizedBox(width: spSm),
                                _buildStatIcon(Icons.comment, "${content["comments"]}"),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (content["tags"] as List).take(3).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _likeContent(index),
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      label: Text(
                                        "Like",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: disabledOutlineBorderColor),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _shareContent(index),
                                      icon: Icon(
                                        Icons.share,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      label: Text(
                                        "Share",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: disabledOutlineBorderColor),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, String count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Text(
          count,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
