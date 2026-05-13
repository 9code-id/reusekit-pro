import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSearch6View extends StatefulWidget {
  @override
  State<GrlSearch6View> createState() => _GrlSearch6ViewState();
}

class _GrlSearch6ViewState extends State<GrlSearch6View> {
  String searchQuery = "";
  String selectedGenre = "all";
  String selectedRating = "all";
  String selectedYear = "all";
  String selectedType = "all";
  bool showAdvancedFilters = false;

  List<String> popularSearches = [
    "action movies",
    "comedy series",
    "documentary",
    "thriller",
    "sci-fi"
  ];

  List<Map<String, dynamic>> genres = [
    {"label": "All Genres", "value": "all"},
    {"label": "Action", "value": "action"},
    {"label": "Comedy", "value": "comedy"},
    {"label": "Drama", "value": "drama"},
    {"label": "Horror", "value": "horror"},
    {"label": "Sci-Fi", "value": "scifi"},
    {"label": "Documentary", "value": "documentary"}
  ];

  List<Map<String, dynamic>> ratings = [
    {"label": "All Ratings", "value": "all"},
    {"label": "9+ Stars", "value": "9+"},
    {"label": "8+ Stars", "value": "8+"},
    {"label": "7+ Stars", "value": "7+"},
    {"label": "6+ Stars", "value": "6+"}
  ];

  List<Map<String, dynamic>> years = [
    {"label": "All Years", "value": "all"},
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
    {"label": "2020s", "value": "2020s"},
    {"label": "2010s", "value": "2010s"}
  ];

  List<Map<String, dynamic>> types = [
    {"label": "All Types", "value": "all"},
    {"label": "Movies", "value": "movie"},
    {"label": "TV Series", "value": "series"},
    {"label": "Documentaries", "value": "documentary"},
    {"label": "Anime", "value": "anime"}
  ];

  List<Map<String, dynamic>> mediaContent = [
    {
      "id": 1,
      "title": "The Last Guardian",
      "type": "Movie",
      "genre": "Action",
      "year": 2024,
      "rating": 8.7,
      "duration": "2h 15m",
      "director": "Christopher Nolan",
      "cast": ["Tom Hardy", "Scarlett Johansson", "Michael Caine"],
      "poster": "https://picsum.photos/300/450?random=1&keyword=movie",
      "backdrop": "https://picsum.photos/800/450?random=11&keyword=action",
      "description": "In a post-apocalyptic world, a lone guardian must protect humanity's last hope.",
      "featured": true,
      "trending": true,
      "watchlist": 156000,
      "reviews": 8924,
      "languages": ["English", "Spanish"],
      "quality": "4K HDR"
    },
    {
      "id": 2,
      "title": "Laugh Out Loud",
      "type": "TV Series",
      "genre": "Comedy",
      "year": 2023,
      "rating": 7.9,
      "duration": "3 Seasons",
      "creator": "Amy Poehler",
      "cast": ["Chris Pratt", "Amy Poehler", "Nick Offerman"],
      "poster": "https://picsum.photos/300/450?random=2&keyword=comedy",
      "backdrop": "https://picsum.photos/800/450?random=12&keyword=tv",
      "description": "A hilarious workplace comedy that follows the adventures of quirky office workers.",
      "featured": false,
      "trending": true,
      "watchlist": 89000,
      "reviews": 5632,
      "languages": ["English"],
      "quality": "HD"
    },
    {
      "id": 3,
      "title": "Ocean Mysteries",
      "type": "Documentary",
      "genre": "Documentary",
      "year": 2024,
      "rating": 9.2,
      "duration": "6 Episodes",
      "director": "David Attenborough",
      "cast": ["David Attenborough"],
      "poster": "https://picsum.photos/300/450?random=3&keyword=ocean",
      "backdrop": "https://picsum.photos/800/450?random=13&keyword=nature",
      "description": "Explore the deepest mysteries of our oceans in this breathtaking documentary series.",
      "featured": true,
      "trending": false,
      "watchlist": 234000,
      "reviews": 12456,
      "languages": ["English", "French", "German"],
      "quality": "4K HDR"
    },
    {
      "id": 4,
      "title": "Dark Shadows",
      "type": "TV Series",
      "genre": "Horror",
      "year": 2022,
      "rating": 8.4,
      "duration": "2 Seasons",
      "creator": "Mike Flanagan",
      "cast": ["Victoria Pedretti", "Oliver Jackson-Cohen", "Kate Siegel"],
      "poster": "https://picsum.photos/300/450?random=4&keyword=horror",
      "backdrop": "https://picsum.photos/800/450?random=14&keyword=dark",
      "description": "A psychological horror series that will keep you on the edge of your seat.",
      "featured": false,
      "trending": false,
      "watchlist": 67000,
      "reviews": 3421,
      "languages": ["English"],
      "quality": "HD"
    },
    {
      "id": 5,
      "title": "Future Wars",
      "type": "Movie",
      "genre": "Sci-Fi",
      "year": 2023,
      "rating": 8.1,
      "duration": "2h 32m",
      "director": "Denis Villeneuve",
      "cast": ["Ryan Gosling", "Ana de Armas", "Oscar Isaac"],
      "poster": "https://picsum.photos/300/450?random=5&keyword=scifi",
      "backdrop": "https://picsum.photos/800/450?random=15&keyword=future",
      "description": "Humanity's final battle against artificial intelligence in the year 2087.",
      "featured": true,
      "trending": true,
      "watchlist": 198000,
      "reviews": 9876,
      "languages": ["English", "Japanese"],
      "quality": "4K HDR"
    }
  ];

