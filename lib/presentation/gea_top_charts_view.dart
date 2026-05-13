import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaTopChartsView extends StatefulWidget {
  const GeaTopChartsView({super.key});

  @override
  State<GeaTopChartsView> createState() => _GeaTopChartsViewState();
}

class _GeaTopChartsViewState extends State<GeaTopChartsView> {
  int selectedTab = 0;
  String selectedCategory = "All Games";
  String selectedTimeframe = "This Week";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Games", "value": "All Games"},
    {"label": "Action", "value": "Action"},
    {"label": "Adventure", "value": "Adventure"},
    {"label": "RPG", "value": "RPG"},
    {"label": "Strategy", "value": "Strategy"},
    {"label": "Puzzle", "value": "Puzzle"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Racing", "value": "Racing"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> topGames = [
    {
      "id": "1",
      "title": "Dragon's Quest",
      "developer": "Epic Studios",
      "category": "RPG",
      "rating": 4.8,
      "downloads": 2500000,
      "revenue": 1250000.0,
      "rank": 1,
      "previousRank": 2,
      "image": "https://picsum.photos/200/200?random=1&keyword=dragon",
      "price": 29.99,
      "releaseDate": "2024-03-15",
    },
    {
      "id": "2",
      "title": "Space Warriors",
      "developer": "Galaxy Games",
      "category": "Action",
      "rating": 4.6,
      "downloads": 3200000,
      "revenue": 980000.0,
      "rank": 2,
      "previousRank": 1,
      "image": "https://picsum.photos/200/200?random=2&keyword=space",
      "price": 0.0,
      "releaseDate": "2024-01-20",
    },
    {
      "id": "3",
      "title": "Mystery Manor",
      "developer": "Puzzle Pro",
      "category": "Puzzle",
      "rating": 4.7,
      "downloads": 1800000,
      "revenue": 720000.0,
      "rank": 3,
      "previousRank": 4,
      "image": "https://picsum.photos/200/200?random=3&keyword=mystery",
      "price": 14.99,
      "releaseDate": "2024-02-10",
    },
    {
      "id": "4",
      "title": "Racing Legends",
      "developer": "Speed Studios",
      "category": "Racing",
      "rating": 4.5,
      "downloads": 2100000,
      "revenue": 650000.0,
      "rank": 4,
      "previousRank": 3,
      "image": "https://picsum.photos/200/200?random=4&keyword=racing",
      "price": 19.99,
      "releaseDate": "2024-04-05",
    },
    {
      "id": "5",
      "title": "Kingdom Builder",
      "developer": "Strategy Games Inc",
      "category": "Strategy",
      "rating": 4.4,
      "downloads": 1500000,
      "revenue": 590000.0,
      "rank": 5,
      "previousRank": 6,
      "image": "https://picsum.photos/200/200?random=5&keyword=kingdom",
      "price": 24.99,
      "releaseDate": "2024-05-01",
    },
  ];

  List<Map<String, dynamic>> trendingGames = [
    {
      "id": "6",
      "title": "Ninja Warrior",
      "developer": "Shadow Games",
      "category": "Action",
      "rating": 4.3,
      "downloads": 850000,
      "growthRate": 125.5,
      "image": "https://picsum.photos/200/200?random=6&keyword=ninja",
      "price": 12.99,
    },
    {
      "id": "7",
      "title": "Ocean Explorer",
      "developer": "Deep Sea Studios",
      "category": "Adventure",
      "rating": 4.6,
      "downloads": 650000,
      "growthRate": 98.3,
      "image": "https://picsum.photos/200/200?random=7&keyword=ocean",
      "price": 0.0,
    },
    {
      "id": "8",
      "title": "Farm Simulator",
      "developer": "Country Games",
      "category": "Simulation",
      "rating": 4.2,
      "downloads": 420000,
      "growthRate": 87.2,
      "image": "https://picsum.photos/200/200?random=8&keyword=farm",
      "price": 9.99,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Charts"),
        actions: [
          QButton(
            icon: Icons.search,
            size: bs.sm,
            onPressed: () {
              si("Search games");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryItems,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Timeframe",
                        items: timeframeItems,
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                // Tab Selector
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 0;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 0 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusSm),
                              bottomLeft: Radius.circular(radiusSm),
                            ),
                            border: Border.all(
                              color: selectedTab == 0 ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "Top Games",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = 1;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == 1 ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(radiusSm),
                              bottomRight: Radius.circular(radiusSm),
                            ),
                            border: Border.all(
                              color: selectedTab == 1 ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "Trending",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: selectedTab == 0 ? _buildTopGames() : _buildTrendingGames(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopGames() {
    return Column(
      spacing: spSm,
      children: [
        // Top 3 Podium
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor.withAlpha(25),
                successColor.withAlpha(25),
              ],
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Text(
                "🏆 Top 3 Games",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPodiumItem(topGames[1], 2, 80),
                  _buildPodiumItem(topGames[0], 1, 100),
                  _buildPodiumItem(topGames[2], 3, 70),
                ],
              ),
            ],
          ),
        ),

        // Full Rankings
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Complete Rankings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...List.generate(topGames.length, (index) {
                final game = topGames[index];
                final rankChange = (game["rank"] as int) - (game["previousRank"] as int);
                final isUp = rankChange < 0;
                final isDown = rankChange > 0;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Rank
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: index < 3 ? primaryColor : disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "${game["rank"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Game Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${game["image"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Game Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${game["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${game["developer"]} • ${game["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${game["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if ((game["price"] as double) > 0) ...[
                                  Text(
                                    "\$${(game["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    "Free",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Stats and Change
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${((game["downloads"] as int) / 1000000).toStringAsFixed(1)}M",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "downloads",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          if (rankChange != 0) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isUp ? Icons.trending_up : Icons.trending_down,
                                  color: isUp ? successColor : dangerColor,
                                  size: 14,
                                ),
                                Text(
                                  "${rankChange.abs()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isUp ? successColor : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            Icon(
                              Icons.remove,
                              color: disabledBoldColor,
                              size: 14,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPodiumItem(Map<String, dynamic> game, int rank, double height) {
    Color rankColor = rank == 1 ? warningColor : rank == 2 ? disabledBoldColor : Colors.brown;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radiusSm),
          child: Image.network(
            "${game["image"]}",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: rankColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusXs),
              topRight: Radius.circular(radiusXs),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "#$rank",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "${((game["downloads"] as int) / 1000000).toStringAsFixed(1)}M",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "${game["title"]}",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTrendingGames() {
    return Column(
      spacing: spSm,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
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
                    color: successColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Trending Games",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                "Games with highest growth rate in the selected timeframe",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              ...List.generate(trendingGames.length, (index) {
                final game = trendingGames[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: disabledOutlineBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Trending Icon
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Game Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusXs),
                        child: Image.network(
                          "${game["image"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      
                      // Game Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${game["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${game["developer"]} • ${game["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${game["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if ((game["price"] as double) > 0) ...[
                                  Text(
                                    "\$${(game["price"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ] else ...[
                                  Text(
                                    "Free",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Growth Rate
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "+${(game["growthRate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${((game["downloads"] as int) / 1000).toInt()}K",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "downloads",
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
              }),
            ],
          ),
        ),
      ],
    );
  }
}
