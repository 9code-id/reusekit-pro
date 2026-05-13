import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory7View extends StatefulWidget {
  @override
  State<GrlCategory7View> createState() => _GrlCategory7ViewState();
}

class _GrlCategory7ViewState extends State<GrlCategory7View> {
  String selectedCategory = 'all';
  String sortBy = 'popular';
  bool showGridView = true;
  
  List<Map<String, dynamic>> appCategories = [
    {
      "id": 1,
      "name": "Productivity Tools",
      "description": "Essential apps for work efficiency and task management",
      "icon": Icons.work,
      "color": 0xFF3F51B5,
      "totalApps": 523,
      "featuredApps": 12,
      "rating": 4.6,
      "downloads": "15.2M",
      "trending": true,
      "growth": "+22%",
      "tags": ["Office", "Planning", "Notes", "Calendar"],
      "popularApps": [
        {"name": "Microsoft Office", "rating": 4.5, "downloads": "500M+"},
        {"name": "Notion", "rating": 4.7, "downloads": "100M+"},
        {"name": "Todoist", "rating": 4.4, "downloads": "50M+"},
        {"name": "Evernote", "rating": 4.2, "downloads": "100M+"},
      ],
      "weeklyStats": [45, 52, 48, 65, 58, 72, 69],
    },
    {
      "id": 2,
      "name": "Creative Suite",
      "description": "Professional tools for design, photography, and video editing",
      "icon": Icons.brush,
      "color": 0xFFE91E63,
      "totalApps": 298,
      "featuredApps": 8,
      "rating": 4.8,
      "downloads": "8.7M",
      "trending": false,
      "growth": "+8%",
      "tags": ["Design", "Photo", "Video", "Art"],
      "popularApps": [
        {"name": "Adobe Photoshop", "rating": 4.6, "downloads": "200M+"},
        {"name": "Canva", "rating": 4.8, "downloads": "500M+"},
        {"name": "VSCO", "rating": 4.3, "downloads": "100M+"},
        {"name": "PicsArt", "rating": 4.5, "downloads": "1B+"},
      ],
      "weeklyStats": [38, 42, 45, 48, 52, 55, 60],
    },
    {
      "id": 3,
      "name": "Developer Tools",
      "description": "Code editors, version control, and development utilities",
      "icon": Icons.code,
      "color": 0xFF4CAF50,
      "totalApps": 187,
      "featuredApps": 6,
      "rating": 4.7,
      "downloads": "3.4M",
      "trending": true,
      "growth": "+35%",
      "tags": ["Coding", "Git", "IDE", "Debug"],
      "popularApps": [
        {"name": "GitHub", "rating": 4.5, "downloads": "50M+"},
        {"name": "Visual Studio Code", "rating": 4.8, "downloads": "100M+"},
        {"name": "Termux", "rating": 4.2, "downloads": "10M+"},
        {"name": "Sublime Text", "rating": 4.6, "downloads": "5M+"},
      ],
      "weeklyStats": [25, 28, 35, 42, 48, 55, 62],
    },
    {
      "id": 4,
      "name": "Entertainment Hub",
      "description": "Games, streaming, music, and digital entertainment platforms",
      "icon": Icons.play_circle,
      "color": 0xFFFF9800,
      "totalApps": 1247,
      "featuredApps": 25,
      "rating": 4.3,
      "downloads": "45.8M",
      "trending": false,
      "growth": "+5%",
      "tags": ["Games", "Music", "Video", "Streaming"],
      "popularApps": [
        {"name": "Spotify", "rating": 4.4, "downloads": "1B+"},
        {"name": "Netflix", "rating": 4.2, "downloads": "1B+"},
        {"name": "YouTube", "rating": 4.1, "downloads": "10B+"},
        {"name": "TikTok", "rating": 4.5, "downloads": "3B+"},
      ],
      "weeklyStats": [120, 115, 118, 125, 130, 128, 135],
    },
    {
      "id": 5,
      "name": "Health & Fitness",
      "description": "Workout tracking, nutrition guides, and wellness applications",
      "icon": Icons.fitness_center,
      "color": 0xFF2196F3,
      "totalApps": 445,
      "featuredApps": 15,
      "rating": 4.5,
      "downloads": "12.3M",
      "trending": true,
      "growth": "+18%",
      "tags": ["Fitness", "Nutrition", "Health", "Wellness"],
      "popularApps": [
        {"name": "MyFitnessPal", "rating": 4.3, "downloads": "100M+"},
        {"name": "Strava", "rating": 4.5, "downloads": "100M+"},
        {"name": "Headspace", "rating": 4.8, "downloads": "50M+"},
        {"name": "Nike Training", "rating": 4.6, "downloads": "50M+"},
      ],
      "weeklyStats": [78, 82, 85, 88, 92, 95, 98],
    },
    {
      "id": 6,
      "name": "Finance & Banking",
      "description": "Digital banking, investment tools, and financial management",
      "icon": Icons.account_balance,
      "color": 0xFF795548,
      "totalApps": 234,
      "featuredApps": 7,
      "rating": 4.4,
      "downloads": "6.8M",
      "trending": false,
      "growth": "+12%",
      "tags": ["Banking", "Investment", "Budget", "Crypto"],
      "popularApps": [
        {"name": "PayPal", "rating": 4.3, "downloads": "1B+"},
        {"name": "Robinhood", "rating": 4.1, "downloads": "10M+"},
        {"name": "Mint", "rating": 4.4, "downloads": "10M+"},
        {"name": "Coinbase", "rating": 4.2, "downloads": "10M+"},
      ],
      "weeklyStats": [32, 35, 38, 35, 40, 42, 45],
    },
  ];

