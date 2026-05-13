import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover7View extends StatefulWidget {
  @override
  State<GrlDiscover7View> createState() => _GrlDiscover7ViewState();
}

class _GrlDiscover7ViewState extends State<GrlDiscover7View> {
  int selectedTabIndex = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> trendingTopics = [
    {
      "title": "Sustainable Living",
      "posts": 1250,
      "growth": "+15%",
      "icon": Icons.eco,
      "color": successColor,
    },
    {
      "title": "Remote Work Tips",
      "posts": 892,
      "growth": "+8%",
      "icon": Icons.laptop,
      "color": primaryColor,
    },
    {
      "title": "Healthy Recipes",
      "posts": 1456,
      "growth": "+22%",
      "icon": Icons.restaurant,
      "color": warningColor,
    },
    {
      "title": "Tech Innovation",
      "posts": 678,
      "growth": "+12%",
      "icon": Icons.rocket_launch,
      "color": infoColor,
    }
  ];

  List<Map<String, dynamic>> recentDiscoveries = [
    {
      "type": "Article",
      "title": "The Future of Space Exploration",
      "author": "NASA Research",
      "timestamp": "2 hours ago",
      "image": "https://picsum.photos/300/200?random=1&keyword=space",
      "readTime": "5 min",
      "category": "Science"
    },
    {
      "type": "Video",
      "title": "Mastering Digital Photography",
      "author": "Photo Academy",
      "timestamp": "4 hours ago", 
      "image": "https://picsum.photos/300/200?random=2&keyword=camera",
      "duration": "12:30",
      "category": "Education"
    },
    {
      "type": "Podcast",
      "title": "Entrepreneurship Mindset",
      "author": "Business Talks",
      "timestamp": "6 hours ago",
      "image": "https://picsum.photos/300/200?random=3&keyword=business",
      "duration": "45:20",
      "category": "Business"
    },
    {
      "type": "Article",
      "title": "Climate Change Solutions",
      "author": "Environmental Science",
      "timestamp": "8 hours ago",
      "image": "https://picsum.photos/300/200?random=4&keyword=environment",
      "readTime": "8 min",
      "category": "Environment"
    }
  ];

  List<Map<String, dynamic>> collections = [
    {
      "name": "Tech Trends 2024",
      "itemCount": 15,
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=technology",
      "description": "Latest developments in technology",
      "curator": "Tech Weekly",
      "isFollowing": true
    },
    {
      "name": "Wellness Journey",
      "itemCount": 23,
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=wellness",
      "description": "Mental and physical health tips",
      "curator": "Health Expert",
      "isFollowing": false
    },
    {
      "name": "Creative Inspiration",
      "itemCount": 31,
      "thumbnail": "https://picsum.photos/300/200?random=7&keyword=art",
      "description": "Design and art inspiration",
      "curator": "Creative Studio",
      "isFollowing": true
    },
    {
      "name": "Cooking Mastery",
      "itemCount": 18,
      "thumbnail": "https://picsum.photos/300/200?random=8&keyword=cooking",
      "description": "Professional cooking techniques",
      "curator": "Chef Masters",
      "isFollowing": false
    }
  ];

