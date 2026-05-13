import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaEntertainmentView extends StatefulWidget {
  const NmaEntertainmentView({super.key});

  @override
  State<NmaEntertainmentView> createState() => _NmaEntertainmentViewState();
}

class _NmaEntertainmentViewState extends State<NmaEntertainmentView> {
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Movies", "value": "Movies"},
    {"label": "TV Shows", "value": "TV Shows"},
    {"label": "Music", "value": "Music"},
    {"label": "Celebrity", "value": "Celebrity"},
    {"label": "Gaming", "value": "Gaming"},
    {"label": "Theater", "value": "Theater"},
  ];

  List<Map<String, dynamic>> breakingNews = [
    {
      "id": 1,
      "title": "Oscar Winner Announced for Best Picture",
      "summary": "Blockbuster film takes home the Academy's highest honor in surprise victory",
      "category": "Movies",
      "author": "Jennifer Martinez",
      "publishedAt": "2024-12-15T16:45:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=1&keyword=movies",
      "readTime": "3 min read",
      "isBreaking": true,
      "views": 125400,
    },
    {
      "id": 2,
      "title": "Pop Superstar Announces World Tour Dates",
      "summary": "Multi-platinum artist reveals 50-city tour starting next summer",
      "category": "Music",
      "author": "David Chen",
      "publishedAt": "2024-12-15T15:20:00Z",
      "imageUrl": "https://picsum.photos/400/250?random=2&keyword=concert",
      "readTime": "4 min read",
      "isBreaking": false,
      "views": 89300,
    },
  ];

  List<Map<String, dynamic>> trendingStories = [
    {
      "id": 3,
      "title": "Streaming Wars Heat Up: New Platform Launches",
      "category": "TV Shows",
      "publishedAt": "2024-12-15T14:30:00Z",
      "views": 67200,
      "trending": true,
    },
    {
      "id": 4,
      "title": "Hollywood Power Couple Announces Engagement",
      "category": "Celebrity",
      "publishedAt": "2024-12-15T13:15:00Z",
      "views": 156800,
      "trending": true,
    },
    {
      "id": 5,
      "title": "Video Game Awards 2024: Winners Revealed",
      "category": "Gaming",
      "publishedAt": "2024-12-15T12:00:00Z",
      "views": 45600,
      "trending": true,
    },
    {
      "id": 6,
      "title": "Broadway Show Breaks Box Office Records",
      "category": "Theater",
      "publishedAt": "2024-12-15T11:30:00Z",
      "views": 34200,
      "trending": false,
    },
  ];

  List<Map<String, dynamic>> movieReviews = [
    {
      "id": 7,
      "title": "The Winter's Tale",
      "genre": "Drama",
      "rating": 4.5,
      "director": "Sarah Johnson",
      "summary": "A haunting tale of love and redemption set against the backdrop of a harsh winter",
      "imageUrl": "https://picsum.photos/300/400?random=7&keyword=movie",
      "releaseDate": "2024-12-20",
      "runtime": "128 min",
    },
    {
      "id": 8,
      "title": "Space Odyssey 2024",
      "genre": "Sci-Fi",
      "rating": 4.2,
      "director": "Michael Adams",
      "summary": "Epic space adventure featuring stunning visuals and compelling characters",
      "imageUrl": "https://picsum.photos/300/400?random=8&keyword=space",
      "releaseDate": "2024-12-22",
      "runtime": "142 min",
    },
    {
      "id": 9,
      "title": "Comedy Central",
      "genre": "Comedy",
      "rating": 3.8,
      "director": "Lisa Thompson",
      "summary": "Hilarious ensemble comedy about unlikely friendships in New York City",
      "imageUrl": "https://picsum.photos/300/400?random=9&keyword=comedy",
      "releaseDate": "2024-12-25",
      "runtime": "96 min",
    },
  ];

  List<Map<String, dynamic>> musicCharts = [
    {
      "position": 1,
      "title": "Midnight Dreams",
      "artist": "Luna Rodriguez",
      "album": "Starlight",
      "duration": "3:45",
      "genre": "Pop",
      "streams": 12500000,
    },
    {
      "position": 2,
      "title": "Electric Soul",
      "artist": "The Neon Collective",
      "album": "City Lights",
      "duration": "4:12",
      "genre": "Electronic",
      "streams": 9800000,
    },
    {
      "position": 3,
      "title": "Broken Strings",
      "artist": "Jake Morrison",
      "album": "Acoustic Sessions",
      "duration": "3:28",
      "genre": "Folk",
      "streams": 8600000,
    },
    {
      "position": 4,
      "title": "Fire & Ice",
      "artist": "Crystal Phoenix",
      "album": "Elements",
      "duration": "3:56",
      "genre": "Rock",
      "streams": 7400000,
    },
    {
      "position": 5,
      "title": "Digital Love",
      "artist": "Cyber Dreams",
      "album": "Future Sounds",
      "duration": "4:33",
      "genre": "Synthwave",
      "streams": 6200000,
    },
  ];

  List<Map<String, dynamic>> celebrityNews = [
    {
      "celebrity": "Emma Stone",
      "headline": "Wins Critics Choice Award for Outstanding Performance",
      "imageUrl": "https://picsum.photos/100/100?random=10&keyword=celebrity",
      "publishedAt": "2024-12-15T10:15:00Z",
    },
    {
      "celebrity": "Ryan Reynolds",
      "headline": "Announces New Comedy Film Project",
      "imageUrl": "https://picsum.photos/100/100?random=11&keyword=actor",
      "publishedAt": "2024-12-15T09:30:00Z",
    },
    {
      "celebrity": "Taylor Swift",
      "headline": "Surprise Album Drop Breaks Streaming Records",
      "imageUrl": "https://picsum.photos/100/100?random=12&keyword=singer",
      "publishedAt": "2024-12-15T08:45:00Z",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entertainment"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Bookmarks
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
            // Category Filter
            QCategoryPicker(
              label: "Entertainment Categories",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Breaking News Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.flash_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Breaking Entertainment News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: breakingNews.map((news) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to full article
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // News Image
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusSm),
                                    topRight: Radius.circular(radiusSm),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage("${news["imageUrl"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    if (news["isBreaking"])
                                      Positioned(
                                        top: spSm,
                                        left: spSm,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "BREAKING",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
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
                                          horizontal: spXs,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${news["category"]}",
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
                              ),
                              // News Content
                              Padding(
                                padding: EdgeInsets.all(spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${news["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${news["summary"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "By ${news["author"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${news["readTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          spacing: 4,
                                          children: [
                                            Icon(
                                              Icons.visibility,
                                              color: disabledBoldColor,
                                              size: 12,
                                            ),
                                            Text(
                                              "${((news["views"] as int) / 1000).toStringAsFixed(1)}K",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
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
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Trending Stories
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
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trending Stories",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: trendingStories.map((story) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to story
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              if (story["trending"])
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.trending_up,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              if (story["trending"]) SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${story["title"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: infoColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${story["category"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: infoColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${DateTime.parse(story["publishedAt"]).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Column(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  Text(
                                    "${((story["views"] as int) / 1000).toStringAsFixed(1)}K",
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
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Movie Reviews Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.movie,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Latest Movie Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QHorizontalScroll(
                    children: movieReviews.map((movie) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusSm),
                                  topRight: Radius.circular(radiusSm),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage("${movie["imageUrl"]}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                          Text(
                                            "${movie["rating"]}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${movie["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${movie["genre"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: successColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${movie["runtime"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${movie["summary"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Directed by ${movie["director"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Release: ${movie["releaseDate"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
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
                ],
              ),
            ),

            // Music Charts Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Top Music Charts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: musicCharts.map((song) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  "${song["position"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    "${song["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${song["artist"]} • ${song["album"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${song["genre"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: infoColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${song["duration"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.play_circle_filled,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                Text(
                                  "${((song["streams"] as int) / 1000000).toStringAsFixed(1)}M",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Celebrity News Section
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
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Celebrity News",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: celebrityNews.map((news) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to celebrity news
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${news["imageUrl"]}"),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${news["celebrity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${news["headline"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${DateTime.parse(news["publishedAt"]).dMMMy}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
