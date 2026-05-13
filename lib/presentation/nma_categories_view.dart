import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaCategoriesView extends StatefulWidget {
  const NmaCategoriesView({super.key});

  @override
  State<NmaCategoriesView> createState() => _NmaCategoriesViewState();
}

class _NmaCategoriesViewState extends State<NmaCategoriesView> {
  String searchQuery = "";
  bool loading = false;
  String selectedLayout = "grid";
  
  List<Map<String, dynamic>> newsCategories = [
    {
      "id": 1,
      "name": "Politics",
      "description": "Government, elections, policy, and political analysis",
      "icon": Icons.account_balance,
      "color": primaryColor,
      "articleCount": 2847,
      "todayCount": 156,
      "isFollowing": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=politics",
      "trending": ["election", "policy", "government"],
      "lastUpdated": "2 minutes ago"
    },
    {
      "id": 2,
      "name": "Business",
      "description": "Markets, economy, finance, and corporate news",
      "icon": Icons.business,
      "color": successColor,
      "articleCount": 3421,
      "todayCount": 203,
      "isFollowing": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=business",
      "trending": ["stocks", "economy", "startup"],
      "lastUpdated": "5 minutes ago"
    },
    {
      "id": 3,
      "name": "Technology",
      "description": "Innovation, gadgets, AI, and digital transformation",
      "icon": Icons.computer,
      "color": infoColor,
      "articleCount": 4156,
      "todayCount": 289,
      "isFollowing": false,
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
      "trending": ["AI", "smartphone", "blockchain"],
      "lastUpdated": "1 minute ago"
    },
    {
      "id": 4,
      "name": "Sports",
      "description": "Athletics, championships, scores, and sports analysis",
      "icon": Icons.sports_soccer,
      "color": warningColor,
      "articleCount": 1967,
      "todayCount": 134,
      "isFollowing": true,
      "image": "https://picsum.photos/300/200?random=4&keyword=sports",
      "trending": ["championship", "football", "olympics"],
      "lastUpdated": "3 minutes ago"
    },
    {
      "id": 5,
      "name": "Health",
      "description": "Medical research, wellness, healthcare, and lifestyle",
      "icon": Icons.health_and_safety,
      "color": dangerColor,
      "articleCount": 2134,
      "todayCount": 98,
      "isFollowing": false,
      "image": "https://picsum.photos/300/200?random=5&keyword=health",
      "trending": ["vaccine", "research", "wellness"],
      "lastUpdated": "7 minutes ago"
    },
    {
      "id": 6,
      "name": "Entertainment",
      "description": "Movies, music, celebrities, and pop culture",
      "icon": Icons.movie,
      "color": secondaryColor,
      "articleCount": 3789,
      "todayCount": 267,
      "isFollowing": true,
      "image": "https://picsum.photos/300/200?random=6&keyword=entertainment",
      "trending": ["hollywood", "music", "celebrity"],
      "lastUpdated": "4 minutes ago"
    },
    {
      "id": 7,
      "name": "Science",
      "description": "Research, discoveries, space, and scientific breakthroughs",
      "icon": Icons.science,
      "color": primaryColor,
      "articleCount": 1543,
      "todayCount": 76,
      "isFollowing": false,
      "image": "https://picsum.photos/300/200?random=7&keyword=science",
      "trending": ["space", "research", "climate"],
      "lastUpdated": "6 minutes ago"
    },
    {
      "id": 8,
      "name": "World News",
      "description": "International affairs, global events, and foreign news",
      "icon": Icons.public,
      "color": successColor,
      "articleCount": 5234,
      "todayCount": 321,
      "isFollowing": true,
      "image": "https://picsum.photos/300/200?random=8&keyword=world",
      "trending": ["international", "global", "foreign"],
      "lastUpdated": "1 minute ago"
    },
    {
      "id": 9,
      "name": "Environment",
      "description": "Climate change, conservation, and environmental issues",
      "icon": Icons.eco,
      "color": successColor,
      "articleCount": 987,
      "todayCount": 45,
      "isFollowing": false,
      "image": "https://picsum.photos/300/200?random=9&keyword=environment",
      "trending": ["climate", "conservation", "renewable"],
      "lastUpdated": "10 minutes ago"
    }
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) {
      return newsCategories;
    }
    return newsCategories.where((category) =>
      (category["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
      (category["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  List<Map<String, dynamic>> get followingCategories {
    return newsCategories.where((category) => 
      category["isFollowing"] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(selectedLayout == "grid" ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              selectedLayout = selectedLayout == "grid" ? "list" : "grid";
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
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
                
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${newsCategories.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Categories",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${followingCategories.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${((newsCategories.fold(0.0, (sum, cat) => sum + (cat["todayCount"] as int))) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Today",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Following Categories Section
                if (followingCategories.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Following",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${followingCategories.length} categories",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QHorizontalScroll(
                    children: followingCategories.map((category) {
                      return Container(
                        width: 200,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Image
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    "${category["image"]}",
                                    height: 80,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
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
                                  SizedBox(height: 4),
                                  Text(
                                    "+${category["todayCount"]} today",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                  
                  SizedBox(height: spMd),
                ],
                
                // All Categories Section
                Row(
                  children: [
                    Text(
                      "All Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${filteredCategories.length} found",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Categories Grid/List
                if (selectedLayout == "grid")
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredCategories.map((category) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Header
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (category["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusSm),
                                  topRight: Radius.circular(radiusSm),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spXs),
                                    decoration: BoxDecoration(
                                      color: category["color"] as Color,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Icon(
                                      category["icon"] as IconData,
                                      color: Colors.white,
                                      size: 20,
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
                                        Text(
                                          "${((category["articleCount"] as int) / 1000).toStringAsFixed(1)}K articles",
                                          style: TextStyle(
                                            color: disabledBoldColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      category["isFollowing"] = !(category["isFollowing"] as bool);
                                      setState(() {});
                                      ss(category["isFollowing"] == true ? 
                                        "Following ${category["name"]}" : 
                                        "Unfollowed ${category["name"]}");
                                    },
                                    child: Icon(
                                      category["isFollowing"] == true ? 
                                        Icons.favorite : Icons.favorite_border,
                                      color: category["isFollowing"] == true ? 
                                        dangerColor : disabledBoldColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Description
                                  Text(
                                    "${category["description"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Trending Topics
                                  Text(
                                    "Trending:",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Wrap(
                                    spacing: 4,
                                    children: (category["trending"] as List<String>).map((topic) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (category["color"] as Color).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "#$topic",
                                          style: TextStyle(
                                            color: category["color"] as Color,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  
                                  SizedBox(height: spSm),
                                  
                                  // Stats Row
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.today,
                                        size: 14,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "+${category["todayCount"]} today",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${category["lastUpdated"]}",
                                        style: TextStyle(
                                          color: disabledColor,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Action Button
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              child: QButton(
                                label: "View Articles",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                else
                  Column(
                    children: filteredCategories.map((category) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: category["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusSm),
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
                                    Text(
                                      "${category["description"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "${((category["articleCount"] as int) / 1000).toStringAsFixed(1)}K articles",
                                          style: TextStyle(
                                            color: disabledColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "+${category["todayCount"]} today",
                                          style: TextStyle(
                                            color: successColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              GestureDetector(
                                onTap: () {
                                  category["isFollowing"] = !(category["isFollowing"] as bool);
                                  setState(() {});
                                  ss(category["isFollowing"] == true ? 
                                    "Following ${category["name"]}" : 
                                    "Unfollowed ${category["name"]}");
                                },
                                child: Icon(
                                  category["isFollowing"] == true ? 
                                    Icons.favorite : Icons.favorite_border,
                                  color: category["isFollowing"] == true ? 
                                    dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
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
