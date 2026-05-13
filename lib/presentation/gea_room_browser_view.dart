import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaRoomBrowserView extends StatefulWidget {
  const GeaRoomBrowserView({super.key});

  @override
  State<GeaRoomBrowserView> createState() => _GeaRoomBrowserViewState();
}

class _GeaRoomBrowserViewState extends State<GeaRoomBrowserView> {
  String searchQuery = "";
  String selectedRegion = "All Regions";
  String selectedGameMode = "All Modes";
  bool showFullRooms = true;

  List<Map<String, dynamic>> gameRooms = [
    {
      "id": "room_001",
      "name": "Epic Battle Arena",
      "host": "PlayerOne",
      "region": "North America",
      "gameMode": "Team Deathmatch",
      "currentPlayers": 6,
      "maxPlayers": 8,
      "map": "Desert Storm",
      "ping": 45,
      "status": "In Progress",
      "isPasswordProtected": false,
      "level": "Intermediate",
      "hostLevel": 47,
      "createdAt": "2024-01-15 14:30",
    },
    {
      "id": "room_002", 
      "name": "Casual Friday",
      "host": "GamerGirl22",
      "region": "Europe",
      "gameMode": "Free For All",
      "currentPlayers": 4,
      "maxPlayers": 6,
      "map": "Urban Jungle",
      "ping": 28,
      "status": "Waiting",
      "isPasswordProtected": true,
      "level": "Beginner",
      "hostLevel": 23,
      "createdAt": "2024-01-15 15:45",
    },
    {
      "id": "room_003",
      "name": "Pro League Practice",
      "host": "EliteSniper",
      "region": "Asia Pacific",
      "gameMode": "Ranked Match",
      "currentPlayers": 8,
      "maxPlayers": 8,
      "map": "Mountain Base",
      "ping": 72,
      "status": "Full",
      "isPasswordProtected": false,
      "level": "Expert",
      "hostLevel": 89,
      "createdAt": "2024-01-15 13:20",
    },
    {
      "id": "room_004",
      "name": "Newbie Training",
      "host": "Coach_Mike",
      "region": "North America",
      "gameMode": "Training Mode",
      "currentPlayers": 3,
      "maxPlayers": 10,
      "map": "Training Grounds",
      "ping": 35,
      "status": "Waiting",
      "isPasswordProtected": false,
      "level": "Beginner",
      "hostLevel": 156,
      "createdAt": "2024-01-15 16:10",
    },
    {
      "id": "room_005",
      "name": "Speed Rush Championship",
      "host": "FastFingers",
      "region": "Europe",
      "gameMode": "Speed Run",
      "currentPlayers": 5,
      "maxPlayers": 8,
      "map": "Circuit Track",
      "ping": 41,
      "status": "In Progress",
      "isPasswordProtected": true,
      "level": "Advanced",
      "hostLevel": 67,
      "createdAt": "2024-01-15 12:55",
    },
  ];

  List<Map<String, dynamic>> get filteredRooms {
    return gameRooms.where((room) {
      final matchesSearch = searchQuery.isEmpty ||
          (room["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (room["host"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesRegion = selectedRegion == "All Regions" || room["region"] == selectedRegion;
      final matchesGameMode = selectedGameMode == "All Modes" || room["gameMode"] == selectedGameMode;
      final matchesFullRooms = showFullRooms || room["status"] != "Full";
      
      return matchesSearch && matchesRegion && matchesGameMode && matchesFullRooms;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Waiting":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Full":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse Game Rooms"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                          "${gameRooms.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Rooms",
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
                          "${gameRooms.where((r) => r["status"] == "Waiting").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Available",
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
                          "${gameRooms.fold(0, (sum, room) => sum + (room["currentPlayers"] as int))}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Active Players",
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

            // Search and Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search rooms...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: [
                      {"label": "All Regions", "value": "All Regions"},
                      {"label": "North America", "value": "North America"},
                      {"label": "Europe", "value": "Europe"},
                      {"label": "Asia Pacific", "value": "Asia Pacific"},
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Game Mode",
                    items: [
                      {"label": "All Modes", "value": "All Modes"},
                      {"label": "Team Deathmatch", "value": "Team Deathmatch"},
                      {"label": "Free For All", "value": "Free For All"},
                      {"label": "Ranked Match", "value": "Ranked Match"},
                      {"label": "Training Mode", "value": "Training Mode"},
                      {"label": "Speed Run", "value": "Speed Run"},
                    ],
                    value: selectedGameMode,
                    onChanged: (value, label) {
                      selectedGameMode = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Show Full Rooms",
                        "value": true,
                        "checked": showFullRooms,
                      }
                    ],
                    value: [
                      if (showFullRooms)
                        {
                          "label": "Show Full Rooms",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showFullRooms = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Room List
            ...filteredRooms.map((room) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: room["status"] == "Full" 
                        ? dangerColor.withAlpha(50)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${room["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    if (room["isPasswordProtected"] == true)
                                      Icon(
                                        Icons.lock,
                                        size: 16,
                                        color: warningColor,
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Host: ${room["host"]} (Lv.${room["hostLevel"]})",
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
                              color: _getStatusColor(room["status"] as String),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${room["status"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Game Info
                      Row(
                        children: [
                          Icon(
                            Icons.gamepad,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${room["gameMode"]} • ${room["map"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Details Row
                      Row(
                        children: [
                          // Players
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${room["currentPlayers"]}/${room["maxPlayers"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: room["currentPlayers"] == room["maxPlayers"]
                                        ? dangerColor
                                        : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Region
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${room["region"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Ping
                          Row(
                            children: [
                              Icon(
                                Icons.wifi,
                                size: 16,
                                color: (room["ping"] as int) < 50 
                                    ? successColor 
                                    : (room["ping"] as int) < 100 
                                        ? warningColor 
                                        : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${room["ping"]}ms",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Level and Join Button
                      Row(
                        children: [
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
                              "${room["level"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: room["status"] == "Full" 
                                ? "Full" 
                                : room["isPasswordProtected"] == true 
                                    ? "Join (Password)" 
                                    : "Join Room",
                            size: bs.sm,
                            onPressed: room["status"] == "Full" 
                                ? null 
                                : () {
                                    //navigateTo('JoinRoomView', arguments: room)
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            // No results message
            if (filteredRooms.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No rooms found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('CreateRoomView')
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
