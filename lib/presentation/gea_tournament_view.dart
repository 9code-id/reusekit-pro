import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaTournamentView extends StatefulWidget {
  const GeaTournamentView({super.key});

  @override
  State<GeaTournamentView> createState() => _GeaTournamentViewState();
}

class _GeaTournamentViewState extends State<GeaTournamentView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";

  List<Map<String, dynamic>> tournaments = [
    {
      "id": 1,
      "name": "World Championship 2024",
      "organizer": "GamePro Esports",
      "game": "Battle Royale",
      "type": "Elimination",
      "status": "Registration",
      "startDate": "2024-07-15",
      "endDate": "2024-07-20",
      "registrationEnd": "2024-07-10",
      "participants": 1247,
      "maxParticipants": 2048,
      "entryFee": 25.0,
      "prizePool": 100000.0,
      "firstPrize": 50000.0,
      "image": "https://picsum.photos/300/200?random=1&keyword=tournament",
      "requirements": ["Level 40+", "Diamond Rank", "Verified Account"],
      "format": "Single Elimination",
      "region": "Global",
    },
    {
      "id": 2,
      "name": "Weekly Warrior Cup",
      "organizer": "Community Tournaments",
      "game": "Team Deathmatch",
      "type": "Round Robin",
      "status": "Live",
      "startDate": "2024-06-16",
      "endDate": "2024-06-16",
      "registrationEnd": "2024-06-15",
      "participants": 64,
      "maxParticipants": 64,
      "entryFee": 0.0,
      "prizePool": 500.0,
      "firstPrize": 250.0,
      "image": "https://picsum.photos/300/200?random=2&keyword=competition",
      "requirements": ["Level 20+", "Gold Rank"],
      "format": "Best of 3",
      "region": "US East",
    },
    {
      "id": 3,
      "name": "Noob Friendly Tournament",
      "organizer": "Beginner League",
      "game": "Capture Flag",
      "type": "Swiss",
      "status": "Registration",
      "startDate": "2024-07-01",
      "endDate": "2024-07-02",
      "registrationEnd": "2024-06-28",
      "participants": 156,
      "maxParticipants": 256,
      "entryFee": 5.0,
      "prizePool": 1000.0,
      "firstPrize": 400.0,
      "image": "https://picsum.photos/300/200?random=3&keyword=gaming",
      "requirements": ["Level 1-25", "Bronze/Silver Rank"],
      "format": "Swiss System",
      "region": "Europe",
    },
    {
      "id": 4,
      "name": "Elite Masters Series",
      "organizer": "Pro Gaming League",
      "game": "Battle Royale",
      "type": "Elimination",
      "status": "Finished",
      "startDate": "2024-05-20",
      "endDate": "2024-05-25",
      "registrationEnd": "2024-05-15",
      "participants": 512,
      "maxParticipants": 512,
      "entryFee": 50.0,
      "prizePool": 25000.0,
      "firstPrize": 12500.0,
      "image": "https://picsum.photos/300/200?random=4&keyword=championship",
      "requirements": ["Level 50+", "Master Rank", "Previous Tournament Experience"],
      "format": "Double Elimination",
      "region": "Global",
      "winner": "ProPlayer123",
    },
  ];

  List<Map<String, dynamic>> myTournaments = [
    {
      "tournament": "Weekly Warrior Cup",
      "status": "Participating",
      "position": "Quarter Finals",
      "nextMatch": "2024-06-16 15:30",
      "wins": 3,
      "losses": 1,
    },
    {
      "tournament": "Elite Masters Series",
      "status": "Eliminated",
      "position": "Round of 16",
      "finalPosition": 12,
      "prizeMoney": 150.0,
    },
  ];

  List<Map<String, dynamic>> get filteredTournaments {
    return tournaments.where((tournament) {
      final matchesSearch = searchQuery.isEmpty ||
          (tournament["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (tournament["organizer"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus = selectedStatus == "All" || tournament["status"] == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Tournaments",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "My Tournaments", icon: Icon(Icons.emoji_events)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        // Browse Tournaments Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Stats Row
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
                            "${tournaments.where((t) => t["status"] == "Live").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "Live Now",
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
                            "${tournaments.where((t) => t["status"] == "Registration").length}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Open",
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
                            "\$${(tournaments.fold(0.0, (sum, t) => sum + (t["prizePool"] as double)) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Total Prize",
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

              // Search and Filter
              QTextField(
                label: "Search tournaments...",
                value: searchQuery,
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),

              QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Registration", "value": "Registration"},
                  {"label": "Live", "value": "Live"},
                  {"label": "Finished", "value": "Finished"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),

              // Tournaments List
              ...filteredTournaments.map((tournament) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tournament Image Header
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusMd),
                          topRight: Radius.circular(radiusMd),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              "${tournament["image"]}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: tournament["status"] == "Live" 
                                      ? dangerColor 
                                      : tournament["status"] == "Registration" 
                                          ? successColor 
                                          : disabledBoldColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${tournament["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "\$${((tournament["prizePool"] as double) / 1000).toStringAsFixed(0)}K Prize",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tournament Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Text(
                              "${tournament["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            Text(
                              "Organized by ${tournament["organizer"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),

                            // Tournament Info
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.videogame_asset,
                                            size: 16,
                                            color: primaryColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${tournament["game"]} • ${tournament["type"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${tournament["participants"]}/${tournament["maxParticipants"]}",
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${tournament["startDate"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.public,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${tournament["region"]}",
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
                              ],
                            ),

                            // Prize Info
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.emoji_events,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Prize Pool: \$${((tournament["prizePool"] as double)).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: warningColor,
                                          ),
                                        ),
                                        Text(
                                          "1st Place: \$${((tournament["firstPrize"] as double)).toStringAsFixed(0)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: warningColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (tournament["entryFee"] > 0)
                                    Text(
                                      "Entry: \$${tournament["entryFee"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  else
                                    Text(
                                      "FREE",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            // Requirements
                            if ((tournament["requirements"] as List).isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Requirements:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  ...(tournament["requirements"] as List<String>).map((req) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: spSm),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "• ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              req,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),

                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: tournament["status"] == "Registration" 
                                        ? "Register" 
                                        : tournament["status"] == "Live" 
                                            ? "Watch Live" 
                                            : "View Results",
                                    size: bs.sm,
                                    onPressed: () {
                                      //navigateTo('TournamentDetailsView', arguments: tournament)
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('ShareTournamentView')
                                  },
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.info,
                                  size: bs.sm,
                                  onPressed: () {
                                    //navigateTo('TournamentInfoView', arguments: tournament)
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        // My Tournaments Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Current Tournaments
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
                          Icons.emoji_events,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "My Tournaments",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ...myTournaments.map((myTournament) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: myTournament["status"] == "Participating" 
                              ? successColor.withAlpha(20) 
                              : Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${myTournament["tournament"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: myTournament["status"] == "Participating" 
                                        ? successColor 
                                        : disabledBoldColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${myTournament["status"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Position: ${myTournament["position"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if (myTournament.containsKey("nextMatch"))
                              Text(
                                "Next Match: ${myTournament["nextMatch"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            if (myTournament.containsKey("prizeMoney"))
                              Text(
                                "Prize Won: \$${myTournament["prizeMoney"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
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

        // Create Tournament Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 64,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Create Your Tournament",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Organize your own tournament and invite players from around the world",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Create Tournament",
                      size: bs.md,
                      onPressed: () {
                        //navigateTo('CreateTournamentView')
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
