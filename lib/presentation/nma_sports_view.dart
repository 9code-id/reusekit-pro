import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaSportsView extends StatefulWidget {
  const NmaSportsView({super.key});

  @override
  State<NmaSportsView> createState() => _NmaSportsViewState();
}

class _NmaSportsViewState extends State<NmaSportsView> {
  String selectedCategory = "all";
  String selectedLeague = "all";
  bool isLive = false;
  bool isLoading = false;

  List<Map<String, dynamic>> sportCategories = [
    {"label": "All Sports", "value": "all"},
    {"label": "Football", "value": "football"},
    {"label": "Basketball", "value": "basketball"},
    {"label": "Baseball", "value": "baseball"},
    {"label": "Soccer", "value": "soccer"},
    {"label": "Tennis", "value": "tennis"},
    {"label": "Hockey", "value": "hockey"},
  ];

  List<Map<String, dynamic>> leagueOptions = [
    {"label": "All Leagues", "value": "all"},
    {"label": "NFL", "value": "nfl"},
    {"label": "NBA", "value": "nba"},
    {"label": "MLB", "value": "mlb"},
    {"label": "Premier League", "value": "premier"},
    {"label": "Champions League", "value": "champions"},
    {"label": "World Cup", "value": "worldcup"},
  ];

  List<Map<String, dynamic>> liveGames = [
    {
      "id": 1,
      "sport": "basketball",
      "league": "NBA",
      "homeTeam": "Los Angeles Lakers",
      "awayTeam": "Boston Celtics",
      "homeScore": 98,
      "awayScore": 102,
      "quarter": "4th",
      "timeLeft": "02:34",
      "isLive": true,
      "venue": "Crypto.com Arena",
      "date": "2025-06-16T19:30:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=1&keyword=lakers",
      "awayLogo": "https://picsum.photos/60/60?random=2&keyword=celtics",
    },
    {
      "id": 2,
      "sport": "football",
      "league": "NFL",
      "homeTeam": "Kansas City Chiefs",
      "awayTeam": "Buffalo Bills",
      "homeScore": 21,
      "awayScore": 14,
      "quarter": "3rd",
      "timeLeft": "08:15",
      "isLive": true,
      "venue": "Arrowhead Stadium",
      "date": "2025-06-16T20:00:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=3&keyword=chiefs",
      "awayLogo": "https://picsum.photos/60/60?random=4&keyword=bills",
    },
  ];

  List<Map<String, dynamic>> recentGames = [
    {
      "id": 3,
      "sport": "soccer",
      "league": "Premier League",
      "homeTeam": "Manchester United",
      "awayTeam": "Liverpool",
      "homeScore": 2,
      "awayScore": 3,
      "status": "Final",
      "isLive": false,
      "venue": "Old Trafford",
      "date": "2025-06-15T15:00:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=5&keyword=manchester",
      "awayLogo": "https://picsum.photos/60/60?random=6&keyword=liverpool",
    },
    {
      "id": 4,
      "sport": "baseball",
      "league": "MLB",
      "homeTeam": "New York Yankees",
      "awayTeam": "Boston Red Sox",
      "homeScore": 8,
      "awayScore": 5,
      "status": "Final",
      "isLive": false,
      "venue": "Yankee Stadium",
      "date": "2025-06-15T19:05:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=7&keyword=yankees",
      "awayLogo": "https://picsum.photos/60/60?random=8&keyword=redsox",
    },
    {
      "id": 5,
      "sport": "tennis",
      "league": "Wimbledon",
      "homeTeam": "Novak Djokovic",
      "awayTeam": "Rafael Nadal",
      "homeScore": 3,
      "awayScore": 1,
      "status": "Final",
      "isLive": false,
      "venue": "Centre Court",
      "date": "2025-06-14T14:00:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=9&keyword=djokovic",
      "awayLogo": "https://picsum.photos/60/60?random=10&keyword=nadal",
    },
  ];

