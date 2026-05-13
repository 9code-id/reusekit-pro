import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameLibraryView extends StatefulWidget {
  const GeaGameLibraryView({super.key});

  @override
  State<GeaGameLibraryView> createState() => _GeaGameLibraryViewState();
}

class _GeaGameLibraryViewState extends State<GeaGameLibraryView> {
  int selectedCategory = 0;
  String searchQuery = "";
  String sortBy = "recent";
  
  final List<Map<String, dynamic>> categories = [
    {"label": "All Games", "value": "all"},
    {"label": "Installed", "value": "installed"},
    {"label": "Favorites", "value": "favorites"},
    {"label": "Recently Played", "value": "recent"},
    {"label": "Wishlist", "value": "wishlist"},
  ];

  final List<Map<String, dynamic>> games = [
    {
      "id": "1",
      "title": "Cyberpunk 2077",
      "developer": "CD Projekt Red",
      "genre": "RPG",
      "rating": 4.2,
      "price": 59.99,
      "installed": true,
      "favorite": true,
      "lastPlayed": "2024-03-15",
      "playtime": "45 hours",
      "size": "70.2 GB",
      "image": "https://picsum.photos/400/600?random=1&keyword=cyberpunk",
      "status": "Ready to Play",
      "achievements": 23,
      "totalAchievements": 45,
    },
    {
      "id": "2",
      "title": "The Witcher 3: Wild Hunt",
      "developer": "CD Projekt Red",
      "genre": "RPG",
      "rating": 4.8,
      "price": 39.99,
      "installed": true,
      "favorite": true,
      "lastPlayed": "2024-03-10",
      "playtime": "120 hours",
      "size": "35.5 GB",
      "image": "https://picsum.photos/400/600?random=2&keyword=witcher",
      "status": "Ready to Play",
      "achievements": 42,
      "totalAchievements": 78,
    },
    {
      "id": "3",
      "title": "Elden Ring",
      "developer": "FromSoftware",
      "genre": "Action RPG",
      "rating": 4.6,
      "price": 49.99,
      "installed": false,
      "favorite": false,
      "lastPlayed": null,
      "playtime": "0 hours",
      "size": "49.2 GB",
      "image": "https://picsum.photos/400/600?random=3&keyword=elden-ring",
      "status": "Not Installed",
      "achievements": 0,
      "totalAchievements": 42,
    },
    {
      "id": "4",
      "title": "Red Dead Redemption 2",
      "developer": "Rockstar Games",
      "genre": "Action Adventure",
      "rating": 4.5,
      "price": 29.99,
      "installed": true,
      "favorite": false,
      "lastPlayed": "2024-02-28",
      "playtime": "85 hours",
      "size": "119.8 GB",
      "image": "https://picsum.photos/400/600?random=4&keyword=red-dead",
      "status": "Ready to Play",
      "achievements": 18,
      "totalAchievements": 52,
    },
    {
      "id": "5",
      "title": "Valorant",
      "developer": "Riot Games",
      "genre": "FPS",
      "rating": 4.3,
      "price": 0.0,
      "installed": true,
      "favorite": true,
      "lastPlayed": "2024-03-16",
      "playtime": "200 hours",
      "size": "23.1 GB",
      "image": "https://picsum.photos/400/600?random=5&keyword=valorant",
      "status": "Ready to Play",
      "achievements": 67,
      "totalAchievements": 89,
    },
    {
      "id": "6",
      "title": "Among Us",
      "developer": "InnerSloth",
      "genre": "Party",
      "rating": 4.1,
      "price": 4.99,
      "installed": false,
      "favorite": false,
      "lastPlayed": null,
      "playtime": "0 hours",
      "size": "250 MB",
      "image": "https://picsum.photos/400/600?random=6&keyword=among-us",
      "status": "Not Installed",
      "achievements": 0,
      "totalAchievements": 15,
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    List<Map<String, dynamic>> filtered = games;
    
    // Filter by category
    if (selectedCategory != 0) {
      String categoryValue = categories[selectedCategory]["value"];
      switch (categoryValue) {
        case "installed":
          filtered = filtered.where((g) => g["installed"] == true).toList();
          break;
        case "favorites":
          filtered = filtered.where((g) => g["favorite"] == true).toList();
          break;
        case "recent":
          filtered = filtered.where((g) => g["lastPlayed"] != null).toList();
          break;
        case "wishlist":
          filtered = filtered.where((g) => g["installed"] == false && g["price"] > 0).toList();
          break;
      }
    }
    
    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((g) => 
        g["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        g["developer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        g["genre"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) {
          if (a["lastPlayed"] == null && b["lastPlayed"] == null) return 0;
          if (a["lastPlayed"] == null) return 1;
          if (b["lastPlayed"] == null) return -1;
          return DateTime.parse(b["lastPlayed"]).compareTo(DateTime.parse(a["lastPlayed"]));
        });
        break;
      case "name":
        filtered.sort((a, b) => a["title"].toString().compareTo(b["title"].toString()));
        break;
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "playtime":
        filtered.sort((a, b) {
          int aTime = int.tryParse(a["playtime"].toString().split(" ")[0]) ?? 0;
          int bTime = int.tryParse(b["playtime"].toString().split(" ")[0]) ?? 0;
          return bTime.compareTo(aTime);
        });
        break;
    }
    
    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Ready to Play":
        return successColor;
      case "Not Installed":
        return disabledBoldColor;
      case "Updating":
        return warningColor;
      case "Downloading":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Library"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Toggle search
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Sort by Recent"),
                onTap: () => setState(() => sortBy = "recent"),
              ),
              PopupMenuItem(
                child: Text("Sort by Name"),
                onTap: () => setState(() => sortBy = "name"),
              ),
              PopupMenuItem(
                child: Text("Sort by Rating"),
                onTap: () => setState(() => sortBy = "rating"),
              ),
              PopupMenuItem(
                child: Text("Sort by Playtime"),
                onTap: () => setState(() => sortBy = "playtime"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search games, developers, genres...",
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
                  onPressed: () {
                    // Perform search
                  },
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: Colors.white,
            child: QCategoryPicker(
              items: categories,
              value: categories[selectedCategory]["value"],
              onChanged: (index, label, value, item) {
                selectedCategory = index;
                setState(() {});
              },
            ),
          ),
          
          // Library Stats
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 100,
              children: [
                _buildStatCard("Total Games", "${games.length}", Icons.gamepad, primaryColor),
                _buildStatCard("Installed", "${games.where((g) => g["installed"] == true).length}", Icons.download_done, successColor),
                _buildStatCard("Favorites", "${games.where((g) => g["favorite"] == true).length}", Icons.favorite, dangerColor),
                _buildStatCard("Total Size", "${games.where((g) => g["installed"] == true).fold(0.0, (sum, g) => sum + double.parse(g["size"].toString().split(" ")[0])).toStringAsFixed(1)} GB", Icons.storage, warningColor),
              ],
            ),
          ),
          
