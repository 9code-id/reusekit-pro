import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSourceDetailView extends StatefulWidget {
  const NmaSourceDetailView({super.key});

  @override
  State<NmaSourceDetailView> createState() => _NmaSourceDetailViewState();
}

class _NmaSourceDetailViewState extends State<NmaSourceDetailView> {
  bool isFollowing = true;
  bool notificationsEnabled = true;
  String selectedCategory = "all";
  
  Map<String, dynamic> sourceData = {
    "id": "bbc",
    "name": "BBC News",
    "description": "Breaking news, world news, UK news, business, politics, technology, science, health, family news and educational resources",
    "logo": "https://picsum.photos/120/120?random=1&keyword=bbc",
    "cover": "https://picsum.photos/400/200?random=2&keyword=newsroom",
    "url": "https://bbc.com/news",
    "founded": "1922",
    "headquarters": "London, United Kingdom",
    "verified": true,
    "followers": 15420000,
    "following": 1250,
    "articlesPerDay": 120,
    "totalArticles": 2450000,
    "language": "English",
    "rating": 4.8,
    "reviews": 125000,
    "categories": ["General News", "Politics", "Business", "Technology", "Sports", "Health"],
    "socialMedia": {
      "twitter": "@BBCNews",
      "facebook": "BBCNews",
      "instagram": "@bbcnews",
      "youtube": "BBCNews"
    },
    "contact": {
      "email": "news@bbc.co.uk",
      "phone": "+44 20 8743 8000",
      "address": "Broadcasting House, Portland Place, London W1A 0AA, UK"
    }
  };

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Articles", "value": "all"},
    {"label": "Breaking News", "value": "breaking"},
    {"label": "Politics", "value": "politics"},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "technology"},
    {"label": "Sports", "value": "sports"},
    {"label": "Health", "value": "health"},
  ];

  List<Map<String, dynamic>> recentArticles = [
    {
      "title": "Global Climate Summit Reaches Historic Agreement",
      "summary": "World leaders unite on ambitious climate action plan",
      "publishedAt": "2 hours ago",
      "category": "Politics",
      "image": "https://picsum.photos/300/200?random=11&keyword=climate",
      "readTime": "4 min read",
      "views": 125000,
    },
    {
      "title": "Tech Giants Report Strong Q4 Earnings",
      "summary": "Major technology companies exceed market expectations",
      "publishedAt": "4 hours ago",
      "category": "Technology",
      "image": "https://picsum.photos/300/200?random=12&keyword=technology",
      "readTime": "3 min read",
      "views": 89000,
    },
    {
      "title": "New Medical Breakthrough in Cancer Research",
      "summary": "Scientists discover promising treatment approach",
      "publishedAt": "6 hours ago",
      "category": "Health",
      "image": "https://picsum.photos/300/200?random=13&keyword=medical",
      "readTime": "5 min read",
      "views": 156000,
    },
    {
      "title": "International Trade Agreement Signed",
      "summary": "Historic deal to boost global economic cooperation",
      "publishedAt": "8 hours ago",
      "category": "Business",
      "image": "https://picsum.photos/300/200?random=14&keyword=business",
      "readTime": "6 min read",
      "views": 78000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Cover Image
            Container(
              height: 250,
              child: Stack(
                children: [
                  // Cover Image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${sourceData["cover"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(100),
                            Colors.black.withAlpha(200),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // AppBar
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: () => back(),
                        child: Container(
                          margin: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      actions: [
                        Container(
                          margin: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              _shareSource();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Source Logo
                  Positioned(
                    bottom: 0,
                    left: spMd,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          image: NetworkImage("${sourceData["logo"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Source Info Section
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Follow Button
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${sourceData["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (sourceData["verified"] as bool)
                                  SizedBox(width: spSm),
                                if (sourceData["verified"] as bool)
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Founded ${sourceData["founded"]} • ${sourceData["headquarters"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: isFollowing ? "Following" : "Follow",
                        size: bs.md,
                        onPressed: () {
                          _toggleFollow();
                        },
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    "${sourceData["description"]}",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Followers",
                          "${((sourceData["followers"] as int) / 1000000).toStringAsFixed(1)}M",
                          Icons.people,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Articles",
                          "${((sourceData["totalArticles"] as int) / 1000000).toStringAsFixed(1)}M",
                          Icons.article,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Rating",
                          "${(sourceData["rating"] as double).toStringAsFixed(1)}/5.0",
                          Icons.star,
                        ),
                      ),
                    ],
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Website",
                          size: bs.sm,
                          onPressed: () {
                            _openWebsite();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: notificationsEnabled ? "Notifications On" : "Enable Notifications",
                          size: bs.sm,
                          onPressed: () {
                            _toggleNotifications();
                          },
                        ),
                      ),
                    ],
                  ),

                  // Categories
                  QCategoryPicker(
                    label: "Filter by Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Recent Articles Section
                  Text(
                    "Recent Articles",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  ...recentArticles.map((article) => _buildArticleItem(article)),

                  // Load More Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Load More Articles",
                      size: bs.md,
                      onPressed: () {
                        _loadMoreArticles();
                      },
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

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleItem(Map<String, dynamic> article) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Article Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${article["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          
          // Article Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${article["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spXs),
                Text(
                  "${article["summary"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${article["publishedAt"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "•",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${article["readTime"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
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
  }

  void _toggleFollow() {
    isFollowing = !isFollowing;
    setState(() {});
    ss(isFollowing ? "Following ${sourceData["name"]}" : "Unfollowed ${sourceData["name"]}");
  }

  void _toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    setState(() {});
    ss(notificationsEnabled ? "Notifications enabled" : "Notifications disabled");
  }

  void _shareSource() {
    ss("Sharing ${sourceData["name"]}");
  }

  void _openWebsite() {
    ss("Opening ${sourceData["url"]}");
  }

  void _loadMoreArticles() {
    ss("Loading more articles...");
  }
}
