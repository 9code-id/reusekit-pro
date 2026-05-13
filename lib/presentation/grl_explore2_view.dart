import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlExplore2View extends StatefulWidget {
  @override
  State<GrlExplore2View> createState() => _GrlExplore2ViewState();
}

class _GrlExplore2ViewState extends State<GrlExplore2View> {
  String searchQuery = "";
  int selectedTab = 0;
  List<String> selectedInterests = [];
  
  List<String> tabs = ["For You", "Following", "Trending", "Recent"];
  
  List<String> interests = [
    "Photography",
    "Art",
    "Technology",
    "Travel",
    "Food",
    "Fashion",
    "Music",
    "Sports",
    "Gaming",
    "Nature",
    "Design",
    "Business"
  ];

  List<Map<String, dynamic>> discoverFeed = [
    {
      "id": "1",
      "type": "post",
      "content": {
        "text": "Just captured this incredible sunset from my rooftop! The colors were absolutely magical tonight 🌅",
        "images": [
          "https://picsum.photos/600/400?random=1&keyword=sunset",
          "https://picsum.photos/600/400?random=11&keyword=sky"
        ]
      },
      "author": {
        "name": "Elena Martinez",
        "username": "@elenamartinez",
        "avatar": "https://picsum.photos/50/50?random=1&keyword=woman",
        "verified": true,
        "followers": "234K"
      },
      "engagement": {
        "likes": 4521,
        "comments": 287,
        "shares": 156,
        "bookmarks": 89
      },
      "timestamp": "2024-03-20T19:30:00",
      "location": "Los Angeles, CA",
      "tags": ["sunset", "photography", "rooftop", "nature"],
      "category": "Photography"
    },
    {
      "id": "2",
      "type": "carousel",
      "content": {
        "text": "My latest art collection: 'Digital Dreams' - Exploring the intersection of reality and imagination ✨",
        "images": [
          "https://picsum.photos/600/600?random=2&keyword=digital",
          "https://picsum.photos/600/600?random=12&keyword=art",
          "https://picsum.photos/600/600?random=22&keyword=abstract",
          "https://picsum.photos/600/600?random=32&keyword=colorful"
        ]
      },
      "author": {
        "name": "Marcus Chen",
        "username": "@marcuschen",
        "avatar": "https://picsum.photos/50/50?random=2&keyword=man",
        "verified": false,
        "followers": "89K"
      },
      "engagement": {
        "likes": 2847,
        "comments": 134,
        "shares": 78,
        "bookmarks": 234
      },
      "timestamp": "2024-03-20T16:45:00",
      "location": "New York, NY",
      "tags": ["digital art", "collection", "abstract", "creative"],
      "category": "Art"
    },
    {
      "id": "3",
      "type": "video",
      "content": {
        "text": "Behind the scenes of building our new AI-powered design tool. The future is here! 🚀",
        "thumbnail": "https://picsum.photos/600/400?random=3&keyword=technology",
        "duration": "2:34"
      },
      "author": {
        "name": "Sarah Johnson",
        "username": "@sarahjohnson",
        "avatar": "https://picsum.photos/50/50?random=3&keyword=woman",
        "verified": true,
        "followers": "456K"
      },
      "engagement": {
        "likes": 6789,
        "comments": 445,
        "shares": 267,
        "bookmarks": 345
      },
      "timestamp": "2024-03-20T14:20:00",
      "location": "San Francisco, CA",
      "tags": ["technology", "ai", "design", "startup"],
      "category": "Technology"
    },
    {
      "id": "4",
      "type": "post",
      "content": {
        "text": "Exploring the hidden gems of Kyoto. This temple has such incredible architecture and peaceful energy 🏯",
        "images": [
          "https://picsum.photos/600/500?random=4&keyword=temple"
        ]
      },
      "author": {
        "name": "David Kim",
        "username": "@davidkim",
        "avatar": "https://picsum.photos/50/50?random=4&keyword=man",
        "verified": false,
        "followers": "156K"
      },
      "engagement": {
        "likes": 3421,
        "comments": 198,
        "shares": 112,
        "bookmarks": 187
      },
      "timestamp": "2024-03-20T11:15:00",
      "location": "Kyoto, Japan",
      "tags": ["travel", "kyoto", "temple", "architecture"],
      "category": "Travel"
    },
    {
      "id": "5",
      "type": "carousel",
      "content": {
        "text": "Today's brunch creation: Matcha pancakes with fresh berries and honey drizzle. Recipe in comments! 🥞",
        "images": [
          "https://picsum.photos/600/600?random=5&keyword=food",
          "https://picsum.photos/600/600?random=15&keyword=pancakes",
          "https://picsum.photos/600/600?random=25&keyword=berries"
        ]
      },
      "author": {
        "name": "Lily Chang",
        "username": "@lilychang",
        "avatar": "https://picsum.photos/50/50?random=5&keyword=woman",
        "verified": true,
        "followers": "321K"
      },
      "engagement": {
        "likes": 5234,
        "comments": 567,
        "shares": 234,
        "bookmarks": 456
      },
      "timestamp": "2024-03-20T09:30:00",
      "location": "Tokyo, Japan",
      "tags": ["food", "brunch", "matcha", "recipe"],
      "category": "Food"
    }
  ];