          // Games List
          Expanded(
            child: filteredGames.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.games,
                          size: 64,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No games found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          searchQuery.isNotEmpty 
                              ? "Try adjusting your search terms"
                              : "Add some games to your library",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredGames.length,
                    itemBuilder: (context, index) {
                      final game = filteredGames[index];
                      return _buildGameCard(game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          // Game Cover
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusMd),
              bottomLeft: Radius.circular(radiusMd),
            ),
            child: Image.network(
              "${game["image"]}",
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          
          // Game Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Favorite
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${game["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (game["favorite"] == true)
                        Icon(
                          Icons.favorite,
                          color: dangerColor,
                          size: 16,
                        ),
                    ],
                  ),
                  
                  SizedBox(height: spXs),
                  
                  // Developer and Genre
                  Row(
                    children: [
                      Text(
                        "${game["developer"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        " • ${game["genre"]}",
                        style: TextStyle(
                          color: disabledColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Rating and Price
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 14,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${game["rating"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        game["price"] == 0.0 ? "Free" : "\$${(game["price"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: game["price"] == 0.0 ? successColor : primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Status and Playtime
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: getStatusColor(game["status"]).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${game["status"]}",
                          style: TextStyle(
                            color: getStatusColor(game["status"]),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (game["installed"] == true) ...[
                        SizedBox(width: spSm),
                        Text(
                          "${game["playtime"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  if (game["installed"] == true) ...[
                    SizedBox(height: spSm),
                    
                    // Achievement Progress
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Achievements: ${game["achievements"]}/${game["totalAchievements"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (game["achievements"] as int) / (game["totalAchievements"] as int),
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(successColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                if (game["installed"] == true) ...[
                  QButton(
                    label: "Play",
                    icon: Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      // Launch game
                    },
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {
                      game["favorite"] = !(game["favorite"] as bool);
                      setState(() {});
                    },
                    child: Icon(
                      game["favorite"] == true ? Icons.favorite : Icons.favorite_border,
                      color: game["favorite"] == true ? dangerColor : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ] else ...[
                  QButton(
                    label: "Install",
                    icon: Icons.download,
                    size: bs.sm,
                    onPressed: () {
                      // Install game
                    },
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${game["size"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
                SizedBox(height: spSm),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.info, size: 16),
                          SizedBox(width: spSm),
                          Text("Game Info"),
                        ],
                      ),
                    ),
                    if (game["installed"] == true)
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16),
                            SizedBox(width: spSm),
                            Text("Uninstall"),
                          ],
                        ),
                      ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.share, size: 16),
                          SizedBox(width: spSm),
                          Text("Share"),
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
    );
  }
}
