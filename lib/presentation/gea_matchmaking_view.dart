import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaMatchmakingView extends StatefulWidget {
  const GeaMatchmakingView({super.key});

  @override
  State<GeaMatchmakingView> createState() => _GeaMatchmakingViewState();
}

class _GeaMatchmakingViewState extends State<GeaMatchmakingView> {
  String selectedMode = "Battle Royale";
  String selectedRank = "Any";
  String selectedRegion = "Auto";
  bool isSearching = false;
  int searchTime = 0;
  int playersFound = 0;
  String matchStatus = "Ready to search";

  List<Map<String, dynamic>> gameModes = [
    {
      "name": "Battle Royale",
      "players": "100",
      "avgWait": "45s",
      "difficulty": "Hard",
      "icon": Icons.military_tech,
      "popularity": 95,
    },
    {
      "name": "Team Deathmatch",
      "players": "8-12",
      "avgWait": "15s",
      "difficulty": "Medium",
      "icon": Icons.group,
      "popularity": 87,
    },
    {
      "name": "Capture Flag",
      "players": "16",
      "avgWait": "25s",
      "difficulty": "Medium",
      "icon": Icons.flag,
      "popularity": 72,
    },
    {
      "name": "Free for All",
      "players": "20-25",
      "avgWait": "20s",
      "difficulty": "Easy",
      "icon": Icons.person,
      "popularity": 68,
    },
    {
      "name": "Elimination",
      "players": "32-64",
      "avgWait": "60s",
      "difficulty": "Expert",
      "icon": Icons.whatshot,
      "popularity": 54,
    },
  ];

  List<Map<String, dynamic>> recentMatches = [
    {
      "mode": "Battle Royale",
      "result": "Victory",
      "rank": "+25",
      "duration": "12:45",
      "kills": 8,
      "placement": 1,
    },
    {
      "mode": "Team Deathmatch",
      "result": "Defeat",
      "rank": "-12",
      "duration": "8:30",
      "kills": 14,
      "placement": 3,
    },
    {
      "mode": "Capture Flag",
      "result": "Victory",
      "rank": "+18",
      "duration": "15:20",
      "kills": 6,
      "placement": 1,
    },
  ];

  void startMatchmaking() {
    setState(() {
      isSearching = true;
      searchTime = 0;
      playersFound = 0;
      matchStatus = "Searching for players...";
    });

    // Simulate matchmaking process
    _simulateMatchmaking();
  }

  void cancelMatchmaking() {
    setState(() {
      isSearching = false;
      searchTime = 0;
      playersFound = 0;
      matchStatus = "Search cancelled";
    });
  }

  void _simulateMatchmaking() {
    if (!isSearching) return;

    Future.delayed(Duration(seconds: 1), () {
      if (!isSearching) return;

      setState(() {
        searchTime++;
        
        // Simulate finding players progressively
        if (searchTime < 10) {
          playersFound = (searchTime * 2).clamp(0, 8);
          matchStatus = "Finding players... ($playersFound/8)";
        } else if (searchTime < 15) {
          matchStatus = "Balancing teams...";
        } else if (searchTime < 20) {
          matchStatus = "Preparing match...";
        } else {
          // Match found
          isSearching = false;
          matchStatus = "Match found! Connecting...";
          _matchFound();
          return;
        }
      });

      _simulateMatchmaking();
    });
  }

  void _matchFound() {
    Future.delayed(Duration(seconds: 2), () {
      ss("Match found! Loading game...");
      //navigateTo('GameView')
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matchmaking"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('MatchmakingSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Status
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isSearching 
                    ? primaryColor.withAlpha(10) 
                    : Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: isSearching 
                    ? Border.all(color: primaryColor.withAlpha(50), width: 2) 
                    : null,
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSearching ? Icons.search : Icons.videogame_asset,
                        color: isSearching ? primaryColor : disabledBoldColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          matchStatus,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: isSearching ? primaryColor : disabledBoldColor,
                          ),
                        ),
                      ),
                      if (isSearching)
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                    ],
                  ),
                  if (isSearching) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Search Time",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${searchTime}s",
                                style: TextStyle(
                                  fontSize: 16,
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
                                "Players Found",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "$playersFound/8",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                                "Mode",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                selectedMode,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Match Preferences
            if (!isSearching)
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
                          Icons.tune,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Match Preferences",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    QDropdownField(
                      label: "Game Mode",
                      items: gameModes.map((mode) => {
                        "label": mode["name"],
                        "value": mode["name"],
                      }).toList(),
                      value: selectedMode,
                      onChanged: (value, label) {
                        selectedMode = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Rank Range",
                            items: [
                              {"label": "Any", "value": "Any"},
                              {"label": "Bronze", "value": "Bronze"},
                              {"label": "Silver", "value": "Silver"},
                              {"label": "Gold", "value": "Gold"},
                              {"label": "Platinum", "value": "Platinum"},
                              {"label": "Diamond", "value": "Diamond"},
                              {"label": "Master", "value": "Master"},
                            ],
                            value: selectedRank,
                            onChanged: (value, label) {
                              selectedRank = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Region",
                            items: [
                              {"label": "Auto", "value": "Auto"},
                              {"label": "US East", "value": "US East"},
                              {"label": "US West", "value": "US West"},
                              {"label": "Europe", "value": "Europe"},
                              {"label": "Asia", "value": "Asia"},
                            ],
                            value: selectedRegion,
                            onChanged: (value, label) {
                              selectedRegion = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Game Modes
            if (!isSearching)
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
                          Icons.sports_esports,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Available Game Modes",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...gameModes.map((mode) {
                      final isSelected = mode["name"] == selectedMode;
                      return GestureDetector(
                        onTap: () {
                          selectedMode = mode["name"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          margin: EdgeInsets.only(bottom: spXs),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? primaryColor.withAlpha(20) 
                                : Colors.grey.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected 
                                  ? primaryColor 
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                mode["icon"] as IconData,
                                color: isSelected ? primaryColor : disabledBoldColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${mode["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? primaryColor : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${mode["players"]} players • Avg ${mode["avgWait"]} wait",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: mode["difficulty"] == "Easy" 
                                          ? successColor 
                                          : mode["difficulty"] == "Medium" 
                                              ? warningColor 
                                              : dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${mode["difficulty"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        size: 12,
                                        color: mode["popularity"] > 80 
                                            ? successColor 
                                            : mode["popularity"] > 60 
                                                ? warningColor 
                                                : disabledBoldColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${mode["popularity"]}%",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: mode["popularity"] > 80 
                                              ? successColor 
                                              : mode["popularity"] > 60 
                                                  ? warningColor 
                                                  : disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Action Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isSearching ? "Cancel Search" : "Start Matchmaking",
                size: bs.md,
                onPressed: isSearching ? cancelMatchmaking : startMatchmaking,
              ),
            ),

            // Recent Matches
            if (!isSearching)
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
                          Icons.history,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Recent Matches",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...recentMatches.map((match) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: match["result"] == "Victory" 
                                    ? successColor 
                                    : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${match["mode"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${match["result"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: match["result"] == "Victory" 
                                              ? successColor 
                                              : dangerColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Duration: ${match["duration"]} • ${match["kills"]} kills",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${match["rank"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: match["rank"].toString().startsWith("+") 
                                        ? successColor 
                                        : dangerColor,
                                  ),
                                ),
                                Text(
                                  "#${match["placement"]}",
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
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
