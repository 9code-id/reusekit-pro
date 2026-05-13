import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArticle9View extends StatefulWidget {
  @override
  State<GrlArticle9View> createState() => _GrlArticle9ViewState();
}

class _GrlArticle9ViewState extends State<GrlArticle9View> {
  Map<String, dynamic> authorProfile = {
    "name": "Dr. Sarah Johnson",
    "title": "AI Research Scientist",
    "bio": "Leading researcher in artificial intelligence applications for healthcare. Published over 50 papers in top-tier journals and speaks at international conferences.",
    "image": "https://picsum.photos/150/150?random=1&keyword=woman-professional",
    "verified": true,
    "joinDate": "2022-03-15",
    "location": "San Francisco, CA",
    "website": "https://sarahjohnson.ai",
    "email": "sarah@sarahjohnson.ai",
    "followers": 15420,
    "following": 234,
    "articles": 42,
    "totalViews": 456789,
    "expertise": ["Artificial Intelligence", "Machine Learning", "Healthcare Technology", "Data Science"],
    "social": {
      "twitter": "@sarahjohnson_ai",
      "linkedin": "sarahjohnsonai",
      "github": "sarahjohnson"
    }
  };

  List<Map<String, dynamic>> publishedArticles = [
    {
      "id": 1,
      "title": "The Future of AI in Medical Diagnosis",
      "category": "Healthcare",
      "publishDate": "2024-12-10",
      "readTime": "8 min read",
      "views": 12400,
      "likes": 456,
      "comments": 23,
      "image": "https://picsum.photos/300/200?random=1&keyword=medical-ai",
      "status": "published",
      "featured": true
    },
    {
      "id": 2,
      "title": "Machine Learning Algorithms for Drug Discovery",
      "category": "Research",
      "publishDate": "2024-12-05",
      "readTime": "12 min read",
      "views": 8900,
      "likes": 312,
      "comments": 18,
      "image": "https://picsum.photos/300/200?random=2&keyword=drug-research",
      "status": "published",
      "featured": false
    },
    {
      "id": 3,
      "title": "Ethics in AI Healthcare Applications",
      "category": "Ethics",
      "publishDate": "2024-11-28",
      "readTime": "10 min read",
      "views": 15600,
      "likes": 789,
      "comments": 45,
      "image": "https://picsum.photos/300/200?random=3&keyword=ai-ethics",
      "status": "published",
      "featured": true
    },
    {
      "id": 4,
      "title": "Deep Learning for Medical Image Analysis",
      "category": "Technology",
      "publishDate": "2024-11-20",
      "readTime": "15 min read",
      "views": 21300,
      "likes": 923,
      "comments": 67,
      "image": "https://picsum.photos/300/200?random=4&keyword=medical-imaging",
      "status": "published",
      "featured": false
    }
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Top Author 2024",
      "description": "Recognized as one of the top contributing authors",
      "icon": Icons.star,
      "color": warningColor,
      "date": "2024-12-01"
    },
    {
      "title": "100K+ Views",
      "description": "Articles reached over 100,000 total views",
      "icon": Icons.visibility,
      "color": successColor,
      "date": "2024-11-15"
    },
    {
      "title": "Expert Contributor",
      "description": "Verified expert in AI and Healthcare",
      "icon": Icons.verified,
      "color": infoColor,
      "date": "2024-10-20"
    }
  ];

  bool isFollowing = false;
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Background
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withAlpha(200)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + spSm,
                  right: spMd,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.share, color: Colors.white, size: 20),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(Icons.more_vert, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Profile Info Section
            Transform.translate(
              offset: Offset(0, -60),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: spMd),
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowLg],
                ),
                child: Column(
                  children: [
                    // Profile Image and Basic Info
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage("${authorProfile["image"]}"),
                        ),
                        if (authorProfile["verified"]) ...[
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Icon(Icons.check, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    Text(
                      "${authorProfile["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${authorProfile["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: disabledColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${authorProfile["location"]}",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                        SizedBox(width: spMd),
                        Icon(Icons.calendar_today, color: disabledColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Joined ${authorProfile["joinDate"]}",
                          style: TextStyle(color: disabledBoldColor),
                        ),
                      ],
                    ),

                    SizedBox(height: spLg),

                    // Stats Row
                    Row(
                      children: [
                        _buildStatColumn("Articles", "${authorProfile["articles"]}"),
                        _buildStatColumn("Followers", "${((authorProfile["followers"] as int) / 1000).toStringAsFixed(1)}K"),
                        _buildStatColumn("Following", "${authorProfile["following"]}"),
                        _buildStatColumn("Views", "${((authorProfile["totalViews"] as int) / 1000).toStringAsFixed(0)}K"),
                      ],
                    ),

                    SizedBox(height: spLg),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: isFollowing ? "Following" : "Follow",
                            size: bs.md,
                            onPressed: () {
                              isFollowing = !isFollowing;
                              setState(() {});
                              if (isFollowing) {
                                ss("Now following ${authorProfile["name"]}");
                              } else {
                                si("Unfollowed ${authorProfile["name"]}");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: QButton(
                            label: "Message",
                            size: bs.md,
                            onPressed: () {
                              si("Opening message composer");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Content Section
            Container(
              margin: EdgeInsets.only(top: -40),
              child: Column(
                children: [
                  // Tab Navigation
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        _buildTabButton("About", 0),
                        _buildTabButton("Articles", 1),
                        _buildTabButton("Achievements", 2),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Tab Content
                  if (currentTab == 0) _buildAboutTab(),
                  if (currentTab == 1) _buildArticlesTab(),
                  if (currentTab == 2) _buildAchievementsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    bool isSelected = currentTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          currentTab = index;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: spMd),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : disabledBoldColor,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "${authorProfile["bio"]}",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Expertise
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Areas of Expertise",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Wrap(
                  spacing: spSm,
                  runSpacing: spSm,
                  children: (authorProfile["expertise"] as List).map<Widget>((expertise) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: primaryColor.withAlpha(60)),
                      ),
                      child: Text(
                        expertise,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Contact & Social
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Connect",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildContactItem(Icons.language, "Website", "${authorProfile["website"]}"),
                _buildContactItem(Icons.email, "Email", "${authorProfile["email"]}"),
                _buildContactItem(Icons.alternate_email, "Twitter", "${authorProfile["social"]["twitter"]}"),
                _buildContactItem(Icons.work, "LinkedIn", "${authorProfile["social"]["linkedin"]}"),
                _buildContactItem(Icons.code, "GitHub", "${authorProfile["social"]["github"]}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: publishedArticles.map((article) {
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
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${article["image"]}",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (article["featured"]) ...[
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Featured",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          "${article["category"]}",
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
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${article["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${article["publishDate"]} • ${article["readTime"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(40),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Published",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(Icons.visibility, color: disabledColor, size: 16),
                          SizedBox(width: spXs),
                          Text("${article["views"]}", style: TextStyle(color: disabledColor, fontSize: 12)),
                          SizedBox(width: spMd),
                          Icon(Icons.favorite, color: disabledColor, size: 16),
                          SizedBox(width: spXs),
                          Text("${article["likes"]}", style: TextStyle(color: disabledColor, fontSize: 12)),
                          SizedBox(width: spMd),
                          Icon(Icons.comment, color: disabledColor, size: 16),
                          SizedBox(width: spXs),
                          Text("${article["comments"]}", style: TextStyle(color: disabledColor, fontSize: 12)),
                          Spacer(),
                          QButton(
                            label: "Read",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAchievementsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: achievements.map((achievement) {
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
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (achievement["color"] as Color).withAlpha(40),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    achievement["icon"],
                    color: achievement["color"],
                    size: 28,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${achievement["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${achievement["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Earned on ${achievement["date"]}",
                        style: TextStyle(
                          color: disabledColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
