import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaMultiplayerView extends StatefulWidget {
  const GeaMultiplayerView({super.key});

  @override
  State<GeaMultiplayerView> createState() => _GeaMultiplayerViewState();
}

class _GeaMultiplayerViewState extends State<GeaMultiplayerView> {
  String selectedMode = "Quick Match";
  bool isSearching = false;
  int playersOnline = 12847;

  List<Map<String, dynamic>> gameModesData = [
    {
      "name": "Quick Match",
      "description": "Fast matchmaking with players of similar skill",
      "players": 8453,
      "avgWaitTime": "45s",
      "icon": Icons.flash_on,
      "color": primaryColor,
      "difficulty": "All Levels",
    },
    {
      "name": "Ranked Match",
      "description": "Competitive ranked gameplay",
      "players": 3247,
      "avgWaitTime": "2m 15s",
      "icon": Icons.military_tech,
      "color": warningColor,
      "difficulty": "Skill-based",
    },
    {
      "name": "Custom Games",
      "description": "Player-created custom game modes",
      "players": 1147,
      "avgWaitTime": "1m 30s",
      "icon": Icons.build,
      "color": infoColor,
      "difficulty": "Varies",
    },
  ];

  List<Map<String, dynamic>> activeMatches = [
    {
      "id": 1,
      "mode": "Team Deathmatch",
      "map": "Desert Storm",
      "players": "6/8",
      "ping": 45,
      "region": "US East",
      "skill": "Diamond",
      "timeLeft": "3:45",
    },
    {
      "id": 2,
      "mode": "Capture the Flag",
      "map": "Urban Warfare",
      "players": "8/8",
      "ping": 32,
      "region": "US West",
      "skill": "Platinum",
      "timeLeft": "12:30",
    },
    {
      "id": 3,
      "mode": "Battle Royale",
      "map": "Frozen Wasteland",
      "players": "47/50",
      "ping": 67,
      "region": "EU",
      "skill": "Gold",
      "timeLeft": "2:15",
    },
  ];

  List<Map<String, dynamic>> recentPlayers = [
    {
      "username": "DragonSlayer99",
      "level": 67,
      "status": "online",
      "lastSeen": "2 minutes ago",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=avatar",
      "rank": "Diamond III",
    },
    {
      "username": "ShadowNinja",
      "level": 45,
      "status": "in-game",
      "lastSeen": "Playing now",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=profile",
      "rank": "Platinum I",
    },
    {
      "username": "FireMage",
      "level": 52,
      "status": "offline",
      "lastSeen": "1 hour ago",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=user",
      "rank": "Gold II",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplayer"),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              //navigateTo('FriendsListView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Online Status
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.public,
                      color: successColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Players Online",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${playersOnline.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} players worldwide",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),

            // Game Modes
            Container(
              width: double.infinity,
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
                  Text(
                    "Game Modes",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...gameModesData.map((mode) {
                    final isSelected = selectedMode == mode["name"];
                    return GestureDetector(
                      onTap: () {
                        selectedMode = mode["name"];
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? (mode["color"] as Color).withAlpha(25) : primaryColor.withAlpha(12),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? mode["color"] as Color : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (mode["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                mode["icon"] as IconData,
                                color: mode["color"] as Color,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${mode["name"]}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${mode["description"]}",
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
                                  "${mode["players"]} players",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "~${mode["avgWaitTime"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
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

            // Matchmaking Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isSearching ? "Searching for Match..." : "Find Match",
                size: bs.md,
                onPressed: isSearching ? null : () {
                  isSearching = true;
                  setState(() {});
                  
                  // Simulate matchmaking
                  Future.delayed(Duration(seconds: 3), () {
                    isSearching = false;
                    ss("Match found! Joining game...");
                    setState(() {});
                  });
                },
              ),
            ),

            if (isSearching)
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
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Searching for players...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Estimated wait time: 45s",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Active Matches
            Container(
              width: double.infinity,
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
                        "Active Matches",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...activeMatches.map((match) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(12),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${match["mode"]} - ${match["map"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${match["players"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${match["region"]} • ${match["ping"]}ms",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${match["skill"]} • ${match["timeLeft"]}",
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

            // Recent Players
            Container(
              width: double.infinity,
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
                        "Recent Players",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          //navigateTo('RecentPlayersView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...recentPlayers.map((player) {
                    Color statusColor = player["status"] == "online" ? successColor :
                                      player["status"] == "in-game" ? warningColor : disabledBoldColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  image: DecorationImage(
                                    image: NetworkImage("${player["avatar"]}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${player["username"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Level ${player["level"]} • ${player["rank"]}",
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
                                "${player["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${player["lastSeen"]}",
                                style: TextStyle(
                                  fontSize: 11,
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

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Create Room",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('CreateRoomView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Browse Rooms",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RoomBrowserView')
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
