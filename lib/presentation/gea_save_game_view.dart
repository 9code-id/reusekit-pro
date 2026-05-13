import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSaveGameView extends StatefulWidget {
  const GeaSaveGameView({super.key});

  @override
  State<GeaSaveGameView> createState() => _GeaSaveGameViewState();
}

class _GeaSaveGameViewState extends State<GeaSaveGameView> {
  String saveGameName = "";
  String selectedSlot = "Auto Save";
  bool isCloudSave = true;

  List<Map<String, dynamic>> saveSlots = [
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
    },
  ];

  List<Map<String, dynamic>> quickSaveOptions = [
    {
      "name": "Quick Save 1",
      "description": "Save current progress instantly",
      "icon": Icons.save,
      "color": primaryColor,
    },
    {
      "name": "Checkpoint Save",
      "description": "Save at last checkpoint",
      "icon": Icons.flag,
      "color": successColor,
    },
    {
      "name": "Manual Save",
      "description": "Create named save file",
      "icon": Icons.create,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save Game"),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud),
            onPressed: () {
              //navigateTo('CloudSaveView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Current Game Status
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
                        Icons.videogame_asset,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Current Game Status",
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
                              "Level 47 - Final Boss Area",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Progress: 92.1% • Playtime: 15h 45m",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusSm),
                          image: DecorationImage(
                            image: NetworkImage("https://picsum.photos/60/40?random=5&keyword=game"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick Save Options
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
                    "Quick Save Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...quickSaveOptions.map((option) {
                    return GestureDetector(
                      onTap: () {
                        // Handle quick save
                        ss("Game saved successfully!");
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (option["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              option["icon"] as IconData,
                              color: option["color"] as Color,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${option["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Manual Save Form
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
                    "Manual Save",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QTextField(
                    label: "Save Name",
                    value: saveGameName,
                    hint: "Enter save game name",
                    onChanged: (value) {
                      saveGameName = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.cloud,
                        color: isCloudSave ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Save to Cloud",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Switch(
                        value: isCloudSave,
                        onChanged: (value) {
                          isCloudSave = value;
                          setState(() {});
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create Save File",
                      size: bs.sm,
                      onPressed: () {
                        if (saveGameName.isNotEmpty) {
                          ss("Save file '${saveGameName}' created successfully!");
                          saveGameName = "";
                          setState(() {});
                        } else {
                          se("Please enter a save name");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Existing Save Slots
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
                        "Save Slots",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${saveSlots.length}/8 slots used",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...saveSlots.map((slot) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(12),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: slot["type"] == "auto" ? warningColor : primaryColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${slot["screenshot"]}"),
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
                                        "${slot["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    if (slot["cloudSync"] == true)
                                      Icon(
                                        Icons.cloud_done,
                                        color: successColor,
                                        size: 16,
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Level ${slot["level"]} • ${(slot["progress"] as num).toStringAsFixed(1)}% • ${slot["playtime"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${slot["lastSaved"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${slot["size"]}",
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
                          SizedBox(width: spSm),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ss("Game saved to slot: ${slot["name"]}");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.save,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              GestureDetector(
                                onTap: () async {
                                  bool isConfirmed = await confirm("Delete this save file?");
                                  if (isConfirmed) {
                                    ss("Save file deleted");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: dangerColor,
                                    size: 16,
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

            // Storage Info
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
                        Icons.storage,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Storage Information",
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
                              "Local Storage",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "8.2 MB used of 100 MB",
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
                              "Cloud Storage",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "6.9 MB used of 1 GB",
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
        ),
      ),
    );
  }
}