  List<Map<String, dynamic>> get filteredFeed {
    List<Map<String, dynamic>> filtered = discoverFeed;
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((post) =>
        (post["content"]["text"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["author"]["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (post["tags"] as List).any((tag) => 
          (tag as String).toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }
    
    // Filter by selected interests
    if (selectedInterests.isNotEmpty) {
      filtered = filtered.where((post) =>
        selectedInterests.contains(post["category"])).toList();
    }
    
    return filtered;
  }

  void _likePost(int index) {
    setState(() {
      filteredFeed[index]["engagement"]["likes"] = 
        (filteredFeed[index]["engagement"]["likes"] as int) + 1;
    });
    ss("Post liked!");
  }

  void _bookmarkPost(int index) {
    setState(() {
      filteredFeed[index]["engagement"]["bookmarks"] = 
        (filteredFeed[index]["engagement"]["bookmarks"] as int) + 1;
    });
    ss("Post bookmarked!");
  }

  void _sharePost(int index) {
    final post = filteredFeed[index];
    setState(() {
      post["engagement"]["shares"] = (post["engagement"]["shares"] as int) + 1;
    });
    ss("Post shared!");
  }

  String _getTimeAgo(String timestamp) {
    DateTime postTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m";
    } else {
      return "now";
    }
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return "${(count / 1000000).toStringAsFixed(1)}M";
    } else if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(1)}K";
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Notifications coming soon");
            },
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            child: QTextField(
              label: "Search posts, people, topics...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  bool isSelected = selectedTab == index;
                  return GestureDetector(
                    onTap: () {
                      selectedTab = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          
          // Interest Filters
          if (selectedInterests.isNotEmpty || interests.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Interests",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: interests.map((interest) {
                      bool isSelected = selectedInterests.contains(interest);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedInterests.remove(interest);
                            } else {
                              selectedInterests.add(interest);
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          
          // Feed
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredFeed.length,
              itemBuilder: (context, index) {
                final post = filteredFeed[index];
                final author = post["author"] as Map<String, dynamic>;
                final content = post["content"] as Map<String, dynamic>;
                final engagement = post["engagement"] as Map<String, dynamic>;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (author["verified"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: successColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${author["username"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ${_getTimeAgo(post["timestamp"] as String)}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'follow') {
                                  ss("Followed ${author["name"]}");
                                } else if (value == 'save') {
                                  _bookmarkPost(index);
                                } else if (value == 'report') {
                                  ss("Post reported");
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'follow',
                                  child: Text('Follow'),
                                ),
                                PopupMenuItem(
                                  value: 'save',
                                  child: Text('Save Post'),
                                ),
                                PopupMenuItem(
                                  value: 'report',
                                  child: Text('Report'),
                                ),
                              ],
                              child: Icon(
                                Icons.more_horiz,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Post Content
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spSm),
                        child: Text(
                          "${content["text"]}",
                          style: TextStyle(
                            fontSize: 15,
                            color: primaryColor,
                            height: 1.4,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Media Content
                      if (post["type"] == "post" && content["images"] != null) ...[
                        if ((content["images"] as List).length == 1)
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("${(content["images"] as List)[0]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 200,
                            child: PageView.builder(
                              itemCount: (content["images"] as List).length,
                              itemBuilder: (context, imageIndex) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("${(content["images"] as List)[imageIndex]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ] else if (post["type"] == "carousel") ...[
                        Container(
                          height: 300,
                          child: PageView.builder(
                            itemCount: (content["images"] as List).length,
                            itemBuilder: (context, imageIndex) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: spXs),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${(content["images"] as List)[imageIndex]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ] else if (post["type"] == "video") ...[
                        Stack(
                          children: [
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${content["thumbnail"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${content["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      
                      // Post Footer
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Location and Tags
                            if (post["location"] != null) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${post["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                            ],
                            
                            // Tags
                            if ((post["tags"] as List).isNotEmpty) ...[
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (post["tags"] as List).take(4).map((tag) {
                                  return Text(
                                    "#$tag",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: spSm),
                            ],
                            
                            // Engagement Stats
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_formatCount(engagement["likes"] as int)} likes",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${_formatCount(engagement["comments"] as int)} comments",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _likePost(index),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          size: 20,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Like",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ss("Comments coming soon");
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.comment_outlined,
                                          size: 20,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Comment",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _sharePost(index),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.share_outlined,
                                          size: 20,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
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
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
