import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaCommunityView extends StatefulWidget {
  const NmaCommunityView({super.key});

  @override
  State<NmaCommunityView> createState() => _NmaCommunityViewState();
}

class _NmaCommunityViewState extends State<NmaCommunityView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";

  final List<Map<String, dynamic>> communityPosts = [
    {
      "id": "post_001",
      "author": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&face",
      "timestamp": "2 hours ago",
      "category": "Breaking News",
      "title": "Major Infrastructure Development Announced",
      "content": "City officials announced a \$500M infrastructure development project that will transform downtown area over the next 3 years. The project includes new roads, bridges, and public facilities.",
      "image": "https://picsum.photos/400/300?random=1&city",
      "likes": 234,
      "comments": 45,
      "shares": 12,
      "isVerified": true,
      "isBreaking": true
    },
    {
      "id": "post_002",
      "author": "Michael Chen",
      "avatar": "https://picsum.photos/100/100?random=2&face",
      "timestamp": "4 hours ago",
      "category": "Local Events",
      "title": "Community Festival This Weekend",
      "content": "Join us for the annual community festival featuring local vendors, live music, and family activities. Free admission for all residents. Food trucks and entertainment from 10 AM to 8 PM.",
      "image": "https://picsum.photos/400/300?random=2&festival",
      "likes": 156,
      "comments": 23,
      "shares": 8,
      "isVerified": false,
      "isBreaking": false
    },
    {
      "id": "post_003",
      "author": "Emma Davis",
      "avatar": "https://picsum.photos/100/100?random=3&face",
      "timestamp": "6 hours ago",
      "category": "Weather Alert",
      "title": "Severe Weather Warning Issued",
      "content": "National Weather Service has issued a severe thunderstorm warning for our area. Heavy rain and strong winds expected tonight. Residents advised to secure outdoor items and avoid unnecessary travel.",
      "image": "https://picsum.photos/400/300?random=3&storm",
      "likes": 89,
      "comments": 34,
      "shares": 67,
      "isVerified": true,
      "isBreaking": true
    },
    {
      "id": "post_004",
      "author": "James Wilson",
      "avatar": "https://picsum.photos/100/100?random=4&face",
      "timestamp": "8 hours ago",
      "category": "Sports",
      "title": "Local Team Wins Championship",
      "content": "Our hometown basketball team secured their first championship in 15 years! The thrilling final game ended 98-94 in overtime. Celebration parade scheduled for this Saturday downtown.",
      "image": "https://picsum.photos/400/300?random=4&sports",
      "likes": 378,
      "comments": 67,
      "shares": 23,
      "isVerified": false,
      "isBreaking": false
    },
    {
      "id": "post_005",
      "author": "Lisa Rodriguez",
      "avatar": "https://picsum.photos/100/100?random=5&face",
      "timestamp": "1 day ago",
      "category": "Health",
      "title": "New Healthcare Facility Opens",
      "content": "State-of-the-art medical center officially opened its doors today. The facility offers 24/7 emergency services, specialized care, and latest medical technology. Free health screenings available this week.",
      "image": "https://picsum.photos/400/300?random=5&hospital",
      "likes": 198,
      "comments": 28,
      "shares": 15,
      "isVerified": true,
      "isBreaking": false
    }
  ];

  final List<Map<String, dynamic>> trendingTopics = [
    {"topic": "#InfrastructureDevelopment", "posts": 125},
    {"topic": "#CommunityFestival", "posts": 89},
    {"topic": "#WeatherAlert", "posts": 156},
    {"topic": "#LocalChampions", "posts": 67},
    {"topic": "#HealthcareNews", "posts": 45},
  ];

  final List<Map<String, dynamic>> contributors = [
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&face",
      "role": "Verified Reporter",
      "posts": 234,
      "followers": 1567,
      "isVerified": true
    },
    {
      "name": "Michael Chen",
      "avatar": "https://picsum.photos/100/100?random=2&face",
      "role": "Community Member",
      "posts": 89,
      "followers": 456,
      "isVerified": false
    },
    {
      "name": "Emma Davis",
      "avatar": "https://picsum.photos/100/100?random=3&face",
      "role": "Weather Correspondent",
      "posts": 167,
      "followers": 890,
      "isVerified": true
    },
    {
      "name": "James Wilson",
      "avatar": "https://picsum.photos/100/100?random=4&face",
      "role": "Sports Reporter",
      "posts": 145,
      "followers": 723,
      "isVerified": false
    }
  ];

  List<Map<String, dynamic>> get filteredPosts {
    return communityPosts.where((post) {
      final matchesCategory = selectedCategory == "All" || post["category"] == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          post["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          post["content"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Breaking News":
        return dangerColor;
      case "Weather Alert":
        return warningColor;
      case "Local Events":
        return infoColor;
      case "Sports":
        return successColor;
      case "Health":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("${post["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${post["author"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (post["isVerified"])
                          Row(
                            children: [
                              SizedBox(width: spXs),
                              Icon(
                                Icons.verified,
                                color: successColor,
                                size: 16,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Text(
                      "${post["timestamp"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getCategoryColor(post["category"]).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${post["category"]}",
                  style: TextStyle(
                    color: _getCategoryColor(post["category"]),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              Expanded(
                child: Text(
                  "${post["title"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (post["isBreaking"])
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "BREAKING",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Text(
            "${post["content"]}",
            style: TextStyle(
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${post["image"]}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ss("Post liked!");
                },
                child: Row(
                  children: [
                    Icon(Icons.favorite_border, color: disabledBoldColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${post["likes"]}",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {
                  ss("Comments feature coming soon");
                },
                child: Row(
                  children: [
                    Icon(Icons.comment_outlined, color: disabledBoldColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${post["comments"]}",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {
                  ss("Share feature coming soon");
                },
                child: Row(
                  children: [
                    Icon(Icons.share_outlined, color: disabledBoldColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${post["shares"]}",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Bookmark feature coming soon");
                },
                child: Icon(Icons.bookmark_border, color: disabledBoldColor, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          color: Colors.white,
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search community posts...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: () {
                      ss("Create post feature coming soon");
                    },
                  ),
                ],
              ),
              QDropdownField(
                label: "Category",
                items: [
                  {"label": "All Categories", "value": "All"},
                  {"label": "Breaking News", "value": "Breaking News"},
                  {"label": "Local Events", "value": "Local Events"},
                  {"label": "Weather Alert", "value": "Weather Alert"},
                  {"label": "Sports", "value": "Sports"},
                  {"label": "Health", "value": "Health"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: filteredPosts.map((post) => _buildPostCard(post)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: Colors.white, size: 32),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trending Topics",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Most discussed topics in the community",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          ...trendingTopics.asMap().entries.map((entry) {
            final index = entry.key;
            final topic = entry.value;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: index == 0 
                        ? Colors.amber
                        : index == 1 
                          ? Colors.grey.shade400
                          : index == 2
                            ? Colors.orange.shade700
                            : primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${topic["topic"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${topic["posts"]} posts",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContributorsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Contributors",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Community members making the biggest impact",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          ...contributors.map((contributor) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("${contributor["avatar"]}"),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${contributor["name"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (contributor["isVerified"])
                              Row(
                                children: [
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Text(
                          "${contributor["role"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.article, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${contributor["posts"]} posts",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.people, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${contributor["followers"]} followers",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Follow",
                    size: bs.sm,
                    onPressed: () {
                      ss("Follow feature coming soon");
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Community",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Feed", icon: Icon(Icons.feed)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Contributors", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildFeedTab(),
        _buildTrendingTab(),
        _buildContributorsTab(),
      ],
    );
  }
}
