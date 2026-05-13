import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameplayView extends StatefulWidget {
  const GeaGameplayView({super.key});

  @override
  State<GeaGameplayView> createState() => _GeaGameplayViewState();
}

class _GeaGameplayViewState extends State<GeaGameplayView> {
  int selectedGameMode = 0;
  bool isPlaying = false;
  int currentLevel = 12;
  double playerHealth = 85.0;
  double playerMana = 60.0;
  int score = 15420;
  int kills = 8;
  int deaths = 3;
  int assists = 12;

  List<Map<String, dynamic>> gameModes = [
    {
      "name": "Campaign",
      "description": "Single player story mode",
      "icon": Icons.person,
      "color": Colors.blue,
      "players": "1 Player"
    },
    {
      "name": "Multiplayer",
      "description": "Online battle with friends",
      "icon": Icons.groups,
      "color": Colors.green,
      "players": "2-10 Players"
    },
    {
      "name": "Battle Royale",
      "description": "Last player standing wins",
      "icon": Icons.military_tech,
      "color": Colors.orange,
      "players": "Up to 100 Players"
    },
    {
      "name": "Arena",
      "description": "Quick 5v5 matches",
      "icon": Icons.sports_kabaddi,
      "color": Colors.red,
      "players": "10 Players"
    },
  ];

  List<Map<String, dynamic>> recentMatches = [
    {
      "mode": "Arena",
      "result": "Victory",
      "duration": "12:34",
      "kills": 15,
      "deaths": 7,
      "score": 2850
    },
    {
      "mode": "Battle Royale",
      "result": "Defeat",
      "duration": "25:18",
      "kills": 8,
      "deaths": 1,
      "score": 1240
    },
    {
      "mode": "Multiplayer",
      "result": "Victory",
      "duration": "18:45",
      "kills": 12,
      "deaths": 9,
      "score": 1890
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gameplay"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to game settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            if (isPlaying) _buildGameSession() else _buildGameModeSelection(),
            if (!isPlaying) _buildQuickStats(),
            if (!isPlaying) _buildRecentMatches(),
            if (!isPlaying) _buildGameControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildGameSession() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.black54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.videogame_asset, color: Colors.white),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Playing ${gameModes[selectedGameMode]["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              QButton(
                label: "Exit Game",
                size: bs.sm,
                onPressed: () {
                  isPlaying = false;
                  setState(() {});
                },
              ),
            ],
          ),
          _buildPlayerStatus(),
          _buildGameStats(),
          _buildMiniMap(),
        ],
      ),
    );
  }

  Widget _buildPlayerStatus() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Level $currentLevel",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text(
                "Score: $score",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          _buildStatusBar("Health", playerHealth, Colors.red),
          _buildStatusBar("Mana", playerMana, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildStatusBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            Spacer(),
            Text(
              "${value.toInt()}%",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: Colors.white.withAlpha(30),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildGameStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard("Kills", kills.toString(), successColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Deaths", deaths.toString(), dangerColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard("Assists", assists.toString(), infoColor),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMap() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.white30),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              "Mini Map",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 30,
            child: _buildMapDot(Colors.blue, "You"),
          ),
          Positioned(
            top: 50,
            right: 40,
            child: _buildMapDot(Colors.red, "Enemy"),
          ),
          Positioned(
            bottom: 30,
            left: 60,
            child: _buildMapDot(Colors.green, "Ally"),
          ),
        ],
      ),
    );
  }

  Widget _buildMapDot(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildGameModeSelection() {
    return Container(
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
            "Select Game Mode",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: gameModes.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> mode = entry.value;
              bool isSelected = selectedGameMode == index;
              
              return GestureDetector(
                onTap: () {
                  selectedGameMode = index;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? (mode["color"] as Color).withAlpha(20) : Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? mode["color"] as Color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        mode["icon"],
                        size: 40,
                        color: isSelected ? mode["color"] as Color : disabledBoldColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${mode["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? mode["color"] as Color : primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${mode["description"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${mode["players"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Game",
              size: bs.md,
              onPressed: () {
                isPlaying = true;
                setState(() {});
                ss("Game started!");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
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
            "Quick Stats",
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
                child: _buildQuickStatCard("Wins", "47", successColor, Icons.emoji_events),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard("Losses", "23", dangerColor, Icons.cancel),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard("K/D Ratio", "1.8", infoColor, Icons.trending_up),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMatches() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Matches",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to match history
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: recentMatches.map((match) => _buildMatchItem(match)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchItem(Map<String, dynamic> match) {
    Color resultColor = match["result"] == "Victory" ? successColor : dangerColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: resultColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: resultColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: resultColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${match["result"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${match["mode"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Duration: ${match["duration"]}",
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
                "${match["kills"]}/${match["deaths"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${match["score"]} pts",
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
  }

  Widget _buildGameControls() {
    return Container(
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
            "Game Controls",
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
                child: QButton(
                  label: "Practice Mode",
                  size: bs.md,
                  onPressed: () {
                    ss("Entering practice mode");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Tutorial",
                  size: bs.md,
                  onPressed: () {
                    ss("Starting tutorial");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
