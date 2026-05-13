import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSocial9View extends StatefulWidget {
  @override
  State<GrlSocial9View> createState() => _GrlSocial9ViewState();
}

class _GrlSocial9ViewState extends State<GrlSocial9View> {
  List<Map<String, dynamic>> communities = [
    {
      "id": 1,
      "name": "UI/UX Designers",
      "description": "A community for designers to share ideas, get feedback, and collaborate on projects.",
      "image": "https://picsum.photos/300/200?random=140",
      "members": 15670,
      "posts": 1234,
      "category": "Design",
      "isJoined": true,
      "privacy": "Public",
      "recentActivity": "5 new posts today",
    },
    {
      "id": 2,
      "name": "Photography Enthusiasts",
      "description": "Share your best shots, get tips from pros, and discover new photography techniques.",
      "image": "https://picsum.photos/300/200?random=141",
      "members": 8945,
      "posts": 867,
      "category": "Photography",
      "isJoined": false,
      "privacy": "Public",
      "recentActivity": "12 new posts today",
    },
    {
      "id": 3,
      "name": "Tech Startup Community",
      "description": "Connect with entrepreneurs, share startup ideas, and find co-founders.",
      "image": "https://picsum.photos/300/200?random=142",
      "members": 23456,
      "posts": 2567,
      "category": "Business",
      "isJoined": true,
      "privacy": "Private",
      "recentActivity": "8 new posts today",
    },
    {
      "id": 4,
      "name": "Fitness & Wellness",
      "description": "Motivation, workout tips, healthy recipes, and wellness discussions.",
      "image": "https://picsum.photos/300/200?random=143",
      "members": 12890,
      "posts": 1456,
      "category": "Health",
      "isJoined": false,
      "privacy": "Public",
      "recentActivity": "20 new posts today",
    },
    {
      "id": 5,
      "name": "Travel Adventurers",
      "description": "Share travel stories, get destination recommendations, and find travel buddies.",
      "image": "https://picsum.photos/300/200?random=144",
      "members": 7654,
      "posts": 934,
      "category": "Travel",
      "isJoined": true,
      "privacy": "Public",
      "recentActivity": "3 new posts today",
    },
  ];

  List<Map<String, dynamic>> trendingPosts = [
    {
      "id": 1,
      "title": "How to create stunning UI animations in Flutter",
      "author": "Sarah Design",
      "authorAvatar": "https://picsum.photos/40/40?random=150",
      "community": "UI/UX Designers",
      "likes": 245,
      "comments": 32,
      "timestamp": "2 hours ago",
      "image": "https://picsum.photos/300/150?random=160",
    },
    {
      "id": 2,
      "title": "Best camera settings for golden hour photography",
      "author": "Mike Photographer",
      "authorAvatar": "https://picsum.photos/40/40?random=151",
      "community": "Photography Enthusiasts",
      "likes": 189,
      "comments": 18,
      "timestamp": "4 hours ago",
      "image": "https://picsum.photos/300/150?random=161",
    },
    {
      "id": 3,
      "title": "Startup funding strategies for 2024",
      "author": "Alex Entrepreneur",
      "authorAvatar": "https://picsum.photos/40/40?random=152",
      "community": "Tech Startup Community",
      "likes": 156,
      "comments": 24,
      "timestamp": "6 hours ago",
      "image": null,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "All", "count": 150, "isSelected": true},
    {"name": "Design", "count": 25, "isSelected": false},
    {"name": "Tech", "count": 35, "isSelected": false},
    {"name": "Business", "count": 18, "isSelected": false},
    {"name": "Health", "count": 22, "isSelected": false},
    {"name": "Travel", "count": 12, "isSelected": false},
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Communities",
          style: TextStyle(
            fontSize: fsH4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search, size: 24),
          SizedBox(width: spMd),
          Icon(Icons.add_circle_outline, size: 24),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                _buildTabButton("Discover", 0),
                SizedBox(width: spMd),
                _buildTabButton("My Communities", 1),
                SizedBox(width: spMd),
                _buildTabButton("Trending", 2),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        selectedTab = index;
        setState(() {});
      },
      child: Container(
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
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildDiscoverTab();
      case 1:
        return _buildMyCommunitiesTab();
      case 2:
        return _buildTrendingTab();
      default:
        return _buildDiscoverTab();
    }
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
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
                        "${category["name"]} (${category["count"]})",
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
          
          // Communities List
          ...List.generate(communities.length, (index) {
            final community = communities[index];
            final isJoined = community["isJoined"] as bool;
            
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
                  // Community Image
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("${community["image"]}"),
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
                            Colors.black.withAlpha(150),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${community["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: community["privacy"] == "Private" ? warningColor : successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    community["privacy"] == "Private" ? Icons.lock : Icons.public,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${community["privacy"]}",
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
                        ],
                      ),
                    ),
                  ),
                  
                  // Community Info
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${community["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Text(
                          "${community["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 16,
                              color: primaryColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${_formatNumber(community["members"] as int)} members",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(
                              Icons.article,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(community["posts"] as int)} posts",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        Text(
                          "${community["recentActivity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        SizedBox(height: spMd),
                        
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: isJoined ? "Joined" : "Join Community",
                                color: isJoined ? successColor : primaryColor,
                                onPressed: () {
                                  communities[index]["isJoined"] = !isJoined;
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: disabledBoldColor),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: disabledBoldColor,
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
        ],
      ),
    );
  }

  Widget _buildMyCommunitiesTab() {
    final joinedCommunities = communities.where((c) => c["isJoined"] as bool).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Communities (${joinedCommunities.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          if (joinedCommunities.isEmpty)
            Center(
              child: Column(
                children: [
                  SizedBox(height: spXl),
                  Icon(
                    Icons.groups_outlined,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No communities joined yet",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Discover and join communities to connect with like-minded people",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Explore Communities",
                    onPressed: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          else
            ...List.generate(joinedCommunities.length, (index) {
              final community = joinedCommunities[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${community["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${community["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${community["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${_formatNumber(community["members"] as int)} members",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Icon(
                      Icons.chevron_right,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending Posts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...List.generate(trendingPosts.length, (index) {
            final post = trendingPosts[index];
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${post["authorAvatar"]}"),
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
                              "${post["author"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${post["community"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  " · ${post["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Post Title
                  Text(
                    "${post["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  if (post["image"] != null) ...[
                    SizedBox(height: spMd),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${post["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  
                  SizedBox(height: spMd),
                  
                  // Post Actions
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(post["likes"] as int)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      SizedBox(width: spMd),
                      
                      Icon(
                        Icons.chat_bubble_outline,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${(post["comments"] as int)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Spacer(),
                      
                      Icon(
                        Icons.share_outlined,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spMd),
                      Icon(
                        Icons.bookmark_border,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
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
