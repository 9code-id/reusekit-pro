import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscover1View extends StatefulWidget {
  @override
  State<GrlDiscover1View> createState() => _GrlDiscover1ViewState();
}

class _GrlDiscover1ViewState extends State<GrlDiscover1View> {
  String searchQuery = "";
  String selectedGenre = "All Genres";
  String selectedReleaseYear = "All Years";
  String selectedRating = "All Ratings";
  String selectedSort = "Popular";
  
  List<Map<String, dynamic>> genreOptions = [
    {"label": "All Genres", "value": "All Genres"},
    {"label": "Action", "value": "Action"},
    {"label": "Comedy", "value": "Comedy"},
    {"label": "Drama", "value": "Drama"},
    {"label": "Horror", "value": "Horror"},
    {"label": "Sci-Fi", "value": "Sci-Fi"},
    {"label": "Romance", "value": "Romance"},
    {"label": "Documentary", "value": "Documentary"},
  ];
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "All Years", "value": "All Years"},
    {"label": "2024-2025", "value": "2024-2025"},
    {"label": "2020-2023", "value": "2020-2023"},
    {"label": "2015-2019", "value": "2015-2019"},
    {"label": "2010-2014", "value": "2010-2014"},
    {"label": "Before 2010", "value": "Before 2010"},
  ];
  
  List<Map<String, dynamic>> ratingOptions = [
    {"label": "All Ratings", "value": "All Ratings"},
    {"label": "9.0+ IMDb", "value": "9.0+"},
    {"label": "8.0+ IMDb", "value": "8.0+"},
    {"label": "7.0+ IMDb", "value": "7.0+"},
    {"label": "6.0+ IMDb", "value": "6.0+"},
  ];
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Popular", "value": "Popular"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Release Date", "value": "Release Date"},
    {"label": "Alphabetical", "value": "Alphabetical"},
    {"label": "Runtime", "value": "Runtime"},
  ];
  
  List<Map<String, dynamic>> movies = [
    {
      "id": 1,
      "title": "Guardians of the Galaxy Vol. 3",
      "originalTitle": "Guardians of the Galaxy Vol. 3",
      "genre": "Action",
      "year": 2023,
      "imdbRating": 8.1,
      "runtime": "150 min",
      "director": "James Gunn",
      "cast": ["Chris Pratt", "Zoe Saldana", "Dave Bautista"],
      "country": "USA",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=1&keyword=galaxy",
      "backdrop": "https://picsum.photos/800/400?random=1&keyword=space",
      "plot": "Still reeling from the loss of Gamora, Peter Quill rallies his team to defend the universe.",
      "awards": "1 win & 15 nominations",
      "boxOffice": "\$845.6M",
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "watchProviders": ["Disney+", "Prime Video", "Netflix"],
      "trailerUrl": "youtube.com/watch?v=example1",
    },
    {
      "id": 2,
      "title": "Oppenheimer",
      "originalTitle": "Oppenheimer",
      "genre": "Drama",
      "year": 2023,
      "imdbRating": 8.6,
      "runtime": "180 min",
      "director": "Christopher Nolan",
      "cast": ["Cillian Murphy", "Emily Blunt", "Robert Downey Jr."],
      "country": "USA/UK",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=2&keyword=oppenheimer",
      "backdrop": "https://picsum.photos/800/400?random=2&keyword=atomic",
      "plot": "The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.",
      "awards": "7 Academy Awards",
      "boxOffice": "\$953.8M",
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "watchProviders": ["Amazon Prime", "Apple TV+", "Paramount+"],
      "trailerUrl": "youtube.com/watch?v=example2",
    },
    {
      "id": 3,
      "title": "Scream VI",
      "originalTitle": "Scream VI",
      "genre": "Horror",
      "year": 2023,
      "imdbRating": 6.8,
      "runtime": "123 min",
      "director": "Matt Bettinelli-Olpin",
      "cast": ["Melissa Barrera", "Jenna Ortega", "Jasmin Savoy Brown"],
      "country": "USA",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=3&keyword=scream",
      "backdrop": "https://picsum.photos/800/400?random=3&keyword=horror",
      "plot": "The Carpenter sisters are pursued by a new Ghostface killer in New York City.",
      "awards": "3 nominations",
      "boxOffice": "\$169.0M",
      "isPopular": false,
      "isNewRelease": true,
      "isTrending": false,
      "watchProviders": ["Paramount+", "Starz", "Hulu"],
      "trailerUrl": "youtube.com/watch?v=example3",
    },
    {
      "id": 4,
      "title": "The Little Mermaid",
      "originalTitle": "The Little Mermaid",
      "genre": "Romance",
      "year": 2023,
      "imdbRating": 7.2,
      "runtime": "135 min",
      "director": "Rob Marshall",
      "cast": ["Halle Bailey", "Jonah Hauer-King", "Melissa McCarthy"],
      "country": "USA",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=4&keyword=mermaid",
      "backdrop": "https://picsum.photos/800/400?random=4&keyword=ocean",
      "plot": "A young mermaid makes a deal with a sea witch to trade her voice for legs.",
      "awards": "2 nominations",
      "boxOffice": "\$569.6M",
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": false,
      "watchProviders": ["Disney+", "Apple TV+", "Google Play"],
      "trailerUrl": "youtube.com/watch?v=example4",
    },
    {
      "id": 5,
      "title": "Spider-Man: Across the Spider-Verse",
      "originalTitle": "Spider-Man: Across the Spider-Verse",
      "genre": "Action",
      "year": 2023,
      "imdbRating": 8.9,
      "runtime": "140 min",
      "director": "Joaquim Dos Santos",
      "cast": ["Shameik Moore", "Hailee Steinfeld", "Oscar Isaac"],
      "country": "USA",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=5&keyword=spiderman",
      "backdrop": "https://picsum.photos/800/400?random=5&keyword=multiverse",
      "plot": "Miles Morales catapults across the Multiverse and encounters a team of Spider-People.",
      "awards": "Academy Award Winner",
      "boxOffice": "\$690.9M",
      "isPopular": true,
      "isNewRelease": false,
      "isTrending": true,
      "watchProviders": ["Netflix", "Sony Pictures", "Amazon Prime"],
      "trailerUrl": "youtube.com/watch?v=example5",
    },
    {
      "id": 6,
      "title": "Fast X",
      "originalTitle": "Fast X",
      "genre": "Action",
      "year": 2023,
      "imdbRating": 5.8,
      "runtime": "142 min",
      "director": "Louis Leterrier",
      "cast": ["Vin Diesel", "Michelle Rodriguez", "Tyrese Gibson"],
      "country": "USA",
      "language": "English",
      "poster": "https://picsum.photos/300/450?random=6&keyword=fastx",
      "backdrop": "https://picsum.photos/800/400?random=6&keyword=cars",
      "plot": "Dom Toretto and his family face their most lethal adversary yet.",
      "awards": "1 nomination",
      "boxOffice": "\$714.6M",
      "isPopular": false,
      "isNewRelease": true,
      "isTrending": false,
      "watchProviders": ["Peacock", "Apple TV+", "Vudu"],
      "trailerUrl": "youtube.com/watch?v=example6",
    },
  ];
  
  List<Map<String, dynamic>> get filteredMovies {
    return movies.where((movie) {
      bool matchesSearch = movie["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          movie["director"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          (movie["cast"] as List).any((actor) => actor.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      bool matchesGenre = selectedGenre == "All Genres" || movie["genre"] == selectedGenre;
      
      return matchesSearch && matchesGenre;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Discovery"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Movie Banner
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusMd),
                    child: Image.network(
                      "https://picsum.photos/800/240?random=10&keyword=cinema",
                      width: double.infinity,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(200),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Now Trending",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    right: spMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avatar: The Way of Water",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "8.1 IMDb",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Text(
                              "2023 • Sci-Fi • 192 min",
                              style: TextStyle(
                                color: Colors.white.withAlpha(220),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Watch Trailer",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spSm),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(40),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
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
            
            // Search Bar
            QTextField(
              label: "Search movies, actors, directors...",
              value: searchQuery,
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Quick Categories
            Text(
              "Browse by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: [
                _buildCategoryCard("Trending", Icons.trending_up, dangerColor),
                _buildCategoryCard("New Releases", Icons.fiber_new, successColor),
                _buildCategoryCard("Top Rated", Icons.star, warningColor),
                _buildCategoryCard("Awards", Icons.emoji_events, primaryColor),
                _buildCategoryCard("Watchlist", Icons.bookmark, secondaryColor),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Text(
              "Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Genre",
                    items: genreOptions,
                    value: selectedGenre,
                    onChanged: (value, label) {
                      selectedGenre = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Results Header
            Row(
              children: [
                Text(
                  "${filteredMovies.length} Movies Found",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(
                        Icons.grid_view,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        Icons.view_list,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Movies Grid
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: filteredMovies.map((movie) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Poster
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${movie["poster"]}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          // Rating Badge
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(radiusSm),
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
                                    "${movie["imdbRating"]}",
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
                          
                          // Status Badges
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (movie["isTrending"])
                                  Container(
                                    margin: EdgeInsets.only(bottom: spXs),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "Trending",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (movie["isNewRelease"])
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "New",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Play Button Overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(radiusMd),
                                ),
                                color: Colors.black.withAlpha(60),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(40),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Movie Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              "${movie["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Year, Genre, Runtime
                            Text(
                              "${movie["year"]} • ${movie["genre"]} • ${movie["runtime"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            // Director
                            Text(
                              "Dir. ${movie["director"]}",
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Cast
                            Text(
                              (movie["cast"] as List).take(2).join(", "),
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            SizedBox(height: spSm),
                            
                            // Watch Providers
                            if ((movie["watchProviders"] as List).isNotEmpty)
                              Wrap(
                                spacing: spXs,
                                children: (movie["watchProviders"] as List).take(2).map((provider) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$provider",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Watch Now",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: disabledOutlineBorderColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Icon(
                                      Icons.bookmark_border,
                                      color: primaryColor,
                                      size: 16,
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
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryCard(String label, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: 120,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: color.withAlpha(50),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