  List<String> categoryFilters = ['all', 'trending', 'featured', 'top-rated'];
  List<String> sortOptions = ['popular', 'rating', 'downloads', 'name'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Categories"),
        actions: [
          IconButton(
            icon: Icon(showGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              showGridView = !showGridView;
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
          // Filter & Sort Bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Category Filters
                QHorizontalScroll(
                  children: categoryFilters.map((filter) => Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory = filter;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory == filter ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          filter.toUpperCase().replaceAll('-', ' '),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == filter ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spSm),
                
                // Sort Options
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 12,
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
                              sortBy = sort;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: sortBy == sort ? successColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                sort.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: sortBy == sort ? Colors.white : disabledBoldColor,
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
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Stats
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Categories Overview",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${appCategories.length}",
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
                                    "${appCategories.fold(0, (sum, cat) => sum + (cat["totalApps"] as int))}",
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
                                    "${appCategories.where((cat) => cat["trending"] as bool).length}",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Trending",
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
                  
                  // Categories Display
                  if (showGridView)
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: _getFilteredCategories().map((category) => _buildCategoryCard(category)).toList(),
                    )
                  else
                    Column(
                      children: _getFilteredCategories().map((category) => _buildCategoryListItem(category)).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCategories() {
    List<Map<String, dynamic>> filtered = appCategories;
    
    if (selectedCategory == 'trending') {
      filtered = filtered.where((cat) => cat["trending"] as bool).toList();
    } else if (selectedCategory == 'featured') {
      filtered = filtered.where((cat) => (cat["featuredApps"] as int) > 10).toList();
    } else if (selectedCategory == 'top-rated') {
      filtered = filtered.where((cat) => (cat["rating"] as double) >= 4.5).toList();
    }
    
    // Sort logic would go here based on sortBy
    return filtered;
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    Color categoryColor = Color(category["color"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        children: [
          // Header with gradient
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusLg),
                topRight: Radius.circular(radiusLg),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      category["icon"] as IconData,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (category["trending"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "TRENDING",
                          style: TextStyle(
                            fontSize: 10,
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
                    fontSize: 12,
                    color: Colors.white70,
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
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${category["totalApps"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
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
                                  color: categoryColor,
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
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${category["downloads"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
                            ),
                          ),
                          Text(
                            "Downloads",
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
                
                // Tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (category["tags"] as List).map((tag) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: categoryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: categoryColor,
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Popular Apps Preview
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Apps:",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        (category["popularApps"] as List).take(3).map((app) => app["name"]).join(" • "),
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
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
    );
  }

  Widget _buildCategoryListItem(Map<String, dynamic> category) {
    Color categoryColor = Color(category["color"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: categoryColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Main Info Row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    category["icon"] as IconData,
                    color: categoryColor,
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
                          if (category["trending"] as bool) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "TRENDING",
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
                Column(
                  children: [
                    Text(
                      "${category["growth"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
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
            
            SizedBox(height: spMd),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${category["totalApps"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
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
                            size: 12,
                            color: warningColor,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${category["rating"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: categoryColor,
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
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${category["downloads"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                        ),
                      ),
                      Text(
                        "Downloads",
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
                      Text(
                        "${category["featuredApps"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: categoryColor,
                        ),
                      ),
                      Text(
                        "Featured",
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
            
            // Action Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