  List<Map<String, dynamic>> get filteredContent {
    List<Map<String, dynamic>> filtered = mediaContent;
    
    if (selectedGenre != "all") {
      filtered = filtered.where((item) => 
        item["genre"].toString().toLowerCase() == selectedGenre.toLowerCase()
      ).toList();
    }
    
    if (selectedType != "all") {
      filtered = filtered.where((item) => 
        item["type"].toString().toLowerCase() == selectedType.toLowerCase()
      ).toList();
    }
    
    if (selectedRating != "all") {
      double minRating = double.parse(selectedRating.replaceAll("+", ""));
      filtered = filtered.where((item) => 
        (item["rating"] as double) >= minRating
      ).toList();
    }
    
    return filtered;
  }

  Color getGenreColor(String genre) {
    switch (genre.toLowerCase()) {
      case "action":
        return dangerColor;
      case "comedy":
        return warningColor;
      case "drama":
        return infoColor;
      case "horror":
        return Colors.purple;
      case "sci-fi":
        return primaryColor;
      case "documentary":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              // Show watchlist
            },
          ),
          IconButton(
            icon: Icon(showAdvancedFilters ? Icons.tune : Icons.tune_outlined),
            onPressed: () {
              showAdvancedFilters = !showAdvancedFilters;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Header with Hero Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusLg),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/800/200?random=100&keyword=cinema"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha(180),
                      Colors.transparent,
                      Colors.black.withAlpha(180)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.all(spMd),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Discover Amazing Content",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spSm),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: spSm),
                          Icon(
                            Icons.search,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "Search movies, series, documentaries...",
                              value: searchQuery,
                              hint: "What do you want to watch?",
                              onChanged: (value) {
                                searchQuery = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(spXs),
                            child: QButton(
                              icon: Icons.search,
                              size: bs.sm,
                              onPressed: () {
                                // Perform search
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quick Filters
            QCategoryPicker(
              label: "Quick Filters",
              items: genres,
              value: selectedGenre,
              onChanged: (index, label, value, item) {
                selectedGenre = value;
                setState(() {});
              },
            ),

            // Advanced Filters
            if (showAdvancedFilters) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Advanced Filters",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Type",
                            items: types,
                            value: selectedType,
                            onChanged: (value, label) {
                              selectedType = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Rating",
                            items: ratings,
                            value: selectedRating,
                            onChanged: (value, label) {
                              selectedRating = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    QDropdownField(
                      label: "Release Year",
                      items: years,
                      value: selectedYear,
                      onChanged: (value, label) {
                        selectedYear = value;  
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Content based on search state
            if (searchQuery.isEmpty) ...[
              // Popular Searches
              Text(
                "Popular Searches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: popularSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        searchQuery = search;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor, primaryColor.withAlpha(180)],
                          ),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          search,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Trending Now
              SizedBox(height: spMd),
              Text(
                "Trending Now",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QHorizontalScroll(
                children: mediaContent.where((item) => item["trending"] as bool).map((item) {
                  return Container(
                    width: 200,
                    margin: EdgeInsets.only(right: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster with Trending Badge
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${item["poster"]}",
                                width: double.infinity,
                                height: 280,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spXs,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Trending",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  Icons.bookmark_border,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        
                        // Title and Info
                        Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: getGenreColor(item["genre"]).withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["genre"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: getGenreColor(item["genre"]),
                                ),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["year"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(item["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${item["duration"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Featured Content
              SizedBox(height: spMd),
              Text(
                "Featured Content",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Column(
                spacing: spSm,
                children: mediaContent.where((item) => item["featured"] as bool).take(2).map((item) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${item["backdrop"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(200),
                            Colors.transparent,
                            Colors.black.withAlpha(200)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: spXs,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Featured",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${item["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(220),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(item["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getGenreColor(item["genre"]).withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${item["genre"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${item["year"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withAlpha(220),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 120,
                            margin: EdgeInsets.only(left: spSm),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusXs),
                              child: Image.network(
                                "${item["poster"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Search Results
            if (searchQuery.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${filteredContent.length} results found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort by: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Relevance",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),

              // Results Grid
              ResponsiveGridView(
                padding: EdgeInsets.all(spXs),
                minItemWidth: 200,
                children: filteredContent.map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Poster
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusSm),
                                topRight: Radius.circular(radiusSm),
                              ),
                              child: Image.network(
                                "${item["poster"]}",
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            
                            // Quality Badge
                            Positioned(
                              top: spXs,
                              left: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${item["quality"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            // Rating Badge
                            Positioned(
                              top: spXs,
                              right: spXs,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(180),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "${(item["rating"] as double).toStringAsFixed(1)}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Play Button Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  color: Colors.black.withAlpha(100),
                                ),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 32,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Content Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Genre and Year
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getGenreColor(item["genre"]).withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${item["genre"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: getGenreColor(item["genre"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["type"]} • ${item["year"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Director/Creator
                              Text(
                                "By ${item["director"] ?? item["creator"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),

                              // Description
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Stats
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${item["duration"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.bookmark_add,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${((item["watchlist"] as int) / 1000).toInt()}K",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Languages
                              if (item["languages"] != null) ...[
                                Wrap(
                                  spacing: spXs,
                                  children: (item["languages"] as List).take(2).map((lang) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "$lang",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
