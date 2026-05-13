import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCategoriesView extends StatefulWidget {
  const GeaCategoriesView({super.key});

  @override
  State<GeaCategoriesView> createState() => _GeaCategoriesViewState();
}

class _GeaCategoriesViewState extends State<GeaCategoriesView> {
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {
      "id": 1,
      "name": "Action",
      "description": "High-intensity games with combat and adventure",
      "gameCount": 1250,
      "color": 0xFFE74C3C,
      "icon": Icons.flash_on,
      "image": "https://picsum.photos/400/200?random=1&keyword=action",
      "trending": true,
    },
    {
      "id": 2,
      "name": "Adventure",
      "description": "Explore vast worlds and embark on epic journeys",
      "gameCount": 980,
      "color": 0xFF27AE60,
      "icon": Icons.explore,
      "image": "https://picsum.photos/400/200?random=2&keyword=adventure",
      "trending": false,
    },
    {
      "id": 3,
      "name": "RPG",
      "description": "Role-playing games with character development",
      "gameCount": 756,
      "color": 0xFF8E44AD,
      "icon": Icons.person,
      "image": "https://picsum.photos/400/200?random=3&keyword=fantasy",
      "trending": true,
    },
    {
      "id": 4,
      "name": "Shooter",
      "description": "First-person and third-person shooting games",
      "gameCount": 892,
      "color": 0xFFE67E22,
      "icon": Icons.gps_fixed,
      "image": "https://picsum.photos/400/200?random=4&keyword=shooter",
      "trending": false,
    },
    {
      "id": 5,
      "name": "Strategy",
      "description": "Think ahead and plan your moves carefully",
      "gameCount": 634,
      "color": 0xFF3498DB,
      "icon": Icons.psychology,
      "image": "https://picsum.photos/400/200?random=5&keyword=strategy",
      "trending": false,
    },
    {
      "id": 6,
      "name": "Sports",
      "description": "Play your favorite sports virtually",
      "gameCount": 423,
      "color": 0xFF2ECC71,
      "icon": Icons.sports_soccer,
      "image": "https://picsum.photos/400/200?random=6&keyword=sports",
      "trending": true,
    },
    {
      "id": 7,
      "name": "Racing",
      "description": "High-speed racing and driving games",
      "gameCount": 345,
      "color": 0xFFF39C12,
      "icon": Icons.directions_car,
      "image": "https://picsum.photos/400/200?random=7&keyword=racing",
      "trending": false,
    },
    {
      "id": 8,
      "name": "Puzzle",
      "description": "Challenge your mind with brain teasers",
      "gameCount": 567,
      "color": 0xFF9B59B6,
      "icon": Icons.extension,
      "image": "https://picsum.photos/400/200?random=8&keyword=puzzle",
      "trending": false,
    },
    {
      "id": 9,
      "name": "Horror",
      "description": "Spine-chilling games for thrill seekers",
      "gameCount": 234,
      "color": 0xFF34495E,
      "icon": Icons.visibility_off,
      "image": "https://picsum.photos/400/200?random=9&keyword=horror",
      "trending": true,
    },
    {
      "id": 10,
      "name": "Simulation",
      "description": "Realistic simulation games and life sims",
      "gameCount": 456,
      "color": 0xFF16A085,
      "icon": Icons.computer,
      "image": "https://picsum.photos/400/200?random=10&keyword=simulation",
      "trending": false,
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((category) {
      return (category["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
             (category["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Field
            QTextField(
              label: "Search categories...",
              value: searchQuery,
              hint: "Find your favorite game category",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Popular Categories Header
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "Popular Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),

            // Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredCategories.map((category) {
                final categoryColor = Color(category["color"] as int);
                final isTrending = category["trending"] as bool;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              topRight: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${category["image"]}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (isTrending)
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Trending",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          // Category Icon Overlay
                          Positioned(
                            bottom: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: categoryColor.withAlpha(200),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Category Info
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
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
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Game Count
                            Row(
                              children: [
                                Icon(
                                  Icons.games,
                                  size: 16,
                                  color: categoryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(category["gameCount"] as int)} games",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: categoryColor,
                                  ),
                                ),
                              ],
                            ),

                            // Explore Button
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: "Explore",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('GeaGenreView', arguments: category)
                                },
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

            // Statistics Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Category Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Categories",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${categories.length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Games",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${((categories.fold(0, (sum, cat) => sum + (cat["gameCount"] as int))) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trending",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${categories.where((cat) => cat["trending"] == true).length}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
          ],
        ),
      ),
    );
  }
}
