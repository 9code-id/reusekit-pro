import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory6View extends StatefulWidget {
  @override
  State<GrlCategory6View> createState() => _GrlCategory6ViewState();
}

class _GrlCategory6ViewState extends State<GrlCategory6View> {
  int selectedTab = 0;
  String searchQuery = '';
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Art & Design",
      "shortName": "Design",
      "description": "Creative tools for digital art, graphic design, and visual content creation",
      "icon": Icons.palette,
      "color": 0xFFE91E63,
      "apps": 187,
      "rating": 4.6,
      "downloads": "2.3M",
      "featured": true,
      "subcategories": ["Graphic Design", "Photo Editing", "3D Modeling", "UI/UX Tools"],
      "popularApps": ["Adobe Creative", "Canva", "Figma", "Procreate"],
      "recentUpdates": 23,
      "newApps": 8,
    },
    {
      "id": 2,
      "name": "Books & Reference",
      "shortName": "Books",
      "description": "Digital libraries, e-readers, dictionaries, and reference materials",
      "icon": Icons.menu_book,
      "color": 0xFF795548,
      "apps": 145,
      "rating": 4.4,
      "downloads": "1.8M",
      "featured": false,
      "subcategories": ["E-books", "Audiobooks", "Dictionaries", "Reference"],
      "popularApps": ["Kindle", "Audible", "Goodreads", "Google Books"],
      "recentUpdates": 15,
      "newApps": 5,
    },
    {
      "id": 3,
      "name": "Communication",
      "shortName": "Comm",
      "description": "Messaging, video calls, email clients, and social communication tools",
      "icon": Icons.message,
      "color": 0xFF4CAF50,
      "apps": 298,
      "rating": 4.2,
      "downloads": "5.7M",
      "featured": true,
      "subcategories": ["Messaging", "Video Calls", "Email", "Social"],
      "popularApps": ["WhatsApp", "Zoom", "Gmail", "Skype"],
      "recentUpdates": 42,
      "newApps": 12,
    },
    {
      "id": 4,
      "name": "News & Magazines",
      "shortName": "News",
      "description": "Latest news, digital magazines, newspapers, and current affairs",
      "icon": Icons.newspaper,
      "color": 0xFF2196F3,
      "apps": 176,
      "rating": 4.1,
      "downloads": "3.2M",
      "featured": false,
      "subcategories": ["Breaking News", "Magazines", "Sports", "Tech News"],
      "popularApps": ["BBC News", "Reuters", "CNN", "The Guardian"],
      "recentUpdates": 28,
      "newApps": 6,
    },
    {
      "id": 5,
      "name": "Music & Audio",
      "shortName": "Music",
      "description": "Music streaming, audio editing, podcasts, and sound production tools",
      "icon": Icons.music_note,
      "color": 0xFF9C27B0,
      "apps": 234,
      "rating": 4.5,
      "downloads": "4.1M",
      "featured": true,
      "subcategories": ["Streaming", "Audio Editing", "Podcasts", "Radio"],
      "popularApps": ["Spotify", "Apple Music", "SoundCloud", "Audacity"],
      "recentUpdates": 31,
      "newApps": 9,
    },
    {
      "id": 6,
      "name": "Weather",
      "shortName": "Weather",
      "description": "Weather forecasts, climate data, and meteorological information",
      "icon": Icons.cloud,
      "color": 0xFF00BCD4,
      "apps": 89,
      "rating": 4.3,
      "downloads": "1.5M",
      "featured": false,
      "subcategories": ["Forecasts", "Radar", "Alerts", "Climate"],
      "popularApps": ["Weather Channel", "AccuWeather", "Weather Underground"],
      "recentUpdates": 12,
      "newApps": 3,
    },
  ];

  List<Map<String, dynamic>> trendingData = [
    {"category": "Communication", "growth": "+23%", "trend": "up"},
    {"category": "Music & Audio", "growth": "+18%", "trend": "up"},
    {"category": "Art & Design", "growth": "+15%", "trend": "up"},
    {"category": "News & Magazines", "growth": "-3%", "trend": "down"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "App Categories Hub",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Categories", icon: Icon(Icons.apps)),
        Tab(text: "Featured", icon: Icon(Icons.star)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildAllCategoriesTab(),
        _buildFeaturedTab(),
        _buildTrendingTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildAllCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search categories...",
                  value: searchQuery,
                  hint: "Enter category name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Quick Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${categories.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${categories.fold(0, (sum, cat) => sum + (cat["apps"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Total Apps",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Categories List
          ...categories.map((category) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                // Category Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Color(category["color"] as int).withAlpha(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Color(category["color"] as int),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (category["featured"] as bool) ...[
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
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
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${category["description"]}",
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
                ),
                
                // Category Stats
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
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
                                    color: Color(category["color"] as int),
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
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${category["rating"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: Color(category["color"] as int),
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
                                  "${category["downloads"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: Color(category["color"] as int),
                                  ),
                                ),
                                Text(
                                  "Downloads",
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
                      
                      // Subcategories
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: (category["subcategories"] as List).map((sub) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(category["color"] as int).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$sub",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(category["color"] as int),
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Explore Apps",
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
    );
  }

  Widget _buildFeaturedTab() {
    List<Map<String, dynamic>> featuredCategories = categories.where((cat) => cat["featured"] as bool).toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [warningColor, warningColor.withAlpha(180)],
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
                      Icons.star,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Featured Categories",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Hand-picked categories with the best apps and highest user satisfaction",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${featuredCategories.length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Featured",
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
                            "${featuredCategories.fold(0, (sum, cat) => sum + (cat["apps"] as int))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Apps",
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
                            "${((featuredCategories.fold(0.0, (sum, cat) => sum + (cat["rating"] as double)) / featuredCategories.length)).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: fsH4,
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
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Featured Categories Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: featuredCategories.map((category) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  // Featured Badge Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Color(category["color"] as int),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category["icon"] as IconData,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["shortName"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: spXs),
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
                  
                  // Content
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      children: [
                        Text(
                          "${category["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spMd),
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
                                      fontSize: 10,
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
                                        size: 14,
                                        color: warningColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${category["rating"]}",
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
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Explore",
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
          ),
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
          // Trending Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trending Categories",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Categories with the highest growth this month",
                        style: TextStyle(
                          fontSize: 13,
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
          
          // Trending List
          ...trendingData.map((trend) {
            Map<String, dynamic> category = categories.firstWhere((cat) => cat["name"] == trend["category"]);
            Color trendColor = trend["trend"] == "up" ? successColor : dangerColor;
            IconData trendIcon = trend["trend"] == "up" ? Icons.trending_up : Icons.trending_down;
            
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: trendColor,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Color(category["color"] as int).withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        category["icon"] as IconData,
                        color: Color(category["color"] as int),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["apps"]} apps • ${category["downloads"]} downloads",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              trendIcon,
                              color: trendColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${trend["growth"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: trendColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Growth",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          SizedBox(height: spMd),
          
          // All Trending Categories
          Text(
            "Other Growing Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...categories.where((cat) => !trendingData.any((trend) => trend["category"] == cat["name"])).map((category) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Color(category["color"] as int).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"] as IconData,
                    color: Color(category["color"] as int),
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Text(
                    "${category["name"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${category["apps"]} apps",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Analytics Overview
          Text(
            "Category Analytics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Key Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.apps,
                      color: primaryColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${categories.fold(0, (sum, cat) => sum + (cat["apps"] as int))}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Apps",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${((categories.fold(0.0, (sum, cat) => sum + (cat["rating"] as double)) / categories.length)).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Avg Rating",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Icon(
                      Icons.download,
                      color: successColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "18.6M",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Total Downloads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
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
                  children: [
                    Icon(
                      Icons.update,
                      color: infoColor,
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${categories.fold(0, (sum, cat) => sum + (cat["recentUpdates"] as int))}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Recent Updates",
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
          
          SizedBox(height: spMd),
          
          // Top Performing Categories
          Text(
            "Top Performing Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...categories.where((cat) => (cat["rating"] as double) >= 4.5).map((category) => Container(
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Color(category["color"] as int).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"] as IconData,
                    color: Color(category["color"] as int),
                    size: 20,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["apps"]} apps • ${category["downloads"]} downloads",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: warningColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${category["rating"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Excellent",
                      style: TextStyle(
                        fontSize: 10,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
