import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaRatingsView extends StatefulWidget {
  const GeaRatingsView({super.key});

  @override
  State<GeaRatingsView> createState() => _GeaRatingsViewState();
}

class _GeaRatingsViewState extends State<GeaRatingsView> {
  int selectedFilter = 0;
  String selectedGenre = "all";
  double minRating = 0.0;
  
  final List<Map<String, dynamic>> filters = [
    {"label": "All Ratings", "value": "all"},
    {"label": "Highly Rated (4.5+)", "value": "high"},
    {"label": "Most Reviewed", "value": "popular"},
    {"label": "Recent Reviews", "value": "recent"},
    {"label": "Critical Acclaim", "value": "critical"},
  ];

  final List<Map<String, dynamic>> genres = [
    {"label": "All Genres", "value": "all"},
    {"label": "Action", "value": "action"},
    {"label": "RPG", "value": "rpg"},
    {"label": "Strategy", "value": "strategy"},
    {"label": "Sports", "value": "sports"},
    {"label": "Indie", "value": "indie"},
  ];

  final List<Map<String, dynamic>> games = [
    {
      "id": "1",
      "title": "Baldur's Gate 3",
      "developer": "Larian Studios",
      "genre": "RPG",
      "userRating": 4.9,
      "criticRating": 96,
      "totalReviews": 125430,
      "positiveReviews": 122580,
      "negativeReviews": 2850,
      "price": 59.99,
      "releaseDate": "2023-08-03",
      "image": "https://picsum.photos/400/600?random=1&keyword=baldur-gate",
      "recentReviewScore": 4.8,
      "tags": ["RPG", "Turn-Based", "Multiplayer", "Story Rich"],
      "reviewSummary": "Overwhelmingly positive reception with praise for storytelling, character development, and tactical combat",
      "pros": ["Exceptional storytelling", "Deep character customization", "Excellent voice acting", "Rich tactical combat"],
      "cons": ["Steep learning curve", "Long loading times", "Some performance issues"],
      "topReviews": [
        {
          "author": "GamerPro123",
          "rating": 5.0,
          "date": "2024-03-15",
          "helpful": 2456,
          "text": "Simply the best RPG I've ever played. The depth of storytelling and character interactions is unmatched.",
        },
        {
          "author": "RPGLover",
          "rating": 4.8,
          "date": "2024-03-12",
          "helpful": 1892,
          "text": "Amazing game with some minor technical issues. The story more than makes up for any shortcomings.",
        },
      ],
    },
    {
      "id": "2",
      "title": "Pizza Tower",
      "developer": "Tour De Pizza",
      "genre": "Indie",
      "userRating": 4.8,
      "criticRating": 89,
      "totalReviews": 45230,
      "positiveReviews": 43420,
      "negativeReviews": 1810,
      "price": 19.99,
      "releaseDate": "2023-01-26",
      "image": "https://picsum.photos/400/600?random=2&keyword=pizza-tower",
      "recentReviewScore": 4.9,
      "tags": ["Platformer", "2D", "Indie", "Comedy"],
      "reviewSummary": "Praised for its unique art style, tight controls, and incredible soundtrack",
      "pros": ["Unique art style", "Excellent soundtrack", "Perfect controls", "High replay value"],
      "cons": ["Short campaign", "Limited difficulty options", "Some repetitive elements"],
      "topReviews": [
        {
          "author": "IndieGamer",
          "rating": 5.0,
          "date": "2024-03-14",
          "helpful": 1234,
          "text": "A masterpiece of 2D platforming. Every level is perfectly crafted and the soundtrack is incredible.",
        },
        {
          "author": "PlatformFan",
          "rating": 4.7,
          "date": "2024-03-10",
          "helpful": 987,
          "text": "Fantastic game with amazing art direction. Wish it was longer but what's here is pure gold.",
        },
      ],
    },
    {
      "id": "3",
      "title": "Counter-Strike 2",
      "developer": "Valve",
      "genre": "Action",
      "userRating": 4.7,
      "criticRating": 87,
      "totalReviews": 890430,
      "positiveReviews": 756365,
      "negativeReviews": 134065,
      "price": 0.0,
      "releaseDate": "2023-09-27",
      "image": "https://picsum.photos/400/600?random=3&keyword=counter-strike",
      "recentReviewScore": 4.5,
      "tags": ["FPS", "Competitive", "Multiplayer", "Free"],
      "reviewSummary": "Mixed reception due to technical issues at launch, but praised for improved graphics",
      "pros": ["Improved graphics", "Better netcode", "Free to play", "Active community"],
      "cons": ["Technical issues", "Missing features from CSGO", "Performance problems", "Steep learning curve"],
      "topReviews": [
        {
          "author": "CompetitiveGamer",
          "rating": 4.5,
          "date": "2024-03-16",
          "helpful": 3456,
          "text": "Great potential but needs more polish. The core gameplay is solid but missing some features.",
        },
        {
          "author": "FPSVeteran",
          "rating": 4.8,
          "date": "2024-03-13",
          "helpful": 2789,
          "text": "Amazing upgrade to the classic formula. Some launch issues but overall excellent.",
        },
      ],
    },
    {
      "id": "4",
      "title": "Hogwarts Legacy",
      "developer": "Avalanche Software",
      "genre": "RPG",
      "userRating": 4.5,
      "criticRating": 84,
      "totalReviews": 567890,
      "positiveReviews": 483207,
      "negativeReviews": 84683,
      "price": 59.99,
      "releaseDate": "2023-02-10",
      "image": "https://picsum.photos/400/600?random=4&keyword=hogwarts",
      "recentReviewScore": 4.3,
      "tags": ["RPG", "Magic", "Open World", "Single Player"],
      "reviewSummary": "Generally positive reviews praising the world design and magic system",
      "pros": ["Beautiful world design", "Great magic system", "Faithful to HP universe", "Good exploration"],
      "cons": ["Repetitive side quests", "Performance issues", "Weak story", "Limited character development"],
      "topReviews": [
        {
          "author": "PotterFan",
          "rating": 4.7,
          "date": "2024-03-11",
          "helpful": 4567,
          "text": "A dream come true for Harry Potter fans. The world is beautifully recreated and exploration is fantastic.",
        },
        {
          "author": "OpenWorldGamer",
          "rating": 4.2,
          "date": "2024-03-08",
          "helpful": 3421,
          "text": "Good game with some flaws. The world is amazing but side quests can be repetitive.",
        },
      ],
    },
    {
      "id": "5",
      "title": "Elden Ring",
      "developer": "FromSoftware",
      "genre": "Action",
      "userRating": 4.6,
      "criticRating": 96,
      "totalReviews": 234567,
      "positiveReviews": 215690,
      "negativeReviews": 18877,
      "price": 59.99,
      "releaseDate": "2022-02-25",
      "image": "https://picsum.photos/400/600?random=5&keyword=elden-ring",
      "recentReviewScore": 4.7,
      "tags": ["Souls-like", "Action RPG", "Open World", "Fantasy"],
      "reviewSummary": "Universal critical acclaim for innovative open-world Souls-like gameplay",
      "pros": ["Innovative open world", "Excellent boss design", "Beautiful art direction", "Deep lore"],
      "cons": ["Very high difficulty", "Can be overwhelming", "Performance issues on PC", "Confusing story"],
      "topReviews": [
        {
          "author": "SoulsVeteran",
          "rating": 5.0,
          "date": "2024-03-09",
          "helpful": 5678,
          "text": "FromSoftware's masterpiece. The perfect evolution of the Souls formula with an incredible open world.",
        },
        {
          "author": "ChallengeSeeker",
          "rating": 4.8,
          "date": "2024-03-07",
          "helpful": 4321,
          "text": "Challenging but rewarding. The sense of discovery and accomplishment is unmatched.",
        },
      ],
    },
    {
      "id": "6",
      "title": "Starfield",
      "developer": "Bethesda Game Studios",
      "genre": "RPG",
      "userRating": 4.2,
      "criticRating": 82,
      "totalReviews": 345678,
      "positiveReviews": 276542,
      "negativeReviews": 69136,
      "price": 69.99,
      "releaseDate": "2023-09-06",
      "image": "https://picsum.photos/400/600?random=6&keyword=starfield",
      "recentReviewScore": 4.0,
      "tags": ["RPG", "Space", "Exploration", "Single Player"],
      "reviewSummary": "Mixed reception with praise for scope but criticism for repetitive gameplay",
      "pros": ["Massive scope", "Beautiful space exploration", "Great character creation", "Solid main story"],
      "cons": ["Repetitive exploration", "Loading screen issues", "Empty planets", "Dated mechanics"],
      "topReviews": [
        {
          "author": "SpaceExplorer",
          "rating": 4.5,
          "date": "2024-03-06",
          "helpful": 3456,
          "text": "Amazing space adventure with some issues. The scope is incredible but can feel repetitive.",
        },
        {
          "author": "BethesdaFan",
          "rating": 3.8,
          "date": "2024-03-05",
          "helpful": 2890,
          "text": "Decent game but doesn't live up to the hype. Some good moments but many empty planets.",
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    List<Map<String, dynamic>> filtered = games;
    
    // Filter by genre
    if (selectedGenre != "all") {
      filtered = filtered.where((g) => 
        g["genre"].toString().toLowerCase().contains(selectedGenre.toLowerCase())
      ).toList();
    }
    
    // Filter by rating and category
    String filterValue = filters[selectedFilter]["value"];
    switch (filterValue) {
      case "high":
        filtered = filtered.where((g) => (g["userRating"] as double) >= 4.5).toList();
        break;
      case "popular":
        filtered = filtered.where((g) => (g["totalReviews"] as int) > 100000).toList();
        break;
      case "recent":
        // Sort by recent review activity (simulated)
        break;
      case "critical":
        filtered = filtered.where((g) => (g["criticRating"] as int) >= 85).toList();
        break;
    }
    
    // Filter by minimum rating
    if (minRating > 0) {
      filtered = filtered.where((g) => (g["userRating"] as double) >= minRating).toList();
    }
    
    // Sort by user rating (highest first)
    filtered.sort((a, b) => (b["userRating"] as double).compareTo(a["userRating"] as double));
    
    return filtered;
  }

  Color getRatingColor(double rating) {
    if (rating >= 4.5) return successColor;
    if (rating >= 4.0) return infoColor;
    if (rating >= 3.5) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Ratings & Reviews"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortDialog();
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
                  colors: [infoColor, infoColor.withAlpha(150)],
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
                        Icons.star,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ratings & Reviews",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Discover what players and critics are saying",
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
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Rating Statistics
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 120,
                children: [
                  _buildStatCard("Avg User Rating", "${(games.fold(0.0, (sum, g) => sum + (g["userRating"] as double)) / games.length).toStringAsFixed(1)}", Icons.star, warningColor),
                  _buildStatCard("Total Reviews", "${((games.fold(0, (sum, g) => sum + (g["totalReviews"] as int)) as int) / 1000000).toStringAsFixed(1)}M", Icons.rate_review, infoColor),
                  _buildStatCard("Highly Rated", "${games.where((g) => (g["userRating"] as double) >= 4.5).length}", Icons.grade, successColor),
                  _buildStatCard("Avg Critic Score", "${(games.fold(0, (sum, g) => sum + (g["criticRating"] as int)) / games.length).toStringAsFixed(0)}", Icons.analytics, primaryColor),
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
                  // Category Filter
                  QCategoryPicker(
                    items: filters,
                    value: filters[selectedFilter]["value"],
                    onChanged: (index, label, value, item) {
                      selectedFilter = index;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Genre Filter
                  Row(
                    children: [
                      Text(
                        "Genre:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QHorizontalScroll(
                          children: genres.map((genre) {
                            bool isSelected = selectedGenre == genre["value"];
                            return GestureDetector(
                              onTap: () {
                                selectedGenre = genre["value"];
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
                                  "${genre["label"]}",
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Games List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Game Reviews (${filteredGames.length})",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...filteredGames.map((game) {
                    double positivePercentage = ((game["positiveReviews"] as int) / (game["totalReviews"] as int)) * 100;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spLg),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: (game["userRating"] as double) >= 4.5 
                            ? Border.all(color: successColor.withAlpha(100), width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Game Header
                          Row(
                            children: [
                              // Game Cover
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["image"]}",
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              
                              SizedBox(width: spMd),
                              
                              // Game Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${game["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${game["developer"]} • ${game["genre"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      game["price"] == 0.0 ? "Free to Play" : "\$${(game["price"] as double).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: game["price"] == 0.0 ? successColor : primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Overall Rating
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(spMd),
                                    decoration: BoxDecoration(
                                      color: getRatingColor(game["userRating"]).withAlpha(30),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${game["userRating"]}",
                                          style: TextStyle(
                                            fontSize: fsH5,
                                            fontWeight: FontWeight.bold,
                                            color: getRatingColor(game["userRating"]),
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: getRatingColor(game["userRating"]),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "User Score",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Rating Breakdown
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "User Reviews:",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${((game["totalReviews"] as int) / 1000).toStringAsFixed(0)}K total",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: LinearProgressIndicator(
                                            value: positivePercentage / 100,
                                            backgroundColor: dangerColor.withAlpha(50),
                                            valueColor: AlwaysStoppedAnimation<Color>(successColor),
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${positivePercentage.toStringAsFixed(0)}% positive",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              Column(
                                children: [
                                  Text(
                                    "Critic Score",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${game["criticRating"]}/100",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Review Summary
                          Text(
                            "${game["reviewSummary"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Pros and Cons
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: successColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "Pros",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: successColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    ...(game["pros"] as List).take(2).map((pro) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: spXs),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("• ", style: TextStyle(color: successColor)),
                                            Expanded(
                                              child: Text(
                                                pro,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_down,
                                          color: dangerColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: spSm),
                                        Text(
                                          "Cons",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    ...(game["cons"] as List).take(2).map((con) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: spXs),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("• ", style: TextStyle(color: dangerColor)),
                                            Expanded(
                                              child: Text(
                                                con,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: disabledBoldColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spMd),
                          
                          // Recent Reviews
                          if ((game["topReviews"] as List).isNotEmpty) ...[
                            Text(
                              "Recent Reviews",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            ...(game["topReviews"] as List).take(1).map((review) {
                              return Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${review["author"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        ...List.generate(5, (index) {
                                          return Icon(
                                            index < (review["rating"] as double).floor() ? Icons.star : Icons.star_border,
                                            color: warningColor,
                                            size: 12,
                                          );
                                        }),
                                        SizedBox(width: spSm),
                                        Text(
                                          "${DateTime.parse(review["date"]).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spSm),
                                    Text(
                                      "${review["text"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: disabledBoldColor,
                                          size: 12,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${review["helpful"]} helpful",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            
                            SizedBox(height: spSm),
                          ],
                          
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Read All Reviews",
                                  icon: Icons.rate_review,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to full reviews
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: game["price"] == 0.0 ? "Play Free" : "Buy Now",
                                  icon: game["price"] == 0.0 ? Icons.play_arrow : Icons.shopping_cart,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to game
                                  },
                                ),
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Minimum Rating"),
            Slider(
              value: minRating,
              min: 0.0,
              max: 5.0,
              divisions: 10,
              label: minRating.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  minRating = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    // Show sort options dialog
  }
}
