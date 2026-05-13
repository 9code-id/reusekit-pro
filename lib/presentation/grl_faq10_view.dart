import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlFaq10View extends StatefulWidget {
  @override
  State<GrlFaq10View> createState() => _GrlFaq10ViewState();
}

class _GrlFaq10ViewState extends State<GrlFaq10View> {
  String searchQuery = "";
  String selectedLanguage = "en";
  bool isDarkMode = false;
  int selectedCategoryIndex = 0;
  
  List<Map<String, dynamic>> languages = [
    {"code": "en", "name": "English", "flag": "🇺🇸"},
    {"code": "es", "name": "Español", "flag": "🇪🇸"},
    {"code": "fr", "name": "Français", "flag": "🇫🇷"},
    {"code": "de", "name": "Deutsch", "flag": "🇩🇪"},
    {"code": "zh", "name": "中文", "flag": "🇨🇳"},
    {"code": "ja", "name": "日本語", "flag": "🇯🇵"},
  ];

  List<Map<String, dynamic>> helpCategories = [
    {
      "title": "Quick Answers",
      "subtitle": "Common questions answered instantly",
      "icon": Icons.flash_on,
      "color": warningColor,
      "count": 25,
      "avgTime": "< 1 min",
    },
    {
      "title": "Step-by-Step Guides",
      "subtitle": "Detailed instructions for complex tasks",
      "icon": Icons.list_alt,
      "color": primaryColor,
      "count": 18,
      "avgTime": "5-10 min",
    },
    {
      "title": "Video Tutorials",
      "subtitle": "Visual guides and demonstrations",
      "icon": Icons.play_circle_filled,
      "color": dangerColor,
      "count": 12,
      "avgTime": "3-15 min",
    },
    {
      "title": "Troubleshooting",
      "subtitle": "Fix common problems quickly",
      "icon": Icons.build_circle,
      "color": infoColor,
      "count": 22,
      "avgTime": "2-8 min",
    },
    {
      "title": "API Documentation",
      "subtitle": "Technical references and examples",
      "icon": Icons.code,
      "color": successColor,
      "count": 15,
      "avgTime": "10-20 min",
    },
    {
      "title": "Community Forum",
      "subtitle": "Get help from other users",
      "icon": Icons.forum,
      "color": Colors.purple,
      "count": 156,
      "avgTime": "varies",
    },
  ];

  List<Map<String, dynamic>> featuredContent = [
    {
      "title": "Getting Started Guide",
      "description": "Everything you need to know to begin using our platform effectively",
      "type": "guide",
      "readTime": "10 min read",
      "rating": 4.9,
      "views": 15420,
      "isNew": true,
      "image": "https://picsum.photos/400/200?random=1&keyword=guide",
    },
    {
      "title": "Advanced Features Masterclass",
      "description": "Unlock the full potential with these advanced tips and tricks",
      "type": "video",
      "readTime": "25 min watch",
      "rating": 4.8,
      "views": 8750,
      "isNew": false,
      "image": "https://picsum.photos/400/200?random=2&keyword=advanced",
    },
    {
      "title": "Common Issues & Solutions",
      "description": "Quick fixes for the most frequently reported problems",
      "type": "troubleshooting",
      "readTime": "8 min read",
      "rating": 4.7,
      "views": 12300,
      "isNew": false,
      "image": "https://picsum.photos/400/200?random=3&keyword=problems",
    },
  ];

  List<Map<String, dynamic>> popularSearches = [
    {"query": "reset password", "count": 1250},
    {"query": "billing issues", "count": 980},
    {"query": "account setup", "count": 875},
    {"query": "API integration", "count": 650},
    {"query": "mobile app", "count": 580},
    {"query": "data export", "count": 420},
  ];

