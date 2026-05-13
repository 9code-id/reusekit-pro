import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaAuthorProfileView extends StatefulWidget {
  const NmaAuthorProfileView({super.key});

  @override
  State<NmaAuthorProfileView> createState() => _NmaAuthorProfileViewState();
}

class _NmaAuthorProfileViewState extends State<NmaAuthorProfileView> {
  bool isFollowing = true;
  bool notificationsEnabled = true;
  String selectedTab = "articles";
  
  Map<String, dynamic> authorData = {
    "id": "john_smith",
    "name": "John Smith",
    "title": "Senior Political Correspondent",
    "organization": "BBC News",
    "avatar": "https://picsum.photos/120/120?random=1&keyword=journalist",
    "cover": "https://picsum.photos/400/200?random=2&keyword=newsroom",
    "bio": "Award-winning political journalist with 15+ years of experience covering international affairs, government policy, and breaking news. Specialized in Middle East politics and US foreign policy.",
    "location": "Washington, D.C.",
    "email": "john.smith@bbc.co.uk",
    "phone": "+1 (555) 123-4567",
    "website": "https://johnsmithjournalist.com",
    "followers": 125000,
    "following": 890,
    "articles": 1850,
    "rating": 4.8,
    "reviews": 15600,
    "joinedDate": "March 2018",
    "verified": true,
    "categories": ["Politics", "World News", "International Affairs"],
    "awards": [
      "Pulitzer Prize for International Reporting (2022)",
      "George Polk Award (2021)",
      "Society of Professional Journalists Award (2020)"
    ],
    "education": [
      "Master of Journalism - Columbia University",
      "Bachelor of Arts in Political Science - Harvard University"
    ],
    "socialMedia": {
      "twitter": "@johnsmith_news",
      "linkedin": "johnsmith-journalist",
      "instagram": "@johnsmith_reporter",
      "facebook": "JohnSmithJournalist"
    }
  };

