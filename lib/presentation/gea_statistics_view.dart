import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaStatisticsView extends StatefulWidget {
  const GeaStatisticsView({super.key});

  @override
  State<GeaStatisticsView> createState() => _GeaStatisticsViewState();
}

class _GeaStatisticsViewState extends State<GeaStatisticsView> {
  String selectedPeriod = "All Time";
  String selectedCategory = "Overall";

  List<Map<String, dynamic>> statisticsData = [
    {
      "category": "Overall",
      "totalGames": 1456,
      "totalWins": 892,
      "totalLosses": 564,
      "winRate": 61.3,
      "playtime": 342.5,
      "level": 78,
      "experience": 145600,
      "rank": "Diamond III",
      "bestStreak": 23,
      "currentStreak": 7,
    },
    {
      "category": "Ranked",
      "totalGames": 567,
      "totalWins": 321,
      "totalLosses": 246,
      "winRate": 56.6,
      "playtime": 189.2,
      "level": 78,
      "experience": 89400,
      "rank": "Diamond III",
      "bestStreak": 15,
      "currentStreak": 3,
    },
    {
      "category": "Casual",
      "totalGames": 889,
      "totalWins": 571,
      "totalLosses": 318,
      "winRate": 64.2,
      "playtime": 153.3,
      "level": 78,
      "experience": 56200,
      "rank": "N/A",
      "bestStreak": 23,
      "currentStreak": 7,
    },
  ];

  List<Map<String, dynamic>> get currentStats {
    return statisticsData.where((stat) => stat["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final stats = currentStats.isNotEmpty ? currentStats[0] : statisticsData[0];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Statistics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              //navigateTo('ShareStatsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: [
                      {"label": "All Time", "value": "All Time"},
                      {"label": "This Season", "value": "This Season"},
                      {"label": "This Month", "value": "This Month"},
                      {"label": "This Week", "value": "This Week"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: [
                      {"label": "Overall", "value": "Overall"},
                      {"label": "Ranked", "value": "Ranked"},
                      {"label": "Casual", "value": "Casual"},
                    ],
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Player Level & Rank
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${stats["level"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "LEVEL",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${stats["rank"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Experience: ${((stats["experience"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            LinearProgressIndicator(
                              value: ((stats["experience"] as int) % 1000) / 1000,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Win Rate & Games
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(stats["winRate"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Win Rate",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stats["totalGames"]}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Total Games",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Wins & Losses
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stats["totalWins"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Wins",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stats["totalLosses"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Losses",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Playtime & Streaks
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(stats["playtime"] as num).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Playtime",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${stats["bestStreak"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Best Streak",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Current Streak
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Win Streak",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stats["currentStreak"]} consecutive wins",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${stats["currentStreak"]}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Detailed Report",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('DetailedStatsView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Compare Players",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('ComparePlayersView')
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