  List<Map<String, dynamic>> upcomingGames = [
    {
      "id": 6,
      "sport": "basketball",
      "league": "NBA",
      "homeTeam": "Golden State Warriors",
      "awayTeam": "Phoenix Suns",
      "status": "Tomorrow 7:30 PM",
      "isLive": false,
      "venue": "Chase Center",
      "date": "2025-06-17T19:30:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=11&keyword=warriors",
      "awayLogo": "https://picsum.photos/60/60?random=12&keyword=suns",
      "odds": {"home": "2.1", "away": "1.8"},
    },
    {
      "id": 7,
      "sport": "football",
      "league": "NFL",
      "homeTeam": "Green Bay Packers",
      "awayTeam": "Chicago Bears",
      "status": "Sunday 1:00 PM",
      "isLive": false,
      "venue": "Lambeau Field",
      "date": "2025-06-18T13:00:00Z",
      "homeLogo": "https://picsum.photos/60/60?random=13&keyword=packers",
      "awayLogo": "https://picsum.photos/60/60?random=14&keyword=bears",
      "odds": {"home": "1.5", "away": "2.7"},
    },
  ];

  List<Map<String, dynamic>> get filteredGames {
    List<Map<String, dynamic>> allGames = [...liveGames, ...recentGames, ...upcomingGames];
    
    if (selectedCategory != "all") {
      allGames = allGames.where((game) => game["sport"] == selectedCategory).toList();
    }
    
    if (selectedLeague != "all") {
      allGames = allGames.where((game) => (game["league"] as String).toLowerCase().contains(selectedLeague)).toList();
    }
    
    if (isLive) {
      allGames = allGames.where((game) => game["isLive"] == true).toList();
    }
    
    return allGames;
  }

  Widget _buildLiveGameCard(Map<String, dynamic> game) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: dangerColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "LIVE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${game["league"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${game["homeLogo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${game["homeTeam"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${game["homeScore"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "-",
                            style: TextStyle(
                              fontSize: 20,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${game["awayScore"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${game["quarter"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "${game["timeLeft"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${game["awayLogo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${game["awayTeam"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${game["venue"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Watch Live",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to live stream
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    bool isUpcoming = game["status"] != "Final";
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${game["league"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: isUpcoming ? infoColor.withAlpha(20) : successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${game["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isUpcoming ? infoColor : successColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${game["homeLogo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${game["homeTeam"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  child: Column(
                    children: [
                      if (isUpcoming) ...[
                        Text(
                          "VS",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        if (game["odds"] != null) ...[
                          SizedBox(height: spSm),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${game["odds"]["home"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${game["odds"]["away"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ] else ...[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${game["homeScore"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "-",
                              style: TextStyle(
                                fontSize: 20,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${game["awayScore"]}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${game["awayLogo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${game["awayTeam"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${game["venue"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  DateTime.parse(game["date"]).dMMMy,
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportsStats() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Sports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${liveGames.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Live Games",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${recentGames.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
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
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${upcomingGames.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Upcoming",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports Center"),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigate to favorites
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.favorite,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isLoading = true;
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          isLoading = false;
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSportsStats(),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Sport",
                      items: sportCategories,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QDropdownField(
                      label: "League",
                      items: leagueOptions,
                      value: selectedLeague,
                      onChanged: (value, label) {
                        selectedLeague = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QSwitch(
                items: [
                  {
                    "label": "Show only live games",
                    "value": true,
                    "checked": isLive,
                  }
                ],
                value: [
                  if (isLive)
                    {
                      "label": "Show only live games",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  isLive = values.isNotEmpty;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (filteredGames.isEmpty)
                Container(
                  padding: EdgeInsets.all(spXl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sports,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No games found",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Try adjusting your filters",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: filteredGames.map((game) {
                    if (game["isLive"] == true) {
                      return _buildLiveGameCard(game);
                    } else {
                      return _buildGameCard(game);
                    }
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