  List<Map<String, dynamic>> recentArticles = [
    {
      "title": "Global Climate Summit Reaches Historic Agreement on Carbon Reduction",
      "summary": "World leaders unite on ambitious climate action plan with binding commitments",
      "publishedAt": "2 hours ago",
      "readTime": "8 min read",
      "category": "Politics",
      "image": "https://picsum.photos/300/200?random=11&keyword=climate",
      "views": 125000,
      "likes": 2400,
      "comments": 450,
      "shares": 680,
    },
    {
      "title": "Congressional Hearing on AI Regulation Sparks Bipartisan Debate",
      "summary": "Lawmakers clash over proposed artificial intelligence oversight measures",
      "publishedAt": "1 day ago",
      "readTime": "6 min read",
      "category": "Technology",
      "image": "https://picsum.photos/300/200?random=12&keyword=congress",
      "views": 89000,
      "likes": 1800,
      "comments": 320,
      "shares": 420,
    },
    {
      "title": "Middle East Peace Talks Resume After Three-Month Hiatus",
      "summary": "Diplomatic efforts renewed with international mediation support",
      "publishedAt": "3 days ago",
      "readTime": "10 min read",
      "category": "World News",
      "image": "https://picsum.photos/300/200?random=13&keyword=diplomacy",
      "views": 156000,
      "likes": 3200,
      "comments": 780,
      "shares": 950,
    },
    {
      "title": "Economic Sanctions Impact on Global Trade Relations",
      "summary": "Analysis of recent policy changes and their international implications",
      "publishedAt": "5 days ago",
      "readTime": "12 min read",
      "category": "Economics",
      "image": "https://picsum.photos/300/200?random=14&keyword=economy",
      "views": 78000,
      "likes": 1400,
      "comments": 290,
      "shares": 380,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "Pulitzer Prize for International Reporting",
      "year": "2022",
      "description": "For outstanding coverage of international conflicts and diplomatic relations",
      "icon": Icons.emoji_events,
    },
    {
      "title": "George Polk Award",
      "year": "2021", 
      "description": "Recognition for investigative reporting on foreign policy",
      "icon": Icons.military_tech,
    },
    {
      "title": "SPJ Award for Excellence",
      "year": "2020",
      "description": "Society of Professional Journalists Award for political coverage",
      "icon": Icons.star,
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
              height: 280,
              child: Stack(
                children: [
                  // Cover Image
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${authorData["cover"]}"),
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
                              _shareProfile();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Avatar
                  Positioned(
                    bottom: 0,
                    left: spMd,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(color: Colors.white, width: 4),
                        image: DecorationImage(
                          image: NetworkImage("${authorData["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Content
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
                                  "${authorData["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (authorData["verified"] as bool)
                                  SizedBox(width: spSm),
                                if (authorData["verified"] as bool)
                                  Icon(
                                    Icons.verified,
                                    color: primaryColor,
                                    size: 24,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${authorData["title"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${authorData["organization"]} • ${authorData["location"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          QButton(
                            label: isFollowing ? "Following" : "Follow",
                            size: bs.md,
                            onPressed: () {
                              _toggleFollow();
                            },
                          ),
                          SizedBox(height: spSm),
                          GestureDetector(
                            onTap: () {
                              _toggleNotifications();
                            },
                            child: Icon(
                              notificationsEnabled ? Icons.notifications : Icons.notifications_off,
                              color: notificationsEnabled ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Bio
                  Text(
                    "${authorData["bio"]}",
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
                          "${((authorData["followers"] as int) / 1000).toStringAsFixed(0)}K",
                          Icons.people,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Articles",
                          "${authorData["articles"]}",
                          Icons.article,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Rating",
                          "${(authorData["rating"] as double).toStringAsFixed(1)}/5.0",
                          Icons.star,
                        ),
                      ),
                    ],
                  ),

                  // Categories
                  QHorizontalScroll(
                    children: (authorData["categories"] as List<String>).map((category) =>
                      Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: primaryColor.withAlpha(50)),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),

                  // Tab Bar
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = "articles";
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spMd),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedTab == "articles" ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "Articles",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selectedTab == "articles" ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = "about";
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spMd),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedTab == "about" ? primaryColor : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Text(
                              "About",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selectedTab == "about" ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Tab Content
                  if (selectedTab == "articles") ..._buildArticlesTab(),
                  if (selectedTab == "about") ..._buildAboutTab(),
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

  List<Widget> _buildArticlesTab() {
    return [
      Text(
        "Recent Articles",
        style: TextStyle(
          fontSize: fsH6,
          fontWeight: FontWeight.bold,
        ),
      ),
      ...recentArticles.map((article) => _buildArticleItem(article)),
      Container(
        width: double.infinity,
        child: QButton(
          label: "View All Articles",
          size: bs.md,
          onPressed: () {
            _viewAllArticles();
          },
        ),
      ),
    ];
  }

  List<Widget> _buildAboutTab() {
    return [
      // Contact Information
      Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildContactItem(Icons.email, "${authorData["email"]}"),
            _buildContactItem(Icons.phone, "${authorData["phone"]}"),
            _buildContactItem(Icons.language, "${authorData["website"]}"),
            _buildContactItem(Icons.calendar_today, "Joined ${authorData["joinedDate"]}"),
          ],
        ),
      ),

      // Awards & Recognition
      Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Awards & Recognition",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...achievements.map((achievement) => _buildAchievementItem(achievement)),
          ],
        ),
      ),

      // Education
      Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          spacing: spSm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Education",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...(authorData["education"] as List<String>).map((education) =>
              Container(
                padding: EdgeInsets.symmetric(vertical: spSm),
                child: Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        education,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
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

  Widget _buildContactItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Icon(
            achievement["icon"] as IconData,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${achievement["title"]} (${achievement["year"]})",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${achievement["description"]}",
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
    );
  }

  void _toggleFollow() {
    isFollowing = !isFollowing;
    setState(() {});
    ss(isFollowing ? "Following ${authorData["name"]}" : "Unfollowed ${authorData["name"]}");
  }

  void _toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    setState(() {});
    ss(notificationsEnabled ? "Notifications enabled" : "Notifications disabled");
  }

  void _shareProfile() {
    ss("Sharing ${authorData["name"]}'s profile");
  }

  void _viewAllArticles() {
    ss("Viewing all articles by ${authorData["name"]}");
  }
}