  List<Map<String, dynamic>> recentUpdates = [
    {
      "title": "New Payment Methods Added",
      "date": "2024-01-25",
      "type": "feature",
      "description": "We now support PayPal and Apple Pay for subscriptions",
    },
    {
      "title": "Security Enhancement Guide",
      "date": "2024-01-22",
      "type": "security",
      "description": "Learn about our latest security features and best practices",
    },
    {
      "title": "Mobile App Update v2.1",
      "date": "2024-01-20",
      "type": "update",
      "description": "New features and bug fixes in the latest mobile app version",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Hub"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              isDarkMode = !isDarkMode;
              setState(() {});
              ss(isDarkMode ? "Dark mode enabled" : "Light mode enabled");
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (String languageCode) {
              selectedLanguage = languageCode;
              setState(() {});
              String languageName = languages.firstWhere((lang) => lang["code"] == languageCode)["name"];
              ss("Language changed to $languageName");
            },
            itemBuilder: (BuildContext context) {
              return languages.map((language) {
                return PopupMenuItem<String>(
                  value: language["code"],
                  child: Row(
                    children: [
                      Text(
                        language["flag"],
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: spSm),
                      Text(language["name"]),
                      if (selectedLanguage == language["code"]) ...[
                        Spacer(),
                        Icon(Icons.check, color: successColor, size: 16),
                      ],
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(204),
                    primaryColor.withAlpha(153),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Need Help?",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Find answers, guides, and get support",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.headset_mic,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Search for help articles, tutorials, or FAQs...",
                        prefixIcon: Icon(Icons.search, color: primaryColor),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (searchQuery.isNotEmpty)
                              IconButton(
                                icon: Icon(Icons.clear, color: disabledBoldColor),
                                onPressed: () {
                                  searchQuery = "";
                                  setState(() {});
                                },
                              ),
                            IconButton(
                              icon: Icon(Icons.mic, color: primaryColor),
                              onPressed: () => ss("Voice search activated"),
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spMd),
                      ),
                    ),
                  ),
                  SizedBox(height: spMd),
                  // Popular Searches
                  Text(
                    "Popular Searches",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: popularSearches.take(4).map((search) => GestureDetector(
                      onTap: () {
                        searchQuery = search["query"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white.withAlpha(102)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              search["query"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(102),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${search["count"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            
            // Quick Stats
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard("24/7", "Support Available", Icons.access_time, successColor),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildStatCard("< 2 min", "Average Response", Icons.speed, primaryColor),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: _buildStatCard("98%", "Issue Resolution", Icons.check_circle, warningColor),
                  ),
                ],
              ),
            ),
            
            // Featured Content
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Content",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QHorizontalScroll(
                    children: featuredContent.map((content) => _buildFeaturedCard(content)).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Help Categories
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse by Category",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: helpCategories.map((category) => _buildCategoryCard(category)).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Recent Updates
            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Updates",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => ss("View all updates"),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...recentUpdates.map((update) => _buildUpdateCard(update)),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Contact Support
            Container(
              margin: EdgeInsets.all(spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Still Need Help?",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Our support team is here to help you 24/7",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: QButton(
                            label: "Start Live Chat",
                            color: successColor,
                            size: bs.md,
                            onPressed: () => ss("Live chat started"),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.email, color: Colors.white),
                          onPressed: () => ss("Email support opened"),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(color: Colors.white),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.phone, color: Colors.white),
                          onPressed: () => ss("Phone support requested"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> content) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusLg),
                  topRight: Radius.circular(radiusLg),
                ),
                child: Image.network(
                  content["image"],
                  width: double.infinity,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              if (content["isNew"])
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "NEW",
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
                    color: Colors.black.withAlpha(153),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        content["type"] == "video" ? Icons.play_circle : Icons.article,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        content["readTime"],
                        style: TextStyle(
                          fontSize: 10,
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
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content["title"],
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  content["description"],
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${content["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spMd),
                    Row(
                      children: [
                        Icon(Icons.visibility, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "${(content["views"] as int) > 1000 ? '${((content["views"] as int) / 1000).toStringAsFixed(1)}K' : content["views"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => ss("${content["title"]} bookmarked"),
                      child: Icon(
                        Icons.bookmark_border,
                        color: primaryColor,
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
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () => ss("${category["title"]} category selected"),
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (category["color"] as Color).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    category["icon"],
                    color: category["color"],
                    size: 24,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (category["color"] as Color).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${category["count"]} articles",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: category["color"],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Text(
              category["title"],
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              category["subtitle"],
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  category["avgTime"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: category["color"],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard(Map<String, dynamic> update) {
    Color typeColor = update["type"] == "feature" ? successColor :
                     update["type"] == "security" ? dangerColor : primaryColor;
    IconData typeIcon = update["type"] == "feature" ? Icons.new_releases :
                       update["type"] == "security" ? Icons.security : Icons.system_update;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: typeColor,
            width: 4,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: typeColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  update["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  update["description"],
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  update["date"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: disabledBoldColor,
          ),
        ],
      ),
    );
  }
}
