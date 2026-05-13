import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaLoadGameView extends StatefulWidget {
  const GeaLoadGameView({super.key});

  @override
  State<GeaLoadGameView> createState() => _GeaLoadGameViewState();
}

class _GeaLoadGameViewState extends State<GeaLoadGameView> {
  String selectedFilter = "All Saves";
  String searchQuery = "";

  List<Map<String, dynamic>> saveFiles = [
    {
      "id": 1,
      "name": "Main Campaign - Level 45",
      "level": 45,
      "progress": 89.5,
      "playtime": "12h 34m",
      "lastSaved": "2024-06-15 14:30",
      "screenshot": "https://picsum.photos/150/100?random=1&keyword=game",
      "size": "2.4 MB",
      "type": "manual",
      "cloudSync": true,
      "difficulty": "Normal",
      "location": "Final Dungeon",
    },
    {
      "id": 2,
      "name": "Speed Run Attempt",
      "level": 23,
      "progress": 45.2,
      "playtime": "3h 12m",
      "lastSaved": "2024-06-14 20:15",
      "screenshot": "https://picsum.photos/150/100?random=2&keyword=race",
      "size": "1.8 MB",
      "type": "manual",
      "cloudSync": true,
      "difficulty": "Hard",
      "location": "Desert Temple",
    },
    {
      "id": 3,
      "name": "Auto Save",
      "level": 47,
      "progress": 92.1,
      "playtime": "15h 45m",
      "lastSaved": "2024-06-15 16:45",
      "screenshot": "https://picsum.photos/150/100?random=3&keyword=adventure",
      "size": "2.7 MB",
      "type": "auto",
      "cloudSync": true,
      "difficulty": "Normal",
      "location": "Boss Arena",
    },
    {
      "id": 4,
      "name": "Hardcore Mode",
      "level": 12,
      "progress": 24.8,
      "playtime": "4h 23m",
      "lastSaved": "2024-06-13 18:22",
      "screenshot": "https://picsum.photos/150/100?random=4&keyword=challenge",
      "size": "1.2 MB",
      "type": "manual",
      "cloudSync": false,
      "difficulty": "Hardcore",
      "location": "Mountain Pass",
    },
    {
      "id": 5,
      "name": "New Game Plus",
      "level": 78,
      "progress": 34.6,
      "playtime": "8h 15m",
      "lastSaved": "2024-06-12 22:30",
      "screenshot": "https://picsum.photos/150/100?random=5&keyword=fantasy",
      "size": "3.1 MB",
      "type": "manual",
      "cloudSync": true,
      "difficulty": "Nightmare",
      "location": "Starting Village",
    },
  ];

  List<Map<String, dynamic>> get filteredSaveFiles {
    return saveFiles.where((save) {
      final matchesFilter = selectedFilter == "All Saves" || 
                           (selectedFilter == "Manual Saves" && save["type"] == "manual") ||
                           (selectedFilter == "Auto Saves" && save["type"] == "auto") ||
                           (selectedFilter == "Cloud Saves" && save["cloudSync"] == true);
      
      final matchesSearch = searchQuery.isEmpty ||
                           (save["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
                           (save["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Game"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Save files refreshed");
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
            // Search and Filter
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search save files...",
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
                    label: "Filter",
                    items: [
                      {"label": "All Saves", "value": "All Saves"},
                      {"label": "Manual Saves", "value": "Manual Saves"},
                      {"label": "Auto Saves", "value": "Auto Saves"},
                      {"label": "Cloud Saves", "value": "Cloud Saves"},
                    ],
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Quick Load Section
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
                        Icons.flash_on,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Quick Load",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      ss("Loading last save...");
                      //navigateTo('GameView')
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${saveFiles[2]["screenshot"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Continue: ${saveFiles[2]["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Level ${saveFiles[2]["level"]} • ${(saveFiles[2]["progress"] as num).toStringAsFixed(1)}% • ${saveFiles[2]["playtime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            color: primaryColor,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Save Files List
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
                      Text(
                        "All Save Files",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredSaveFiles.length} saves found",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (filteredSaveFiles.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.save_alt,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No save files found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your search or filter",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ...filteredSaveFiles.map((save) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(12),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: save["type"] == "auto" ? warningColor : 
                                   save["difficulty"] == "Hardcore" ? dangerColor :
                                   save["difficulty"] == "Nightmare" ? Colors.purple : primaryColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Save File Header
                          Container(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${save["screenshot"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${save["name"]}",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (save["cloudSync"] == true)
                                            Icon(
                                              Icons.cloud_done,
                                              color: successColor,
                                              size: 16,
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${save["location"]} • ${save["difficulty"]} Mode",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Level ${save["level"]} • ${(save["progress"] as num).toStringAsFixed(1)}% Complete",
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

                          // Progress Bar
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: LinearProgressIndicator(
                              value: (save["progress"] as num) / 100,
                              backgroundColor: disabledColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                save["difficulty"] == "Hardcore" ? dangerColor :
                                save["difficulty"] == "Nightmare" ? Colors.purple : primaryColor,
                              ),
                              minHeight: 4,
                            ),
                          ),

                          // Save Info & Actions
                          Container(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Playtime: ${save["playtime"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Saved: ${save["lastSaved"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "${save["size"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //navigateTo('SaveFileDetailsView', arguments: save)
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.info,
                                          color: infoColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    GestureDetector(
                                      onTap: () {
                                        ss("Loading ${save["name"]}...");
                                        //navigateTo('GameView', arguments: save)
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(spXs),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(25),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: successColor,
                                          size: 16,
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
                    );
                  }),
                ],
              ),
            ),

            // Storage Info
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
                  Icon(
                    Icons.storage,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Storage Usage",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Local: 8.2 MB • Cloud: 6.9 MB",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Manage",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('SaveManagerView')
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
