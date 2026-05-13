import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaFeaturedGamesView extends StatefulWidget {
  const GeaFeaturedGamesView({super.key});

  @override
  State<GeaFeaturedGamesView> createState() => _GeaFeaturedGamesViewState();
}

class _GeaFeaturedGamesViewState extends State<GeaFeaturedGamesView> {
  int selectedCategory = 0;
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All Featured", "value": "all"},
    {"label": "Editor's Choice", "value": "editors"},
    {"label": "New & Notable", "value": "new"},
    {"label": "On Sale", "value": "sale"},
    {"label": "Free to Play", "value": "free"},
  ];

  final List<Map<String, dynamic>> featuredGames = [
    {
      "id": "1",
      "title": "Baldur's Gate 3",
      "developer": "Larian Studios",
      "genre": "RPG",
      "rating": 4.9,
      "originalPrice": 59.99,
      "salePrice": null,
      "discount": 0,
      "category": "editors",
      "featured": true,
      "new": false,
      "free": false,
      "description": "An epic RPG adventure with deep character customization and meaningful choices",
      "tags": ["RPG", "Adventure", "Turn-Based", "Multiplayer"],
      "releaseDate": "2023-08-03",
      "image": "https://picsum.photos/600/800?random=1&keyword=fantasy-rpg",
      "screenshots": [
        "https://picsum.photos/800/600?random=11&keyword=game-rpg",
        "https://picsum.photos/800/600?random=12&keyword=fantasy-battle",
        "https://picsum.photos/800/600?random=13&keyword=rpg-character",
      ],
      "trailer": "trailer_url_1",
      "requirements": {
        "minimum": "Intel i5-4690 / AMD FX-8350",
        "recommended": "Intel i7-8700K / AMD Ryzen 5 3600",
        "storage": "150 GB",
      },
    },
    {
      "id": "2",
      "title": "Starfield",
      "developer": "Bethesda Game Studios",
      "genre": "RPG",
      "rating": 4.3,
      "originalPrice": 69.99,
      "salePrice": 49.99,
      "discount": 29,
      "category": "sale",
      "featured": true,
      "new": true,
      "free": false,
      "description": "Explore the vast expanse of space in this next-generation role-playing game",
      "tags": ["RPG", "Space", "Exploration", "Single Player"],
      "releaseDate": "2023-09-06",
      "image": "https://picsum.photos/600/800?random=2&keyword=space-game",
      "screenshots": [
        "https://picsum.photos/800/600?random=21&keyword=space-exploration",
        "https://picsum.photos/800/600?random=22&keyword=sci-fi-game",
        "https://picsum.photos/800/600?random=23&keyword=spaceship",
      ],
      "trailer": "trailer_url_2",
      "requirements": {
        "minimum": "Intel i7-6800K / AMD Ryzen 5 2600X",
        "recommended": "Intel i5-10600K / AMD Ryzen 5 3600X",
        "storage": "125 GB",
      },
    },
    {
      "id": "3",
      "title": "Apex Legends",
      "developer": "Respawn Entertainment",
      "genre": "Battle Royale",
      "rating": 4.4,
      "originalPrice": 0.0,
      "salePrice": null,
      "discount": 0,
      "category": "free",
      "featured": true,
      "new": false,
      "free": true,
      "description": "Fast-paced battle royale with unique character abilities and squad-based gameplay",
      "tags": ["Battle Royale", "FPS", "Multiplayer", "Free to Play"],
      "releaseDate": "2019-02-04",
      "image": "https://picsum.photos/600/800?random=3&keyword=battle-royale",
      "screenshots": [
        "https://picsum.photos/800/600?random=31&keyword=fps-game",
        "https://picsum.photos/800/600?random=32&keyword=battle-arena",
        "https://picsum.photos/800/600?random=33&keyword=multiplayer",
      ],
      "trailer": "trailer_url_3",
      "requirements": {
        "minimum": "Intel i3-6300 / AMD FX-4350",
        "recommended": "Intel i5-3570K / AMD FX-8350",
        "storage": "56 GB",
      },
    },
    {
      "id": "4",
      "title": "Spider-Man Remastered",
      "developer": "Insomniac Games",
      "genre": "Action Adventure",
      "rating": 4.7,
      "originalPrice": 59.99,
      "salePrice": 29.99,
      "discount": 50,
      "category": "sale",
      "featured": true,
      "new": false,
      "free": false,
      "description": "Swing through New York City as the web-slinging superhero in this action-packed adventure",
      "tags": ["Action", "Adventure", "Superhero", "Open World"],
      "releaseDate": "2022-08-12",
      "image": "https://picsum.photos/600/800?random=4&keyword=superhero",
      "screenshots": [
        "https://picsum.photos/800/600?random=41&keyword=spider-man",
        "https://picsum.photos/800/600?random=42&keyword=city-swing",
        "https://picsum.photos/800/600?random=43&keyword=superhero-action",
      ],
      "trailer": "trailer_url_4",
      "requirements": {
        "minimum": "Intel i3-4160 / AMD FX-6300",
        "recommended": "Intel i5-4670 / AMD Ryzen 5 1600",
        "storage": "75 GB",
      },
    },
    {
      "id": "5",
      "title": "Hogwarts Legacy",
      "developer": "Avalanche Software",
      "genre": "RPG",
      "rating": 4.5,
      "originalPrice": 59.99,
      "salePrice": null,
      "discount": 0,
      "category": "new",
      "featured": true,
      "new": true,
      "free": false,
      "description": "Experience life as a student at Hogwarts School of Witchcraft and Wizardry",
      "tags": ["RPG", "Magic", "Adventure", "Single Player"],
      "releaseDate": "2023-02-10",
      "image": "https://picsum.photos/600/800?random=5&keyword=magic-school",
      "screenshots": [
        "https://picsum.photos/800/600?random=51&keyword=hogwarts",
        "https://picsum.photos/800/600?random=52&keyword=magic-spells",
        "https://picsum.photos/800/600?random=53&keyword=wizard-game",
      ],
      "trailer": "trailer_url_5",
      "requirements": {
        "minimum": "Intel i5-6600 / AMD Ryzen 5 1400",
        "recommended": "Intel i7-8700 / AMD Ryzen 5 3600",
        "storage": "85 GB",
      },
    },
    {
      "id": "6",
      "title": "Fortnite",
      "developer": "Epic Games",
      "genre": "Battle Royale",
      "rating": 4.2,
      "originalPrice": 0.0,
      "salePrice": null,
      "discount": 0,
      "category": "free",
      "featured": true,
      "new": false,
      "free": true,
      "description": "Build, battle, and be the last one standing in this iconic battle royale game",
      "tags": ["Battle Royale", "Building", "Multiplayer", "Free to Play"],
      "releaseDate": "2017-07-25",
      "image": "https://picsum.photos/600/800?random=6&keyword=fortnite",
      "screenshots": [
        "https://picsum.photos/800/600?random=61&keyword=building-game",
        "https://picsum.photos/800/600?random=62&keyword=battle-royale-arena",
        "https://picsum.photos/800/600?random=63&keyword=multiplayer-battle",
      ],
      "trailer": "trailer_url_6",
      "requirements": {
        "minimum": "Intel i3-3225 / AMD FX-4350",
        "recommended": "Intel i5-7300U / AMD Ryzen 3 1200",
        "storage": "26 GB",
      },
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    if (selectedCategory == 0) return featuredGames;
    
    String categoryValue = categories[selectedCategory]["value"];
    switch (categoryValue) {
      case "editors":
        return featuredGames.where((g) => g["category"] == "editors").toList();
      case "new":
        return featuredGames.where((g) => g["new"] == true).toList();
      case "sale":
        return featuredGames.where((g) => g["discount"] > 0).toList();
      case "free":
        return featuredGames.where((g) => g["free"] == true).toList();
      default:
        return featuredGames;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured Games"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // Background Pattern
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/800/400?random=100&keyword=gaming-banner"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            primaryColor.withAlpha(180),
                            BlendMode.multiply,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Content
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 32,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Featured Games",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Discover the best games handpicked by our editors",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            QButton(
                              label: "Browse All",
                              icon: Icons.explore,
                              size: bs.sm,
                              onPressed: () {
                                // Navigate to browse all
                              },
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: Colors.white.withAlpha(100)),
                              ),
                              child: Text(
                                "${featuredGames.length} Featured Games",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
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
            
            SizedBox(height: spLg),
            
            // Category Filter
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: QCategoryPicker(
                items: categories,
                value: categories[selectedCategory]["value"],
                onChanged: (index, label, value, item) {
                  selectedCategory = index;
                  setState(() {});
                },
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Quick Stats
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 120,
                children: [
                  _buildQuickStat("On Sale", "${featuredGames.where((g) => g["discount"] > 0).length}", Icons.local_offer, warningColor),
                  _buildQuickStat("Free Games", "${featuredGames.where((g) => g["free"] == true).length}", Icons.free_breakfast, successColor),
                  _buildQuickStat("New Releases", "${featuredGames.where((g) => g["new"] == true).length}", Icons.new_releases, infoColor),
                  _buildQuickStat("Editor's Choice", "${featuredGames.where((g) => g["category"] == "editors").length}", Icons.star, primaryColor),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Featured Games Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedCategory == 0 ? "All Featured Games" : "${categories[selectedCategory]["label"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredGames.map((game) {
                      return _buildGameCard(game);
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 3,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Game Cover with Badges
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
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Badges
              Positioned(
                top: spSm,
                left: spSm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (game["category"] == "editors")
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "EDITOR'S CHOICE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (game["new"] == true)
                      Container(
                        margin: EdgeInsets.only(top: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Discount Badge
              if (game["discount"] > 0)
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "-${game["discount"]}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              // Rating
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${game["rating"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Game Info
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "${game["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spXs),
                
                // Developer and Genre
                Text(
                  "${game["developer"]} • ${game["genre"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                
                SizedBox(height: spSm),
                
                // Description
                Text(
                  "${game["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spMd),
                
                // Tags
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (game["tags"] as List).take(3).map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Price and Action
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (game["discount"] > 0) ...[
                            Text(
                              "\$${(game["originalPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              "\$${(game["salePrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ] else ...[
                            Text(
                              game["free"] == true ? "Free to Play" : "\$${(game["originalPrice"] as double).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: game["free"] == true ? successColor : primaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    QButton(
                      label: game["free"] == true ? "Play Free" : "Buy Now",
                      size: bs.sm,
                      onPressed: () {
                        // Navigate to game details or purchase
                      },
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
}
