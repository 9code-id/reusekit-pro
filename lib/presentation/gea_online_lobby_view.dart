import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaOnlineLobbyView extends StatefulWidget {
  const GeaOnlineLobbyView({super.key});

  @override
  State<GeaOnlineLobbyView> createState() => _GeaOnlineLobbyViewState();
}

class _GeaOnlineLobbyViewState extends State<GeaOnlineLobbyView> {
  String selectedRegion = "US East";
  String chatMessage = "";
  bool isReady = false;

  List<Map<String, dynamic>> lobbyPlayers = [
    {
      "id": 1,
      "username": "GameMaster",
      "level": 89,
      "rank": "Diamond I",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=avatar",
      "status": "host",
      "isReady": true,
      "ping": 0,
      "kills": 2847,
      "deaths": 1523,
      "winRate": 78.4,
    },
    {
      "id": 2,
      "username": "ShadowHunter",
      "level": 67,
      "rank": "Platinum II",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=profile",
      "status": "player",
      "isReady": true,
      "ping": 45,
      "kills": 1943,
      "deaths": 1247,
      "winRate": 65.2,
    },
    {
      "id": 3,
      "username": "DragonSlayer",
      "level": 54,
      "rank": "Gold III",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=user",
      "status": "player",
      "isReady": false,
      "ping": 67,
      "kills": 1456,
      "deaths": 1123,
      "winRate": 58.9,
    },
    {
      "id": 4,
      "username": "You",
      "level": 78,
      "rank": "Diamond III",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=gamer",
      "status": "player",
      "isReady": false,
      "ping": 32,
      "kills": 2456,
      "deaths": 1634,
      "winRate": 71.8,
    },
  ];

  List<Map<String, dynamic>> chatMessages = [
    {
      "id": 1,
      "username": "GameMaster",
      "message": "Welcome to the lobby everyone!",
      "timestamp": "18:45",
      "type": "message",
    },
    {
      "id": 2,
      "username": "System",
      "message": "ShadowHunter joined the lobby",
      "timestamp": "18:46",
      "type": "system",
    },
    {
      "id": 3,
      "username": "ShadowHunter",
      "message": "Hey all, ready for some action?",
      "timestamp": "18:46",
      "type": "message",
    },
    {
      "id": 4,
      "username": "System",
      "message": "DragonSlayer joined the lobby",
      "timestamp": "18:47",
      "type": "system",
    },
    {
      "id": 5,
      "username": "DragonSlayer",
      "message": "Let's do this! Which map are we playing?",
      "timestamp": "18:47",
      "type": "message",
    },
  ];

  Map<String, dynamic> gameSettings = {
    "mode": "Team Deathmatch",
    "map": "Desert Storm",
    "maxPlayers": 8,
    "timeLimit": 15,
    "killLimit": 50,
    "difficulty": "Normal",
    "friendlyFire": false,
    "autoBalance": true,
  };

  @override
  Widget build(BuildContext context) {
    final readyPlayersCount = lobbyPlayers.where((p) => p["isReady"] == true).length;
    final allReady = readyPlayersCount == lobbyPlayers.length;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Lobby"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('LobbySettingsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Game Info Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${gameSettings["mode"]} - ${gameSettings["map"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: allReady ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${lobbyPlayers.length}/${gameSettings["maxPlayers"]} Players",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: allReady ? successColor : warningColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Region: $selectedRegion",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "$readyPlayersCount/${lobbyPlayers.length} ready",
                      style: TextStyle(
                        fontSize: 12,
                        color: allReady ? successColor : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Players List
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
                          "Players",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        ...lobbyPlayers.map((player) {
                          final isHost = player["status"] == "host";
                          final isYou = player["username"] == "You";
                          
                          return Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isYou ? primaryColor.withAlpha(25) : primaryColor.withAlpha(12),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border(
                                left: BorderSide(
                                  width: 4,
                                  color: isHost ? warningColor : 
                                         player["isReady"] == true ? successColor : disabledBoldColor,
                                ),
                              ),
                            ),
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
                                    if (isHost)
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: warningColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 12,
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
                                      Row(
                                        children: [
                                          Text(
                                            "${player["username"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (isHost) ...[
                                            SizedBox(width: spXs),
                                            Text(
                                              "HOST",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: warningColor,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Level ${player["level"]} • ${player["rank"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "K/D: ${player["kills"]}/${player["deaths"]} • WR: ${(player["winRate"] as num).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 11,
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: player["isReady"] == true ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        player["isReady"] == true ? "READY" : "NOT READY",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: player["isReady"] == true ? successColor : dangerColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${player["ping"]}ms",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: (player["ping"] as int) > 100 ? dangerColor : 
                                               (player["ping"] as int) > 50 ? warningColor : successColor,
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

                  // Game Settings
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
                              Icons.settings,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Game Settings",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Time Limit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${gameSettings["timeLimit"]} minutes",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "Kill Limit",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${gameSettings["killLimit"]} kills",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Difficulty",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${gameSettings["difficulty"]}",
                                    style: TextStyle(
                                      fontSize: 14,
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
                                    "Friendly Fire",  
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    gameSettings["friendlyFire"] == true ? "Enabled" : "Disabled",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: gameSettings["friendlyFire"] == true ? dangerColor : successColor,
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
                ],
              ),
            ),
          ),

          // Chat Section
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Lobby Chat",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm),
                    child: ListView.builder(
                      itemCount: chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = chatMessages[index];
                        final isSystem = message["type"] == "system";
                        
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${message["timestamp"]} ",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (!isSystem) ...[
                                Text(
                                  "${message["username"]}: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                              Expanded(
                                child: Text(
                                  "${message["message"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isSystem ? disabledBoldColor : primaryColor,
                                    fontStyle: isSystem ? FontStyle.italic : FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  child: Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Type a message...",
                          value: chatMessage,
                          onChanged: (value) {
                            chatMessage = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        label: "Send",
                        size: bs.sm,
                        onPressed: chatMessage.isNotEmpty ? () {
                          // Add message to chat
                          chatMessages.add({
                            "id": chatMessages.length + 1,
                            "username": "You",
                            "message": chatMessage,
                            "timestamp": "18:${48 + chatMessages.length}",
                            "type": "message",
                          });
                          chatMessage = "";
                          setState(() {});
                        } : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Actions
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: isReady ? "Not Ready" : "Ready",
                    size: bs.sm,
                    onPressed: () {
                      isReady = !isReady;
                      // Update player ready status
                      final playerIndex = lobbyPlayers.indexWhere((p) => p["username"] == "You");
                      if (playerIndex != -1) {
                        lobbyPlayers[playerIndex]["isReady"] = isReady;
                      }
                      setState(() {});
                      
                      ss(isReady ? "You are ready!" : "You are not ready");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: allReady ? "Start Game" : "Waiting...",
                    size: bs.sm,
                    onPressed: allReady ? () {
                      ss("Starting game...");
                      //navigateTo('GameView')
                    } : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
