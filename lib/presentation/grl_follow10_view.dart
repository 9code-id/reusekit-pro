import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFollow10View extends StatefulWidget {
  @override
  State<GrlFollow10View> createState() => _GrlFollow10ViewState();
}

class _GrlFollow10ViewState extends State<GrlFollow10View> {
  String searchQuery = "";
  bool showMutualOnly = false;
  int selectedSort = 0;
  
  List<String> sortOptions = [
    "Most Relevant",
    "Most Followers", 
    "Alphabetical",
    "Recently Active"
  ];

  List<Map<String, dynamic>> trendingCreators = [
    {
      "name": "Alexandra Chen",
      "username": "@alexandrachen",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "cover": "https://picsum.photos/300/150?random=1&keyword=art",
      "category": "Digital Art",
      "followers": "2.4M",
      "engagement": "12.5%",
      "verified": true,
      "trending": true,
      "growthRate": "+45%",
      "bio": "Digital artist creating surreal worlds and characters",
      "weeklyViews": "4.2M",
      "mutualConnections": 18,
      "topContent": [
        "https://picsum.photos/100/100?random=11&keyword=art",
        "https://picsum.photos/100/100?random=12&keyword=digital",
        "https://picsum.photos/100/100?random=13&keyword=creative"
      ],
      "badges": ["Rising Star", "Top Creator"]
    },
    {
      "name": "Marcus Rodriguez",
      "username": "@marcusrodriguez",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "cover": "https://picsum.photos/300/150?random=2&keyword=tech",
      "category": "Technology",
      "followers": "1.8M",
      "engagement": "8.7%",
      "verified": true,
      "trending": false,
      "growthRate": "+32%",
      "bio": "Tech entrepreneur sharing startup insights and innovation",
      "weeklyViews": "3.1M",
      "mutualConnections": 24,
      "topContent": [
        "https://picsum.photos/100/100?random=21&keyword=tech",
        "https://picsum.photos/100/100?random=22&keyword=startup",
        "https://picsum.photos/100/100?random=23&keyword=innovation"
      ],
      "badges": ["Thought Leader", "Verified Expert"]
    },
    {
      "name": "Sophia Williams",
      "username": "@sophiawilliams",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "cover": "https://picsum.photos/300/150?random=3&keyword=fashion",
      "category": "Fashion & Lifestyle",
      "followers": "3.2M",
      "engagement": "15.3%",
      "verified": true,
      "trending": true,
      "growthRate": "+67%",
      "bio": "Fashion designer and sustainable lifestyle advocate",
      "weeklyViews": "5.8M",
      "mutualConnections": 12,
      "topContent": [
        "https://picsum.photos/100/100?random=31&keyword=fashion",
        "https://picsum.photos/100/100?random=32&keyword=style",
        "https://picsum.photos/100/100?random=33&keyword=lifestyle"
      ],
      "badges": ["Trending", "Fashion Icon"]
    },
    {
      "name": "David Kim",
      "username": "@davidkim",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=man",
      "cover": "https://picsum.photos/300/150?random=4&keyword=food",
      "category": "Food & Cooking",
      "followers": "987K",
      "engagement": "18.9%",
      "verified": false,
      "trending": true,
      "growthRate": "+89%",
      "bio": "Chef creating innovative fusion cuisine and cooking tutorials",
      "weeklyViews": "2.7M",
      "mutualConnections": 8,
      "topContent": [
        "https://picsum.photos/100/100?random=41&keyword=food",
        "https://picsum.photos/100/100?random=42&keyword=cooking",
        "https://picsum.photos/100/100?random=43&keyword=recipe"
      ],
      "badges": ["Rising Chef", "Viral Creator"]
    },
    {
      "name": "Emma Thompson",
      "username": "@emmathompson",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=woman",
      "cover": "https://picsum.photos/300/150?random=5&keyword=travel",
      "category": "Travel & Adventure",
      "followers": "1.5M",
      "engagement": "11.2%",
      "verified": true,
      "trending": false,
      "growthRate": "+28%",
      "bio": "Adventure photographer capturing the world's hidden gems",
      "weeklyViews": "3.9M",
      "mutualConnections": 15,
      "topContent": [
        "https://picsum.photos/100/100?random=51&keyword=travel",
        "https://picsum.photos/100/100?random=52&keyword=adventure",
        "https://picsum.photos/100/100?random=53&keyword=nature"
      ],
      "badges": ["Travel Expert", "Photography Pro"]
    },
    {
      "name": "James Wilson",
      "username": "@jameswilson",
      "avatar": "https://picsum.photos/80/80?random=6&keyword=man",
      "cover": "https://picsum.photos/300/150?random=6&keyword=fitness",
      "category": "Fitness & Health",
      "followers": "756K",
      "engagement": "22.1%",
      "verified": false,
      "trending": true,
      "growthRate": "+156%",
      "bio": "Fitness coach helping people transform their lives",
      "weeklyViews": "1.8M",
      "mutualConnections": 6,
      "topContent": [
        "https://picsum.photos/100/100?random=61&keyword=fitness",
        "https://picsum.photos/100/100?random=62&keyword=workout",
        "https://picsum.photos/100/100?random=63&keyword=health"
      ],
      "badges": ["Fitness Guru", "Transformation Expert"]
    }
  ];