  List<Map<String, dynamic>> suggestedUsers = [
    {
      "name": "Dr. Sarah Chen",
      "expertise": "AI Research",
      "followers": "125K",
      "avatar": "SC",
      "isFollowing": false,
      "recentPost": "Breaking down neural networks"
    },
    {
      "name": "Mark Thompson",
      "expertise": "Sustainable Design",
      "followers": "89K",
      "avatar": "MT",
      "isFollowing": true,
      "recentPost": "Eco-friendly architecture trends"
    },
    {
      "name": "Lisa Rodriguez",
      "expertise": "Digital Marketing",
      "followers": "156K",
      "avatar": "LR",
      "isFollowing": false,
      "recentPost": "Social media strategy guide"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discover Hub"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () => _showNotifications(),
          ),
          IconButton(
            icon: Icon(Icons.person_add_alt),
            onPressed: () => _showSuggestedUsers(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search discoveries...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () => _showFilterOptions(),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
              children: [
                _buildTabButton("Trending", 0),
                _buildTabButton("Recent", 1),
                _buildTabButton("Collections", 2),
                _buildTabButton("Following", 3),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: IndexedStack(
              index: selectedTabIndex,
              children: [
                _buildTrendingTab(),
                _buildRecentTab(),
                _buildCollectionsTab(),
                _buildFollowingTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedTabIndex = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? primaryColor : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), secondaryColor.withAlpha(20)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What's Trending",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Discover the most popular topics right now",
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Trending Topics Grid
          Text(
            "Trending Topics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: trendingTopics.map((topic) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (topic["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            topic["icon"],
                            color: topic["color"],
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${topic["growth"]}",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Text(
                      "${topic["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.article,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${topic["posts"]} posts",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    QButton(
                      label: "Explore Topic",
                      size: bs.sm,
                      onPressed: () {
                        si("Exploring ${topic["title"]}");
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Insights
          Text(
            "Quick Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInsightCard("Active Users", "24.5K", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInsightCard("New Posts", "1.2K", Icons.post_add, primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInsightCard("Trending Now", "89", Icons.trending_up, warningColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInsightCard("Popular Tags", "156", Icons.tag, secondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: recentDiscoveries.length,
      itemBuilder: (context, index) {
        final item = recentDiscoveries[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              // Image with type overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(radiusLg)),
                    child: Image.network(
                      "${item["image"]}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    left: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getTypeColor("${item["type"]}"),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["type"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${item["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      Row(
                        children: [
                          Text(
                            "${item["author"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " • ${item["timestamp"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                            decoration: BoxDecoration(
                              color: _getCategoryColor("${item["category"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${item["category"]}",
                              style: TextStyle(
                                color: _getCategoryColor("${item["category"]}"),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            item["type"] == "Video" || item["type"] == "Podcast" 
                              ? Icons.play_circle_outline 
                              : Icons.access_time,
                            size: 12,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            item["type"] == "Video" || item["type"] == "Podcast"
                              ? "${item["duration"]}"
                              : "${item["readTime"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Action button
              Padding(
                padding: EdgeInsets.only(right: spSm),
                child: QButton(
                  icon: item["type"] == "Video" || item["type"] == "Podcast" 
                    ? Icons.play_arrow 
                    : Icons.article,
                  size: bs.sm,
                  onPressed: () {
                    si("Opening ${item["title"]}");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCollectionsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Stack(
                  children: [
                    Image.network(
                      "${collection["thumbnail"]}",
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
                          "${collection["itemCount"]} items",
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

              // Content
              Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${collection["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "${collection["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),

                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: secondaryColor.withAlpha(20),
                          child: Text(
                            "${collection["curator"]}".substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "by ${collection["curator"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        QButton(
                          label: collection["isFollowing"] ? "Following" : "Follow",
                          size: bs.sm,
                          color: collection["isFollowing"] ? disabledBoldColor : primaryColor,
                          onPressed: () {
                            collection["isFollowing"] = !collection["isFollowing"];
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Explore Collection",
                        onPressed: () {
                          si("Exploring ${collection["name"]}");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFollowingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Following Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "23",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "156",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "New Posts",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: disabledOutlineBorderColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Collections",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Empty State
          Container(
            padding: EdgeInsets.all(spMd * 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people_outline,
                  size: 64,
                  color: disabledBoldColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "Start Following Creators",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Follow your favorite creators to see their latest content in your personalized feed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Discover Creators",
                  onPressed: () => _showSuggestedUsers(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Article":
        return primaryColor;
      case "Video":
        return dangerColor;
      case "Podcast":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Science":
        return infoColor;
      case "Education":
        return warningColor;
      case "Business":
        return primaryColor;
      case "Environment":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showNotifications() {
    si("No new notifications");
  }

  void _showSuggestedUsers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Suggested Creators",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(spMd),
                itemCount: suggestedUsers.length,
                itemBuilder: (context, index) {
                  final user = suggestedUsers[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: primaryColor.withAlpha(20),
                              child: Text(
                                "${user["avatar"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${user["expertise"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${user["followers"]} followers",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              label: user["isFollowing"] ? "Following" : "Follow",
                              size: bs.sm,
                              color: user["isFollowing"] ? disabledBoldColor : primaryColor,
                              onPressed: () {
                                user["isFollowing"] = !user["isFollowing"];
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recent Post:",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${user["recentPost"]}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
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
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Filter & Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.tune,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Advanced filtering options coming soon",
                    style: TextStyle(
                      color: disabledBoldColor,
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
