import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory4View extends StatefulWidget {
  @override
  State<GrlCategory4View> createState() => _GrlCategory4ViewState();
}

class _GrlCategory4ViewState extends State<GrlCategory4View> {
  String selectedCategory = 'all';
  String searchQuery = '';
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Gaming & Entertainment",
      "description": "Video games, streaming services, and entertainment apps",
      "icon": Icons.gamepad,
      "color": 0xFF7B68EE,
      "items": 156,
      "trending": true,
      "rating": 4.8,
      "subcategories": ["Video Games", "Streaming", "Music", "Podcasts"],
    },
    {
      "id": 2,
      "name": "Health & Fitness",
      "description": "Workout apps, health tracking, and wellness tools",
      "icon": Icons.fitness_center,
      "color": 0xFF32CD32,
      "items": 243,
      "trending": false,
      "rating": 4.6,
      "subcategories": ["Workout", "Nutrition", "Mental Health", "Sleep"],
    },
    {
      "id": 3,
      "name": "Travel & Navigation",
      "description": "Maps, travel guides, and transportation apps",
      "icon": Icons.flight,
      "color": 0xFF1E90FF,
      "items": 87,
      "trending": true,
      "rating": 4.7,
      "subcategories": ["Maps", "Hotels", "Flights", "Car Rental"],
    },
    {
      "id": 4,
      "name": "Food & Delivery",
      "description": "Restaurant delivery, recipes, and cooking guides",
      "icon": Icons.restaurant,
      "color": 0xFFFF6347,
      "items": 198,
      "trending": false,
      "rating": 4.5,
      "subcategories": ["Delivery", "Recipes", "Reviews", "Cooking"],
    },
    {
      "id": 5,
      "name": "Photography & Video",
      "description": "Photo editing, video creation, and media tools",
      "icon": Icons.camera_alt,
      "color": 0xFFDA70D6,
      "items": 134,
      "trending": true,
      "rating": 4.9,
      "subcategories": ["Photo Edit", "Video Edit", "Filters", "Storage"],
    },
    {
      "id": 6,
      "name": "Finance & Banking",
      "description": "Banking apps, investment tools, and financial planning",
      "icon": Icons.account_balance,
      "color": 0xFF20B2AA,
      "items": 76,
      "trending": false,
      "rating": 4.4,
      "subcategories": ["Banking", "Investment", "Budgeting", "Crypto"],
    },
  ];

  List<String> filterOptions = ['all', 'trending', 'top-rated', 'new'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    hint: "Enter category name or keyword",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Filter Chips
            QHorizontalScroll(
              children: filterOptions.map((filter) => Container(
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
                      color: selectedCategory == filter ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border.all(
                        color: selectedCategory == filter ? primaryColor : disabledBoldColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter.toUpperCase().replaceAll('-', ' '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedCategory == filter ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Stats Overview
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "App Store Categories",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${categories.length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "${categories.fold(0, (sum, category) => sum + (category["items"] as int))}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "${categories.where((c) => c["trending"] as bool).length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
            
            // Section Header
            Row(
              children: [
                Text(
                  "Browse Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: categories.map((category) {
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
                      // Category Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: categoryColor.withAlpha(30),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusLg),
                            topRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: categoryColor,
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
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (category["trending"] as bool)
                                        Container(
                                          margin: EdgeInsets.only(top: 4),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warningColor,
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
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
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
                      
                      // Category Content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            // Stats Row
                            Row(
                              children: [
                                Icon(
                                  Icons.apps,
                                  size: 16,
                                  color: categoryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${category["items"]} apps",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${category["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Subcategories
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: (category["subcategories"] as List).map((sub) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: categoryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$sub",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: categoryColor,
                                  ),
                                ),
                              )).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Browse Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Browse Apps",
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
