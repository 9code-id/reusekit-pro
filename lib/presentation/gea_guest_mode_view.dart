import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGuestModeView extends StatefulWidget {
  const GeaGuestModeView({super.key});

  @override
  State<GeaGuestModeView> createState() => _GeaGuestModeViewState();
}

class _GeaGuestModeViewState extends State<GeaGuestModeView> {
  List<String> selectedInterests = [];

  List<Map<String, dynamic>> gameCategories = [
    {
      "name": "Action",
      "icon": Icons.flash_on,
      "color": Colors.red,
      "gameCount": 1250,
      "description": "Fast-paced, high-energy games",
    },
    {
      "name": "Adventure",
      "icon": Icons.explore,
      "color": Colors.orange,
      "gameCount": 890,
      "description": "Explore worlds and solve mysteries",
    },
    {
      "name": "RPG",
      "icon": Icons.auto_awesome,
      "color": Colors.purple,
      "gameCount": 650,
      "description": "Role-playing and character development",
    },
    {
      "name": "Strategy",
      "icon": Icons.psychology,
      "color": Colors.blue,
      "gameCount": 450,
      "description": "Think ahead and plan your moves",
    },
    {
      "name": "Sports",
      "icon": Icons.sports_soccer,
      "color": Colors.green,
      "gameCount": 320,
      "description": "Athletic competitions and sports",
    },
    {
      "name": "Racing",
      "icon": Icons.directions_car,
      "color": Colors.deepOrange,
      "gameCount": 280,
      "description": "High-speed racing challenges",
    },
    {
      "name": "Puzzle",
      "icon": Icons.extension,
      "color": Colors.teal,
      "gameCount": 750,
      "description": "Brain teasers and logical challenges",
    },
    {
      "name": "Simulation",
      "icon": Icons.build,
      "color": Colors.brown,
      "gameCount": 380,
      "description": "Build and manage virtual worlds",
    },
  ];

  List<Map<String, dynamic>> featuredGames = [
    {
      "title": "Cosmic Warriors",
      "genre": "Action",
      "rating": 4.8,
      "players": "1.2M",
      "image": "https://picsum.photos/300/200?random=1&keyword=space",
      "isFree": true,
    },
    {
      "title": "Mystery Island",
      "genre": "Adventure",
      "rating": 4.6,
      "players": "850K",
      "image": "https://picsum.photos/300/200?random=2&keyword=island",
      "isFree": true,
    },
    {
      "title": "Dragon Quest",
      "genre": "RPG",
      "rating": 4.9,
      "players": "2.1M",
      "image": "https://picsum.photos/300/200?random=3&keyword=dragon",
      "isFree": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Mode"),
        actions: [
          TextButton(
            onPressed: () {
              //navigateTo('GeaLoginView')
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Welcome, Guest Player!",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Explore our gaming library with limited access. Create an account to unlock full features, save progress, and join the community.",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Create Free Account",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('GeaRegisterView')
                    },
                  ),
                ],
              ),
            ),

            // Guest Limitations
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Guest Mode Limitations",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      _buildLimitationItem("No game progress saving"),
                      _buildLimitationItem("Limited to free games only"),
                      _buildLimitationItem("No community features"),
                      _buildLimitationItem("No achievements or rewards"),
                      _buildLimitationItem("Session expires after 2 hours"),
                    ],
                  ),
                ],
              ),
            ),

            // Choose Your Interests
            Text(
              "Choose Your Gaming Interests",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Text(
              "Select categories to get personalized game recommendations",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),

            // Game Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: gameCategories.map((category) {
                final isSelected = selectedInterests.contains(category["name"]);
                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      selectedInterests.remove(category["name"]);
                    } else {
                      selectedInterests.add(category["name"]);
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? category["color"].withAlpha(20)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected 
                            ? category["color"]
                            : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              category["icon"],
                              color: category["color"],
                              size: 24,
                            ),
                            Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: category["color"],
                                size: 20,
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${category["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${category["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${(category["gameCount"] as int)} games",
                          style: TextStyle(
                            fontSize: 12,
                            color: category["color"],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Featured Free Games
            Text(
              "Featured Free Games",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: featuredGames.map((game) {
                return Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
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
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (game["isFree"])
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "FREE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
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
                              "${game["genre"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${game["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${game["players"]} players",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              child: QButton(
                                label: game["isFree"] ? "Play Now" : "Preview",
                                size: bs.sm,
                                onPressed: () {
                                  //playGame(game)
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

            // Start Playing Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Playing as Guest",
                size: bs.md,
                onPressed: () {
                  //navigateTo('GeaHomeView', arguments: {'isGuest': true})
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitationItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.block,
            color: warningColor,
            size: 14,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: warningColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
