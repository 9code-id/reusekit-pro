import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaLeaderboardsView extends StatefulWidget {
  const GeaLeaderboardsView({super.key});

  @override
  State<GeaLeaderboardsView> createState() => _GeaLeaderboardsViewState();
}

class _GeaLeaderboardsViewState extends State<GeaLeaderboardsView> {
  String selectedLeaderboard = "Global";
  String selectedTimeframe = "All Time";
  
  List<Map<String, dynamic>> globalLeaderboard = [
    {
      "rank": 1,
      "playerId": "player_001",
      "username": "DragonSlayer99",
      "score": 125400,
      "level": 45,
      "country": "US",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 18,
      "lastActive": "2 hours ago",
    },
    {
      "rank": 2,
      "playerId": "player_002",
      "username": "MysticMage",
      "score": 118750,
      "level": 42,
      "country": "JP",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 16,
      "lastActive": "5 hours ago",
    },
    {
      "rank": 3,
      "playerId": "player_003",
      "username": "ShadowHunter",
      "score": 112300,
      "level": 40,
      "country": "DE",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 15,
      "lastActive": "1 day ago",
    },
    {
      "rank": 4,
      "playerId": "player_004",
      "username": "FirePhoenix",
      "score": 108900,
      "level": 38,
      "country": "BR",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 14,
      "lastActive": "3 hours ago",
    },
    {
      "rank": 5,
      "playerId": "player_005",
      "username": "IceQueen",
      "score": 105600,
      "level": 37,
      "country": "CA",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 13,
      "lastActive": "6 hours ago",
    },
    {
      "rank": 15,
      "playerId": "current_user",
      "username": "You",
      "score": 87250,
      "level": 28,
      "country": "ID",
      "avatar": "https://picsum.photos/50/50?random=15&keyword=avatar",
      "isCurrentUser": true,
      "achievements": 8,
      "lastActive": "Now",
    },
  ];

  List<Map<String, dynamic>> friendsLeaderboard = [
    {
      "rank": 1,
      "playerId": "current_user",
      "username": "You",
      "score": 87250,
      "level": 28,
      "country": "ID",
      "avatar": "https://picsum.photos/50/50?random=15&keyword=avatar",
      "isCurrentUser": true,
      "achievements": 8,
      "lastActive": "Now",
    },
    {
      "rank": 2,
      "playerId": "friend_001",
      "username": "BestFriend",
      "score": 82100,
      "level": 26,
      "country": "ID",
      "avatar": "https://picsum.photos/50/50?random=16&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 7,
      "lastActive": "2 hours ago",
    },
    {
      "rank": 3,
      "playerId": "friend_002",
      "username": "GameBuddy",
      "score": 78900,
      "level": 25,
      "country": "MY",
      "avatar": "https://picsum.photos/50/50?random=17&keyword=avatar",
      "isCurrentUser": false,
      "achievements": 6,
      "lastActive": "1 day ago",
    },
  ];

  List<Map<String, dynamic>> get currentLeaderboard {
    return selectedLeaderboard == "Global" ? globalLeaderboard : friendsLeaderboard;
  }

  Color getRankColor(int rank) {
    switch (rank) {
      case 1: return warningColor; // Gold
      case 2: return disabledBoldColor; // Silver
      case 3: return warningColor.withAlpha(150); // Bronze
      default: return primaryColor;
    }
  }

  IconData getRankIcon(int rank) {
    switch (rank) {
      case 1: return Icons.emoji_events;
      case 2: return Icons.emoji_events;
      case 3: return Icons.emoji_events;
      default: return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = currentLeaderboard.firstWhere((player) => player["isCurrentUser"] as bool);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboards"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              //refreshLeaderboard()
              ss("Leaderboard refreshed!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Player Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "${currentUser["avatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${currentUser["username"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Rank #${currentUser["rank"]} • Level ${currentUser["level"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Text(
                          "${((currentUser["score"] as int) / 1000).toStringAsFixed(1)}K points",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: warningColor,
                        size: 24,
                      ),
                      Text(
                        "${currentUser["achievements"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Achievements",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Leaderboard",
                    items: [
                      {"label": "Global", "value": "Global"},
                      {"label": "Friends", "value": "Friends"},
                    ],
                    value: selectedLeaderboard,
                    onChanged: (value, label) {
                      selectedLeaderboard = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: [
                      {"label": "All Time", "value": "All Time"},
                      {"label": "This Week", "value": "This Week"},
                      {"label": "This Month", "value": "This Month"},
                    ],
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Leaderboard Stats
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
                          "${currentLeaderboard.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Players",
                          style: TextStyle(
                            fontSize: 12,
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
                          "${currentUser["rank"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Your Rank",
                          style: TextStyle(
                            fontSize: 12,
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
                          "${((currentLeaderboard.first["score"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Top Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Top 3 Podium
            if (currentLeaderboard.length >= 3) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Text(
                      "Top 3 Champions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 2nd Place
                        _buildPodiumPosition(currentLeaderboard[1], 2, 80),
                        // 1st Place
                        _buildPodiumPosition(currentLeaderboard[0], 1, 100),
                        // 3rd Place
                        _buildPodiumPosition(currentLeaderboard[2], 3, 60),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Full Leaderboard List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "$selectedLeaderboard Leaderboard",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          selectedTimeframe,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                  ...currentLeaderboard.asMap().entries.map((entry) {
                    final index = entry.key;
                    final player = entry.value;
                    final isCurrentUser = player["isCurrentUser"] as bool;
                    final rank = player["rank"] as int;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCurrentUser ? primaryColor.withAlpha(20) : null,
                        border: isCurrentUser ? Border.all(color: primaryColor, width: 1) : null,
                      ),
                      child: Row(
                        children: [
                          // Rank
                          Container(
                            width: 40,
                            child: Column(
                              children: [
                                Icon(
                                  getRankIcon(rank),
                                  color: getRankColor(rank),
                                  size: rank <= 3 ? 24 : 20,
                                ),
                                Text(
                                  "#$rank",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: getRankColor(rank),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Avatar
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: isCurrentUser ? Border.all(color: primaryColor, width: 2) : null,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "${player["avatar"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          // Player Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${player["username"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrentUser ? primaryColor : primaryColor,
                                      ),
                                    ),
                                    if (isCurrentUser) ...[
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "YOU",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Level ${player["level"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "•",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${player["achievements"]} achievements",
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
                          
                          // Score
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${((player["score"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${player["lastActive"]}",
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

            // Challenge Friends Button
            if (selectedLeaderboard == "Friends") ...[
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Challenge Friends",
                  onPressed: () {
                    //navigateTo('ChallengeFriendsView')
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumPosition(Map<String, dynamic> player, int rank, double height) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: getRankColor(rank), width: 3),
          ),
          child: ClipOval(
            child: Image.network(
              "${player["avatar"]}",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "${player["username"]}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "${((player["score"] as int) / 1000).toStringAsFixed(1)}K",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: getRankColor(rank).withAlpha(50),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusSm),
              topRight: Radius.circular(radiusSm),
            ),
            border: Border.all(color: getRankColor(rank), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                getRankIcon(rank),
                color: getRankColor(rank),
                size: 24,
              ),
              Text(
                "#$rank",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: getRankColor(rank),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
