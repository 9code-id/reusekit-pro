import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGenreView extends StatefulWidget {
  const GeaGenreView({super.key});

  @override
  State<GeaGenreView> createState() => _GeaGenreViewState();
}

class _GeaGenreViewState extends State<GeaGenreView> {
  String selectedSortBy = "Popular";
  String searchQuery = "";
  int selectedGenreFilter = 0;

  List<String> genreFilters = [
    "All Games",
    "New Releases", 
    "Top Rated",
    "Coming Soon",
    "Free to Play",
    "On Sale"
  ];

  List<Map<String, dynamic>> games = [
    {
      "id": 1,
      "title": "Cyberpunk Adventures",
      "developer": "NeonStudio",
      "genre": "Action RPG",
      "rating": 4.8,
      "price": 59.99,
      "originalPrice": 79.99,
      "discount": 25,
      "releaseDate": "2024-03-15",
      "image": "https://picsum.photos/300/400?random=1&keyword=cyberpunk",
      "screenshots": 8,
      "reviews": 15420,
      "isNewRelease": true,
      "isOnSale": true,
      "isFreeToPlay": false,
      "platforms": ["PC", "PlayStation", "Xbox"],
      "tags": ["Sci-Fi", "Open World", "Multiplayer"],
    },
    {
      "id": 2,
      "title": "Medieval Conquest",
      "developer": "Castle Games",
      "genre": "Strategy",
      "rating": 4.6,
      "price": 0.0,
      "originalPrice": 0.0,
      "discount": 0,
      "releaseDate": "2023-11-20",
      "image": "https://picsum.photos/300/400?random=2&keyword=medieval",
      "screenshots": 12,
      "reviews": 8750,
      "isNewRelease": false,
      "isOnSale": false,
      "isFreeToPlay": true,
      "platforms": ["PC", "Mobile"],
      "tags": ["Medieval", "Strategy", "Castle Building"],
    },
    {
      "id": 3,
      "title": "Space Odyssey",
      "developer": "Cosmic Interactive",
      "genre": "Adventure",
      "rating": 4.9,
      "price": 45.99,
      "originalPrice": 45.99,
      "discount": 0,
      "releaseDate": "2024-06-01",
      "image": "https://picsum.photos/300/400?random=3&keyword=space",
      "screenshots": 15,
      "reviews": 23100,
      "isNewRelease": true,
      "isOnSale": false,
      "isFreeToPlay": false,
      "platforms": ["PC", "PlayStation", "Xbox", "Switch"],
      "tags": ["Space", "Exploration", "Sci-Fi"],
    },
    {
      "id": 4,
      "title": "Racing Thunder",
      "developer": "SpeedWorks",
      "genre": "Racing",
      "rating": 4.4,
      "price": 29.99,
      "originalPrice": 49.99,
      "discount": 40,
      "releaseDate": "2023-08-10",
      "image": "https://picsum.photos/300/400?random=4&keyword=racing",
      "screenshots": 10,
      "reviews": 12300,
      "isNewRelease": false,
      "isOnSale": true,
      "isFreeToPlay": false,
      "platforms": ["PC", "PlayStation", "Xbox"],
      "tags": ["Racing", "Multiplayer", "Cars"],
    },
    {
      "id": 5,
      "title": "Horror Mansion",
      "developer": "Nightmare Studios",
      "genre": "Horror",
      "rating": 4.7,
      "price": 34.99,
      "originalPrice": 34.99,
      "discount": 0,
      "releaseDate": "2024-10-31",
      "image": "https://picsum.photos/300/400?random=5&keyword=horror",
      "screenshots": 6,
      "reviews": 5680,
      "isNewRelease": false,
      "isOnSale": false,
      "isFreeToPlay": false,
      "platforms": ["PC", "PlayStation"],
      "tags": ["Horror", "Survival", "Mystery"],
    },
    {
      "id": 6,
      "title": "Football Manager Elite",
      "developer": "Sports Interactive Plus",
      "genre": "Sports Simulation",
      "rating": 4.5,
      "price": 0.0,
      "originalPrice": 0.0,
      "discount": 0,
      "releaseDate": "2024-01-15",
      "image": "https://picsum.photos/300/400?random=6&keyword=football",
      "screenshots": 9,
      "reviews": 18900,
      "isNewRelease": true,
      "isOnSale": false,
      "isFreeToPlay": true,
      "platforms": ["PC", "Mobile", "PlayStation", "Xbox"],
      "tags": ["Football", "Management", "Simulation"],
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    List<Map<String, dynamic>> result = games;

    // Apply filter
    switch (selectedGenreFilter) {
      case 1: // New Releases
        result = result.where((game) => game["isNewRelease"] == true).toList();
        break;
      case 2: // Top Rated
        result = result.where((game) => (game["rating"] as double) >= 4.7).toList();
        break;
      case 3: // Coming Soon
        result = result.where((game) => DateTime.parse(game["releaseDate"]).isAfter(DateTime.now())).toList();
        break;
      case 4: // Free to Play
        result = result.where((game) => game["isFreeToPlay"] == true).toList();
        break;
      case 5: // On Sale
        result = result.where((game) => game["isOnSale"] == true).toList();
        break;
    }

    // Apply search
    if (searchQuery.isNotEmpty) {
      result = result.where((game) {
        return (game["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (game["developer"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (game["genre"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply sorting
    switch (selectedSortBy) {
      case "Rating":
        result.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Price (Low to High)":
        result.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "Price (High to Low)":
        result.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "Release Date":
        result.sort((a, b) => DateTime.parse(b["releaseDate"]).compareTo(DateTime.parse(a["releaseDate"])));
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Action Games"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Sort
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search games...",
                    value: searchQuery,
                    hint: "Find your next adventure",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: [
                      {"label": "Popular", "value": "Popular"},
                      {"label": "Rating", "value": "Rating"},
                      {"label": "Price (Low to High)", "value": "Price (Low to High)"},
                      {"label": "Price (High to Low)", "value": "Price (High to Low)"},
                      {"label": "Release Date", "value": "Release Date"},
                    ],
                    value: selectedSortBy,
                    onChanged: (value, label) {
                      selectedSortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Genre Filters
            QCategoryPicker(
              label: "Filter Games",
              items: genreFilters.asMap().entries.map((entry) => {
                "label": entry.value,
                "value": entry.key.toString(),
              }).toList(),
              value: selectedGenreFilter.toString(),
              onChanged: (index, label, value, item) {
                selectedGenreFilter = int.parse(value);
                setState(() {});
              },
            ),

            // Games Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
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
                          "${filteredGames.length}",
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
                          "Average Rating",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(filteredGames.fold(0.0, (sum, game) => sum + (game["rating"] as double)) / filteredGames.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
                          "Free Games",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${filteredGames.where((game) => game["isFreeToPlay"] == true).length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Games List
            ...filteredGames.map((game) {
              final isOnSale = game["isOnSale"] as bool;
              final isFreeToPlay = game["isFreeToPlay"] as bool;
              final isNewRelease = game["isNewRelease"] as bool;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Game Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        bottomLeft: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${game["image"]}",
                            width: 120,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          if (isNewRelease)
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "NEW",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if (isOnSale && !isFreeToPlay)
                            Positioned(
                              bottom: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "-${game["discount"]}%",
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
                    ),

                    // Game Details
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            // Title and Developer
                            Text(
                              "${game["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            Text(
                              "${game["developer"]} • ${game["genre"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Rating and Reviews
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${game["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${((game["reviews"] as int) / 1000).toStringAsFixed(1)}K)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                            // Platforms
                            Row(
                              children: [
                                Icon(
                                  Icons.devices,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    (game["platforms"] as List<String>).join(", "),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            // Price and Action
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (isFreeToPlay)
                                        Text(
                                          "Free to Play",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        )
                                      else ...[
                                        if (isOnSale) ...[
                                          Text(
                                            "\$${(game["originalPrice"] as double).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Text(
                                            "\$${(game["price"] as double).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: dangerColor,
                                            ),
                                          ),
                                        ] else
                                          Text(
                                            "\$${(game["price"] as double).toStringAsFixed(2)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                      ],
                                    ],
                                  ),
                                ),
                                QButton(
                                  label: "View",
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('GeaGameDetailView', arguments: game)
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
