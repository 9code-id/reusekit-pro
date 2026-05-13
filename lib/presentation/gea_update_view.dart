import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaUpdateView extends StatefulWidget {
  const GeaUpdateView({super.key});

  @override
  State<GeaUpdateView> createState() => _GeaUpdateViewState();
}

class _GeaUpdateViewState extends State<GeaUpdateView> {
  bool isUpdating = false;
  bool autoUpdateEnabled = true;
  String updateChannel = "Stable";
  String lastCheckTime = "2 hours ago";

  List<Map<String, dynamic>> installedGames = [
    {
      "id": 1,
      "title": "Cyber Combat 2077",
      "currentVersion": "1.3.2",
      "latestVersion": "1.3.5",
      "updateSize": "2.1 GB",
      "hasUpdate": true,
      "isUpdating": false,
      "updateProgress": 0.0,
      "cover": "https://picsum.photos/400/600?random=1&keyword=game",
      "releaseNotes": "Bug fixes and performance improvements. New weapon skins available. Enhanced graphics for RTX cards.",
      "releaseDate": "2024-06-15",
      "priority": "High",
      "autoUpdate": true,
    },
    {
      "id": 2,
      "title": "Fantasy Realm Quest",
      "currentVersion": "2.1.0",
      "latestVersion": "2.1.0",
      "updateSize": "0 GB",
      "hasUpdate": false,
      "isUpdating": false,
      "updateProgress": 0.0,
      "cover": "https://picsum.photos/400/600?random=2&keyword=fantasy",
      "releaseNotes": "No updates available",
      "releaseDate": "2024-06-01",
      "priority": "None",
      "autoUpdate": true,
    },
    {
      "id": 3,
      "title": "Racing Thunder",
      "currentVersion": "1.8.5",
      "latestVersion": "1.9.0",
      "updateSize": "1.5 GB",
      "hasUpdate": true,
      "isUpdating": false,
      "updateProgress": 0.0,
      "cover": "https://picsum.photos/400/600?random=3&keyword=racing",
      "releaseNotes": "New racing tracks added. Physics engine improvements. Multiplayer stability fixes.",
      "releaseDate": "2024-06-14",
      "priority": "Medium",
      "autoUpdate": false,
    },
    {
      "id": 4,
      "title": "Strategy Empire",
      "currentVersion": "3.2.1",
      "latestVersion": "3.2.8",
      "updateSize": "850 MB",
      "hasUpdate": true,
      "isUpdating": false,
      "updateProgress": 0.0,
      "cover": "https://picsum.photos/400/600?random=4&keyword=strategy",
      "releaseNotes": "Balance changes to units. New civilization added. UI improvements.",
      "releaseDate": "2024-06-12",
      "priority": "Low",
      "autoUpdate": true,
    },
  ];

  List<Map<String, dynamic>> updateQueue = [];

  void _startUpdate(Map<String, dynamic> game) {
    setState(() {
      game["isUpdating"] = true;
      updateQueue.add(game);
      if (updateQueue.length == 1) {
        _simulateUpdate(game);
      }
    });
    ss("Update started for ${game["title"]}");
  }

  void _simulateUpdate(Map<String, dynamic> game) {
    setState(() {
      isUpdating = true;
    });
    // Simulate update progress
  }

  void _pauseUpdate(Map<String, dynamic> game) {
    setState(() {
      game["isUpdating"] = false;
      isUpdating = false;
    });
    si("Update paused for ${game["title"]}");
  }

  void _resumeUpdate(Map<String, dynamic> game) {
    setState(() {
      game["isUpdating"] = true;
      isUpdating = true;
    });
    si("Update resumed for ${game["title"]}");
  }

  void _cancelUpdate(Map<String, dynamic> game) {
    setState(() {
      game["isUpdating"] = false;
      game["updateProgress"] = 0.0;
      updateQueue.removeWhere((g) => g["id"] == game["id"]);
      isUpdating = updateQueue.isNotEmpty;
    });
    sw("Update cancelled for ${game["title"]}");
  }

  void _updateAll() {
    final gamesToUpdate = installedGames.where((game) => 
      game["hasUpdate"] as bool && !(game["isUpdating"] as bool)
    ).toList();
    
    for (final game in gamesToUpdate) {
      if (!updateQueue.any((g) => g["id"] == game["id"])) {
        _startUpdate(game);
      }
    }
  }

