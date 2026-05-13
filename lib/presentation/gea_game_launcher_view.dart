import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaGameLauncherView extends StatefulWidget {
  const GeaGameLauncherView({super.key});

  @override
  State<GeaGameLauncherView> createState() => _GeaGameLauncherViewState();
}

class _GeaGameLauncherViewState extends State<GeaGameLauncherView> {
  String selectedGame = "";
  bool isLaunching = false;
  String launchStatus = "";

  List<Map<String, dynamic>> installedGames = [
    {
      "id": 1,
      "title": "Cyber Combat 2077",
      "version": "1.3.5",
      "size": "45.2 GB",
      "lastPlayed": "2024-06-15 14:30",
      "playTime": "127 hours",
      "cover": "https://picsum.photos/400/600?random=1&keyword=game",
      "status": "Ready",
      "isRunning": false,
      "canLaunch": true,
      "installPath": "C:\\Games\\CyberCombat2077",
      "executable": "CyberCombat2077.exe",
      "launchOptions": [
        {"label": "Normal", "value": ""},
        {"label": "Windowed", "value": "-windowed"},
        {"label": "Low Graphics", "value": "-lowgfx"},
        {"label": "Safe Mode", "value": "-safemode"},
      ],
      "selectedLaunchOption": "",
      "category": "Action",
      "rating": 4.8,
    },
    {
      "id": 2,
      "title": "Fantasy Realm Quest",
      "version": "2.1.0",
      "size": "28.7 GB",
      "lastPlayed": "2024-06-14 20:15",
      "playTime": "89 hours",
      "cover": "https://picsum.photos/400/600?random=2&keyword=fantasy",
      "status": "Ready",
      "isRunning": true,
      "canLaunch": false,
      "installPath": "C:\\Games\\FantasyRealm",
      "executable": "FantasyRealm.exe",
      "launchOptions": [
        {"label": "Normal", "value": ""},
        {"label": "Fullscreen", "value": "-fullscreen"},
        {"label": "High Quality", "value": "-hq"},
      ],
      "selectedLaunchOption": "",
      "category": "RPG",
      "rating": 4.6,
    },
    {
      "id": 3,
      "title": "Racing Thunder",
      "version": "1.9.0",
      "size": "15.3 GB",
      "lastPlayed": "2024-06-13 18:45",
      "playTime": "34 hours",
      "cover": "https://picsum.photos/400/600?random=3&keyword=racing",
      "status": "Needs Update",
      "isRunning": false,
      "canLaunch": true,
      "installPath": "C:\\Games\\RacingThunder",
      "executable": "RacingThunder.exe",
      "launchOptions": [
        {"label": "Normal", "value": ""},
        {"label": "Debug Mode", "value": "-debug"},
        {"label": "Performance", "value": "-performance"},
      ],
      "selectedLaunchOption": "",
      "category": "Racing",
      "rating": 4.4,
    },
    {
      "id": 4,
      "title": "Strategy Empire",
      "version": "3.2.8",
      "size": "12.1 GB",
      "lastPlayed": "Never",
      "playTime": "0 hours",
      "cover": "https://picsum.photos/400/600?random=4&keyword=strategy",
      "status": "Ready",
      "isRunning": false,
      "canLaunch": true,
      "installPath": "C:\\Games\\StrategyEmpire",
      "executable": "StrategyEmpire.exe",
      "launchOptions": [
        {"label": "Normal", "value": ""},
        {"label": "Tutorial", "value": "-tutorial"},
        {"label": "Sandbox", "value": "-sandbox"},
      ],
      "selectedLaunchOption": "",
      "category": "Strategy",
      "rating": 4.2,
    },
  ];

