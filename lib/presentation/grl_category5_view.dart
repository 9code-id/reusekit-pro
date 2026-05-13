import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory5View extends StatefulWidget {
  @override
  State<GrlCategory5View> createState() => _GrlCategory5ViewState();
}

class _GrlCategory5ViewState extends State<GrlCategory5View> {
  String selectedSort = 'popularity';
  String selectedFilter = 'all';
  bool showFavorites = false;
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "E-commerce & Shopping",
      "description": "Online shopping, marketplace, and retail applications",
      "icon": Icons.shopping_bag,
      "gradient": [0xFF6A0572, 0xFF9A0E86],
      "apps": 342,
      "avgRating": 4.3,
      "growth": "+12%",
      "featured": true,
      "tags": ["Shopping", "Marketplace", "Fashion", "Electronics"],
      "topApps": ["Amazon", "eBay", "Shopify", "Etsy"],
    },
    {
      "id": 2,
      "name": "Social Media & Communication",
      "description": "Social networks, messaging, and community platforms",
      "icon": Icons.chat,
      "gradient": [0xFF1976D2, 0xFF42A5F5],
      "apps": 567,
      "avgRating": 4.1,
      "growth": "+8%",
      "featured": false,
      "tags": ["Social", "Messaging", "Community", "Video Chat"],
      "topApps": ["WhatsApp", "Telegram", "Discord", "Signal"],
    },
    {
      "id": 3,
      "name": "Education & Learning",
      "description": "Online courses, language learning, and educational tools",
      "icon": Icons.school,
      "gradient": [0xFF388E3C, 0xFF66BB6A],
      "apps": 234,
      "avgRating": 4.7,
      "growth": "+25%",
      "featured": true,
      "tags": ["Learning", "Courses", "Languages", "Skills"],
      "topApps": ["Duolingo", "Khan Academy", "Coursera", "Udemy"],
    },
    {
      "id": 4,
      "name": "Business & Productivity",
      "description": "Office tools, project management, and business applications",
      "icon": Icons.business_center,
      "gradient": [0xFFFF5722, 0xFFFF8A65],
      "apps": 189,
      "avgRating": 4.5,
      "growth": "+15%",
      "featured": false,
      "tags": ["Office", "Projects", "Teams", "Documents"],
      "topApps": ["Slack", "Trello", "Notion", "Asana"],
    },
    {
      "id": 5,
      "name": "Entertainment & Media",
      "description": "Streaming, music, podcasts, and digital entertainment",
      "icon": Icons.movie,
      "gradient": [0xFF7B1FA2, 0xFFBA68C8],
      "apps": 456,
      "avgRating": 4.2,
      "growth": "+5%",
      "featured": true,
      "tags": ["Streaming", "Music", "Podcasts", "TV Shows"],
      "topApps": ["Netflix", "Spotify", "YouTube", "Disney+"],
    },
    {
      "id": 6,
      "name": "Lifestyle & Wellness",
      "description": "Health tracking, meditation, and lifestyle applications",
      "icon": Icons.spa,
      "gradient": [0xFF00ACC1, 0xFF4DD0E1],
      "apps": 298,
      "avgRating": 4.6,
      "growth": "+18%",
      "featured": false,
      "tags": ["Health", "Fitness", "Meditation", "Wellness"],
      "topApps": ["Headspace", "MyFitnessPal", "Calm", "Strava"],
    },
  ];

  List<String> sortOptions = ['popularity', 'rating', 'growth', 'apps-count'];
  List<String> filterOptions = ['all', 'featured', 'trending', 'new'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Explorer"),
        actions: [
          IconButton(
            icon: Icon(showFavorites ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              showFavorites = !showFavorites;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Sort Options
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: sortOptions.map((sort) => Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedSort = sort;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: selectedSort == sort ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                sort.replaceAll('-', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: selectedSort == sort ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Filter Options
                Row(
                  children: [
                    Text(
                      "Filter:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: filterOptions.map((filter) => Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedFilter = filter;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: selectedFilter == filter ? successColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                filter.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: selectedFilter == filter ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Categories List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Quick Stats
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [infoColor, infoColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${categories.length}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Categories",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${categories.fold(0, (sum, cat) => sum + (cat["apps"] as int))}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Total Apps",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${((categories.fold(0.0, (sum, cat) => sum + (cat["avgRating"] as double)) / categories.length)).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Avg Rating",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Categories
                  ...categories.where((category) {
                    if (selectedFilter == 'featured') {
                      return category["featured"] as bool;
                    }
                    return true;
                  }).map((category) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Category Header with Gradient
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color((category["gradient"] as List)[0]),
                                Color((category["gradient"] as List)[1]),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      category["icon"] as IconData,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${category["name"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (category["featured"] as bool)
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withAlpha(51),
                                              borderRadius: BorderRadius.circular(radiusSm),
                                            ),
                                            child: Text(
                                              "FEATURED",
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
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${category["growth"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${category["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Category Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            children: [
                              // Stats Row
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${category["apps"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "Apps",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 16,
                                              color: warningColor,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              "${category["avgRating"]}",
                                              style: TextStyle(
                                                fontSize: fsH6,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Rating",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${category["growth"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "Growth",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Tags
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: (category["tags"] as List).map((tag) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color((category["gradient"] as List)[0]).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "$tag",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color((category["gradient"] as List)[0]),
                                      ),
                                    ),
                                  )).toList(),
                                ),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Top Apps
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Popular Apps:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    (category["topApps"] as List).join(" • "),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Explore Button
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Explore Category",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
