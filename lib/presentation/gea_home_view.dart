import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaHomeView extends StatefulWidget {
  const GeaHomeView({super.key});

  @override
  State<GeaHomeView> createState() => _GeaHomeViewState();
}

class _GeaHomeViewState extends State<GeaHomeView> {
  String searchQuery = "";
  int currentBottomIndex = 0;

  List<Map<String, dynamic>> featuredGames = [
    {
      "title": "Cosmic Warriors",
      "genre": "Action",
      "rating": 4.8,
      "downloads": "1.2M",
      "image": "https://picsum.photos/400/200?random=1&keyword=space",
      "isFeatured": true,
      "isNew": false,
      "price": "Free",
    },
    {
      "title": "Mystery Island",
      "genre": "Adventure",
      "rating": 4.6,
      "downloads": "850K",
      "image": "https://picsum.photos/400/200?random=2&keyword=island",
      "isFeatured": true,
      "isNew": true,
      "price": "Free",
    },
    {
      "title": "Dragon Quest Elite",
      "genre": "RPG",
      "rating": 4.9,
      "downloads": "2.1M",
      "image": "https://picsum.photos/400/200?random=3&keyword=dragon",
      "isFeatured": true,
      "isNew": false,
      "price": "\$4.99",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"name": "Action", "icon": Icons.flash_on, "color": Colors.red, "count": 1250},
    {"name": "Adventure", "icon": Icons.explore, "color": Colors.orange, "count": 890},
    {"name": "RPG", "icon": Icons.auto_awesome, "color": Colors.purple, "count": 650},
    {"name": "Strategy", "icon": Icons.psychology, "color": Colors.blue, "count": 450},
    {"name": "Sports", "icon": Icons.sports_soccer, "color": Colors.green, "count": 320},
    {"name": "Racing", "icon": Icons.directions_car, "color": Colors.deepOrange, "count": 280},
    {"name": "Puzzle", "icon": Icons.extension, "color": Colors.teal, "count": 750},
    {"name": "Simulation", "icon": Icons.build, "color": Colors.brown, "count": 380},
  ];

  List<Map<String, dynamic>> recentlyPlayed = [
    {
      "title": "Space Shooter",
      "lastPlayed": "2 hours ago",
      "progress": 75,
      "image": "https://picsum.photos/100/100?random=10&keyword=space",
    },
    {
      "title": "Puzzle Master",
      "lastPlayed": "Yesterday",
      "progress": 45,
      "image": "https://picsum.photos/100/100?random=11&keyword=puzzle",
    },
    {
      "title": "Racing Pro",
      "lastPlayed": "3 days ago",
      "progress": 90,
      "image": "https://picsum.photos/100/100?random=12&keyword=car",
    },
  ];

  List<Map<String, dynamic>> topCharts = [
    {
      "rank": 1,
      "title": "Battle Royale Ultra",
      "genre": "Action",
      "rating": 4.9,
      "image": "https://picsum.photos/60/60?random=20&keyword=battle",
    },
    {
      "rank": 2,
      "title": "City Builder",
      "genre": "Simulation",
      "rating": 4.7,
      "image": "https://picsum.photos/60/60?random=21&keyword=city",
    },
    {
      "rank": 3,
      "title": "Adventure Quest",
      "genre": "RPG",
      "rating": 4.8,
      "image": "https://picsum.photos/60/60?random=22&keyword=quest",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "GameZone",
      selectedIndex: currentBottomIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: "Games",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: "Library",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildGamesTab(),
        _buildDiscoverTab(),
        _buildLibraryTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentBottomIndex = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back, Player!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Ready for your next adventure?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.games,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),

          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search games...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Featured Games
          Text(
            "Featured Games",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          QHorizontalScroll(
            children: featuredGames.map((game) {
              return Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${game["image"]}",
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (game["isNew"])
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "NEW",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${game["price"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "${game["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${game["genre"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${game["rating"]}",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Text(
                                "${game["downloads"]} downloads",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: game["price"] == "Free" ? "Play Now" : "Buy Now",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('GameDetailView', arguments: game)
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

          // Categories
          Text(
            "Browse Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categories.map((category) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      category["icon"],
                      color: category["color"],
                      size: 32,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${category["count"]} games",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Recently Played
          Text(
            "Continue Playing",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...recentlyPlayed.map((game) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${game["image"]}",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${game["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Last played: ${game["lastPlayed"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: (game["progress"] as int) / 100,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${game["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Continue",
                    size: bs.sm,
                    onPressed: () {
                      //continueGame(game)
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGamesTab() {
    return Center(
      child: Text(
        "Games Library",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return Center(
      child: Text(
        "Discover New Games",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildLibraryTab() {
    return Center(
      child: Text(
        "My Game Library",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text(
        "Player Profile",
        style: TextStyle(fontSize: 18, color: primaryColor),
      ),
    );
  }
}
