import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaNewReleasesView extends StatefulWidget {
  const GeaNewReleasesView({super.key});

  @override
  State<GeaNewReleasesView> createState() => _GeaNewReleasesViewState();
}

class _GeaNewReleasesViewState extends State<GeaNewReleasesView> {
  int selectedPeriod = 0;
  String selectedGenre = "all";
  
  final List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "This Year", "value": "year"},
  ];

  final List<Map<String, dynamic>> genres = [
    {"label": "All Genres", "value": "all"},
    {"label": "Action", "value": "action"},
    {"label": "RPG", "value": "rpg"},
    {"label": "Strategy", "value": "strategy"},
    {"label": "Sports", "value": "sports"},
    {"label": "Racing", "value": "racing"},
  ];

  final List<Map<String, dynamic>> newReleases = [
    {
      "id": "1",
      "title": "Lies of P",
      "developer": "Neowiz",
      "genre": "Action RPG",
      "rating": 4.6,
      "price": 59.99,
      "releaseDate": "2024-03-15",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": false,
      "description": "A dark reimagining of Pinocchio set in a Belle Époque-inspired world",
      "tags": ["Souls-like", "Action RPG", "Dark Fantasy", "Single Player"],
      "image": "https://picsum.photos/600/800?random=1&keyword=dark-fantasy",
      "screenshots": [
        "https://picsum.photos/800/600?random=11&keyword=dark-rpg",
        "https://picsum.photos/800/600?random=12&keyword=fantasy-combat",
      ],
      "systemRequirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel i5-8400 / AMD Ryzen 5 2600",
        "memory": "16 GB RAM",
        "graphics": "GTX 1060 6GB / RX 580 8GB",
        "storage": "50 GB",
      },
      "weeksSinceRelease": 1,
    },
    {
      "id": "2",
      "title": "Pizza Tower",
      "developer": "Tour De Pizza",
      "genre": "Platformer",
      "rating": 4.8,
      "price": 19.99,
      "releaseDate": "2024-03-10",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": false,
      "description": "A fast-paced 2D platformer inspired by the Wario Land series",
      "tags": ["Platformer", "2D", "Indie", "Comedy"],
      "image": "https://picsum.photos/600/800?random=2&keyword=pizza-game",
      "screenshots": [
        "https://picsum.photos/800/600?random=21&keyword=2d-platformer",
        "https://picsum.photos/800/600?random=22&keyword=cartoon-game",
      ],
      "systemRequirements": {
        "os": "Windows 7 64-bit",
        "processor": "Intel i3-4160 / AMD FX-4350",
        "memory": "4 GB RAM",
        "graphics": "GTX 750 Ti / R7 260X",
        "storage": "2 GB",
      },
      "weeksSinceRelease": 1,
    },
    {
      "id": "3",
      "title": "Atomic Heart",
      "developer": "Mundfish",
      "genre": "Action RPG",
      "rating": 4.3,
      "price": 69.99,
      "releaseDate": "2024-02-28",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": false,
      "description": "An adventure set in an alternate universe Soviet Union filled with robots",
      "tags": ["Action RPG", "FPS", "Sci-Fi", "Soviet"],
      "image": "https://picsum.photos/600/800?random=3&keyword=retro-futurism",
      "screenshots": [
        "https://picsum.photos/800/600?random=31&keyword=soviet-tech",
        "https://picsum.photos/800/600?random=32&keyword=robot-combat",
      ],
      "systemRequirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel i5-2500K / AMD FX-6300",
        "memory": "8 GB RAM",
        "graphics": "GTX 960 / RX 570",
        "storage": "90 GB",
      },
      "weeksSinceRelease": 3,
    },
    {
      "id": "4",
      "title": "Wo Long: Fallen Dynasty",
      "developer": "Team Ninja",
      "genre": "Action RPG",
      "rating": 4.4,
      "price": 59.99,
      "releaseDate": "2024-02-15",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": false,
      "description": "A dark fantasy Three Kingdoms action RPG with souls-like combat",
      "tags": ["Souls-like", "Action RPG", "Chinese Fantasy", "Multiplayer"],
      "image": "https://picsum.photos/600/800?random=4&keyword=chinese-warrior",
      "screenshots": [
        "https://picsum.photos/800/600?random=41&keyword=ancient-china",
        "https://picsum.photos/800/600?random=42&keyword=warrior-combat",
      ],
      "systemRequirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel i7-6700K / AMD Ryzen 5 1600",
        "memory": "12 GB RAM",
        "graphics": "GTX 1060 6GB / RX 580 8GB",
        "storage": "60 GB",
      },
      "weeksSinceRelease": 4,
    },
    {
      "id": "5",
      "title": "Forspoken",
      "developer": "Luminous Productions",
      "genre": "Action RPG",
      "rating": 3.8,
      "price": 69.99,
      "releaseDate": "2024-01-24",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": false,
      "description": "Follow Frey's journey as she's transported to a beautiful yet cruel land",
      "tags": ["Action RPG", "Magic", "Open World", "Female Protagonist"],
      "image": "https://picsum.photos/600/800?random=5&keyword=magic-adventure",
      "screenshots": [
        "https://picsum.photos/800/600?random=51&keyword=magical-world",
        "https://picsum.photos/800/600?random=52&keyword=spell-casting",
      ],
      "systemRequirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel i7-8700K / AMD Ryzen 5 3600",
        "memory": "16 GB RAM",
        "graphics": "GTX 1070 / RX 5700 XT",
        "storage": "150 GB",
      },
      "weeksSinceRelease": 8,
    },
    {
      "id": "6",
      "title": "Street Fighter 6",
      "developer": "Capcom",
      "genre": "Fighting",
      "rating": 4.7,
      "price": 59.99,
      "releaseDate": "2024-04-01",
      "preOrder": false,
      "earlyAccess": false,
      "comingSoon": true,
      "description": "The latest installment in the legendary fighting game series",
      "tags": ["Fighting", "Competitive", "Multiplayer", "Tournament"],
      "image": "https://picsum.photos/600/800?random=6&keyword=street-fighter",
      "screenshots": [
        "https://picsum.photos/800/600?random=61&keyword=fighting-game",
        "https://picsum.photos/800/600?random=62&keyword=martial-arts",
      ],
      "systemRequirements": {
        "os": "Windows 10 64-bit",
        "processor": "Intel i5-7500 / AMD Ryzen 3 1200",
        "memory": "8 GB RAM",
        "graphics": "GTX 1060 / RX 580",
        "storage": "60 GB",
      },
      "weeksSinceRelease": -1,
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    List<Map<String, dynamic>> filtered = newReleases;
    
    // Filter by genre
    if (selectedGenre != "all") {
      filtered = filtered.where((g) => 
        g["genre"].toString().toLowerCase().contains(selectedGenre.toLowerCase())
      ).toList();
    }
    
    // Filter by period
    String periodValue = periods[selectedPeriod]["value"];
    DateTime now = DateTime.now();
    
    filtered = filtered.where((g) {
      DateTime releaseDate = DateTime.parse(g["releaseDate"]);
      int daysDiff = now.difference(releaseDate).inDays;
      
      switch (periodValue) {
        case "week":
          return daysDiff >= -7 && daysDiff <= 7;
        case "month":
          return daysDiff >= -30 && daysDiff <= 30;
        case "3months":
          return daysDiff >= -90 && daysDiff <= 90;
        case "year":
          return daysDiff >= -365 && daysDiff <= 365;
        default:
          return true;
      }
    }).toList();
    
    // Sort by release date (newest first)
    filtered.sort((a, b) => DateTime.parse(b["releaseDate"]).compareTo(DateTime.parse(a["releaseDate"])));
    
    return filtered;
  }

  String getGameStatus(Map<String, dynamic> game) {
    DateTime releaseDate = DateTime.parse(game["releaseDate"]);
    DateTime now = DateTime.now();
    
    if (game["comingSoon"] == true) {
      return "Coming Soon";
    } else if (game["preOrder"] == true) {
      return "Pre-Order";
    } else if (game["earlyAccess"] == true) {
      return "Early Access";
    } else if (releaseDate.isAfter(now)) {
      return "Coming Soon";
    } else {
      int daysSinceRelease = now.difference(releaseDate).inDays;
      if (daysSinceRelease <= 7) {
        return "Just Released";
      } else if (daysSinceRelease <= 30) {
        return "New Release";
      } else {
        return "Available";
      }
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Just Released":
        return successColor;
      case "New Release":
        return infoColor;
      case "Coming Soon":
        return warningColor;
      case "Pre-Order":
        return primaryColor;
      case "Early Access":
        return Colors.purple;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Releases"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigate to release notifications settings
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to release calendar
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.new_releases,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Game Releases",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Discover the latest games hitting the market",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Updated Daily",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${filteredGames.length} Games",
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
            
            SizedBox(height: spLg),
            
            // Filters
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Period Filter
                  Text(
                    "Time Period",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: periods.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> period = entry.value;
                      bool isSelected = selectedPeriod == index;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedPeriod = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${period["label"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Genre Filter
                  QCategoryPicker(
                    label: "Genre",
                    items: genres,
                    value: selectedGenre,
                    onChanged: (index, label, value, item) {
                      selectedGenre = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Release Statistics
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 120,
                children: [
                  _buildStatCard("This Week", "${newReleases.where((g) => (g["weeksSinceRelease"] as int) <= 1 && (g["weeksSinceRelease"] as int) >= 0).length}", Icons.schedule, successColor),
                  _buildStatCard("This Month", "${newReleases.where((g) => (g["weeksSinceRelease"] as int) <= 4 && (g["weeksSinceRelease"] as int) >= 0).length}", Icons.calendar_today, infoColor),
                  _buildStatCard("Coming Soon", "${newReleases.where((g) => g["comingSoon"] == true || (g["weeksSinceRelease"] as int) < 0).length}", Icons.upcoming, warningColor),
                  _buildStatCard("Avg Rating", "${(newReleases.fold(0.0, (sum, g) => sum + (g["rating"] as double)) / newReleases.length).toStringAsFixed(1)}", Icons.star, primaryColor),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Games List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latest Releases",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...filteredGames.map((game) {
                    String status = getGameStatus(game);
                    Color statusColor = getStatusColor(status);
                    DateTime releaseDate = DateTime.parse(game["releaseDate"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: status == "Just Released" 
                            ? Border.all(color: successColor.withAlpha(100), width: 2)
                            : null,
                      ),
                      child: Row(
                        children: [
                          // Game Cover
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["image"]}",
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              
                              // Status Badge
                              Positioned(
                                top: spXs,
                                left: spXs,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    status.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(width: spMd),
                          
                          // Game Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title and Rating
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
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
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
                                      ],
                                    ),
                                  ],
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
                                
                                // Release Date
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: disabledBoldColor,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Released ${releaseDate.dMMMy}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Tags
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (game["tags"] as List).take(3).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: statusColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          
                          // Price and Action
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(game["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              QButton(
                                label: game["comingSoon"] == true ? "Wishlist" : "Buy Now",
                                icon: game["comingSoon"] == true ? Icons.bookmark_border : Icons.shopping_cart,
                                size: bs.sm,
                                onPressed: () {
                                  // Handle purchase or wishlist
                                },
                              ),
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
                                        Text("Game Details"),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        Icon(Icons.bookmark, size: 16),
                                        SizedBox(width: spSm),
                                        Text("Add to Wishlist"),
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
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
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
}
