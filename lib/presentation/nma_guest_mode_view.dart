import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaGuestModeView extends StatefulWidget {
  const NmaGuestModeView({Key? key}) : super(key: key);

  @override
  State<NmaGuestModeView> createState() => _NmaGuestModeViewState();
}

class _NmaGuestModeViewState extends State<NmaGuestModeView> {
  bool showLimitedFeatures = false;
  
  List<Map<String, dynamic>> guestFeatures = [
    {
      "title": "Browse Latest News",
      "description": "Read breaking news and trending articles",
      "icon": Icons.newspaper,
      "available": true
    },
    {
      "title": "Search Articles",
      "description": "Find specific news topics and stories",
      "icon": Icons.search,
      "available": true
    },
    {
      "title": "View Categories",
      "description": "Explore news by different categories",
      "icon": Icons.category,
      "available": true
    },
    {
      "title": "Share Articles",
      "description": "Share interesting stories with others",
      "icon": Icons.share,
      "available": true
    },
  ];

  List<Map<String, dynamic>> limitedFeatures = [
    {
      "title": "Personalized Feed",
      "description": "Customized news based on your interests",
      "icon": Icons.person,
      "requiresAccount": true
    },
    {
      "title": "Save Articles",
      "description": "Bookmark articles to read later",
      "icon": Icons.bookmark,
      "requiresAccount": true
    },
    {
      "title": "Offline Reading",
      "description": "Download articles for offline access",
      "icon": Icons.offline_pin,
      "requiresAccount": true
    },
    {
      "title": "Push Notifications",
      "description": "Get notified about breaking news",
      "icon": Icons.notifications,
      "requiresAccount": true
    },
    {
      "title": "Comment & Discuss",
      "description": "Join conversations about articles",
      "icon": Icons.comment,
      "requiresAccount": true
    },
    {
      "title": "Follow Sources",
      "description": "Subscribe to your favorite news sources",
      "icon": Icons.rss_feed,
      "requiresAccount": true
    },
  ];

  List<Map<String, dynamic>> sampleNews = [
    {
      "title": "Global Climate Summit Begins in Geneva",
      "source": "World News",
      "time": "2 hours ago",
      "category": "Environment",
      "image": "https://picsum.photos/300/200?random=1&keyword=climate"
    },
    {
      "title": "Tech Giants Announce AI Partnership",
      "source": "Tech Today",
      "time": "4 hours ago", 
      "category": "Technology",
      "image": "https://picsum.photos/300/200?random=2&keyword=technology"
    },
    {
      "title": "Olympic Games Preparation Underway",
      "source": "Sports Central",
      "time": "6 hours ago",
      "category": "Sports",
      "image": "https://picsum.photos/300/200?random=3&keyword=sports"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Mode"),
        actions: [
          QButton(
            icon: Icons.account_circle,
            size: bs.sm,
            onPressed: () {
              // ss('Next page'));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildGuestWelcome(),
            _buildAvailableFeatures(),
            _buildLimitedFeatures(),
            _buildSampleNews(),
            _buildUpgradePrompt(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestWelcome() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withAlpha(20),
            primaryColor.withAlpha(10),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.waving_hand,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Welcome, Guest!",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Explore news without an account",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Text(
            "You're browsing in guest mode. You can read news and explore categories, but some features require an account.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create Account",
                  size: bs.sm,
                  onPressed: () {
                    // ss('Next page'));
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Sign In",
                  size: bs.sm,
                  onPressed: () {
                    // ss('Next page'));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableFeatures() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Available in Guest Mode",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
          ...guestFeatures.asMap().entries.map((entry) {
            final index = entry.key;
            final feature = entry.value;
            final isLast = index == guestFeatures.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      feature["icon"] as IconData,
                      color: successColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${feature["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${feature["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: successColor,
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

  Widget _buildLimitedFeatures() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Requires Account",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showLimitedFeatures = !showLimitedFeatures;
                    });
                  },
                  child: Icon(
                    showLimitedFeatures 
                        ? Icons.keyboard_arrow_up 
                        : Icons.keyboard_arrow_down,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (showLimitedFeatures) ...[
            ...limitedFeatures.asMap().entries.map((entry) {
              final index = entry.key;
              final feature = entry.value;
              final isLast = index == limitedFeatures.length - 1;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: isLast ? null : Border(
                    bottom: BorderSide(
                      color: disabledColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        feature["icon"] as IconData,
                        color: warningColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${feature["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${feature["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.lock,
                      color: warningColor,
                      size: 16,
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildSampleNews() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Latest News",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...sampleNews.asMap().entries.map((entry) {
            final index = entry.key;
            final article = entry.value;
            final isLast = index == sampleNews.length - 1;
            
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: isLast ? null : Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${article["image"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "${article["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${article["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${article["source"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${article["time"]}",
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
            );
          }),
          Container(
            padding: EdgeInsets.all(spMd),
            child: Container(
              width: double.infinity,
              child: QButton(
                label: "Read More News",
                size: bs.sm,
                onPressed: () {
                  // ss('Next page'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradePrompt() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withAlpha(200),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 40,
          ),
          
          Text(
            "Unlock Full Experience",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          Text(
            "Create a free account to save articles, get personalized recommendations, and access exclusive features.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(220),
              height: 1.4,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create Free Account",
                  size: bs.md,
                  onPressed: () {
                    // ss('Next page'));
                  },
                ),
              ),
            ],
          ),
          
          GestureDetector(
            onTap: () {
              // ss('Next page'));
            },
            child: Text(
              "Already have an account? Sign In",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(200),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
