import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSpectatorModeView extends StatefulWidget {
  const GeaSpectatorModeView({super.key});

  @override
  State<GeaSpectatorModeView> createState() => _GeaSpectatorModeViewState();
}

class _GeaSpectatorModeViewState extends State<GeaSpectatorModeView> {
  int selectedMatch = 0;
  String selectedCamera = "Free Cam";
  bool showPlayerStats = true;
  bool showMiniMap = true;
  bool autoDirector = false;

  List<Map<String, dynamic>> liveMatches = [
    {
      "id": 1,
      "tournament": "VCT Champions",
      "teamA": "Team Alpha",
      "teamB": "Team Beta",
      "scoreA": 11,
      "scoreB": 8,
      "map": "Ascent",
      "round": "Round 20",
      "status": "live",
      "viewers": 45000,
    },
    {
      "id": 2,
      "tournament": "Regional Finals",
      "teamA": "Pro Squad",
      "teamB": "Elite Gaming",
      "scoreA": 7,
      "scoreB": 13,
      "map": "Bind",
      "round": "Round 21",
      "status": "live",
      "viewers": 28000,
    },
    {
      "id": 3,
      "tournament": "Qualifier Match",
      "teamA": "Rising Stars",
      "teamB": "Veterans",
      "scoreA": 13,
      "scoreB": 9,
      "map": "Haven",
      "round": "Match Complete",
      "status": "finished",
      "viewers": 12000,
    },
  ];

  List<Map<String, dynamic>> players = [
    {
      "name": "Phoenix",
      "agent": "Duelist",
      "kills": 18,
      "deaths": 12,
      "assists": 6,
      "adr": 165.4,
      "alive": true,
      "hp": 100,
      "armor": 50,
    },
    {
      "name": "Sage",
      "agent": "Sentinel",
      "kills": 14,
      "deaths": 10,
      "assists": 8,
      "adr": 142.2,
      "alive": true,
      "hp": 75,
      "armor": 25,
    },
    {
      "name": "Sova",
      "agent": "Initiator",
      "kills": 12,
      "deaths": 14,
      "assists": 12,
      "adr": 138.7,
      "alive": false,
      "hp": 0,
      "armor": 0,
    },
  ];

  List<String> cameraOptions = [
    "Free Cam",
    "Player POV",
    "Overhead Map",
    "Tactical View",
    "Director Mode",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spectator Mode"),
        actions: [
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () => _showSpectatorSettings(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          _buildMatchSelector(),
          Expanded(
            child: _buildSpectatorInterface(),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchSelector() {
    return Container(
      height: 100,
      color: primaryColor.withAlpha(10),
      child: QHorizontalScroll(
        children: liveMatches.map((match) => _buildMatchCard(match)).toList(),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    bool isSelected = (match["id"] as int) == liveMatches[selectedMatch]["id"];
    
    return GestureDetector(
      onTap: () {
        selectedMatch = liveMatches.indexOf(match);
        setState(() {});
      },
      child: Container(
        width: 280,
        margin: EdgeInsets.all(spXs),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: 2,
          ),
        ),
        child: Column(
          spacing: spXs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: match["status"] == "live" ? dangerColor : disabledBoldColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    match["status"] == "live" ? "LIVE" : "FINISHED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.visibility,
                  color: isSelected ? Colors.white : disabledBoldColor,
                  size: 12,
                ),
                SizedBox(width: 2),
                Text(
                  "${((match["viewers"] as int) / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    color: isSelected ? Colors.white : disabledBoldColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Text(
              "${match["tournament"]}",
              style: TextStyle(
                color: isSelected ? Colors.white : disabledBoldColor,
                fontSize: 10,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${match["teamA"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  "${match["scoreA"]} - ${match["scoreB"]}",
                  style: TextStyle(
                    color: isSelected ? Colors.white : primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${match["teamB"]}",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: isSelected ? Colors.white : primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${match["map"]} • ${match["round"]}",
              style: TextStyle(
                color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpectatorInterface() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Main game view (simulated)
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.withAlpha(50),
                    Colors.green.withAlpha(50),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.videogame_asset,
                    size: 100,
                    color: Colors.white.withAlpha(100),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Game View - ${selectedCamera}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${liveMatches[selectedMatch]["map"]} • ${liveMatches[selectedMatch]["round"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Top UI overlay
          _buildTopOverlay(),
          
          // Player stats overlay
          if (showPlayerStats) _buildPlayerStatsOverlay(),
          
          // Mini map overlay
          if (showMiniMap) _buildMiniMapOverlay(),
          
          // Bottom controls
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    final match = liveMatches[selectedMatch];
    return Positioned(
      top: spSm,
      left: spSm,
      right: spSm,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(150),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Text(
              "${match["teamA"]}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: spSm),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${match["scoreA"]} - ${match["scoreB"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: spSm),
            Text(
              "${match["teamB"]}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "LIVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStatsOverlay() {
    return Positioned(
      top: 80,
      right: spSm,
      child: Container(
        width: 200,
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(180),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          spacing: spXs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Player Stats",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            ...players.map((player) => _buildPlayerStatRow(player)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStatRow(Map<String, dynamic> player) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: (player["alive"] as bool) ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: (player["alive"] as bool) ? successColor : dangerColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              "${player["name"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "${player["kills"]}/${player["deaths"]}",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMapOverlay() {
    return Positioned(
      bottom: 80,
      right: spSm,
      child: Container(
        width: 120,
        height: 120,
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(180),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Column(
          children: [
            Text(
              "Mini Map",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: Colors.white30),
                ),
                child: Center(
                  child: Text(
                    "${liveMatches[selectedMatch]["map"]}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: spSm,
      left: spSm,
      right: spSm,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(180),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Camera",
                items: cameraOptions.map((camera) => {
                  "label": camera,
                  "value": camera,
                }).toList(),
                value: selectedCamera,
                onChanged: (value, label) {
                  selectedCamera = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: showPlayerStats ? Icons.visibility : Icons.visibility_off,
              size: bs.sm,
              onPressed: () {
                showPlayerStats = !showPlayerStats;
                setState(() {});
              },
            ),
            SizedBox(width: spXs),
            QButton(
              icon: showMiniMap ? Icons.map : Icons.map_outlined,
              size: bs.sm,
              onPressed: () {
                showMiniMap = !showMiniMap;
                setState(() {});
              },
            ),
            SizedBox(width: spXs),
            QButton(
              icon: autoDirector ? Icons.auto_mode : Icons.videocam,
              size: bs.sm,
              onPressed: () {
                autoDirector = !autoDirector;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSpectatorSettings() {
    ss("Spectator settings opened");
  }
}