  List<Map<String, dynamic>> get filteredCreators {
    List<Map<String, dynamic>> filtered = trendingCreators;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((creator) =>
        (creator["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (creator["username"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (creator["category"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (creator["bio"] as String).toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    
    if (showMutualOnly) {
      filtered = filtered.where((creator) => 
        (creator["mutualConnections"] as int) > 0).toList();
    }
    
    // Sort based on selected option
    switch (selectedSort) {
      case 0: // Most Relevant
        filtered.sort((a, b) {
          int scoreA = (a["trending"] as bool ? 100 : 0) + (a["mutualConnections"] as int);
          int scoreB = (b["trending"] as bool ? 100 : 0) + (b["mutualConnections"] as int);
          return scoreB.compareTo(scoreA);
        });
        break;
      case 1: // Most Followers
        filtered.sort((a, b) {
          double aFollowers = _parseFollowerCount(a["followers"] as String);
          double bFollowers = _parseFollowerCount(b["followers"] as String);
          return bFollowers.compareTo(aFollowers);
        });
        break;
      case 2: // Alphabetical
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case 3: // Recently Active
        filtered.sort((a, b) {
          double aEngagement = double.parse((a["engagement"] as String).replaceAll('%', ''));
          double bEngagement = double.parse((b["engagement"] as String).replaceAll('%', ''));
          return bEngagement.compareTo(aEngagement);
        });
        break;
    }
    
    return filtered;
  }

  double _parseFollowerCount(String followers) {
    if (followers.contains('M')) {
      return double.parse(followers.replaceAll('M', '')) * 1000000;
    } else if (followers.contains('K')) {
      return double.parse(followers.replaceAll('K', '')) * 1000;
    }
    return double.tryParse(followers) ?? 0;
  }

  void _followCreator(int index) {
    final creator = filteredCreators[index];
    ss("Started following ${creator["name"]}!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Creators"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Refreshing trending creators...");
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trending Creators",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Discover the most popular creators and rising stars",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      _buildStatBadge("${trendingCreators.length}", "Creators"),
                      SizedBox(width: spSm),
                      _buildStatBadge("${trendingCreators.where((c) => c["trending"]).length}", "Trending"),
                      SizedBox(width: spSm),
                      _buildStatBadge("${trendingCreators.where((c) => c["verified"]).length}", "Verified"),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Search and Filters
            QTextField(
              label: "Search creators...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show mutual connections only",
                        "value": true,
                        "checked": showMutualOnly,
                      }
                    ],
                    value: [
                      if (showMutualOnly)
                        {
                          "label": "Show mutual connections only",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showMutualOnly = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: DropdownButton<int>(
                    value: selectedSort,
                    underline: SizedBox.shrink(),
                    items: sortOptions.asMap().entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(
                          entry.value,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedSort = value ?? 0;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Results Header
            Text(
              "Showing ${filteredCreators.length} creators",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            // Creators List
            ...List.generate(filteredCreators.length, (index) {
              final creator = filteredCreators[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image
                    Stack(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            image: DecorationImage(
                              image: NetworkImage("${creator["cover"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (creator["trending"] as bool)
                          Positioned(
                            top: spSm,
                            right: spSm,
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
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Trending",
                                    style: TextStyle(
                                      fontSize: 12,
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
                    
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Header
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
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
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        if (creator["verified"] as bool) ...[
                                          SizedBox(width: spXs),
                                          Icon(
                                            Icons.verified,
                                            size: 16,
                                            color: successColor,
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      "${creator["username"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: spXs),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${creator["category"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              QButton(
                                label: "Follow",
                                size: bs.sm,
                                onPressed: () => _followCreator(index),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Bio
                          Text(
                            "${creator["bio"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Stats Row
                          Row(
                            children: [
                              _buildCreatorStat("${creator["followers"]}", "Followers"),
                              SizedBox(width: spMd),
                              _buildCreatorStat("${creator["engagement"]}", "Engagement"),
                              SizedBox(width: spMd),
                              _buildCreatorStat("${creator["growthRate"]}", "Growth"),
                              Spacer(),
                              if ((creator["mutualConnections"] as int) > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${creator["mutualConnections"]} mutual",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Badges
                          if ((creator["badges"] as List).isNotEmpty) ...[
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (creator["badges"] as List).map((badge) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "$badge",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                          ],
                          
                          // Top Content
                          Text(
                            "Top Content",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          QHorizontalScroll(
                            children: List.generate((creator["topContent"] as List).length, (contentIndex) {
                              return Container(
                                width: 80,
                                height: 80,
                                margin: EdgeInsets.only(right: spXs),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  image: DecorationImage(
                                    image: NetworkImage("${(creator["topContent"] as List)[contentIndex]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
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
      ),
    );
  }

  Widget _buildStatBadge(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatorStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