  List<Map<String, dynamic>> recentlyPlayed = [];
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadRecentlyPlayed();
    _loadFavorites();
  }

  void _loadRecentlyPlayed() {
    recentlyPlayed = installedGames
        .where((game) => game["lastPlayed"] != "Never")
        .toList()
      ..sort((a, b) => DateTime.parse(a["lastPlayed"]).compareTo(DateTime.parse(b["lastPlayed"])));
    setState(() {});
  }

  void _loadFavorites() {
    favorites = installedGames.where((game) => 
      (game["playTime"] as String).contains("hours") && 
      int.parse((game["playTime"] as String).split(" ")[0]) > 50
    ).toList();
    setState(() {});
  }

  void _launchGame(Map<String, dynamic> game) {
    if (!(game["canLaunch"] as bool)) return;
    
    setState(() {
      isLaunching = true;
      selectedGame = game["title"];
      launchStatus = "Initializing...";
    });
    
    // Simulate launch process
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        launchStatus = "Loading game assets...";
      });
    });
    
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        launchStatus = "Starting game engine...";
      });
    });
    
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        isLaunching = false;
        game["isRunning"] = true;
        game["canLaunch"] = false;
        game["lastPlayed"] = DateTime.now().toString().substring(0, 16);
      });
      ss("${game["title"]} launched successfully!");
      _loadRecentlyPlayed();
    });
  }

  void _closeGame(Map<String, dynamic> game) {
    setState(() {
      game["isRunning"] = false;
      game["canLaunch"] = true;
    });
    si("${game["title"]} has been closed");
  }

  void _changeLaunchOption(Map<String, dynamic> game, String option) {
    setState(() {
      game["selectedLaunchOption"] = option;
    });
    si("Launch option changed for ${game["title"]}");
  }

  void _openGameFolder(Map<String, dynamic> game) {
    si("Opening game folder: ${game["installPath"]}");
  }

  void _verifyGameFiles(Map<String, dynamic> game) {
    si("Verifying game files for ${game["title"]}...");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready":
        return successColor;
      case "Running":
        return primaryColor;
      case "Needs Update":
        return warningColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Launcher"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Refreshing game library...");
              _loadRecentlyPlayed();
              _loadFavorites();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Launch Status
            if (isLaunching) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Launching $selectedGame",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                launchStatus,
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
                  ],
                ),
              ),
            ],

            // Recently Played
            if (recentlyPlayed.isNotEmpty) ...[
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
                    Text(
                      "Recently Played",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    QHorizontalScroll(
                      children: recentlyPlayed.map((game) {
                        return Container(
                          width: 120,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["cover"]}",
                                  width: 120,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "${game["title"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${game["playTime"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],

            // Quick Actions
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
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.download,
                                color: primaryColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Downloads",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
                            color: successColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: successColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.system_update,
                                color: successColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Updates",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
                            color: warningColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: warningColor.withAlpha(50),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.settings,
                                color: warningColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
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
            ),

            // Installed Games
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
                  Text(
                    "Installed Games (${installedGames.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...installedGames.map((game) {
                    final isRunning = game["isRunning"] as bool;
                    final canLaunch = game["canLaunch"] as bool;
                    final status = game["status"] as String;
                    final launchOptions = game["launchOptions"] as List<Map<String, dynamic>>;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isRunning ? primaryColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isRunning ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${game["cover"]}",
                                  width: 60,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${game["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
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
                                            color: _getStatusColor(status),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            isRunning ? "Running" : status,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    Text(
                                      "Version ${game["version"]} • ${game["size"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${game["playTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Expanded(
                                          child: Text(
                                            "Last: ${game["lastPlayed"] != "Never" ? game["lastPlayed"] : "Never"}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          // Launch Options
                          if (launchOptions.length > 1) ...[
                            Row(
                              children: [
                                Text(
                                  "Launch Option:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    child: QDropdownField(
                                      label: "",
                                      items: launchOptions.map((option) => {
                                        "label": option["label"],
                                        "value": option["value"],
                                      }).toList(),
                                      value: game["selectedLaunchOption"],
                                      onChanged: (value, label) {
                                        _changeLaunchOption(game, value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          
                          // Action Buttons
                          Row(
                            children: [
                              if (isRunning) ...[
                                QButton(
                                  label: "Close Game",
                                  size: bs.sm,
                                  onPressed: () => _closeGame(game),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  label: "Show Window",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Showing ${game["title"]} window");
                                  },
                                ),
                              ] else ...[
                                QButton(
                                  label: canLaunch ? "Launch" : "Cannot Launch",
                                  size: bs.sm,
                                  onPressed: canLaunch ? () => _launchGame(game) : null,
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    _showGameOptions(game);
                                  },
                                ),
                              ],
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${game["rating"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
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

  void _showGameOptions(Map<String, dynamic> game) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${game["title"]} Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            QButton(
              label: "Open Game Folder",
              size: bs.md,
              onPressed: () {
                back();
                _openGameFolder(game);
              },
            ),
            
            QButton(
              label: "Verify Game Files",
              size: bs.md,
              onPressed: () {
                back();
                _verifyGameFiles(game);
              },
            ),
            
            QButton(
              label: "Game Properties",
              size: bs.md,
              onPressed: () {
                back();
                //navigateTo('GeaGamePropertiesView', arguments: game)
              },
            ),
            
            QButton(
              label: "Uninstall",
              size: bs.md,
              onPressed: () async {
                back();
                bool isConfirmed = await confirm("Are you sure you want to uninstall ${game["title"]}?");
                if (isConfirmed) {
                  ss("${game["title"]} uninstalled successfully");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