  void _checkForUpdates() {
    setState(() {
      lastCheckTime = "Just now";
    });
    ss("Checking for updates...");
    // Simulate update check
  }

  void _toggleAutoUpdate(Map<String, dynamic> game) {
    setState(() {
      game["autoUpdate"] = !(game["autoUpdate"] as bool);
    });
    si("Auto-update ${game["autoUpdate"] ? "enabled" : "disabled"} for ${game["title"]}");
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gamesWithUpdates = installedGames.where((game) => game["hasUpdate"] as bool).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Updates"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _checkForUpdates,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('GeaUpdateSettingsView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Update Settings
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
                    "Update Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto-update Games",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Automatically download and install updates",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoUpdateEnabled,
                        onChanged: (value) {
                          autoUpdateEnabled = value;
                          setState(() {});
                        },
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
                              "Update Channel",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Choose update stability level",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          updateChannel,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Last checked: $lastCheckTime",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Check Now",
                        size: bs.sm,
                        onPressed: _checkForUpdates,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Update Summary
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
                      Expanded(
                        child: Text(
                          "Available Updates",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      if (gamesWithUpdates.isNotEmpty)
                        QButton(
                          label: "Update All",
                          size: bs.sm,
                          onPressed: _updateAll,
                        ),
                    ],
                  ),
                  
                  if (gamesWithUpdates.isEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 48,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "All games are up to date!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "No updates available at this time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${gamesWithUpdates.length} games",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Updates available",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${gamesWithUpdates.fold(0.0, (sum, game) => sum + double.parse(game["updateSize"].toString().replaceAll(" GB", "").replaceAll(" MB", "")))} GB",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Total download size",
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

            // Current Update Progress
            if (isUpdating && updateQueue.isNotEmpty) ...[
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
                          Icons.system_update,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Updating: ${updateQueue[0]["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.pause,
                          size: bs.sm,
                          onPressed: () => _pauseUpdate(updateQueue[0]),
                        ),
                      ],
                    ),
                    
                    LinearProgressIndicator(
                      value: (updateQueue[0]["updateProgress"] as double) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${(updateQueue[0]["updateProgress"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${updateQueue[0]["currentVersion"]} → ${updateQueue[0]["latestVersion"]}",
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

            // Games List
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
                    "Installed Games",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...installedGames.map((game) {
                    final hasUpdate = game["hasUpdate"] as bool;
                    final isUpdating = game["isUpdating"] as bool;
                    final autoUpdate = game["autoUpdate"] as bool;
                    final priority = game["priority"] as String;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: hasUpdate ? primaryColor.withAlpha(10) : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: hasUpdate ? primaryColor.withAlpha(50) : disabledOutlineBorderColor,
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
                                  width: 50,
                                  height: 75,
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
                                        if (hasUpdate && priority != "None")
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(priority),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              priority,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    
                                    Row(
                                      children: [
                                        Text(
                                          "Current: ${game["currentVersion"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        if (hasUpdate) ...[
                                          SizedBox(width: spSm),
                                          Text(
                                            "→ ${game["latestVersion"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: successColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    
                                    if (hasUpdate)
                                      Text(
                                        "Update size: ${game["updateSize"]}",
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
                          
                          if (hasUpdate && (game["releaseNotes"] as String).isNotEmpty) ...[
                            Text(
                              "What's New:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${game["releaseNotes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          
                          Row(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: autoUpdate,
                                    onChanged: (value) => _toggleAutoUpdate(game),
                                  ),
                                  Text(
                                    "Auto-update",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              if (hasUpdate) ...[
                                if (isUpdating)
                                  Row(
                                    children: [
                                      QButton(
                                        label: "Pause",
                                        size: bs.sm,
                                        onPressed: () => _pauseUpdate(game),
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        label: "Cancel",
                                        size: bs.sm,
                                        onPressed: () => _cancelUpdate(game),
                                      ),
                                    ],
                                  )
                                else
                                  QButton(
                                    label: "Update",
                                    size: bs.sm,
                                    onPressed: () => _startUpdate(game),
                                  ),
                              ] else
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "Up to date",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
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
