import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaTournamentsView extends StatefulWidget {
  const GeaTournamentsView({super.key});

  @override
  State<GeaTournamentsView> createState() => _GeaTournamentsViewState();
}

class _GeaTournamentsViewState extends State<GeaTournamentsView> {
  String selectedGame = "All Games";
  int selectedTournament = 0;
  
  List<String> games = ["All Games", "Valorant", "CS2", "League of Legends", "Dota 2"];
  
  List<Map<String, dynamic>> tournaments = [
    {
      "id": 1,
      "name": "World Championship 2024",
      "game": "League of Legends",
      "status": "Live",
      "stage": "Finals",
      "totalPrize": 500000,
      "teams": 16,
      "startDate": "2024-08-01",
      "endDate": "2024-08-31",
      "region": "Global",
      "image": "https://picsum.photos/400/250?random=1&keyword=tournament",
      "currentMatch": "Team A vs Team B",
      "viewerCount": 2500000
    },
    {
      "id": 2,
      "name": "Champions League",
      "game": "Valorant",
      "status": "Upcoming",
      "stage": "Qualifiers",
      "totalPrize": 250000,
      "teams": 32,
      "startDate": "2024-09-15",
      "endDate": "2024-10-15",
      "region": "Americas",
      "image": "https://picsum.photos/400/250?random=2&keyword=esports",
      "currentMatch": null,
      "viewerCount": 0
    },
    {
      "id": 3,
      "name": "Major Tournament",
      "game": "CS2",
      "status": "Registration",
      "stage": "Open Qualifiers",
      "totalPrize": 1000000,
      "teams": 64,
      "startDate": "2024-10-01",
      "endDate": "2024-11-01",
      "region": "Europe",
      "image": "https://picsum.photos/400/250?random=3&keyword=gaming",
      "currentMatch": null,
      "viewerCount": 0
    }
  ];

  List<Map<String, dynamic>> brackets = [
    {
      "round": "Quarter Finals",
      "matches": [
        {"team1": "Team Alpha", "team2": "Team Beta", "score1": 2, "score2": 1, "status": "Finished"},
        {"team1": "Team Gamma", "team2": "Team Delta", "score1": 0, "score2": 2, "status": "Finished"},
        {"team1": "Team Echo", "team2": "Team Fox", "score1": 1, "score2": 1, "status": "Live"},
        {"team1": "Team Golf", "team2": "Team Hotel", "score1": 0, "score2": 0, "status": "Upcoming"},
      ]
    },
    {
      "round": "Semi Finals",
      "matches": [
        {"team1": "Team Alpha", "team2": "Team Delta", "score1": 0, "score2": 0, "status": "Upcoming"},
        {"team1": "TBD", "team2": "TBD", "score1": 0, "score2": 0, "status": "TBD"},
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredTournaments {
    if (selectedGame == "All Games") return tournaments;
    return tournaments.where((tournament) => tournament["game"] == selectedGame).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Live":
        return dangerColor;
      case "Upcoming":
        return warningColor;
      case "Registration":
        return successColor;
      case "Finished":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tournaments"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game Filter
            QCategoryPicker(
              items: games.map((game) => {
                "label": game,
                "value": game,
              }).toList(),
              value: selectedGame,
              onChanged: (index, label, value, item) {
                selectedGame = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Featured Tournament
            if (filteredTournaments.isNotEmpty)
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  image: DecorationImage(
                    image: NetworkImage("${filteredTournaments[0]["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusMd),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(204),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: getStatusColor("${filteredTournaments[0]["status"]}"),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${filteredTournaments[0]["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${filteredTournaments[0]["name"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${filteredTournaments[0]["game"]} • ${filteredTournaments[0]["stage"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(Icons.emoji_events, color: Colors.white, size: 18),
                          SizedBox(width: spXs),
                          Text(
                            "\$${((filteredTournaments[0]["totalPrize"] as int).toDouble()).currency}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          if ((filteredTournaments[0]["viewerCount"] as int) > 0)
                            Row(
                              children: [
                                Icon(Icons.visibility, color: Colors.white, size: 18),
                                SizedBox(width: spXs),
                                Text(
                                  "${((filteredTournaments[0]["viewerCount"] as int) / 1000000).toStringAsFixed(1)}M viewers",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Tournament List
            Text(
              "All Tournaments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTournaments.length,
              itemBuilder: (context, index) {
                final tournament = filteredTournaments[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusMd),
                              bottomLeft: Radius.circular(radiusMd),
                            ),
                            child: Image.network(
                              "${tournament["image"]}",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: getStatusColor("${tournament["status"]}").withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${tournament["status"]}",
                                          style: TextStyle(
                                            color: getStatusColor("${tournament["status"]}"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${tournament["region"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "${tournament["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${tournament["game"]} • ${tournament["stage"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  Row(
                                    children: [
                                      Icon(Icons.emoji_events, size: 16, color: primaryColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${((tournament["totalPrize"] as int).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.groups, size: 16, color: disabledBoldColor),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${tournament["teams"]} teams",
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
                          ),
                        ],
                      ),
                      
                      // Tournament Details
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusMd),
                            bottomRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${tournament["startDate"]} - ${tournament["endDate"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    selectedTournament = index;
                                    _showTournamentDetails(tournament);
                                  },
                                ),
                                SizedBox(width: spSm),
                                if (tournament["status"] == "Registration")
                                  QButton(
                                    label: "Register",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                              ],
                            ),
                          ],
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

  void _showTournamentDetails(Map<String, dynamic> tournament) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledOutlineBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Tournament Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tournament Info
                    Text(
                      "${tournament["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: getStatusColor("${tournament["status"]}"),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tournament["status"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${tournament["game"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Tournament Stats
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "\$${((tournament["totalPrize"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Prize Pool",
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
                                Text(
                                  "${tournament["teams"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Teams",
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
                                Text(
                                  "${tournament["region"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Region",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Brackets
                    Text(
                      "Tournament Brackets",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: brackets.length,
                      itemBuilder: (context, roundIndex) {
                        final round = brackets[roundIndex];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${round["round"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: (round["matches"] as List).length,
                              itemBuilder: (context, matchIndex) {
                                final match = (round["matches"] as List)[matchIndex];
                                return Container(
                                  margin: EdgeInsets.only(bottom: spSm),
                                  padding: EdgeInsets.all(spMd),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusMd),
                                    border: Border.all(
                                      color: disabledOutlineBorderColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${match["team1"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${match["team2"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${match["score1"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "${match["score2"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: spMd),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                        decoration: BoxDecoration(
                                          color: getStatusColor("${match["status"]}").withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${match["status"]}",
                                          style: TextStyle(
                                            color: getStatusColor("${match["status"]}"),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                            SizedBox(height: spMd),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
