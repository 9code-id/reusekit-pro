import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList6View extends StatefulWidget {
  @override
  State<GrlList6View> createState() => _GrlList6ViewState();
}

class _GrlList6ViewState extends State<GrlList6View> {
  String searchQuery = "";
  String selectedGenre = "All";
  String selectedYear = "All";
  
  List<Map<String, dynamic>> genreOptions = [
    {"label": "All", "value": "All"},
    {"label": "Action", "value": "Action"},
    {"label": "Comedy", "value": "Comedy"},
    {"label": "Drama", "value": "Drama"},
    {"label": "Horror", "value": "Horror"},
    {"label": "Sci-Fi", "value": "Sci-Fi"},
  ];

  List<Map<String, dynamic>> yearOptions = [
    {"label": "All", "value": "All"},
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
    {"label": "2021", "value": "2021"},
  ];

  List<Map<String, dynamic>> movies = [
    {
      "id": "MOV-001",
      "title": "The Digital Revolution",
      "genre": "Sci-Fi",
      "year": 2024,
      "duration": 142,
      "rating": 8.7,
      "director": "Sarah Mitchell",
      "cast": ["John Smith", "Emma Johnson", "Michael Chen"],
      "poster": "https://picsum.photos/300/450?random=51&keyword=movie",
      "description": "In a world where AI controls everything, a group of rebels fights to restore human freedom.",
      "reviews": 1250,
      "watchTime": "2h 22m",
      "releaseDate": "2024-03-15",
      "isWatched": false,
      "isFavorite": false,
    },
    {
      "id": "MOV-002",
      "title": "Comedy Central",
      "genre": "Comedy",
      "year": 2023,
      "duration": 98,
      "rating": 7.4,
      "director": "Mike Rodriguez",
      "cast": ["Anna Davis", "Chris Wilson", "David Brown"],
      "poster": "https://picsum.photos/300/450?random=52&keyword=comedy",
      "description": "A hilarious journey through modern dating and friendship in the digital age.",
      "reviews": 892,
      "watchTime": "1h 38m",
      "releaseDate": "2023-07-20",
      "isWatched": true,
      "isFavorite": true,
    },
    {
      "id": "MOV-003",
      "title": "Shadow's Edge",
      "genre": "Action",
      "year": 2024,
      "duration": 156,
      "rating": 8.2,
      "director": "Alex Thompson",
      "cast": ["Maria Garcia", "Robert Taylor", "Lisa Wong"],
      "poster": "https://picsum.photos/300/450?random=53&keyword=action",
      "description": "An elite agent must stop a global conspiracy that threatens world peace.",
      "reviews": 2103,
      "watchTime": "2h 36m",
      "releaseDate": "2024-05-12",
      "isWatched": false,
      "isFavorite": true,
    },
    {
      "id": "MOV-004",
      "title": "The Last Symphony",
      "genre": "Drama",
      "year": 2023,
      "duration": 134,
      "rating": 9.1,
      "director": "Elena Petrov",
      "cast": ["Vincent Miller", "Sophie Laurent", "James Park"],
      "poster": "https://picsum.photos/300/450?random=54&keyword=drama",
      "description": "A touching story of a pianist's final performance and the memories it awakens.",
      "reviews": 1876,
      "watchTime": "2h 14m",
      "releaseDate": "2023-11-08",
      "isWatched": true,
      "isFavorite": false,
    },
    {
      "id": "MOV-005",
      "title": "Night Terrors",
      "genre": "Horror",
      "year": 2022,
      "duration": 107,
      "rating": 6.8,
      "director": "Marcus Black",
      "cast": ["Julia Harper", "Tom Anderson", "Kelly Martinez"],
      "poster": "https://picsum.photos/300/450?random=55&keyword=horror",
      "description": "A family moves into an old house and discovers its terrifying secrets.",
      "reviews": 1456,
      "watchTime": "1h 47m",
      "releaseDate": "2022-10-31",
      "isWatched": false,
      "isFavorite": false,
    },
  ];

  List<Map<String, dynamic>> get filteredMovies {
    return movies.where((movie) {
      bool matchesSearch = "${movie["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${movie["director"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesGenre = selectedGenre == "All" || movie["genre"] == selectedGenre;
      bool matchesYear = selectedYear == "All" || "${movie["year"]}" == selectedYear;
      return matchesSearch && matchesGenre && matchesYear;
    }).toList();
  }

  Color getRatingColor(double rating) {
    if (rating >= 8.0) return successColor;
    if (rating >= 7.0) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Collection"),
        actions: [
          Icon(Icons.search),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.black54],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.movie,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Your Movie Library",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${movies.length} movies",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              " • ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                            Text(
                              "${movies.where((m) => m["isWatched"] == true).length} watched",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
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

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search movies",
                    value: searchQuery,
                    hint: "Search by title or director...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

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
                    label: "Year",
                    items: yearOptions,
                    value: selectedYear,
                    onChanged: (value, label) {
                      selectedYear = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Movies (${filteredMovies.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                final ratingColor = getRatingColor((movie["rating"] as double));
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusLg),
                          bottomLeft: Radius.circular(radiusLg),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${movie["poster"]}",
                              width: 120,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            if (movie["isWatched"] as bool)
                              Positioned(
                                top: spXs,
                                right: spXs,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spSm,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${movie["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  QButton(
                                    icon: (movie["isFavorite"] as bool)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: bs.sm,
                                    onPressed: () {
                                      movie["isFavorite"] = !(movie["isFavorite"] as bool);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${movie["genre"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${movie["year"]} • ${movie["watchTime"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                "Directed by ${movie["director"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor,
                                ),
                              ),

                              Text(
                                "${movie["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),

                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Cast:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      (movie["cast"] as List).join(", "),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: spSm,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ratingColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Row(
                                          spacing: spXs,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: ratingColor,
                                              size: 14,
                                            ),
                                            Text(
                                              "${movie["rating"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: ratingColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "(${movie["reviews"]} reviews)",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    spacing: spXs,
                                    children: [
                                      QButton(
                                        icon: (movie["isWatched"] as bool)
                                            ? Icons.replay
                                            : Icons.play_arrow,
                                        size: bs.sm,
                                        onPressed: () {
                                          movie["isWatched"] = true;
                                          setState(() {});
                                        },
                                      ),
                                      QButton(
                                        icon: Icons.more_vert,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
